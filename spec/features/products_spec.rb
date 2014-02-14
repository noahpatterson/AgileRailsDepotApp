require 'spec_helper'

describe "Products" do
  describe "GET /products" do

    before do
      create(:product)
      create(:product, title: 'new')
      visit '/products'
    end

    it "should visit the home page" do
      expect(page.status_code).to eq(200)
    end

    it 'should have 4 nav links' do
      expect(page).to have_css('#columns #side a', minimum: 4)
    end

    it 'should have a 2 main entries' do
      expect(page).to have_css('tr', count: 2)
    end

    it 'should have a title' do
      expect(page).to have_content 'Progamming Ruby 1.9'
      expect(page).to have_content 'new'
    end

    it 'should follow a show link' do
      first('.list_actions').click_on('Show')
      expect(current_path).to eq('/products/1')
      expect(page).to have_content('Progamming Ruby 1.9')
    end

    it 'should foollow a edit link' do
      first('.list_actions').click_on('Edit')
      expect(current_path).to eq('/products/1/edit')
      expect(page).to have_selector('form')
    end

    it 'should Destroy a product', js: true do
      page.evaluate_script('window.confirm = function() { return true; }')
      first('.list_actions').click_on('Destroy')
      expect(page).to_not have_content('Progamming Ruby 1.9')
    end

    it 'should follow create new product' do
      click_link 'Create new product'
      expect(current_path).to eq('/products/new')
      expect(page).to have_selector('form')
      expect(page).to have_css('#product_title', text: '')
    end

  end
end