require 'rails_helper'

RSpec.describe "Mechanic show page" do
  let!(:six_flags) {AmusementPark.create!(name: 'Six Flags', admission_cost: 75)}

  let!(:hurler) {six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)}
  let!(:scrambler) {six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)}
  let!(:ferris) {six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 2, open: false)}
  let!(:log_flume) {six_flags.rides.create!(name: 'Log Flume', thrill_rating: 9, open: true)}
  let!(:brain_wagon) {six_flags.rides.create!(name: 'The Brain Wagon', thrill_rating: 6, open: true)}
  

  let!(:garth) {Mechanic.create!(name: "Garth Brooksfield", years_experience: 12)}
  let!(:bono) {Mechanic.create!(name: "Bono MacBono", years_experience: 4)}

  before :each do
    garth.rides << hurler
    garth.rides << scrambler
    garth.rides << ferris
    garth.rides << log_flume
    visit "/mechanics/#{garth.id}"
  end

  describe 'when I visit a mechanic show page' do
    describe 'I see name, years of experience, and rides they work on' do
      it 'displays mechanic name and years of experience' do
        expect(page).to have_content(garth.name)
        expect(page).to have_content(garth.years_experience)
        expect(page).to_not have_content(bono.name)
        expect(page).to_not have_content(bono.years_experience)
      end

      it 'lists open rides the mechanic works on by thrill' do
        expect(page).to have_content(hurler.name)
        expect(page).to have_content(scrambler.name)
        expect(page).to have_content(log_flume.name)
        expect(log_flume.name).to appear_before(hurler.name)
        expect(hurler.name).to appear_before(scrambler.name)
        expect(page).to_not have_content(ferris.name)
        expect(page).to_not have_content(brain_wagon.name)
      end
    end

    describe 'adding a ride to a mechanics workload' do
      # As a user,
      # When I go to a mechanics show page
      # I see a form to add a ride to their workload
      # When I fill in that field with an id of an existing ride and hit submit
      # I’m taken back to that mechanic's show page
      # And I see the name of that newly added ride on this mechanics show page

      it 'has a form to add a ride' do
        expect(page).to_not have_content(brain_wagon.name)

        fill_in "Ride ID", with: brain_wagon.id
        click_on "Submit"

        expect(current_path).to eq("/mechanics/#{garth.id}")
        expect(page).to have_content(brain_wagon.name)
      end
    end
  end
end