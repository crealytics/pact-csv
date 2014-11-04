require 'csv-diff'

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
        diff = ::CSVDiff.new(expected, actual)
        puts "*" * 80, diff.summary.inspect
        puts diff.adds.inspect      # Details of the additions to file2
        puts diff.deletes.inspect   # Details of the deletions to file1
        puts diff.updates.inspect   # Details of the updates from file1 to file2
        puts diff.moves.inspect     # Details of the moves from file1 to file2
        puts diff.diffs.inspect     # Details of all differences
        puts diff.warnings.inspect  # Any warnings generated during the diff process
        diff.warnings + diff.diffs.to_a
      end
    end
  end
end