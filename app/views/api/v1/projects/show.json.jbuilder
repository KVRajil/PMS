json.project do
  json.partial! partial: 'project', project: @project
  json.user do
    json.partial! partial: '/users/user', user: @project.user
  end
end
