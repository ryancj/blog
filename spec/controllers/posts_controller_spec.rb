require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post)  { FactoryGirl.create(:post) }
  let(:user)  { FactoryGirl.create(:user) }

  describe '#new' do
    context 'With user signed in' do
      before { signin(user) }
      it 'instantiates a new Post object into a instance variable if user is signed in' do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

    it 'redirects to the sign-in page if the user is not signed in' do
      get :new
      expect(response).to redirect_to new_session_path
    end
  end

  describe '#create' do
    it 'renders #new if the post does not have a title' do
      post :create, post: FactoryGirl.attributes_for(:post, {title: nil})
      expect(response).to render_template(:new)
    end
  end

end
