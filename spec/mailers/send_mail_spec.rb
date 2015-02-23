require "rails_helper"

RSpec.describe SendMail, :type => :mailer do
  describe "sample_mail" do
    let(:mail) { SendMail.sample_mail }

    it "renders the headers" do
      expect(mail.subject).to eq("Sample mail")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
