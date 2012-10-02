require "yaml"

module RubyWhatsapp
  module BinaryTreeNode
    class Writer
      attr_reader :output

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

      def write_int8 value
        @output << (value & 0xff).chr
      end

      def write_int16 value
        @output << ((value & 0xff00) >> 8).chr
        @output << ((value & 0x00ff) >> 0).chr
        # todo - warning original func has a different return value
      end

      # todo - incomplete
      def write node
      end

      # todo - incomplete
      def write_internal node
        len = 1
        len += node.attribute_nodes.size * 2
        len += 1 unless node.children.empty?
        len += 1 unless node.content.empty?
        write_list_start len
      end

      def write_list_start length
        if length == 0
          @output << "\x00"
        elsif length < 256
          @output << "\xf8"+length.chr
        else
          # todo - duplication of login of write_int8 method
          @output << "\xf9"+(length%256).chr
        end
      end

      def write_token token
        if token < 0xf5
          @output << token.chr
        elsif token <= 0x1f4
          @output << "\xfe" + (token - 0xf5).chr
        end
      end
    end
  end
end