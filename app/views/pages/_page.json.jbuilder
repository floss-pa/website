json.extract! page, :id, :user_id, :title, :language, :content, :carousel, :is_publish, :in_menu, :is_home, :created_at, :updated_at
json.url page_url(page, format: :json)
