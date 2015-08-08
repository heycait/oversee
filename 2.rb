# Write a class `Sample` whose initialize method takes an arbitrary hash, e.g.
  # `h = {"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 'here'}`
# and represent each key in the hash as an attribute of an instance of the class, such that I can say:
# `c = Sample.new(h)`
  # `c.this` should return `[1,2,3,4,5,6]`
  # `c.that`  should return `['here', 'there', 'everywhere']`
  # `c.other` should return `'here'`

class Sample
  def initialize(args)
    args.each do |key, value|
      self.instance_variable_set("@#{key}".to_sym, value)
      Sample.class_eval("attr_reader :#{key}")
    end
  end
end

# Driver Test Code
h = {"this" => [1,2,3,4,5,6], "that" => ['here', 'there', 'everywhere'], :other => 'here'}
c = Sample.new(h)

p c.this == [1,2,3,4,5,6]
p c.that == ['here', 'there', 'everywhere']
p c.other == 'here'

test = {"here" => "is another example", "more_data" => [7,8,9]}
d = Sample.new(test)

p d.here == "is another example"
p d.more_data == [7,8,9]