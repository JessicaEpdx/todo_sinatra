require('spec_helper')

describe(List) do
  describe(".all") do
    it('starts off with no lists') do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus", :id => nil})
      expect(list.name()).to(eq("Epicodus"))
    end
  end

    describe("#save") do
      it("saves list") do
        list = List.new({:name => "Epicodus", :id => nil})
        list.save()
        expect(List.all()).to(eq([list]))
      end
    end

  describe("#id") do
    it("sets its id when you save it") do
      list = List.new({:name => "Epicodus", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

end
