describe ('array') 
{
  before = function(self)
    self.list = a{888}
  end;
  
  ["array.first should return the first element"] = function(self)
    expect(self.list.first).should_be(self.list[1])
  end;
  
  ["array.last should return the last element"] = function(self)
    expect(self.list.last).should_be(self.list[#self.list])
  end;
  
  ["allows insertion of elements"] = function(self)
    self.list[2] = 22
    expect(self.list[2]).should_be(22)
  end;
  
  ["allows array access"] = function(self) 
    expect(self.list[1]).should_be(888)

    -- Failed expectation
    expect(self.list[2]).should_be(2)
    expect(true).should_be(false)
  end;
}

describe ('array - iterator') 
{
  before = function(self)
    self.list = a{1,2,3,4,5} 
  end;
  
  ["array#each should iterate through all elements"] = function(self)
    local sum = 0
    local list = a{1,2,3,4,5}
    list.each(function(value) sum = sum + value end)
    expect(sum).should_be(1+2+3+4+5)
  end;
}

describe ('array - transformation iterator') 
{
  before = function(self)
    self.list = a{111,222,333,444}
  end;
  
  ["array#map should return transformed array"] = function(self)
  
    local result = self.list.map(function(value, key) 
      return value + 1
    end)
    
    type_of(result).should_be 'table'
    expect(result).should_be(a{112,223,334,445})
    
  end;
  
  ["array#reduce reduces reduces to singular value"] = function(self)
    local result = self.list.reduce(0, function(sum, value) 
      return sum + value
    end)
  
    type_of(result).should_be "number"
    expect(result).should_be(111 + 222 + 333 + 444)
  end;
}

describe ("array - conditional iterator") 
{
  before = function(self)
    self.list = a{111,222,333,444}
  end;
  
  ["array#any requires condition met with any item"] = function(self)
  
    local result = self.list.any(function(e) return e > 400 end)
    expect(result).should_be_true()

    result = self.list.any(function(e) return e > 500 end)
    expect(result).should_be_false()
    
  end;
  
  ["array#all requires condition met with all items"] = function(self)
  
    local result = self.list.all(function(e) return e > 1 end)
    expect(result).should_be_true()
    
    result = self.list.all(function(e) return e > 200 end)
    expect(result).should_be_false()
    
  end;
  
  ["array#contains require if element exists"] = function(self)
  
    expect(self.list.contains(333)).should_be_true()	
    expect(self.list.contains(3)).should_be_false()
    
  end;
  
  ["array#filter should return all element met given condition"] = function(self)
  
    local result = self.list.filter(function(e) return e > 300 end)  
  
    expect(result).should_be(a{333,444})
    expect(result == a{}).should_be_false()
    
  end;
}