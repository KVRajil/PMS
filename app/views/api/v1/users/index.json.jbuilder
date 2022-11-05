json.users @users do |user|
  json.partial! partial: 'user', user: user
end
json.meta do
  json.current_page @users.current_page
  json.total_pages  @users.total_pages
  json.total_count  @users.total_count
end
