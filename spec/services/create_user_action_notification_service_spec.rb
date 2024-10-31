require 'rails_helper'

RSpec.describe CreateUserActionNotificationService do
  subject {
    described_class.new(
      1,
      "created",
      3
    )
  }

  describe ".perform" do
    context "all valid parameters" do
      it "creates the notification" do
        expect { subject.perform }.to change { UserActionNotification.count }.by(1)
      end
    end

    context "null actor id" do
      it "raises an error" do
        subject.actor_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "negative actor id" do
      it "raises an error" do
        subject.actor_id = subject.actor_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null action" do
      it "raises an error" do
        subject.action = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty action" do
      it "raises an error" do
        subject.action = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null user task id" do
      it "raises an error" do
        subject.user_task_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "negative user task id" do
      it "raises an error" do
        subject.user_task_id = subject.user_task_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all null parameters" do
      it "raises an error" do
        subject.actor_id = nil
        subject.action = nil
        subject.user_task_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end
  end
end
