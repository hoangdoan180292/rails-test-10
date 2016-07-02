require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user)  { create(:user) }

  before { @request.env['devise.mapping'] = Devise.mappings[:user] }
  before { sign_in user }

  describe '#index' do
    let!(:comments)  { create_list(:comment, 2) }

    it 'return list of comments' do
      get :index

      expect(assigns(:comments)).to eq comments
      expect(assigns(:comment)).to be_a Comment
    end
  end
end