# frozen_string_literal: true

class DryRunReporter
  attr_reader :report

  def initialize
    @report = {}
  end

  def add_to_report(key, *values)
    report[key] = [] if report[key].nil?
    report[key].concat(values)
    report[key].uniq!
  end

  def print_report
    if @report.to_a.map(&:second).flatten.empty?
      puts 'Dry run active. No data would be removed in normal run.'
    else
      puts 'Dry run active. The following data would be removed in normal run:'

      @report.to_a.map(&:first).each do |symbol|
        print_report_line(symbol)
      end
    end
  end

  private

  def print_report_line(symbol)
    puts " - #{symbol}: #{@report[symbol].to_json}" if @report[symbol].any?
  end
end
