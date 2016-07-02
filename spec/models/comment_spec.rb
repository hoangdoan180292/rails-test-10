require 'rails_helper'

RSpec.describe Comment, :type => :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :message }
  end

  context 'associations' do
    it { is_expected.to have_many :replies  }

    it { is_expected.to belong_to :parent   }
    it { is_expected.to belong_to :user     }
  end
end