class Spoiler < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique", :scope => :user_id
  validates_format_of :name, :with => /^.*$/, :on => :create, :message => "is invalid", :allow_blank => false
  
  def self.popular
    # Assuming your model is named Model and its table is models:
    # cols = column_names.collect {|c| "#{c}"}.join(",")
    # And this is something like your query
    # find_by_sql("SELECT #{cols}, count(*) AS count GROUP BY name, #{cols}")
    # all(:select => "spoilers.id, spoilers.name", :group => :name)
    all.collect(&:name).sort.uniq
  end
end
