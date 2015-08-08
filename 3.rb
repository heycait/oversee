require 'rubygems'
require 'rubyXL'


def sort_data()
  workbook = RubyXL::Parser.parse("data.xlsx")
  worksheet = workbook[0]

  keys = []
  sort_data = []

  # p worksheet.extract_data

  worksheet.extract_data.each_with_index do |row, index|
    if index == 0
      keys = row
      sort_data = Array.new (row.length) {[0, ""]}
    else
      row.each_with_index do |data, ind|
        if data == nil
          length = 0
        else
          length = data.to_s.length
        end

        if sort_data[ind][0] < length
          sort_data[ind] = [length, row[0]]
        end
      end
    end
  end

  return Hash[keys.zip(sort_data)]

end


p sort_data