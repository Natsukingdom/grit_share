json.extract! pomo, :id, :start_time, :stop_time, :end_time, :comment, :created_at, :updated_at
json.url user_pomo_url(@user, pomo, format: :json)
