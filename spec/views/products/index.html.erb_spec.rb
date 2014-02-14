require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :title => "Title",
        :description => "MyText",
        :image_url => "Image Url.jpg",
        :price => 9.99
      ),
      stub_model(Product,
        :title => "Title",
        :description => "MyText",
        :image_url => "Image Url.jpg",
        :price => 9.99
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "dt", :text => "Title".to_s, :count => 2
    assert_select "dd", :text => "MyText".to_s, :count => 2
    expect(rendered).to have_xpath("//img[contains(@src,\"/images/Image Url.jpg\")]", count: 2)
    # assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
