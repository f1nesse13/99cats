class CatRentalRequest < ApplicationRecord
  STATUSES = [
    "PENDING", "APPROVED", "DENIED"
  ]
  validates :cat_id, :start_date, :end_date, :status
  validates :status, inclusion: STATUSES
  validate :does_not_overlap_approved_request
  
  belongs_to :cat,
             foreign_key: :cat_id,
             class_name: "Cat"

  def overlapping_requests
    CatRentalRequest.where(cat_id: cat_id).where.not(id: self.id).where(<<-SQL, start_date: start_date, end_date: end_date) NOT ((start_date > :end_date) OR (end_date < :start_date))
    SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status == 'APPROVED'"}
  end

  def overlapping_pending_requests
    overlapping_requests.where("status == 'PENDING'"}
  end

  def does_not_overlap_approved_request
    errors[:base] << "Overlaps an already approved request" unless overlapping_approved_requests.empty?
  end
end
