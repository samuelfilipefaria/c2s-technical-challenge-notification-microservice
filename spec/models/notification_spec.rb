require 'rails_helper'

RSpec.describe Notification, :type => :model do
  subject {
    described_class.new(
      task_description: "Task",
      user_id: "3",
      operation: "creation",
      task_id: "7",
      scraped_data: "Brand: Ferrari | Model: Spider | Price: R$ 1000000"
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a task_description" do
    subject.task_description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a operation" do
    subject.operation = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a task_id" do
    subject.task_id = nil
    expect(subject).to_not be_valid
  end

  it "is valid without scraped_data" do
    subject.scraped_data = nil
    expect(subject).to be_valid
  end
end
