require 'rails_helper'

describe Post, type: :request do
  context 'list posts' do
    it 'successfully' do
      get '/api/v1/posts'

      expect(response).to have_http_status(:ok)
    end
  end

  context 'create a post' do
    it 'successfully' do
      user = create(:user, :valid)
      params = { post: { body: 'Good Stuff' } }
      headers = { Authorization: JsonWebTokenService.encode(user_id: user.id) }

      post '/api/v1/posts', params: params, headers: headers

      expect(response).to have_http_status(:created)
    end

    context 'failure' do
      it 'token not sended' do
        params = { post: { body: 'Good Stuff' } }

        post '/api/v1/posts', params: params

        expect(response).to have_http_status(:unauthorized)
      end

      it 'blank body' do
        user = create(:user, :valid)
        big_string = 'a' * 281
        params = { post: { body: big_string } }
        headers = { Authorization: JsonWebTokenService.encode(user_id: user.id) }

        post '/api/v1/posts', params: params, headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'show' do
    it 'successfully' do
      post = create(:post)
      user = create(:user, email: 'another@email.com', password: '123456')
      headers = { Authorization: JsonWebTokenService.encode(user_id: user.id) }

      get "/api/v1/posts/#{post.id}", headers: headers

      expect(response).to have_http_status(:ok)
    end

    it 'record not found' do
      user = create(:user, email: 'another@email.com', password: '123456')
      headers = { Authorization: JsonWebTokenService.encode(user_id: user.id) }

      get '/api/v1/posts/123', headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'destroy' do
    it 'successfully' do
      user = create(:user, :valid)
      post = create(:post, user: user)
      headers = { Authorization: JsonWebTokenService.encode(user_id: user.id) }

      delete "/api/v1/posts/#{post.id}", headers: headers

      expect(response).to have_http_status(:ok)
    end
  end
end
