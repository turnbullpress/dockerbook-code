require 'spec_helper'

describe WProv::Application do

  describe "GET '/'" do
    it "should return the index page." do
      get '/'
      last_response.should be_ok
    end
  end

  describe "GET '/wordpress/list'" do
    it "should return the Wordpress list instances page." do
      get '/wordpress/list'
      last_response.should be_ok
    end
  end

  describe "POST '/wordpress/create'" do
    it "should create a Wordpress instance." do
      post '/wordpress/create'
      last_response.should be_ok
    end
  end

  describe "POST '/wordpress/delete'" do
    it "should delete a Wordpress instance." do
      post '/wordpress/delete'
      last_response.should be_ok
    end
  end
end
