class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics
end

public

def avg_experience
  average(:years_experience)
end