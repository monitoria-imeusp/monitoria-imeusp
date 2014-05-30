json.array!(@candidatures) do |candidature|
  json.extract! candidature, :id, :avaliability_daytime, :avaliability_night_time, :time_period_preference, :course1_id, :course2_id, :course3_id
  json.url candidature_url(candidature, format: :json)
end
