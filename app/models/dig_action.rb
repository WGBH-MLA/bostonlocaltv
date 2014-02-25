class DigAction < ActiveRecord::Base

  TYPES = [:initiated, :withdrawn, :digitizing, :complete]

  attr_accessible :admin_user_id, :admin_user, :type, :user_item_id, :user_item

  belongs_to :user_item
  belongs_to :admin_user

  validates_presence_of :user_item
  validates :type, inclusion: {in: TYPES}
  # TYPES = {initiated: "initiated", withdrawn: "withdrawn", digitizing: "digitizing", complete: "complete"}
end
