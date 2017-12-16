require 'rails_helper'


RSpec.describe 'a store admin can visit admin dashboard' do
  describe 'and see a link for all items assocatiated to by store' do
    it 'when clicked that link should be the admin item index with admin functionality' do
      create(:item)
      @admin = create(:user)
      role = create(:role, name: "store_admin")
      store = create(:store)
      # item = create(:item)
      create(:store_user, user: @admin, role: role, store: store)
      # admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit strore_path
      click_on "Edit"
      fill_in "item[title]", with: "White Cat Twosie"
      fill_in "item[description]", with: "two is better"
      fill_in "item[price]", with: "39.99"
      page.attach_file("item[image]", testing_image)
      click_on "Update"

      expect(page).to have_content("White Cat Twosie")
      expect(page).to have_content("39.99")
    end
  end
end