# frozen_string_literal: true

require "rails_helper"
require "spec_helper"

# AppSettings
#
# Simple access to Rails.configuration.settings[:some_key]
#
# Rails.configuration.settings[:some_key]                       # Some Value
# or
# AppSettings.some_key                                          # Some Value
#
# see: config/klue-settings.yml
describe AppSettings do
  before(:each) do
    FactoryBot.reload
  end

  # --------------------------------------------------------------------------------
  # AppSettings - Access known settings
  # --------------------------------------------------------------------------------

  context "access application settings" do
    before(:each) do
      FactoryBot.reload
    end

    it "should have configured settings" do
      expect(AppSettings::SOME_VALUE).to_not be_nil

      L.kv "SOME_VALUE", AppSettings::SOME_VALUE
    end
  end
end
