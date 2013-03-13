class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name
  
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  
  validates :first_name, :last_name, :presence => true
  
  def full_name
    [first_name, last_name].join(" ")
  end
end
