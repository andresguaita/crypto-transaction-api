require 'rails_helper'

RSpec.describe Wallet, type: :model do

  it { should belong_to(:user) }


  it { should validate_presence_of(:currency) }


  it { should validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }
end
