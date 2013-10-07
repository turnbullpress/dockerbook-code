require 'spec_helper'

describe TProv::Application do

  describe "GET '/'" do
    it "should return the index page." do
      get '/'
      last_response.should be_ok
    end
  end

  describe "GET '/tomcat/list'" do
    it "should return the Tomcat list instances page." do
      get '/tomcat/list'
      last_response.should be_ok
    end
  end
end
