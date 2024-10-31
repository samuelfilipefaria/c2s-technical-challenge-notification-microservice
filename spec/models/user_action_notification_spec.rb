require 'rails_helper'

RSpec.describe UserActionNotification, type: :model do
  subject {
    described_class.new(
      actor_id: 1,
      action: "created",
      user_task_id: 3
    )
  }

  context "all valid parameters" do
    it "is a valid notification" do
      expect(subject).to be_valid
    end
  end

  context "null actor id" do
    it "is not a valid notification" do
      subject.actor_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty actor id" do
    it "is not a valid notification" do
      subject.actor_id = ""
      expect(subject).to_not be_valid
    end
  end

  context "null action" do
    it "is not a valid notification" do
      subject.action = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty action" do
    it "is not a valid notification" do
      subject.action = ""
      expect(subject).to_not be_valid
    end
  end

  context "null user task id" do
    it "is not a valid notification" do
      subject.user_task_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty user task id" do
    it "is not a valid notification" do
      subject.user_task_id = ""
      expect(subject).to_not be_valid
    end
  end
end
