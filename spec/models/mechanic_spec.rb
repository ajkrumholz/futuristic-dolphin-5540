require 'rails_helper'

RSpec.describe Mechanic do

  let!(:garth) {Mechanic.create!(name: "Garth Brooksfield", years_experience: 12)}
  let!(:bono) {Mechanic.create!(name: "Bono MacBono", years_experience: 4)} 
  let!(:toby) {Mechanic.create!(name: "Toby Keithburg", years_experience: 15)} 
  let!(:trisha) {Mechanic.create!(name: "Trisha Yearday", years_experience: 35)} 

  describe 'relationships' do
    it { should have_many(:rides).through(:ride_mechanics)}
  end

  describe 'instance' do
    describe 'avg_experience' do
      it 'returns the average years of experience for all mechanics' do
        @mechanics = Mechanic.all

        expect(@mechanics.avg_experience).to eq(16.5)
      end
    end
  end
end