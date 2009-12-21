class Spoiler < ActiveRecord::Base
  
  MAX_TAGS = 20
  
  belongs_to :user
  
  validate :maximum_tags, :on => :create
  validates_uniqueness_of :name, :on => :create, :message => "must be unique", :scope => :user_id
  validates_format_of :name, :with => /^.*$/, :on => :create, :message => "is invalid", :allow_blank => false
  
  private 
  
  def maximum_tags
    errors.add(:spoiler, "You have reached the maximum of #{MAX_TAGS} tags") if user.spoilers.count > MAX_TAGS
  end
  
end
