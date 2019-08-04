# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'specification' do
    context 'db columns' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:document).of_type(:string).with_options(null: false) }
      it { is_expected.to have_db_column(:birthday).of_type(:date).with_options(null: false) }
    end

    context 'associations' do
      it { is_expected.to have_many(:animals) }
    end
  end

  describe '#able_to_have_swallow_bird?' do
    subject do
      described_class.new(name: 'Fulano', document: '12321', birthday: birthday)
    end

    context 'when the person is 18 years old' do
      let(:birthday) { (Date.today.years_ago 18) }

      it { is_expected.to be_able_to_have_swallow_bird }
    end

    context 'when the person is younger than 18' do
      let(:birthday) { (Date.today.years_ago 17) }

      it { is_expected.not_to be_able_to_have_swallow_bird }
    end

    context 'when the person is older than 18' do
      let(:birthday) { (Date.today.years_ago 28) }

      it { is_expected.to be_able_to_have_swallow_bird }
    end
  end

  describe '#able_to_have_cat?' do
    subject do
      described_class.new(name: name, document: '12321', birthday: Date.today.years_ago(18))
    end

    context 'when the name starts with a' do
      let(:name) { 'antonio' }

      it { is_expected.not_to be_able_to_have_cat }
    end

    context 'when the name starts with A' do
      let(:name) { 'Ana' }

      it { is_expected.not_to be_able_to_have_cat }
    end

    context 'when the name does not start with a or A' do
      let(:name) { 'Maria' }

      it { is_expected.to be_able_to_have_cat }
    end
  end

  describe '#cost_limit_reached?' do
    let(:animal_type) { AnimalType.create(name: 'Gato') }
    let(:person) do
      Person.new(
        name: 'Fulano',
        birthday: Date.today.years_ago(20),
        document: '123'
      )
    end

    context 'when cost with animals is exactly 1000' do
      before do
        Animal.create(
          name: 'Bob',
          monthly_cost: 1000,
          person: person,
          animal_type: animal_type
        )
        person.reload
      end

      it { expect(person.animals).to be_present }
      it { expect(person.cost_limit_reached?).to be false }
    end

    context 'when cost with animals is more than 1000' do
      before do
        Animal.create(
          name: 'Bob',
          monthly_cost: 1002,
          person: person,
          animal_type: animal_type
        )
        person.reload
      end

      it { expect(person.animals).to be_present }
      it { expect(person.cost_limit_reached?).to be true }
    end

    context 'when cost with animals is less than 1000' do
      before do
        Animal.create(
          name: 'Bob',
          monthly_cost: 999.99,
          person: person,
          animal_type: animal_type
        )
        person.reload
      end

      it { expect(person.animals).to be_present }
      it { expect(person.cost_limit_reached?).to be false }
    end
  end
end
