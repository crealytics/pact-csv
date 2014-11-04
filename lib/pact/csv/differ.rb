require 'daff'

module Pact
  module CSV

    class Differ

      attr_reader :expected, :actual, :options
      def initialize expected, actual, options = {}
        @expected = expected
        @actual = actual
        @options = options
      end

      def self.call expected, actual, options = {}
        new(expected, actual, options).call
      end

      def call
        expected_data = ::CSV.parse(expected, headers: true)
        actual_data = ::CSV.parse(actual, headers: true)
        compare(expected_data, actual_data)
      end

      def compare(expected, actual)
        aligned = Coopy::Coopy.compare_tables(to_table(expected), to_table(actual)).align
        flags = Daff::CompareFlags.new
        table_diff = Daff::SimpleTable.new(0,0)
        highlighter = Daff::TableDiff.new(aligned, flags)
        highlighter.hilite(table_diff)
        [table_diff.data, table_diff.get_width, table_diff.get_height]
      end
      def to_table(arr)
        t = Daff::SimpleTable.new(arr.first.size, arr.size)
        arr.each_with_index {|row, row_num| row.each_with_index {|cell, col_num| t.set_cell(col_num, row_num, cell)}}
        t
      end

    end
  end
end