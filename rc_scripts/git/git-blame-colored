#!/usr/bin/env ruby

# Colorize string
class String
	def colorize(color_code)
		"\e[#{color_code}m#{self}\e[0m"
	end
end

class Colors
	@@user_color = 34
	@@colors = [31, 32, 33, 35, 36]
	@@index = 0

	def self.user
		@@user_color
	end

	def self.next
		color = @@colors[@@index]

		# Should take care of case when more users than colors
		if @@index < @@colors.count
			@@index += 1
		else
			@@index = 0
		end
		color
	end
end

class Authors
	@@authors = {}

	def self.[](key)
		@@authors[key]
	end

	def self.[]=(key, value)
		@@authors[key] = value
	end

	def self.include?(key)
		@@authors.include?(key)
	end

	def self.all
		@@authors.collect{ |k,v| v.to_s }.join(' ')
	end
end

class Author
	def initialize(name)
		@lines = 0
		@name = name
		if name == $current_user
			@color = Colors.user
		else
			@color = Colors.next
		end
		@initials = @name.split.collect { |word| word[0] }.join
	end

	def initials
		@initials.colorize(@color)
	end

	def add_line
		@lines += 1
	end

	def to_s
		"#{@name.colorize(@color)}(#{@lines})"
	end
end

def blame(filename)
	output = "#{filename}: "

	content = `git blame --line-porcelain #{filename} 2>&1`

	if content =~ /^fatal:/
		output << content.match(/^fatal: (.*)/)[1] + "\n\n"
		return output
	else
		output << "\n"
	end

	content.split(/^[a-f0-9]{40}/).each_with_index do |line, line_number|
		next if line_number == 0

		# Get code line
		if line =~ /^(previous|boundary)/
			code = line.split("\n")[12]
		else
			code = line.split("\n")[11]
		end
		code.gsub!("\t", "  ")

		# Get author
		if line =~ /^author /
			author = line.match(/^author (.*)$/)[1]
			if !Authors.include?(author)
				Authors[author] = Author.new(author)
			end
			Authors[author].add_line
		end

		output << "%s %-4s %s\n" % [Authors[author].initials, line_number, code]
	end

	output << "\n"
	return output
end


###   MAIN   ###

# Make sure a file was specified
filenames = ARGV
if filenames.empty?
	puts "Specify a file to blame"
	exit 1
end

# Get the current user's name
$current_user = `git config --get user.name`.chomp

output = filenames.collect { |filename| blame(filename) }.join
output.chomp!

# Print all output
print <<EOS

#{Authors.all}

#{output}
#{Authors.all}

EOS
