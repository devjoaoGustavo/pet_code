# frozen_string_literal: true

class Person < ApplicationRecord
  has_many :animals

  MONTHLY_COST_LIMIT = 1000.0

  def self.names_of_who_has_dogs
    joins(animals: :animal_type)
      .where(animal_types: { name: 'Cachorro' })
      .pluck(:name)
  end

  def self.ordered_reversed_by_animal_monthly_cost
    eager_load(:animals)
      .sort_by(&:animal_monthly_cost)
      .reverse
  end

  def self.three_months_cost
    ordered_reversed_by_animal_monthly_cost
      .map do |person|
      [person, (person.animal_monthly_cost * 3).to_f]
    end
  end

  def able_to_have_swallow_bird?
    birthday.years_since(18) <= Date.today
  end

  def able_to_have_cat?
    !name.start_with?(/a|A/)
  end

  def cost_limit_reached?
    animal_monthly_cost > MONTHLY_COST_LIMIT
  end

  def animal_monthly_cost
    animals.sum(&:monthly_cost)
  end
end
