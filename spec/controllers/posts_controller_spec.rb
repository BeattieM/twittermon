require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'loads all of the posts into @posts' do
      post1 = FactoryGirl.create(:post)
      post2 = FactoryGirl.create(:post)
      get :index

      expect(assigns(:posts)).to match_array([post1, post2])
    end
  end

  describe 'POST #create without being logged in' do
    it 'should not have a current_user' do
      expect(subject.current_user).to eq(nil)
    end

    it 'fails to create a new Post object and responds with an HTTP 204 status code' do
      comment = Faker::Lorem.sentence
      allow(PokemonService).to receive(:search_for_pokemon).and_return(FactoryGirl.create(:pokemon))
      post :create, params: { post: { comment: comment } }

      expect(response).to be_success
      expect(response).to have_http_status(204)
      expect(Post.first).to eq(nil)
    end
  end

  describe 'POST #create while being logged in' do
    login_user

    it 'should have a current_user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'creates a new Post object and responds successfully with an HTTP 200 status code' do
      comment = Faker::Lorem.sentence
      allow(PokemonService).to receive(:search_for_pokemon).and_return(FactoryGirl.create(:pokemon))
      post :create, params: { post: { comment: comment } }

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(Post.first.comment).to eq(comment)
      expect(Post.first.user).to eq(subject.current_user)
    end
  end

  describe 'PATCH #update an existing Post' do
    login_user

    it 'successfully updates the Post' do
      post1 = FactoryGirl.create(:post, user: User.first)
      patch :update, params: { id: post1.uuid, post: { comment: 'updated' } }

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(Post.first.comment).to eq('updated')
    end
  end

  describe 'PATCH #update another users Post' do
    login_user

    it 'fails to update the Post' do
      post1 = FactoryGirl.create(:post)
      patch :update, params: { id: post1.uuid, post: { comment: 'updated' } }

      expect(response).not_to be_success
      expect(response).to have_http_status(404)
    end
  end

  describe 'PATCH #update a nonexistent Post' do
    login_user

    it 'fails to update the Post' do
      patch :update, params: { id: 'bad_uuid', post: { comment: 'updated' } }

      expect(response).not_to be_success
      expect(response).to have_http_status(404)
    end
  end

  describe 'DELETE #destroy an existing Post' do
    login_user

    it 'successfully flags the Post as deleted' do
      post1 = FactoryGirl.create(:post, user: User.first)
      delete :destroy, params: { id: post1.uuid }

      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(Post.count).to eq(0)
      expect(Post.with_deleted.count).to eq(1)
    end
  end

  describe 'DELETE #destroy another users Post' do
    login_user

    it 'fails to delete the Post' do
      post1 = FactoryGirl.create(:post)
      delete :destroy, params: { id: post1.uuid }

      expect(response).not_to be_success
      expect(response).to have_http_status(404)
    end
  end

  describe 'DELETE #destroy a nonexistent Post' do
    login_user

    it 'fails to delete the Post' do
      delete :destroy, params: { id: 'bad_uuid' }

      expect(response).not_to be_success
      expect(response).to have_http_status(404)
    end
  end
end
