Queue = {
	new = function(self)
		local obj = {5}
		self.__index = self
		setmetatable(obj, self)
		return obj
	end,

	add = function(self,item)
		self[#self+1] = item
	end,

	remove = function(self)
		local first
		if (#self == 0) then
			return nil
		else
			first = self[1]
			for k,v in pairs(self) do
				self[k] = self[k+1]
			end
		end
		return first
	end,

	__tostring = function(t)
		local result = {}
		for k, v in pairs(t) do
			result[#result + 1] = k .. ":" .. v
		end
		return table.concat(result, "\n")
	end
}

q = Queue:new()
q:add(1)
q:add(8)
q:add(99)
print('Removed: ' .. q:remove())
print('Removed: ' .. q:remove())
print(q)