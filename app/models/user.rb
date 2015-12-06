class User < ActiveRecord::Base

  has_many :comments
  has_many :spots, foreign_key: :created_by

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
  ratyrate_rater

  def is_admin?
    role == 'admin'
  end
end
