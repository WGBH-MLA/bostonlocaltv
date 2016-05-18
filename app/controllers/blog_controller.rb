class BlogController < ApplicationController
  def index
    @blogs = Blog.all.reverse.select{|blog| blog.path =~ /^\d{4}/}
  end
  
  def show
    @blog = Blog.find_by_path(params[:path])
    @page_title = @blog.title
    params[:path] = nil # search widget grabs ALL parameters.
  end
end