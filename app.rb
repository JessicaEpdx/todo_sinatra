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
