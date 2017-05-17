require "spec_helper"
require "talent_accounts/shared/shared_examples"
RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_email) { "user@example.com" }
  let(:invalid_email) { "john-example.com" }
  let(:hubble_uuid) { "3650735786582309797" }

  describe "create" do
    context "with valid arguments" do
      let(:talent_account_creation) { HubbleApiClient::TalentAccount.create(email: valid_email) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_creation).to be_a(String)
      end
    end

    context "with invalid arguments" do
      let(:talent_account_creation) { HubbleApiClient::TalentAccount.create(email: invalid_email) }
      it "should return nil" do
        expect(talent_account_creation).to be_nil
      end
    end

    context "connection errors" do
      include_examples "connection_errors" do
        let(:http_call) { HubbleApiClient::TalentAccount.create(email: valid_email) }
      end
    end
  end

  describe "mock#create" do
    let(:talent_account) { HubbleApiClient::TalentAccount }
    context "with valid arguments" do
      it "should return a TalentAccount hubble id" do
        allow(talent_account).to receive(:create).with(email: valid_email).and_return(hubble_uuid)
        expect(talent_account.create(email: valid_email)).to eq(hubble_uuid)
      end
    end

    context "with invalid arguments" do
      it "should return nil" do
        allow(talent_account).to receive(:create).with(email: invalid_email).and_return(nil)
        expect(talent_account.create(email: invalid_email)).to be_nil
      end
    end
  end

  describe "update" do
    context "with valid arguments" do
      let(:talent_account_update) { HubbleApiClient::TalentAccount.new(id: hubble_uuid).update(email: valid_email) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_update).to be_a(String)
      end
    end

    context "with invalid arguments" do
      let(:talent_account_update) { HubbleApiClient::TalentAccount.new(id: hubble_uuid).update(email: invalid_email) }
      it "should be nil" do
        expect(talent_account_update).to be_nil
      end
    end

    context "connection errors" do
      include_examples "connection_errors" do
        let(:http_call) { HubbleApiClient::TalentAccount.new(id: hubble_uuid).update(email: valid_email) }
      end
    end
  end

  describe "mock#update" do
    let(:talent_account) { HubbleApiClient::TalentAccount.new(id: hubble_uuid) }
    context "with valid arguments" do
      let(:attrs) { {email: valid_email} }
      it "should return a TalentAccount hubble id" do
        allow(talent_account).to receive(:update).with(attrs).and_return(hubble_uuid)
        expect(talent_account.update(attrs)).to be_a(String)
      end
    end

    context "with invalid arguments" do
      let(:attrs) { {email: invalid_email} }
      it "should be nil" do
        allow(talent_account).to receive(:update).with(attrs).and_return(nil)
        expect(talent_account.update(attrs)).to be_nil
      end
    end
  end
end
