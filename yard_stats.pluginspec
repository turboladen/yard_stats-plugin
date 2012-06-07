Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = "yard_stats"
  plugin.display_name = "Yard Stats Plugin"
  plugin.version = '0.0.1'
  plugin.description = 'TODO: enter description here'

  # You should create a wiki-page for your plugin when you publish it, see
  # https://wiki.jenkins-ci.org/display/JENKINS/Hosting+Plugins#HostingPlugins-AddingaWikipage
  # This line makes sure it's listed in your POM.
  plugin.url = 'https://wiki.jenkins-ci.org/display/JENKINS/Yard+Stats+Plugin'

  # The first argument is your user name for jenkins-ci.org.
  plugin.developed_by "steve.loveless", "Steve Loveless <steve.loveless@gmail.com>"

  # This specifies where your code is hosted.
  # Alternatives include:
  #  :github => 'myuser/yard_stats-plugin' (without myuser it defaults to jenkinsci)
  #  :git => 'git://repo.or.cz/yard_stats-plugin.git'
  #  :svn => 'https://svn.jenkins-ci.org/trunk/hudson/plugins/yard_stats-plugin'
  plugin.uses_repository :github => "turboladen/yard_stats-plugin"

  # This is a required dependency for every ruby plugin.
  plugin.depends_on 'ruby-runtime', '0.10'

  # This is a sample dependency for a Jenkins plugin, 'git'.
  #plugin.depends_on 'git', '1.1.11'
end
