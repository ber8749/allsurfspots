class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
  ratyrate_rater

  has_many :spots, foreign_key: :created_by
  has_many :comments

  def is_admin?
    role == 'admin'
  end
end
