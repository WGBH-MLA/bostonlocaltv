module Dataset

  class Base
    extend ActiveModel::Callbacks
    define_model_callbacks :process, :process_record

    include Dataset::ProgressBarCallbacks

    attr_reader :file

    def initialize file
      @file = file
    end

    def process! opts = {}
      # not implemented
    end
  end
end
