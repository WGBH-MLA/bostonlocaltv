require 'rack/utils'

class Bcat
  # ARGF style multi-file streaming interface. Input is read with IO#readpartial
  # to avoid buffering.
  class Reader
    attr_reader :is_command
    attr_reader :args
    attr_reader :fds

    def initialize(is_command, args=[])
      @is_command = is_command
      @args = args
    end

    def open
      @fds = is_command ? open_command : open_files
      @buf = []
    end

    def open_command
      [IO.popen(args.join(' '), 'rb')]
    end

    def open_files
      args.map do |f|
        if f == '-'
          $stdin
        else
          File.open(f, 'rb')
        end
      end
    end

    def each
      yield @buf.shift while @buf.any?
      while fd = fds.first
        fds.shift and next if fd.closed?
        fd.sync = true
        begin
          while buf = fd.readpartial(4096)
            yield buf
          end
        rescue EOFError
          fd.close
        end
        fds.shift
      end
    end

    def sniff
      @format ||=
        catch :detect do
          each do |chunk|
            @buf << chunk
            case chunk
            when /\A\s*</m
              throw :detect, 'html'
            when /\A\s*[^<]/m
              throw :detect, 'text'
            end
          end
          throw :detect, 'text'
        end
    end
  end

  # Like Reader but writes all input to an output IO object in addition to
  # yielding to the block.
  class TeeFilter
    def initialize(source, out=$stdout)
      @source = source
      @out = out
    end

    def each
      @source.each do |chunk|
        yield chunk
        @out.write chunk
      end
    end
  end

  class TextFilter
    include Rack::Utils

    def initialize(source, force=false)
      @source = source
      @force = force
    end

    def each
      yield "<pre>"
      @source.each do |chunk|
        chunk = escape_html(chunk)
        chunk = "<span>#{chunk}</span>" if !chunk.gsub!(/\n/, "<br>")
        yield chunk
      end
      yield "</pre>"
    end
  end
end
