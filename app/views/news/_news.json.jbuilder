json.extract! news, :id, :user_id, :title, :keywords, :language, :publish, :published_at, :created_at, :updated_at
json.url news_url(news, format: :json)
