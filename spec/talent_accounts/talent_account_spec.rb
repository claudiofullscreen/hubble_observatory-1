require "spec_helper"

RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_email) { "bruce.park@fullscreen.com" }
  let(:invalid_email) { "john-example.com" }
  let(:hubble_uuid) { 1234 }

  describe "create!" do
    context "with valid arguments" do
      it "should return a TalentAccount" do
        expect(HubbleApiClient::TalentAccount.create!(email: valid_email)).to be_a(HubbleApiClient::TalentAccount)
      end
    end

    context "with invalid arguments" do
      it "should raise an error" do
        expect { HubbleApiClient::TalentAccount.create!(email: invalid_email) }.to raise_error
      end
    end
  end

  describe "update!" do
    context "with valid arguments" do
      it "should return a TalentAccount" do
        expect(HubbleApiClient::TalentAccount.update!(attributes: {email: valid_email}, hubble_uuid: hubble_uuid)).to be_a(HubbleApiClient::TalentAccount)
      end
    end

    context "with invalid arguments" do
      it "should raise an error" do
        expect { HubbleApiClient::TalentAccount.update!(attributes: {email: invalid_email}, hubble_uuid: hubble_uuid) }.to raise_error
      end
    end
  end
end
