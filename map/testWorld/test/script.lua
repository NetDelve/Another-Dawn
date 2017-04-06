return function (v)
	if not v.__xx then
		v.__xx = 0
	end
	v.__xx = v.__xx + 1
	if v.__xx >= 50 then
		v.__xx = 0
	end
	v.x = v.__xx
	return v
end
