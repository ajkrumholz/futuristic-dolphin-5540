require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  let!(:six_flags) {AmusementPark.create!(name: 'Six Flags', admission_cost: 75)}

  let!(:hurler) {six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)}
  let!(:scrambler) {six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)}
  let!(:ferris) {six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)}
  let!(:log_flume) {six_flags.rides.create!(name: 'Log Flume', thrill_rating: 9, open: true)}

  describe 'relationships' do
    it { should have_many(:rides) }
  end

  describe 'instance methods' do
    describe 'rides_alpha' do
      it 'returns an array of rides ordered by name' do
        expect(six_flags.rides_alpha).to eq([ferris, log_flume, hurler, scrambler])
      end
    end

    describe 'avg_thrill' do
      it 'returns the avg thrill rating of its rides' do
        expect(six_flags.avg_thrill).to eq(5.5)
      end
    end
  end
end