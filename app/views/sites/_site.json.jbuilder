json.extract! site, :id, :name, :address, :contact, :phone, :email, :customer_id, :created_at, :updated_at
json.url site_url(site, format: :json)
