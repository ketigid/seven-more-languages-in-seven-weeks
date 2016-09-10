function retry( count, body )
	math.randomseed(os.time())
	for i = 1,count do
		print('Count: ' .. i)
		local co = {}
		co[i] = coroutine.create(body)
		succeeded, value = coroutine.resume(co[i])
		if (type(value)=='string') then
			-- print('String detected')
		else
			-- print('No string detected')
			break
		end
	end
end

retry(
	5,
	function()
		local p = math.random()
		-- print(p)
		if (p > 0.2) then
			-- print('Yielding back')
			coroutine.yield('Something bad happened')
		end
		print('Succeeded')
	end
	)