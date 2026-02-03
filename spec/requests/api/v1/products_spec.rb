# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  let!(:category) { Category.create!(title: 'Стратегии') }

  let!(:product) do
    Product.create!(
      title: 'Terraforming Mars',
      stock: 10,
      description: 'Полное описание игры',
      short_description: 'Краткое описание',
      rules: 'Правила игры',
      contents: 'Содержимое коробки',
      price: 3999.99,
      min_players: 1,
      max_players: 5,
      age_rating: 12,
      play_time: 120,
      category: category
    )
  end

  describe 'GET /api/v1/products' do
    it 'returns list of products' do
      get '/api/v1/products'

      expect(response).to have_http_status(:ok)

      json = response.parsed_body
      expect(json).to include('data', 'meta')
      expect(json['data']).to be_an(Array)
      expect(json['data']).to include(
        a_hash_including(
          'id' => product.id,
          'title' => product.title,
          'short_description' => product.short_description
        )
      )
    end

    it 'supports pagination params' do
      get '/api/v1/products', params: { limit: 5 }

      expect(response.parsed_body['meta']).to include('limit' => 5)
    end
  end

  describe 'GET /api/v1/products/:id' do
    context 'when product exists' do
      it 'returns product' do
        get "/api/v1/products/#{product.id}"

        expect(response).to have_http_status(:ok)

        json = response.parsed_body
        expect(json).to include(
          'id' => product.id,
          'title' => product.title,
          'description' => product.description,
          'rules' => product.rules,
          'contents' => product.contents
        )
      end
    end

    context 'when product does not exist' do
      it 'returns 404' do
        get '/api/v1/products/999999'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/products' do
    context 'with valid params' do
      let(:params) do
        {
          product: {
            title: 'Gloomhaven',
            stock: 5,
            description: 'Описание',
            short_description: 'Коротко',
            rules: 'Правила',
            contents: 'Компоненты',
            price: 9999,
            min_players: 1,
            max_players: 4,
            age_rating: 14,
            play_time: 180,
            category_id: category.id
          }
        }
      end

      it 'creates product' do
        expect do
          post '/api/v1/products', params: params
        end.to change(Product, :count).by(1)

        expect(response).to have_http_status(:created)

        json = response.parsed_body
        expect(json['title']).to eq('Gloomhaven')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          product: {
            title: '',
            category_id: category.id
          }
        }
      end

      it 'returns validation error' do
        expect do
          post '/api/v1/products', params: params
        end.not_to change(Product, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/v1/products/:id' do
    context 'with valid params' do
      let(:params) do
        {
          product: {
            title: 'Обновлённое название'
          }
        }
      end

      it 'updates product' do
        patch "/api/v1/products/#{product.id}", params: params

        expect(response).to have_http_status(:ok)
        expect(product.reload.title).to eq('Обновлённое название')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          product: {
            min_players: 5,
            max_players: 2
          }
        }
      end

      it 'returns validation error' do
        patch "/api/v1/products/#{product.id}", params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/products/:id' do
    it 'deletes product' do
      expect do
        delete "/api/v1/products/#{product.id}"
      end.to change(Product, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
