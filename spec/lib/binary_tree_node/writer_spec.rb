require 'spec_helper'

describe RubyWhatsapp::BinaryTreeNode::Writer do
  describe '#token_map' do
    it 'reduces the numbers of elements in the dictionary' do
      subject.token_map.size.should == 240
    end
  end
end