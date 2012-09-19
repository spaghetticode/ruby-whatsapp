require 'spec_helper'

describe RubyWhatsapp::BinaryTreeNode::Writer do
  def to_bytes string
    string.each_byte.inject([]) {|ary, b| ary << b} if string
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
      to_bytes(subject.write_list_start(0).last).should == [0]
      to_bytes(subject.write_list_start(89).last).should == [248, 89]
      to_bytes(subject.write_list_start(13232).last).should == [249, 176]
    end
  end

  describe '#write_token' do
    it 'returns the expected results' do
      to_bytes(subject.write_token(23).last).should == [23]
      to_bytes(subject.write_token(298).last).should == [254, 53]
      lambda{subject.write_token(1233)}.should_not change(subject, :output)
    end
  end
end