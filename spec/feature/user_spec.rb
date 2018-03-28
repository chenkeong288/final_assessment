require 'rails_helper'

feature "Sign Up" do 

  scenario "user Sign Up with unique email" do 
    visit "/users/new"
    fill_in "user[first_name]", with: "Dragon"
    fill_in "user[last_name]", with: "Ball"
    fill_in "user[email]", with: "dragonball@gmail.com"
    fill_in "user[password]", with: "123"
    fill_in "user[password_confirmation]", with: "123"
    click_button "Create User"
    expect(page).to have_text "Your Ultimate Car Listing"
  end

  describe "failed Log In" do 

    before do 
      User.create(first_name: "Jacky", last_name: "Chan", email: "jacky@gmail.com", password: "777", password_confirmation: "777")
    end

    scenario "user Sign Up with existing email" do
      visit "/users/new"
      fill_in "user[first_name]", with: "Jacky"
      fill_in "user[last_name]", with: "Chan"
      fill_in "user[email]", with: "jacky@gmail.com"
      fill_in "user[password]", with: "777"
      fill_in "user[password_confirmation]", with: "777"
      click_button "Create User"
      expect(page).to have_text "Email has already been taken"
    end
  
  end

end



