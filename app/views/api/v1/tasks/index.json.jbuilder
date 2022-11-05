json.tasks @tasks do |task|
  json.partial! partial: 'task', task: task
  json.project do
    json.partial! partial: 'api/v1/projects/project', project: @project
  end
  if task.assignee.present?
    json.assignee do
      json.partial! partial: '/users/user', user: task.assignee
    end
  else
    json.assignee nil
  end
  if task.reporter.present?
    json.reporter do
      json.partial! partial: '/users/user', user: task.reporter
    end
  else
    json.reporter nil
  end
end
json.meta do
  json.current_page @tasks.current_page
  json.total_pages  @tasks.total_pages
  json.total_count  @tasks.total_count
end
