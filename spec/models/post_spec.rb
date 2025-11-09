require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:customer) { create(:customer) }
  let(:genre) { create(:genre) }
  let(:post) { build(:post, customer: customer, genre: genre) }

  context 'バリデーションのテスト' do
    it 'タイトルと本文があれば有効である' do
      expect(post).to be_valid
    end

    it 'タイトルがない場合は無効である' do
      post.title = ""
      expect(post).to_not be_valid
    end

    it 'タイトルが100文字を超える場合は無効である' do
      post.title = "あ" * 101
      expect(post).to_not be_valid
    end

    it '本文がない場合は無効である' do
      post.introduction = ""
      expect(post).to_not be_valid
    end

    it '本文が2000文字以内であれば有効である' do
      post.introduction = "あ" * 500
      expect(post).to be_valid
    end

    it '本文が2001文字以上の場合は無効である' do
      post.introduction = "あ" * 501
      expect(post).to_not be_valid
    end
  end
end