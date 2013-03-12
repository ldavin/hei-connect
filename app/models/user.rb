class User < ActiveRecord::Base
  attr_accessible :password, :username
  attr_encrypted :password, key: ENV['ENC_USER_PASSWORD_KEY'], :unless => Rails.env.development?

  validates :username, uniqueness: true, presence: true
  validates :password, presence: true, on: :create
  validates :ecampus_student_id, :ecampus_user_id, numericality: {only_integer: true}

  after_create :set_token

  private

  def set_token
    self.update_attribute(:token, Digest::MD5.hexdigest("#{self.id}-#{Random.rand}"))
  end
end
