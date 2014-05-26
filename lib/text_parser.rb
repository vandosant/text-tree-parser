class TextParser
  def initialize(text_tree)
    @text_tree_lines = text_tree.split("\n")
  end

  def hashify
    result = {}

    indent = 0
    last_indent = 0
    last_boss = ""
    @text_tree_lines.each_with_index do |line, index|
      if line.index(/\S/) == 0
        result[line] = nil
      elsif line.index(/\S/) == last_indent
        result[line.strip] = last_boss
      else
        boss = @text_tree_lines[index - 1].strip
        result[line.strip] = boss
        indent = line.index(/\S/)
      end
      last_indent = indent
      last_boss = boss
    end
    result
  end
end