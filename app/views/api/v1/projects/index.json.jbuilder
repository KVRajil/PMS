json.projects @projects do |project|
  json.partial! partial: 'project', project: project
  json.user do
    json.partial! partial: '/users/user', user: project.user
  end
end
json.meta do
  json.current_page @projects.current_page
  json.total_pages  @projects.total_pages
  json.total_count  @projects.total_count
end
