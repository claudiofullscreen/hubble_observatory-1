require "spec_helper"

RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_email) { "brian.lu@fullscreen.com" }
  let(:invalid_email) { "john-example.com" }
  let(:hubble_uuid) { "1234" }

  describe "create" do
    context "with valid arguments" do
      let(:talent_account) { HubbleApiClient::TalentAccount.create(email: valid_email) }
      it "should return a TalentAccount" do
        expect(talent_account).to be_a(HubbleApiClient::TalentAccount)
        expect(talent_account.hubble_uuid).to eq hubble_uuid
      end
    end

    context "with invalid arguments" do
      it "should return nil" do
        expect(HubbleApiClient::TalentAccount.create(email: invalid_email)).to eq(nil)
      end
    end
  end

  describe "update" do
    context "with valid arguments" do
      let(:talent_account) { HubbleApiClient::TalentAccount.update(attributes: {email: valid_email}, hubble_uuid: hubble_uuid) }
      it "should return a TalentAccount" do
        expect(talent_account).to be_a(HubbleApiClient::TalentAccount)
        expect(talent_account.hubble_uuid).to eq hubble_uuid
      end
    end

    context "with invalid arguments" do
      it "should raise an error" do
        expect(HubbleApiClient::TalentAccount.update(attributes: {email: invalid_email}, hubble_uuid: hubble_uuid)).to eq(nil)
      end
    end
  end
end
