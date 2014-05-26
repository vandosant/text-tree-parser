require 'spec_helper'
require_relative '../lib/text_parser'

describe TextParser do
  let :input do
    <<-TREE.chomp
Izaiah Deckow
  Joel Corkery
    Della Schuppe
    Lurline Ankunding
Eulalia Bode
  Claude McCullough
TREE
  end

  it 'knows the boss of an employee' do
    text_tree = TextParser.new(input)

    actual = text_tree.hashify

    expect(actual).to include({"Joel Corkery" => "Izaiah Deckow"})
  end

  it 'knows the boss of the boss is nil' do
    text_tree = TextParser.new(input)

    actual = text_tree.hashify

    expect(actual).to include({"Izaiah Deckow" => nil})
  end

  it 'knows the boss of multiple employees' do
    text_tree = TextParser.new(input)

    actual = text_tree.hashify

    expect(actual).to include({"Della Schuppe" => "Joel Corkery", "Lurline Ankunding" => "Joel Corkery"})
  end

  it 'recognizes multiple top-level bosses' do
    text_tree = TextParser.new(input)

    actual = text_tree.hashify

    expect(actual).to include({"Izaiah Deckow" => nil, "Eulalia Bode" => nil})
  end
end