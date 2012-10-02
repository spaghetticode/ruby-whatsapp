require 'spec_helper'

describe RubyWhatsapp::BinaryTreeNode::Writer do
  before {subject.output.clear}

  def to_bytes strinOrArray
    if strinOrArray
      strinOrArray = strinOrArray.join if strinOrArray.kind_of? Array
      result = strinOrArray.each_byte.inject([]) {|ary, b| ary << b}
      subject.output.clear
      result
    end
  end

  describe '#token_map' do
    it 'reduces the numbers of elements in the dictionary' do
      subject.token_map.size.should == 240
    end
  end

  describe '#write_int8' do
    it 'returns the expected results' do
      to_bytes(subject.write_int8(32)).should == [32]
      to_bytes(subject.write_int8(259)).should == [3]
    end
  end

  describe '#write_int16' do
    it 'returns the expected results' do
      to_bytes(subject.write_int16(32)).should == [0, 32]
      to_bytes(subject.write_int16(656)).should == [2, 144]
    end
  end

  describe '#write_int24' do
    it 'returns the expected results' do
      to_bytes(subject.write_int24(0)).should == [0, 0, 0]
      to_bytes(subject.write_int24(32)).should == [0, 0, 32]
      to_bytes(subject.write_int24(1344)).should == [0, 5, 64]
    end
  end

  describe '#write' do
    it 'works' do
      pending
    end
  end

  describe '#write_internal' do
    it 'works' do
      # xml = Nokogiri.XML('<receipt_acks></receipt_acks>').children.first
      # subject.write xml
      pending
    end
  end

  describe '#write_list_start' do
    it 'returns the expected results' do
      to_bytes(subject.write_list_start(0)).should == [0]
      to_bytes(subject.write_list_start(89)).should == [248, 89]
      to_bytes(subject.write_list_start(13232)).should == [249, 176]
    end
  end

  describe '#write_token' do
    it 'returns the expected results' do
      to_bytes(subject.write_token(23)).should == [23]
      to_bytes(subject.write_token(298)).should == [254, 53]
      lambda{subject.write_token(1233)}.should_not change(subject, :output)
    end
  end
end