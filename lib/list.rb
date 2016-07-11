class List
  attr_reader(:name, :id, :timestamp)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @timestamp = attributes[:timestamp] || '01/01/2001'
    @id = attributes[:id] || nil
  end

  define_singleton_method(:all) do
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      timestamp = list.fetch("timestamp")
      lists.push(List.new({:name => name, :id => id, :timestamp => timestamp}))
    end
    lists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO lists (name, timestamp) VALUES ('#{@name}', '#{@timestamp}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:order) do
    returned_lists = DB.exec("SELECT * FROM lists ORDER BY id ASC;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      timestamp = list.fetch("timestamp")
      lists.push(List.new({:name => name, :id => id, :timestamp => timestamp}))
    end
    lists
  end

  define_method(:==) do |another_list|
    self.name().==(another_list.name()).&(self.id().==(another_list.id())).&(self.timestamp().==(another_list.timestamp()))
  end
end
