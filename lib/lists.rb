class List
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    return_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    return_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |other_list|
    (self.name() == other_list.name()) & (self.id() == other_list.id())
  end

  define_singleton_method(:find) do |id|
     found_list = nil
     List.all().each() do |list|
       if list.id().==(id)
         found_list = list
       end
     end
     found_list
   end

   define_method(:tasks) do
     all_tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id};")
     tasks = []
     all_tasks.each() do |task|
       description = task.fetch("description")
       list_id = task.fetch("list_id").to_i
       tasks.push(Task.new({:description => description, :list_id => list_id}))
     end
     tasks
   end

end
