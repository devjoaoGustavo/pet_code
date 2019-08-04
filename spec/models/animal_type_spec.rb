# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalType, type: :model do
  describe 'specifications' do
    context 'database table columns' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end
  end
end
