require('sinatra')
require('sinatra/reloader')
require('./lib/tasks')
require('./lib/lists')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "to_do_list"})


get("/") do
  erb(:index)
end

get("/lists/new") do
  erb(:list_form)
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  @list = list.name()
  erb(:success)
end

get("/lists") do
  @lists = List.all()
  erb(:lists)
end

get("/list/:id") do
  @list = List.find(params.fetch('id').to_i)
  erb(:list)
end

post('/tasks') do
  task = params.fetch("task")
  id = params.fetch("list_id").to_i
  new_task = Task.new({:description => task, :list_id => id})
  new_task.save()
  @list = List.find(id)
  erb(:task_success)
end

get('/tasks') do
  erb(:list)
end
