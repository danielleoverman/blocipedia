class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators 
  
  validates :title, length: { minimum: 5 } , presence: true
  validates :body,  length: { minimum: 20 }, presence: true

  default_scope { order('created_at DESC') }
  scope :visible_to, -> (user) { user ? all : where(private: false) }  

end
