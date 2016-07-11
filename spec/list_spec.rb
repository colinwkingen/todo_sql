require('rspec')
require('pg')
require('list')
require("spec_helper")

# DB = PG.connect({:dbname => 'to_do_test'})
#
# RSpec.configure do |config|
#   config.after(:each) do
#     DB.exec("DELETE FROM lists *;")
#   end
# end

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff"})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end
  describe(".order") do
    it("it returns list items in order of id") do
      list1 = List.new({:name => "List 1"})
      list2 = List.new({:name => "List 2"})
      list1.save()
      list2.save()
      expect(List.order()[0]).to(eq(list1))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff"})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#timestamp") do
    it("sets its timestamp when you save it") do
      list = List.new({:name => "Epicodus stuff", :timestamp => "01/01/2001"})
      list.save()
      expect(list.timestamp()).to(eq("01/01/2001"))
    end
  end


  describe("#save") do
    it("lets you save the database") do
      list = List.new({:name => "Epicodus stuff"})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end
  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff"})
      list2 = List.new({:name => "Epicodus stuff"})
      expect(list1).to(eq(list2))
    end
  end
end
