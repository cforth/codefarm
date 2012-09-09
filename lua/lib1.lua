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


--hanoi test

function fwrite(fmt, ...)
	return io.write(string.format(fmt, ...))
end


function hanoi_init(level, time)
	fwrite("Level is %d\nMust in %d seconds\n",level, time)
end


function hanoi_set(options)
	if type(options.level) ~= "number" then
		error("Not set level!")
	end

	hanoi_init(options.level,
		options.time or 600
		)
end


--cforth test

dirt = {
	{name = "dup2",		defin = "dup dup"	},
	{name = "2drop",	defin = "dorp drop"	},
	{name = "square", 	defin = "dup *"		},
	{name = "add2",		defin = "2 +"		},
	{name = "++",		defin = "1 +"		},
}


function sort_dirt()
	table.sort(dirt, function(a,b) return (a.name < b.name) end)
end


function print_dirt()
	for i=1,#dirt do
		print(dirt[i].name, dirt[i].defin)
	end
end
