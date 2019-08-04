# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'specifications' do
    context 'database table columns' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:monthly_cost).of_type(:decimal) }
      it { is_expected.to have_db_column(:animal_type_id).of_type(:integer) }
      it { is_expected.to have_db_column(:person_id).of_type(:integer) }
    end

    context 'associations' do
      it { is_expected.to belong_to(:person) }
      it { is_expected.to belong_to(:animal_type) }
    end
  end

  describe 'validity' do
    let(:animal_type) { AnimalType.create(name: 'Gato') }
    let(:birthday) { Date.today.years_ago(20) }
    let(:name) { 'Fulano' }
    let(:person) do
      Person.new(
        name: name,
        birthday: birthday,
        document: '123'
      )
    end

    context 'when person has reached monthly cost' do
      before do
        Animal.create(
          name: 'Bob',
          monthly_cost: 1001,
          person: person,
          animal_type: animal_type
        )
        person.reload
      end

      it do
        animal = Animal.new(name: 'Ted', monthly_cost: 10, person: person, animal_type: animal_type)

        expect(animal).not_to be_valid
        expect(animal.errors.full_messages).to include 'Fulano has exceeded animal monthly cost'
      end
    end

    context 'when person is not allowed to have cats' do
      let(:name) { 'Amélia' }

      it do
        animal = Animal.new(name: 'Ted', monthly_cost: 10, person: person, animal_type: animal_type)

        expect(animal).not_to be_valid
        expect(animal.errors.full_messages).to include 'Amélia is not allowed to have cats'
      end
    end

    context 'when person is not allowed to have swallow birds' do
      let(:animal_type) { AnimalType.create(name: 'Andorinha') }
      let(:birthday) { Date.today.years_ago(17) }

      it do
        animal = Animal.new(name: 'Ted', monthly_cost: 10, person: person, animal_type: animal_type)

        expect(animal).not_to be_valid
        expect(animal.errors.full_messages).to include 'Fulano is not allowed to have swallow birds'
      end
    end
  end
end
