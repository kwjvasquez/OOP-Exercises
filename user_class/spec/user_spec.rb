# frozen_string_literal: true

require_relative '../user'
require 'factories'

RSpec.describe User do
  subject(:users) { described_class.new }

  let(:info_user) { attributes_for(:user) }

  describe '.create' do
    context 'when all arguments are passed' do
      it 'add an user' do
        expect { users.create(**info_user) }.to change(users, :count).by(1)
      end

      it 'does not add an user' do
        users.create(**info_user)
        info_user2 = attributes_for(:user)
        info_user2[:id] = info_user[:id]
        expect { users.create(**info_user2) }.to change(users, :count).by(0)
      end
    end

    context 'when an optional arguments are not passed' do
      it 'add an user without the attibute' do
        info_user.delete(:age)
        users.create(**info_user)
        save_user = users.find(info_user[:id])
        expect(save_user[:age]).to be_nil
      end
    end

    context 'when an required argument are not passed' do
      it 'raises an error' do
        info_user.delete(:id)
        expect { users.create(**info_user) }.to raise_error(ArgumentError)
      end
    end
  end
end
