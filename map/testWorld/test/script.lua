return function (v)
	if not __xx then
		__xx = 0
	end
	__xx = __xx + 1
	if __xx >= 50 then
		__xx = 0
	end
	v.x = __xx
	return v
end
