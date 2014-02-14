require 'spec_helper'

describe "Store" do
  describe "GET /" do

    before do
      create(:product)
      create(:product, title: 'new')
      visit '/'
    end

    it "should visit the home page" do
      expect(page.status_code).to eq(200)
    end

    it 'should have 4 nav links' do
      expect(page).to have_css('#columns #side a', minimum: 4)
    end

    it 'should have a 2 main entries' do
      expect(page).to have_css('#main .entry', count: 2)
    end

    it 'should have a title' do
      expect(page).to have_content 'Progamming Ruby 1.9'
    end

    it 'should havea formmated price' do
      expect(page).to have_css('.price', text: /\$[,\d]+\.\d\d/)
    end
  end
end
