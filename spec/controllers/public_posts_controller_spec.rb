require 'rails_helper'

RSpec.describe Public::PostsController, type: :controller do
  let(:customer) { create(:customer) }
  let(:genre) { create(:genre) }

  before do
    sign_in customer  # Deviseヘルパーでログイン再現
  end

  describe 'GET #index' do
    it 'レスポンスが成功すること' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    let(:post_record) { create(:post, customer: customer, genre: genre) }

    it '投稿詳細が表示されること' do
      get :show, params: { id: post_record.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:post)).to eq(post_record)
    end
  end

  describe 'POST #create' do
    context '有効なパラメータの場合' do
      it '新しい投稿が作成されること' do
        valid_params = {
          post: {
            title: "RSpec投稿テスト",
            introduction: "これはRSpecのcreateテストです",
            genre_id: genre.id
          }
        }

        expect {
          post :create, params: valid_params
        }.to change(Post, :count).by(1)
      end
    end

    context '無効なパラメータの場合' do
      it '投稿が作成されないこと' do
        invalid_params = {
          post: {
            title: '',
            introduction: '',
            genre_id: nil
          }
        }

        expect {
          post :create, params: invalid_params
        }.not_to change(Post, :count)
      end
    end
  end
end
