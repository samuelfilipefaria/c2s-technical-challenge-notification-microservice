require 'rails_helper'

RSpec.describe CreateWebScrapingNotificationService do
  subject {
    described_class.new(
      "Brand: Ferrari | Model: Spider | Price: R$ 1000000.00",
      "success",
      3
    )
  }

  describe ".perform" do
    context "all valid parameters" do
      it "creates the notification" do
        expect { subject.perform }.to change { WebScrapingNotification.count }.by(1)
      end
    end

    context "null scraped data" do
      it "creates the notification" do
        expect { subject.perform }.to change { WebScrapingNotification.count }.by(1)
      end
    end

    context "empty scraped data" do
      it "creates the notification" do
        expect { subject.perform }.to change { WebScrapingNotification.count }.by(1)
      end
    end

    context "null result" do
      it "raises an error" do
        subject.result = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty result" do
      it "raises an error" do
        subject.result = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null web scraping task id" do
      it "raises an error" do
        subject.web_scraping_task_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "negative web scraping task id" do
      it "raises an error" do
        subject.web_scraping_task_id = subject.web_scraping_task_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all null parameters" do
      it "raises an error" do
        subject.scraped_data = nil
        subject.result = nil
        subject.web_scraping_task_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end
  end
end
