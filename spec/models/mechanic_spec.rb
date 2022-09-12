require 'rails_helper'

RSpec.describe Mechanic do
  let!(:six_flags) {AmusementPark.create!(name: 'Six Flags', admission_cost: 75)}

  let!(:garth) {Mechanic.create!(name: "Garth Brooksfield", years_experience: 12)}
  let!(:bono) {Mechanic.create!(name: "Bono MacBono", years_experience: 4)} 
  let!(:toby) {Mechanic.create!(name: "Toby Keithburg", years_experience: 15)} 
  let!(:trisha) {Mechanic.create!(name: "Trisha Yearday", years_experience: 35)} 

  let!(:hurler) {six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)}
  let!(:scrambler) {six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)}
  let!(:ferris) {six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)}
  let!(:log_flume) {six_flags.rides.create!(name: 'Log Flume', thrill_rating: 9, open: true)}
  let!(:brain_wagon) {six_flags.rides.create!(name: 'The Brain Wagon', thrill_rating: 6, open: true)}

  describe 'relationships' do
    it { should have_many(:rides).through(:ride_mechanics)}
  end

  describe 'instance methods' do
    describe 'avg_experience' do
      it 'returns the average years of experience for all mechanics' do
        @mechanics = Mechanic.all

        expect(@mechanics.avg_experience).to eq(16.5)
      end
    end

    describe 'open rides' do
      it 'returns an array of rides that are open, sorted by thrill' do
        garth.rides << hurler
        garth.rides << scrambler
        garth.rides << ferris
        garth.rides << log_flume

        expect(garth.open_rides).to eq([log_flume, hurler, scrambler])
      end
    end
  end
end