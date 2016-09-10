function table_to_string(t)
  local result = {}
  for k, v in pairs(t) do
    result[#result + 1] = k .. ":" .. v
  end
  return table.concat(result, "\n")
end

function concatenate( a1, a2 )
	local a3 = {}
	for i,n in ipairs(a1) do
		a3[#a3+1] = n
	end
	for i,n in ipairs(a2) do
		a3[#a3+1] = n
	end
	return a3
end

global_mt = {
	__newindex = function(t, k, v)
		setmetatable(v, { 
			__add = concatenate,
			__tostring = table_to_string })
		rawset(t,k,v)
	end
}
setmetatable(_G, global_mt)
table1 = {1,2}
table2 = {3,4}
print("{1, 2} + {3, 4} is")
table3 = table1 + table2
print(table3)