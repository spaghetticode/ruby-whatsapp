require "yaml"

module RubyWhatsapp
  module BinaryTreeNode
    class Writer
      def dictionaty_path
        File.join File.dirname(__FILE__), 'dictionary.yml'
      end

      def dictionary
        @dictionary ||= YAML.load_file dictionaty_path
      end

      def token_map
        @token_map ||= dictionary.inject({}) {|hash, pair| hash[pair.last.to_s] = pair.first; hash}
      end

      def initialize
        @output = []
      end

      def write node
        return @output << "\x00" if node.nil?
        len = 1
        len += node.attribute_nodes.size * 2
        len += 1 unless node.children.empty?
        len += 1 unless node.content.empty?
      end
    end
  end
end