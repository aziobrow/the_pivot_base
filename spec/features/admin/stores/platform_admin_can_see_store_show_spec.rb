require 'rails_helper'

feature 'a store admin can visit a store show page' do
  let(:admin) {create(:store_admin_with_store_items)}
  let(:store) { admin.stores.first }

  context 'and manage store details' do
    it 'they see all store information' do
      login_user(admin.email, admin.password)
      visit store_admin_dashboard_path
      click_on "#{store.name}"

      expect(current_path).to eq(admin_store_path(store.url))
      expect(page).to have_content(store.name)
      expect(page).to have_content(store.status)
    end

    it 'they see all users associated with that store' do
      manager = create(:store_manager, store: store)
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_content("Store Manager: #{manager.name}")
      expect(page).to have_content("Store Administrator: #{admin.name}")
    end

    it 'they see a link to update store info' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("Update Business Information")
    end

    it 'they see a link to all store items' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("See All Items for this Store")
    end

    it 'they see a link to all store orders' do
      login_user(admin.email, admin.password)
      visit admin_store_path(store.url)

      expect(page).to have_link("See All Orders for this Store")
    end
  end
end
