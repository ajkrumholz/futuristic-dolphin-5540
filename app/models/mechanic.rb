class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics
end

public

def avg_experience
  average(:years_experience)
end

def open_rides
  rides.where(open: true).order(thrill_rating: :desc)
end