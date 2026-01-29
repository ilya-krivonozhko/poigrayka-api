# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.create!(title: 'Board games') }

  let(:valid_attributes) do
    {
      title: 'Game',
      description: 'Full description',
      short_description: 'Short description',
      rules: 'Game rules',
      contents: 'Box contents',
      stock: 10,
      price: 1999,
      age_rating: 10,
      play_time: 60,
      min_players: 2,
      max_players: 4,
      category: category
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      product = described_class.new(valid_attributes)
      expect(product).to be_valid
    end

    it 'is invalid without a title' do
      product = described_class.new(valid_attributes.merge(title: nil))
      expect(product).not_to be_valid
      # TODO(i18n): add translation
      expect(product.errors[:title]).to include("can't be blank")
    end

    it 'is invalid if title is too short' do
      product = described_class.new(valid_attributes.merge(title: 'A'))
      expect(product).not_to be_valid
    end

    it 'is invalid if title is too long' do
      product = described_class.new(valid_attributes.merge(title: 'a' * 81))
      expect(product).not_to be_valid
    end

    it 'is invalid without description fields' do
      %i[description short_description rules contents].each do |field|
        product = described_class.new(valid_attributes.merge(field => nil))
        expect(product).not_to be_valid
        # TODO(i18n): add translation
        expect(product.errors[field]).to include("can't be blank")
      end
    end

    it 'is invalid if short_description is longer than 150 characters' do
      product = described_class.new(
        valid_attributes.merge(short_description: 'a' * 151)
      )
      expect(product).not_to be_valid
    end

    it 'is invalid with negative stock' do
      product = described_class.new(valid_attributes.merge(stock: -1))
      expect(product).not_to be_valid
    end

    it 'is invalid with non-integer stock' do
      product = described_class.new(valid_attributes.merge(stock: 1.5))
      expect(product).not_to be_valid
    end

    it 'is invalid with negative price' do
      product = described_class.new(valid_attributes.merge(price: -10))
      expect(product).not_to be_valid
    end

    it 'is invalid with too large price' do
      product = described_class.new(valid_attributes.merge(price: 10_000_000))
      expect(product).not_to be_valid
    end

    it 'is invalid with negative age_rating' do
      product = described_class.new(valid_attributes.merge(age_rating: -1))
      expect(product).not_to be_valid
    end

    it 'is invalid with zero play_time' do
      product = described_class.new(valid_attributes.merge(play_time: 0))
      expect(product).not_to be_valid
    end

    it 'is invalid with negative play_time' do
      product = described_class.new(valid_attributes.merge(play_time: -10))
      expect(product).not_to be_valid
    end

    it 'is invalid with zero min_players' do
      product = described_class.new(valid_attributes.merge(min_players: 0))
      expect(product).not_to be_valid
    end

    it 'is invalid with zero max_players' do
      product = described_class.new(valid_attributes.merge(max_players: 0))
      expect(product).not_to be_valid
    end

    it 'is invalid with too much max_players' do
      product = described_class.new(valid_attributes.merge(max_players: 101))
      expect(product).not_to be_valid
    end

    it 'is invalid when min_players is greater than max_players' do
      product = described_class.new(
        valid_attributes.merge(min_players: 5, max_players: 2)
      )
      expect(product).not_to be_valid
      # TODO(i18n): add translation
      expect(product.errors[:min_players]).to include(
        'не может быть больше чем максимальное количество игроков'
      )
    end
  end
end
