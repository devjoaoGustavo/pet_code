# frozen_string_literal: true

class AnimalAllowanceValidator < ActiveModel::Validator
  def validate(record)
    validate_allowance(record) if record.person.present?
  end

  private

  def validate_allowance(record)
    unless record.person.able_to_have_cat?
      record.errors[:base] << "#{record.person.name} is not allowed to have cats"
    end

    unless record.person.able_to_have_swallow_bird?
      record.errors[:base] << "#{record.person.name} is not allowed to have swallow birds"
    end
  end
end
