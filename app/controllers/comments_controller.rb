class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = current_user.comments.new(params[:comment])
    if @comment.save
      flash[:success] = "Comment created successfully"
    else
      flash[:error] = "Unable to save comment"
    end
    redirect_to "/catalog/#{@comment.solr_document_id}#comments"
  end
end
