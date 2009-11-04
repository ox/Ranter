require 'digest/sha1'

class User < ActiveRecord::Base

  validates_length_of :password, :within => 3..30
  validates_presence_of :password
  validates_confirmation_of :password

  attr_protected :id

  attr_accessor :password, :password_confirmation

  def self.authenticate(pass)
    return nil if pass.to_s.empty?
    u=find_by_password(User.encrypt(pass))
    return nil if u.nil?
    return u 
  end

  def password=(pass)
    self.password = User.encrypt(pass)
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save
    Notifications.deliver_forgot_password(self.email, self.login, new_pass)
  end

  # Sort users by their display names
  def <=>(user)
    self.to_s.downcase <=> user.to_s.downcase
  end

  def name
    eval('"' + "#{id}" + '"')
  end

  def logged?
    true
  end

  def anonymous?
    !logged?
  end

  def to_s
    id
  end

  def admin?
    self.admin ? false : true
  end

  def self.current=(user)
    @current_user = user
  end

  def self.current
    @current_user ||= User.anonymous
  end
  #
  ## Returns the anonymous user.  If the anonymous user does not exist, it is created.  There can be only
  # one anonymous user per database.
  def self.anonymous
    anonymous_user = AnonymousUser.find(:first)
    if anonymous_user.nil?
      anonymous_user = AnonymousUser.create(:admin => 0)
      raise 'Unable to create the anonymous user.' if !anonymous_user.new_record?
    end
    anonymous_user
  end

  private

#  def self.encrypt(pass, salt)
#    Digest::SHA1.hexdigest(pass+salt)
#  end

  def self.encrypt(pass)
    Digest::SHA1.hexdigest(pass)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
end

class AnonymousUser < User

  def id; 'Anonymous' end
  def logged?; false end
  def email; false end
end

