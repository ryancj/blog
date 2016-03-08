require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    it 'validates the presence of the post title' do
      post = Post.create(title: '')
      post.valid?
      expect(post.errors.messages).to have_key(:title)
    end

    it 'validates the minimum length of post title' do
      post = Post.create(title: 'abcdef')
      post.valid?
      expect(post.errors.messages).to have_key(:title)
    end

    it 'validates the presence of the post body' do
      post = Post.create(body: '')
      post.valid?
      expect(post.errors.messages).to have_key(:body)
    end
  end

  describe '.body_snippet' do
    it 'returns max. 100 characters with "..." at the end of it' do
      chars = 'c' * 100
      post = Post.new(body: chars)
      expect(post.body_snippet).to eq(('c' * 100) + '...')
    end
  end

end
