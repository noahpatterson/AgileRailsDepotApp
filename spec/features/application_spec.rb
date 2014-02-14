require 'spec_helper'

describe "Application" do
  describe "GET /" do
    it 'should display the current time' do
      visit '/'
      expect(find('#time').text.to_time).to be_within(50).of(Time.now)
    end
  end
end