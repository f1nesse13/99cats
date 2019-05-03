class CatRentalRequest < ApplicationRecord
  validate :cat_id, :start_date, :end_date, :status
  validates :status, inclusion: ["PENDING", "APPROVED", "DENIED"]
  validate :does_not_overlap_approved_request

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
end
