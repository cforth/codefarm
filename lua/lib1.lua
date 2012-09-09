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


function foo0 () end
function foo1 () return "a" end
function foo2 () return "a", "b" end


function add(...)
	local s = 0
	for i,v in ipairs{...} do
		s = s + v
	end
	return s
end

function add1(...)
	print("calling add:", ...)
	return add(...)
end
