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
      xhr :post, 'create', comment: reply.attributes 
    end

    let(:comment)       { create(:comment, user: user) }
    let(:user_james)    { create(:user, name: "James") }

    context 'Success' do 
      let(:reply)     { build(:comment, user_id: user_james, parent_id: comment.id) }

      it 'save a comment' do
        do_request

        expect(Comment.all.size).to eq 2
      end
    end

    context 'failure' do
      let(:reply)      { build(:comment, message: '', user_id: user_james, parent_id: comment.id) }

      it 'renders new on failure' do
        do_request

        expect(Comment.all.size).to eq 1
      end
    end
  end

  describe '#edit' do
    def do_request
      xhr :post, 'edit', id: comment.id
    end

    let(:comment) { create(:comment) }

    it 'return comment' do
      do_request
      
      expect(assigns(:comment)).to eq comment
    end
  end

  describe '#update' do
    def do_request
      xhr :patch, 'update', id: comment.id, comment: comment_params
    end

    let!(:comment) { create(:comment) }

    context 'success' do 
      let(:comment_params) { attributes_for(:comment, message: 'new message') }
      it 'update a comment' do 
        do_request

        expect(comment.reload.message).to eq 'new message'
      end
    end

    context 'fail' do 
      let(:comment_params) { attributes_for(:comment, message: '') }
      it 'dont change message' do 
        do_request

        expect(comment.reload.message).to eq comment.message
      end
    end
  end
end