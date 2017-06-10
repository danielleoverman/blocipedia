class User < ApplicationRecord
  enum role: [:standard, :premium, :admin]
  
  after_initialize :set_default_role   #, :if => :new_record
 
  def set_default_role
    self.role ||= :standard
  end   

  has_many :wikis
  has_many :collaborators
  has_many :wikis, through: :collaborators
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
 
       
end
