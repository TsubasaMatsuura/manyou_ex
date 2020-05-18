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

  validates :name, presence: true 
  validates :detail, presence: true 


  enum progress: { "未着手": 0, "着手中": 1, "完了": 2 }
  enum priority: { "低": 0, "中": 1, "高": 2 }

  scope :search_name, -> (name) { where("name LIKE ?", "%#{(name)}%") if name.present? }
  scope :search_progress, -> (progress) { where(progress: progress) if progress.present? }
end
