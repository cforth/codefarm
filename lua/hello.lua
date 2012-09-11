--hello world
--print("Hello world!")

--fact
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
