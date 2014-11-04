require 'cucumber'

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
        expected_table = Cucumber::Ast::Table.new(expected.map(&:to_hash))
        actual_table = Cucumber::Ast::Table.new(actual.map(&:to_hash))
        errors = []
        begin
          expected_table.diff!(actual_table)
        rescue => e
          errors = [e.table]
        end
        errors
      end
    end
  end
end