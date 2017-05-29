require "rails_helper"

RSpec.describe User, type: :model do
   # tests for email
   it { is_expected.to validate_presence_of(:email) }
   it { is_expected.to validate_uniqueness_of(:email) }
   it { is_expected.to allow_value("user@blocipedia.com").for(:email) }
 
   # tests for password
   it { is_expected.to validate_presence_of(:password) }
   it { is_expected.to validate_length_of(:password).is_at_least(6) }
end
