class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :races

  def admin?
    role == 'admin'
  end

  def recalculate_stats
    self.wpm = latest_races.all.map(&:wpm).sum / latest_races.count
    self.accuracy = latest_races.all.map(&:accuracy).sum / latest_races.count
  end

  def latest_races
    races.order(:created_at, :desc).limit(10)
  end
end

