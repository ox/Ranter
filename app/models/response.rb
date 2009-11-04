class Response < ActiveRecord::Base
  belongs_to :thread, :class_name => "Thread"

  def to_s
    :body
  end
end
