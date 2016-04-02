json.array!(@camps) do |camp|
  json.extract! camp, :id, :name, :start_date, :end_date, :location
  json.url camp_url(camp, format: :json)
end
