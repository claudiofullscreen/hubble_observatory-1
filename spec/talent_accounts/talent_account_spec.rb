require "spec_helper"

RSpec.describe HubbleApiClient::TalentAccount do
  let(:valid_args) { { email: "bruce.park@fullscreen.com", gorilla_id: 1 } }
  let(:invalid_args) { { email: "john-example.com", gorilla_id: 1  } }

  describe "find_or_create_by!" do
    context "with valid email and id arguments" do
      it "should return a TalentAccount" do
        expect(HubbleApiClient::TalentAccount.find_or_create_by!(valid_args)).to be_a(HubbleApiClient::TalentAccount)
      end
    end

    context "with invalid  email and id arguments" do
      it "should raise an error" do
        expect { HubbleApiClient::TalentAccount.find_or_create_by!(invalid_args) }.to raise_error
      end
    end
  end
end
