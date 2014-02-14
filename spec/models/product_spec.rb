require 'spec_helper'

describe Product do

  let(:product) { create(:product)}

  #test validation
  it 'should not contain empty product attributes' do
    bad_product = Product.new
    expect(bad_product.invalid?).to be_true
    expect(bad_product.errors[:title].any?).to be_true
    expect(bad_product.errors[:description].any?).to be_true
    expect(bad_product.errors[:price].any?).to be_true
    expect(bad_product.errors[:image_url].any?).to be_true
  end

  it 'should have price as positive' do
    product.price = -1
    expect(product.invalid?).to be_true
    expect(product.errors[:price]).to eq(['must be greater than or equal to 0.01'])

    product.price = 0
    expect(product.invalid?).to be_true
    expect(product.errors[:price]).to eq(['must be greater than or equal to 0.01'])

    product.price = 1
    expect(product.valid?).to be_true
  end

  it 'should have an image url with .jpg, .png or .gif' do
    ok = %w{ fred.gif fred.jpg fred.png FRED.jpg FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    good = ok.map do |img| 
      product.image_url = img
      product.valid? 
    end
    expect(good.all?).to be_true

    bad = bad.map { |img| 
      product.image_url = img
      product.valid? }
    expect(bad.any?).to be_false, "there is an good image in the bad list"
  end

  it 'should have an unique name' do
    product
    product_new = build(:product, price: 40.00)
    expect(product_new).to_not be_valid
    expect(product_new.errors[:title]).to eq(['has already been taken'])
  end

  it 'should have a description of >= 10 characters' do
    expect(product).to be_valid
    product.description= 'a'
    expect(product).to_not be_valid
    expect(product.errors[:description]).to eq(["You need to have description of at least 10 characters"])
  end

  describe '#latest' do
    it 'should return the last updated product' do
      create(:product, title: 'new')
      expect(Product.latest.title).to eq('new')
    end
  end
end
