require "spec_helper"
shared_examples "connection_errors" do
  HubbleObservatory::ConnectionError.errors.each do |connection_error|
    context "given #{connection_error.to_s}" do
      let(:error) { connection_error.new }
      before { expect(Net::HTTP).to(receive(:start).and_raise error) }
      it { expect { http_call }.to raise_error(HubbleObservatory::ConnectionError) }
    end
  end
end
