require "spec_helper"

RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_email_with_user_id) { { email: "bruce.park@fullscreen.com", id: 1 } }
  let(:invalid_email_with_user_id) { { email: "john-example.com", id: 1  } }

  describe "find_or_create_by!" do
    context "valid_email_with_user_id" do
      it "should return a TalentAccount" do
        expect(HubbleApiClient::TalentAccount.find_or_create_by!(valid_email_with_user_id)).to be_a(HubbleApiClient::TalentAccount)
      end
    end

    context "invalid_email_with_user_id" do
      it "should raise an error" do
        expect { HubbleApiClient::TalentAccount.find_or_create_by!(invalid_email_with_user_id) }.to raise_error
      end
    end
  end
end
