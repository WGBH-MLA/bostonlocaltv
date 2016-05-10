class Blog < Cmless
  ROOT = (Rails.root + 'app/views/blog').to_s
  attr_reader :body_html
end