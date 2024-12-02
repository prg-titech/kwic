# a simple KWIC program

class LineStore
  attr_reader :rows
  def initialize()
    @rows=[]
  end
  def getChar(row, word, offset)
    rows[row][word][offset]
  end
  def getRow(row)
    rows[row] || (rows[row] = [])
  end
  def getWord(row,word)
    row[word] || (row[word] = [])
  end
  def setChar(row, word, offset, char)
    getWord(getRow(row),word)[offset] = char
  end
  def numChars(row,word) getWord(getRow(row),word).length end
  def numWords(row)      getRow(row).length       end
  def numRows()          rows.length              end
  def to_s
    rows.map{ |row| row.map{ |word| word.join }.join(" ") }.join("\n")
  end
end

class Input
  def self.input(filename)
    open(filename) do |ins|
      line_store = LineStore.new
      ins.read.split(/\n/).each_with_index do |row, row_i|
        row.split(" ").each_with_index do |word, word_i|
          word.each_char.each_with_index do |char, char_i|
            line_store.setChar(row_i, word_i, char_i, char)
          end
        end
      end
      line_store
    end
  end
end

class Rotate
  def initialize(line_store)
    @line_store = line_store
    @shift_table = []
    line_store.numRows.times do |row|
      line_store.numWords(row).times do |word|
        @shift_table.push([row,word])
      end
    end
  end
  def getChar(shift,word,char)
    row,word_offset = @shift_table[shift]
    @line_store.getChar(row, word_offset+word, char)
  end
  def numChars(shift,word)
    row,word_offset = @shift_table[shift]
    @line_store.numChars(row, word+word_offset)
  end
  def numWords(shift)
    row,word_offset = @shift_table[shift]
    @line_store.numWords(row) - word_offset
  end
  def numBackWords(shift)
    row,word_offset = @shift_table[shift]
    word_offset
  end
  def original_row(shift) @shift_table[shift][0] end
  def numRows() @shift_table.length end
  def to_s
    numRows.times.map{ |shift|
      numWords(shift).times.map{ |word|
        numChars(shift,word).times.map{ |char|
          getChar(shift,word,char)
        }.join
      }.join(" ")
    }.join("\n")
  end
end

class Sort
  def initialize(line_store)
    @line_store = line_store
  end
  def shift_to_str(shift)
    @line_store.numWords(shift).times.map{ |word|
      @line_store.numChars(shift,word).times.map{ |char|
        @line_store.getChar(shift,word,char)
      }.join 
    }.join(" ") +
      @line_store.numBackWords(shift).times.map{|word|
       w = -word-1
       @line_store.numChars(shift,w).times.map{ |char|
        @line_store.getChar(shift,w,char)
      }.join 
    }.join(" ").reverse
  end
  def doSort()
    @row_indices =
      (0...@line_store.numRows).to_a.
        sort{ |r1,r2| shift_to_str(r1).downcase <=> shift_to_str(r2).downcase }
    self
  end
  def shift(i) @row_indices[i] end
  def numRows() @line_store.numRows end
  def numWords(s) @line_store.numWords(self.shift(s)) end
  def numBackWords(s) @line_store.numBackWords(self.shift(s)) end
  def numChars(s,w) @line_store.numChars(self.shift(s),w) end
  def getChar(s,w,c) @line_store.getChar(self.shift(s),w,c) end
  def getOriginalRow(s)
    @line_store.original_row(shift(s))
  end
end

class Output
  def initialize(line_store) @line_store = line_store end
  def output()
    puts @line_store.numRows.times.map{ |shift|
      keyword_and_after = @line_store.numWords(shift).times.map{ |word|
        @line_store.numChars(shift,word).times.map{ |char|
          @line_store.getChar(shift,word,char)
        }.join
      }.join(" ")
      before_keyword = @line_store.numBackWords(shift).times.map{ |bword|
        w = -bword-1
        @line_store.numChars(shift,w).times.map{ |char|
          @line_store.getChar(shift,w,char)
        }.join
      }.join(" ")
      sprintf("%5d ",@line_store.getOriginalRow(shift)) +
        (before_keyword.length > 35 ? before_keyword[-34..-1] : before_keyword).
          rjust(35) + "|" + keyword_and_after[0..35]
    }.join("\n")
  end
end

class Integrate
  def main
    file, keyword = ARGV
    line_store = Input.input(file)
#    puts line_store
    rotated = Rotate.new(line_store)
#    puts rotated
    sorted = Sort.new(rotated).doSort()
    Output.new(sorted).output()
  end
end

if __FILE__ == $0
  Integrate.new.main
end
