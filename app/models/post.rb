class Post < ActiveRecord::Base
  has_many :responses, :class_name => "Response", :foreign_key => "post_id" 

  def to_s
    :body
  end
  
end
