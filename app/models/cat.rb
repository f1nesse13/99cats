class Cat < ApplicationRecord
  COLORS = [
    "Grey", "Black", "White", "Orange", "Brown",
  ]
  validates :birth_date, :name, :description, presence: true
  validates :color, presence: true, inclusion: COLORS
  validates :sex, presence: true, inclusion: ["M", "F"]

  has_many :rental_requests, dependent: :destroy,
                             foreign_key: :cat_id,
                             class_name: "CatRentalRequest"

  def age
    today = Date.today
    bday = self.birth_date
    if bday.mon == today.mon
      bday.mday <= today.mday ? (today.year - bday.year) : ((today.year - bday.year) - 1)
    else
      bday.mon > today.mon ? ((today.year - bday.year) - 1) : (today.year - bday.year)
    end
  end

  def ordered_rentals
    self.rental_requests.order(:start_date)
  end
end
