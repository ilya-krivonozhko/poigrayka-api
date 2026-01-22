# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { |ex| described_class.new(ex.metadata[title] || 'Card games') }

  describe 'validations' do
    it 'is valid with a valid title' do
      category = described_class.new(title: 'Настольные игры')
      expect(category).to be_valid
    end

    it 'is invalid without a title' do
      category = described_class.new(title: nil)
      expect(category).not_to be_valid
      expect(category.errors[:title]).to include("can't be blank")
    end

    it 'is invalid if the title is not unique (case insensitive)' do
      described_class.create!(title: 'Стратегии')
      duplicate = described_class.new(title: 'стратегии')
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:title]).to include('has already been taken')
    end

    it 'is invalid if the title is longer than 50 characters' do
      long_title = 'a' * 51
      category = described_class.new(title: long_title)
      expect(category).not_to be_valid
      expect(category.errors[:title]).to include('is too long (maximum is 50 characters)')
    end

    it 'is valid with a title exactly 50 characters long' do
      valid_title = 'a' * 50
      category = described_class.new(title: valid_title)
      expect(category).to be_valid
    end
  end
end
