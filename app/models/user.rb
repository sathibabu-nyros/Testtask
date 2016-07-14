class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # s3 bucket storage configuration 
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
    :storage => :s3,   
    :s3_region => 'us-west-2a',
    :s3_credentials => "#{Rails.root}/config/aws.yml",
    :path => "users/:id/:style.:extension"

  validates :email, :password, :password_confirmation, :firstname, :lastname, :phone_no, :address, presence: true  
  validates :email, :phone_no,  uniqueness: true   
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i  
  
  # validates :phone_no,:presence => true,
  #                :numericality => true,
  #                :length => { :minimum => 10, :maximum => 15 }
  validates :avatar, attachment_presence: true
  has_attached_file :avatar, :styles => { :medium =>     "300x300#", :thumb => "200x200#" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
