require "spec_helper"

RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_email) { "user@example.com" }
  let(:invalid_email) { "john-example.com" }
  let(:hubble_uuid) { "3650735786582309797" }

  describe "create" do
    context "with valid arguments" do
      let(:talent_account_creation) { HubbleApiClient::TalentAccount.create(email: valid_email) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_creation).to eq hubble_uuid
      end
    end

    context "with invalid arguments" do
      let(:talent_account_creation) { HubbleApiClient::TalentAccount.create(email: invalid_email) }
      it "should return nil" do
        expect(talent_account_creation).to be_nil
      end
    end
  end

  describe "update" do
    context "with valid arguments" do
      let(:talent_account_update) { HubbleApiClient::TalentAccount.update(attributes: {email: valid_email}, hubble_uuid: hubble_uuid) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_update).to eq hubble_uuid
      end
    end

    context "with invalid arguments" do
      let(:talent_account_update) { HubbleApiClient::TalentAccount.update(attributes: {email: invalid_email}, hubble_uuid: hubble_uuid) }
      it "should be nil" do
        expect(talent_account_update).to be_nil
      end
    end
  end
end
