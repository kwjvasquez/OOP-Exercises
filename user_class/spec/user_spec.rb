# frozen_string_literal: true

require_relative '../user'
require 'factories'

RSpec.shared_context "user info" do
  let(:user) { subject.create(**info_user) }
  let(:user_id) { info_user[:id] }

  before do
    user
  end
end

RSpec.describe User do
  subject { described_class.new }

  let(:info_user) { attributes_for(:user) }

  describe ".create" do
    context "when all arguments are passed" do
      context "when the user id does not exist" do
        it "adds a user" do
          expect { subject.create(**info_user) }.to change(subject, :count).by(1)
        end
      end

      context "when the user id already exists" do
        it "does not add a user" do
          subject.create(**info_user)
          info_user2 = attributes_for(:user)
          info_user2[:id] = info_user[:id]
          expect { subject.create(**info_user2) }.to change(subject, :count).by(0)
        end
      end
    end

    context "when an optional argument is not passed" do
      it "adds a user without the attribute" do
        info_user.delete(:age)
        subject.create(**info_user)
        save_user = subject.find(info_user[:id])
        expect(save_user[:age]).to be_nil
      end
    end

    context "when a required argument is not passed" do
      it "raises an error" do
        info_user.delete(:id)
        expect { subject.create(**info_user) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#find" do
    include_context "user info"

    context "when the user exists" do
      it "returns the information" do
        expect(subject.find(user_id)).to eq(info_user)
      end
    end

    context "when the user does not exist" do
      let(:user_id) { 999 }

      it "returns nil" do
        expect(subject.find(user_id)).to be_nil
      end
    end
  end

  describe ".update" do
    include_context "user info"

    let(:update_info) { attributes_for(:user).except(:id, :last_name, :email) }

    context "When the user exists" do
      it "update the information" do
        expect { subject.update(id: user_id, **update_info) }.to change { subject.find(user_id) }
      end

      it "changes the users list" do
        expect { subject.update(id: user_id, **update_info) }.to change { subject.all }
      end
    end

    context "when the user does not exist" do
      let(:user_id) { 999 }

      it "does not change the users list" do
        expect { subject.update(id: user_id, **update_info) }.not_to change { subject.all }
      end

      it "returns nil" do
        expect(subject.update(id: user_id, **update_info)).to be_nil
      end
    end
  end
end
