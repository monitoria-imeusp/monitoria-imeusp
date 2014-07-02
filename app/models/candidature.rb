class Candidature < ActiveRecord::Base
  include ActiveModel::Validations
  validates :time_period_preference, presence: true
  validates :course1_id, presence: true
  #validates :transcript_file_path, :path => ':rails_root/public/uploads/transcripts/', :presence => {:message => "Apenas PDF."}
  validates :transcript_file_path, presence: true
  belongs_to :student
  def main_department
    Course.where(id: course1_id).take.department
  end
end
