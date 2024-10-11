require 'rails_helper'

RSpec.describe Transaction, type: :model do

  it { should belong_to(:user).class_name('User').with_foreign_key('user_id') }


  it { should validate_presence_of(:currency_sent) }
  it { should validate_presence_of(:currency_received) }
  it { should validate_presence_of(:amount_sent) }
  it { should validate_presence_of(:amount_received) }

  it { should validate_numericality_of(:amount_sent).is_greater_than(0) }
end
