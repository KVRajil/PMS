# README

A simple Project Management App using Rails 7(API only).
User can create projects, create tasks on it and assign the tasks to people.

Features
1. User sign up and login
2. Project CRUD
3. Task CRUD


Rails version - 7.0.4   
Ruby  version - 3.0.2


Setup & Installation steps:
1. Create master.key file in config folder (value - 2775d20d83da8ca079203af26ce39c21)
2. Just run docker-compose up --build


Run test cases
1. docker exec -it DOCKER_ID  bash
2. rspec spec/


file:///{path}/project_management_app/coverage/index.html - code coverage

http://localhost:3000/apipie - APIPIE documentation

https://documenter.getpostman.com/view/9745014/2s8YYFrihy - POSTMAN API collection
