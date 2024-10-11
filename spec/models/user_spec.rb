require 'rails_helper'

RSpec.describe User, type: :model do

  it { should have_many(:transactions).class_name('Transaction').with_foreign_key('user_id').dependent(:destroy) }
  it { should have_many(:wallets) }


  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }


end
