class Pomo < ApplicationRecord
  belongs_to :user
  validates :start_time, presence: true
  validate :end_time_must_be_greater_than_start_time, :passage_seconds_must_be_greater_than_or_equal_to_remainder_between_end_time_and_start_time
  validates :user_id, presence: true
  validates :passage_seconds,
    numericality: { greater_than_or_equal_to: 0,
                    less_than_or_equal_to: 1500 }
  def end_time_must_be_greater_than_start_time
    return if end_time.blank? || start_time.blank?
    if (end_time <=> start_time) <= 0
      errors.add(:end_time, 'end_time must be greater than start_time')
    end
  end

  def passage_seconds_must_be_greater_than_or_equal_to_remainder_between_end_time_and_start_time
    return if end_time.blank? || start_time.blank? || passage_seconds.blank?
    if (end_time - start_time).to_i < passage_seconds
      errors.add(:passage_seconds, 'passage_seconds must be less than a remainder between start_time and end_time')
    end
  end

end
