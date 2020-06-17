json.extract! car, :id, :title, :description, :model, :price, :year, :color, :miles, :created_at, :updated_at
json.url car_url(car, format: :json)
