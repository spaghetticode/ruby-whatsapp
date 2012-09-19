require 'spec_helper'

describe RubyWhatsapp::BinaryTreeNode::Writer do
  def to_bytes string
    string.each_byte.inject([]) {|ary, b| ary << b}
  end

  describe '#token_map' do
    it 'reduces the numbers of elements in the dictionary' do
      subject.token_map.size.should == 240
    end
  end

  describe '#write' do
    it 'works' do
      xml = Nokogiri.XML('<receipt_acks></receipt_acks>').children.first
      subject.write xml
    end
  end

  describe '#write_list_start' do
    it 'returns the expected results' do
      to_bytes(subject.write_list_start(0)).should == [0]
      to_bytes(subject.write_list_start(89)).should == [248, 89]
      to_bytes(subject.write_list_start(13232)).should == [249, 176]
    end
  end
end