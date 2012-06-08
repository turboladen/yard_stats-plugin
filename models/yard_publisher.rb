require 'stringio'
require 'yard'

module Kernel
  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end
end

class YardPublisher < Jenkins::Tasks::Publisher
  display_name "Publish YARD stats"

  LINES = %r[^\S+\s+(?<total>\d+)\s\(\s+(?<undocumented>\d+)]

  attr_reader :yard_file_glob

  def initialize(attrs)
    @yard_file_glob = attrs['yard_file_glob']
  end

  def cli
    @cli ||= ::YARD::CLI::Stats.new
  end

  def perform(build, launcher, listener)
    listener.info "Build env: #{build.workspace}"
    listener.info "About to start gettin funky with YARD..."
    listener.info "yard file glob: #{@yard_file_glob}"

    cli.run "#{build.workspace}/#{@yard_file_glob}"

    files = stats_for :files
    listener.info "total: #{files[:total]}"
    listener.info "undocumented: #{files[:undocumented]}"

    modules = stats_for :modules
    listener.info "total: #{modules[:total]}"
    listener.info "undocumented: #{modules[:undocumented]}"

    classes = stats_for :classes
    listener.info "total: #{classes[:total]}"
    listener.info "undocumented: #{classes[:undocumented]}"

    constants = stats_for :constants
    listener.info "total: #{constants[:total]}"
    listener.info "undocumented: #{constants[:undocumented]}"

    methods = stats_for :methods
    listener.info "total: #{methods[:total]}"
    listener.info "undocumented: #{methods[:undocumented]}"
  end

  private

  def stats_for(type)
    out = capture_stdout { cli.send("stats_for_#{type}".to_sym) }

    out.string.match(LINES)
  end
end


