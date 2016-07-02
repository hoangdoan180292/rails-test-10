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

  describe '#create' do
    def do_request
      post :create, comment: comment.attributes
    end

    context 'Success' do 
      let(:comment) { build(:comment, user: user, id: '') }

      it 'save a comment' do
        expect{ do_request }.to change(Comment, :count).by(1)
      end
    end

    context 'failure' do
      let(:comment)      { build(:comment, message: '', id: '') }

      it 'renders new on failure' do
        expect{ do_request }.to_not change{ Comment.count }
      end
    end
  end

  describe '#reply' do
    def do_request
      post :reply, comment: reply.attributes, id: comment.id
    end

    let(:comment)       { create(:comment, user: user) }
    let(:user_james)    { create(:user, name: "James") }

    context 'Success' do 
      let(:reply)     { build(:comment, user_id: user_james) }

      it 'save a comment' do
        do_request

        expect(Comment.all.size).to eq 2
      end
    end

    context 'failure' do
      let(:reply)      { build(:comment, message: '', user_id: user_james) }

      it 'renders new on failure' do
        do_request

        expect(Comment.all.size).to eq 1
      end
    end
  end
end