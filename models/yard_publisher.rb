require File.expand_path(File.dirname(__FILE__) + '/../lib/kernel_ext')
require File.expand_path(File.dirname(__FILE__) + '/yard_stats_action')
require 'yard'


class YardPublisher < Jenkins::Tasks::Publisher
  display_name "Publish YARD stats"

  LINES = %r[^\S*\s+(?<total>\d+)(\s\(\s+(?<undocumented>\d+))?]

  attr_reader :yard_file_glob

  def initialize(attrs)
    @yard_file_glob = attrs['yard_file_glob']
  end

  def cli
    @cli ||= ::YARD::CLI::Stats.new
  end

  def log(msg)
    @listener.info "YARD plugin: #{msg}"
  end

  def perform(build, launcher, local_listener)
    @listener = local_listener
    log "About to start gettin funky with YARD..."
    log "Checking glob: #{@yard_file_glob}"

    cli.run "#{build.workspace}/#{@yard_file_glob}"

    files = stats_for :files
    modules = stats_for :modules
    classes = stats_for :classes
    constants = stats_for :constants
    methods = stats_for :methods

    puts "build class: #{build.class}"
    puts "publisher methods: #{self.methods}"
    #puts "build project: #{build.project.inspect}"
    #puts "build project actions: #{build.project.actions}"
    puts "project action: #{project_action(build.project)}"
  end

  def project_action(project)
    YardStatsAction.new
  end

  private

  def stats_for(type)
    out = capture_stdout { cli.send("stats_for_#{type}".to_sym) }
    stats = out.match(LINES)
    percent = (stats[:undocumented] || 0).to_i / stats[:total].to_f * 100
    log "Total #{type}: #{stats[:total]}"
    log "Undocumented #{type}: #{stats[:undocumented] || 0} (#{"%0.2f" % percent}%)"

    stats
  end
end


