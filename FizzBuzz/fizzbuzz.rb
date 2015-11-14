class FizzBuzz
	attr_accessor :tmp
	
	def initialize temp
		@tmp = temp
	end
	
	def doFizzBuzz
		1.upto(10) do |i|
			if i % 5 == 0 and i % 3 == 0
			@tmp += "FizzBuzz"
			elsif i % 5 == 0
			@tmp += "Buzz"
			elsif i % 3 == 0
			@tmp += "Fizz"
			else
			@tmp += i.to_s
			end
		end
	end
end

fb = FizzBuzz.new("")
fb.doFizzBuzz
puts fb.tmp