class Task < ApplicationRecord
	scope :sorted_by, -> (sort_option) do

    if sort_option.nil?
      order(priority: :desc).order(created_at: :desc)
    elsif sort_option.include?('deadline')
      order(deadline: :desc)
    else
      order(priority: :desc).order(created_at: :desc)
    end
  end
end
