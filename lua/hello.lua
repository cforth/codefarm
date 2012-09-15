--hello world
--print("Hello world!")

--[==[fact
function fact(n)
	if n == 0 then
		return 1
	else 
		return n * fact(n-1)
	end
end

print("Enter a number:")
a = io.read("*number")
print("Fact of ".. a.." is "..fact(a))
--]==]

--[==[closure
sortbygrade = function (names, grades)
	table.sort(names, function (n1, n2)
		return grades[n1] > grades[n2]
	end)
end


--newCounter
function newCounter ()
	local i = 0
	return function ()
		i = i + 1
		return i
	end
end
--]==]

--maze
function room1()
	local move = io.read()
	if move == "->A"  then 
		return room2()
	elseif move == "->B" then 
		return room4()
	else
		print("invalid move")
		return room1()
	end
end


function room2()
	local move = io.read()
	if move == "<-" then 
		return room1()
	elseif move == "->A" then 
		return room3()
	else
		print("invalid move")
		return room2()
	end
end


function room3()
	local move = io.read()
	if move == "<-" then
		return room2()
	elseif move == "->A" then
		return room6()
	else
		print("invalid move")
		return room3()
	end
end


function room4()
	local move = io.read()
	if move == "<-" then
		return room1()
	elseif move == "->A" then
		return room5()
	elseif move == "->B" then
		return room7()
	else
		print("invalid move")
		return room4()
	end
end


function room5()
	local move = io.read()
	if move == "<-" then
		return room4()
	elseif move == "->A" then
		return room8()
	else
		print("invalid move")
		return room5()
	end
end


function room6()
	local move = io.read()
	if move == "<-" then
		return room3()
	else
		print("invalid move")
		return room6()
	end
end


function room7()
	local move = io.read()
	if move == "<-" then
		return room4()
	else
		print("invalid move")
		return room7()
	end
end


function room8()
	local move = io.read()
	if move == "<-" then
		return room5()
	elseif move == "->A" then
		return room9()
	else
		print("invalid move")
		return room4()
	end
end


function room9()
	print("congratulations!")
end
