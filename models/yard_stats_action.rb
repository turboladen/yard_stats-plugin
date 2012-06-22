class YardStatsAction < Jenkins::Model::ProminentProjectAction
  display_name 'Yard Stats'
  icon 'gear.png'
  url_path 'yard_stuff'

  def getIconFileName
    self.class.icon
  end

  def getUrlName
    self.class.url_path
  end

  def pants
    puts "pants called"
    "PATNS"
  end
end

Jenkins::Plugin.instance.register_extension(YardStatsAction)
