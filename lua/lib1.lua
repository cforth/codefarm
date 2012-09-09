--file 'lib1.lua'

function norm (x, y)
	local n2 = x^2 + y^2
	return math.sqrt(n2)
end


function maximum (a)
	local mi = 1
	local m = a[mi]
	for i,val in ipairs(a) do
		if val > m then
			mi = i
			m = val
		end
	end
	return m,mi
end
