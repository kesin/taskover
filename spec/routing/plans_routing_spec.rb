require 'rails_helper'

RSpec.describe "routing to plans", :type => :routing do

  it "routes / to plans#index" do
    expect(:get => "/").to route_to(
                               :controller => "plans",
                               :action => "index"
                           )
  end

  it "routes /plans/:id to plan#show for id" do
    expect(:get => "/plans/1").to route_to(
                                      :controller => "plans",
                                      :action => "show",
                                      :id => "1"
                                  )
  end

end