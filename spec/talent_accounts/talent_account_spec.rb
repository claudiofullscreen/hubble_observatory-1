require "spec_helper"
require "talent_accounts/shared/shared_examples"
RSpec.describe HubbleObservatory::TalentAccount do
  let(:valid_email) { "user@example.com" }
  let(:invalid_email) { "john-example.com" }
  let(:hubble_uuid) { "3650735786582309797" }
  let(:new_valid_email) { "user-#{Time.now.to_i}@example.com" }

  describe "create" do
    context "with valid arguments" do
      let(:talent_account_hubble_uuid) { HubbleObservatory::TalentAccount.create(email: valid_email) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_hubble_uuid).to be_a(String)
      end
    end

    context "with invalid arguments" do
      let(:talent_account_hubble_uuid) { HubbleObservatory::TalentAccount.create(email: invalid_email) }
      it "should return nil" do
        expect(talent_account_hubble_uuid).to be_nil
      end
    end

    context "connection errors" do
      include_examples "connection_errors" do
        let(:http_call) { HubbleObservatory::TalentAccount.create(email: valid_email) }
      end
    end
  end

  describe "update" do
    context "with existing valid email" do
      let(:talent_account_hubble_uuid) { HubbleObservatory::TalentAccount.new(id: hubble_uuid).update(email: valid_email) }
      it "should be nil" do
        expect(talent_account_hubble_uuid).to be_nil
      end
    end

    context "new valid email" do
      let(:talent_account_hubble_uuid) { HubbleObservatory::TalentAccount.new(id: hubble_uuid).update(email: new_valid_email) }
      it "should return a TalentAccount hubble id" do
        expect(talent_account_hubble_uuid).to be_a(String)
      end
    end

    context "with invalid arguments" do
      let(:talent_account_hubble_uuid) { HubbleObservatory::TalentAccount.new(id: hubble_uuid).update(email: invalid_email) }
      it "should be nil" do
        expect(talent_account_hubble_uuid).to be_nil
      end
    end

    context "connection errors" do
      include_examples "connection_errors" do
        let(:http_call) { HubbleObservatory::TalentAccount.new(id: hubble_uuid).update(email: valid_email) }
      end
    end
  end
end
