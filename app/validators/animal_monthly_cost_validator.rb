# frozen_string_literal: true

class AnimalMonthlyCostValidator < ActiveModel::Validator
  def validate(record)
    validate_monthly_cost(record) if record.person.present?
  end

  private

  def validate_monthly_cost(record)
    if record.person.cost_limit_reached?
      record.errors[:base] << "#{record.person.name} has exceeded animal monthly cost"
    end
  end
end
