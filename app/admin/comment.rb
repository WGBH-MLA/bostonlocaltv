ActiveAdmin.register Comment do

	index do
    column :id
    column :comment do |comment|
      truncate(comment.comment)
    end
    column :user_id do |comment|
      comment.user.to_s
    end
    column :solr_document_id do |comment|
      link_to comment.solr_document_id, "/catalog/#{comment.solr_document_id}", target: '_blank'
    end
    column :created_at
    column :approved

    default_actions                   

    column :actions do |comment|
      if comment.approved?
        link_to "Block", block_admin_comment_path(comment), :method => :put
      else
        link_to "Approve", approve_admin_comment_path(comment), :method => :put
      end
    end
  end 

  member_action :approve, :method => :put do
    comment = Comment.find(params[:id])
    comment.approve!
    flash[:notice] = 'Comment approved'
    redirect_to admin_comments_url
  end

  member_action :block, :method => :put do
    comment = Comment.find(params[:id])
    comment.block!
    flash[:notice] = 'Comment blocked'
    redirect_to admin_comments_url
  end
end
