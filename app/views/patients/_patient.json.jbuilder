json.extract! patient, :id, :name, :email, :problem, :created_at, :updated_at
json.url patient_url(patient, format: :json)
