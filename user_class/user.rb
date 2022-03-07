# frozen_string_literal: true

class User
  VALID_ATR = %i[first_name last_name email age address].freeze

  attr_reader :all

  def initialize
    @all = []
  end

  def create(id:, first_name:, last_name:, email:, **opt_info)
    info = {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email
    }
    info.merge!(age: opt_info[:age]) if opt_info[:age]
    info.merge!(address: opt_info[:address]) if opt_info[:address]

    @all << info
  end

  def count
    @all.size
  end

  def find(id)
    @all.find { |user| user if id == user[:id] }
  end

  def where(**filters)
    elements = []

    @all.each do |user|
      check = true
      filters.each do |atr, value|
        check = false unless user[atr] == value
      end
      elements << user if check
    end

    elements
  end

  def update(id:, **info_update)
    user = find(id)

    return unless user

    info_update.each do |atr, value_update|
      user[atr] = value_update if VALID_ATR.include?(atr)
    end
  end

  def destroy(id:)
    @all.delete_if { |user| id == user[:id] }
  end
end
