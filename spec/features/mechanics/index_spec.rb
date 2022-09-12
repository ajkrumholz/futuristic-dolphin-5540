require 'rails_helper'

RSpec.describe 'Mechanics Index' do

  let!(:six_flags) {AmusementPark.create!(name: 'Six Flags', admission_cost: 75)}
  let!(:universal) {AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)}

  let!(:hurler) {six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)}
  let!(:scrambler) {six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)}
  let!(:ferris) {six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)}
  
  let!(:jaws) {universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)}

  let!(:garth) {Mechanic.create!(name: "Garth Brooksfield", years_experience: 12)}
  let!(:bono) {Mechanic.create!(name: "Bono MacBono", years_experience: 4)} 
  let!(:toby) {Mechanic.create!(name: "Toby Keithburg", years_experience: 15)} 
  let!(:trisha) {Mechanic.create!(name: "Trisha Yearday", years_experience: 35)} 

# As a user,
# When I visit the mechanics index page

  before :each do
    visit '/mechanics'
  end

  describe 'index page content' do

    it 'displays a header' do
      expect(page).to have_content("All Mechanics")
    end

    it 'displays a list of all mechanics and their years of experience' do
      expect(page).to have_content(garth.name)
      expect(page).to have_content(bono.name)
      expect(page).to have_content(toby.name)
      expect(page).to have_content(trisha.name)
    end

    it 'displays the average years of mechanic experience' do
      expect(page).to have_content(Mechanic.all.average(:years_experience))
    end

  end
end