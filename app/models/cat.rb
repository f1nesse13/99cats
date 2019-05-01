class Cat < ApplicationRecord
  COLORS = [
    "Grey", "Black", "White", "Orange", "Brown"
  ]
  validates :birth_date, :name, :description, presence: true
  validates :color, presence: true, inclusion: COLORS
  validates :sex, presence: true, inclusion: ["M", "F"]

  def age
    today = Date.today
    bday = self.birth_date
    if bday.mon == today.mon
      bday.mday <= today.mday ? (today.year - bday.year) : ((today.year - bday.year) - 1)
    else
      bday.mon > today.mon ? ((today.year - bday.year) - 1) : (today.year - bday.year)
    end
  end
end
