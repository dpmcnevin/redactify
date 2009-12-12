class Spoiler < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique", :scope => :user_id
  validates_format_of :name, :with => /^[\w\d\s]+$/, :on => :create, :message => "is invalid", :allow_blank => false
  
  def self.popular
    all(:select => "id, name", :group => :name)
  end
end
