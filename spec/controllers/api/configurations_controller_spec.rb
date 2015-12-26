require 'rails_helper'

RSpec.describe Api::ConfigurationsController, type: :controller do
  it "should list configurations" do
    get :index, format: :json
    expect(json_response).to eql Rails.application.config.configuration
  end
end
