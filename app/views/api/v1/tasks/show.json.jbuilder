json.task do
  json.partial! partial: 'task', task: @task
  json.project do
    json.partial! partial: 'api/v1/projects/project', project: @project
  end
  json.assignee do
    json.partial! partial: '/users/user', user: @task.assignee
  end
  json.reporter do
    json.partial! partial: '/users/user', user: @task.reporter
  end
end
