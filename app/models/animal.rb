# frozen_string_literal: true

class Animal < ApplicationRecord
  belongs_to :person
  belongs_to :animal_type

  validates_with AnimalMonthlyCostValidator
  validates_with AnimalAllowanceValidator

  DOG = 'Cachorro'

  def self.mean_of_monthly_cost_for_dogs
    dogs
      .then do |collection|
      collection.sum(&:monthly_cost) / collection.length
    end
  end

  def self.dogs
    joins(:animal_type)
      .where(animal_types: { name: DOG })
  end
end
