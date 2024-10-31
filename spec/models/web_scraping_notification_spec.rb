require 'rails_helper'

RSpec.describe WebScrapingNotification, type: :model do
  subject {
    described_class.new(
      scraped_data: "Brand: Ferrari | Model: Spider | Price: R$ 1000000.00",
      result: "success",
      web_scraping_task_id: 3
    )
  }

  context "all valid parameters" do
    it "is a valid notification" do
      expect(subject).to be_valid
    end
  end

  context "null scraped data" do
    it "is not a valid notification" do
      subject.scraped_data = nil
      expect(subject).to be_valid
    end
  end

  context "empty scraped data" do
    it "is not a valid notification" do
      subject.scraped_data = ""
      expect(subject).to be_valid
    end
  end

  context "null result" do
    it "is not a valid notification" do
      subject.result = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty result" do
    it "is not a valid notification" do
      subject.result = ""
      expect(subject).to_not be_valid
    end
  end

  context "null web scraping task id" do
    it "is not a valid notification" do
      subject.web_scraping_task_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty web scraping task id" do
    it "is not a valid notification" do
      subject.web_scraping_task_id = ""
      expect(subject).to_not be_valid
    end
  end
end
