# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Categories', type: :request do
  let!(:category) { Category.create!(title: 'Стратегии') }

  describe 'GET /api/v1/categories' do
    it 'returns list of categories' do
      get '/api/v1/categories'

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      expect(json).to include('data', 'meta')
      expect(json['data']).to be_an(Array)
      expect(json['data']).to include(
        a_hash_including(
          'id' => category.id,
          'title' => category.title
        )
      )
    end

    it 'supports pagination params' do
      get '/api/v1/categories', params: { limit: 5 }

      expect(response.parsed_body['meta']).to include('limit' => 5)
    end
  end

  describe 'GET /api/v1/categories/:id' do
    context 'when category exists' do
      it 'returns category' do
        get "/api/v1/categories/#{category.id}"

        expect(response).to have_http_status(:ok)

        json = response.parsed_body
        expect(json).to include(
          'id' => category.id,
          'title' => category.title
        )
      end
    end

    context 'when category does not exist' do
      it 'returns 404' do
        get '/api/v1/categories/999999'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/categories' do
    context 'with valid params' do
      let(:params) do
        {
          category: {
            title: 'Семейные игры'
          }
        }
      end

      it 'creates a category' do
        expect do
          post '/api/v1/categories', params: params
        end.to change(Category, :count).by(1)

        expect(response).to have_http_status(:created)

        json = response.parsed_body
        expect(json['title']).to eq('Семейные игры')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          category: {
            title: ''
          }
        }
      end

      it 'returns validation error' do
        expect do
          post '/api/v1/categories', params: params
        end.not_to change(Category, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/v1/categories/:id' do
    context 'with valid params' do
      let(:params) do
        {
          category: {
            title: 'Обновлённая категория'
          }
        }
      end

      it 'updates category' do
        patch "/api/v1/categories/#{category.id}", params: params

        expect(response).to have_http_status(:ok)
        expect(category.reload.title).to eq('Обновлённая категория')
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          category: {
            title: ''
          }
        }
      end

      it 'returns validation error' do
        patch "/api/v1/categories/#{category.id}", params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/categories/:id' do
    it 'deletes category' do
      expect do
        delete "/api/v1/categories/#{category.id}"
      end.to change(Category, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
