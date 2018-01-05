class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save {self.email = email.downcase}

  validates :name,
    presence:true,
    length: {maximum: Settings.user.name_maximum, minimum: Settings.user.name_minimum}

  validates :email,
    presence:true,
    length: {maximum: Settings.user.email_maximum, minimum: Settings.user.email_minimum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  has_secure_password

  validates :password,
    presence:true,
    length: {minimum: Settings.user.password_minimum}
end
