# Please answer in either Ruby, Perl, PHP, Python or Java
# Convert this string
#   string = "{key:[[value_1, value_2],[value_3, value4]], 5:10:00AM]}"
# to this hash:
#   h = {"key" => [["value_1", "value_2"],["value_3", "value4"]], 5=>"10:00AM"}
# then convert h to JSON.
# Please note that the brackets are unbalanced on purpose.


require 'json/ext'

# Solution needs refactoring to take care of edge cases, redundancy and situations with unpaired open brackets

string = "{key:[[value_1, value_2], [value_3, value4]], 5:10:00AM]}"

def brackets(string)
  brackets = {"{" => "}", "[" => "]", "(" => ")"}
  stack = []
  remove_indeces = []
  string.each_char.with_index do |char, index|
    if brackets.keys.include?(char)
      stack << [char, index]
    elsif brackets.values.include?(char)
      if stack.last[0] == brackets.key(char)
        stack.pop
      else
        remove_indeces << index
      end
    end
  end

  remove_indeces.each do |num|
    string[num] = ''
  end

  return string

end

# p brackets(string)
# p brackets(string2)

def convert_str_hash(string)
  string = brackets(string)

  fixed_string = ""
  brackets = {"{" => "}", "[" => "]", "(" => ")"}
  current_string = ""
  string.each_char.with_index do |char, index|
    if char == ":" && (string[index+3]+string[index+4] != 'AM')
      if current_string.to_i > 0
        fixed_string += current_string
      else
        fixed_string += "'#{current_string}'"
      end
      current_string = ""
      fixed_string += " => "
    elsif brackets.keys.include?(char) || brackets.values.include?(char)
      if !current_string.empty?
        fixed_string += "'#{current_string}'"
        current_string = ""
      end
      fixed_string += char
    elsif char == "," || char == " "
      if !current_string.empty?
        fixed_string += "'#{current_string}'"
        current_string = ""
      end
        fixed_string += char
    else
      current_string += char
    end
  end
  return eval(fixed_string).to_json
end

p convert_str_hash(string)
