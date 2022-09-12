require 'rails_helper'

RSpec.describe 'Amusement Park show page' do
  let!(:six_flags) {AmusementPark.create!(name: 'Six Flags', admission_cost: 75)}

  let!(:magic_mtn) {AmusementPark.create!(name: 'Magic Mountain', admission_cost: 600)}

  let!(:hurler) {six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)}
  let!(:scrambler) {six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)}
  let!(:ferris) {six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)}
  let!(:log_flume) {six_flags.rides.create!(name: 'Log Flume', thrill_rating: 9, open: true)}

  let!(:brain_wagon) {magic_mtn.rides.create!(name: 'The Brain Wagon', thrill_rating: 6, open: true)}

  before :each do
    visit "/amusement_parks/#{six_flags.id}"
  end

  it 'displays the name and admissions price for the park' do
    expect(page).to have_content(six_flags.name)
    expect(page).to have_content(six_flags.admission_cost)
    expect(page).to_not have_content(magic_mtn.name)
    expect(page).to_not have_content(magic_mtn.admission_cost)
  end

  it 'displays a list of all rides listed alpha' do
    expect(page).to_not have_content(brain_wagon.name)

    expect(ferris.name).to appear_before(log_flume.name)
    expect(log_flume.name).to appear_before(hurler.name)
    expect(hurler.name).to appear_before(scrambler.name)
  end

  it 'displays average thrill rating of rides' do
    expect(page).to have_content(six_flags.avg_thrill)
  end
end