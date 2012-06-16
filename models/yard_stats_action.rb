class YardStatsAction < Jenkins::Model::HealthReportingAction
  display_name 'Yard Stats'
  icon 'gear.png'

  def getIconFileName
    # Defining so I don't get an error saying this isn't defined.  Not sure why
    # I'm getting that error, since this method is defined in Action, which is
    # included in HealthReportingAction.
  end
end

Jenkins::Plugin.instance.register_extension(YardStatsAction)
