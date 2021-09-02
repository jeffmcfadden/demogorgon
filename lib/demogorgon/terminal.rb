module Demogorgon
  class Terminal

    def self.word_wrap(text, line_width: 80, break_sequence: "\n")
      text.split("\n").collect! do |line|
        line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1#{break_sequence}").rstrip : line
      end * break_sequence
    end

    def self.print(s)
      Kernel.print word_wrap(s)
    end

    def self.puts(s)
      Kernel.print word_wrap(s) + "\n"
    end

  end
end