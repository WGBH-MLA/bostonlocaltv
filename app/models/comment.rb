class Comment < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'created_at ASC'

  scope :approved, where(approved: true)

  def approve!
    update_attribute(:approved, true)
  end

  def block!
    update_attribute(:approved, false)
  end
end
