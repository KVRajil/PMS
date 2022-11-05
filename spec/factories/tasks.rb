FactoryBot.define do
  factory :task do
    title { 'title' }
    description { 'description' }
    project_id { 1 }
    reporter_id { 1 }
    assignee_id { 1 }
    status { 'yet_to_start' }
    start_date { Time.zone.today }
    end_date { Time.zone.tomorrow }
  end
end
