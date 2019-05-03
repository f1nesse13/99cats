class CatRentalRequest < ApplicationRecord
  validate :cat_id, :start_date, :end_date, :status
  validates :status, inclusion: ["PENDING", "APPROVED", "DENIED"]
  validate :does_not_overlap_approved_request, :start_date_before_end_date

  belongs_to :cat,
             foreign_key: :cat_id,
             class_name: "Cat"

  def overlapping_requests
    CatRentalRequest.where.not(id: self.id).where(cat_id: cat_id).where.not("end_date < :start_date or start_date > :end_date", start_date: self.start_date, end_date: self.end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: "PENDING")
  end

  def does_not_overlap_approved_request
    unless overlapping_approved_requests.empty?
      errors[:base] << "Overlaps an already approved request"
    end
  end

  def start_date_before_end_date
    unless self.end_date > self.start_date
      errors[:base] << "Start date must come before end date!"
    end
  end

  def approve!
    self.update(status: "APPROVED")
    overlapping_pending_requests.where.not(id: self.id).update_all(status: "DENIED")
  end

  # ------------- TESTING PURPOSES ONLY!!! ---------------------------
  def self.reset_to_pending
    CatRentalRequest.update_all(status: "PENDING")
  end
  # ------------------------------------------------------------------
end
