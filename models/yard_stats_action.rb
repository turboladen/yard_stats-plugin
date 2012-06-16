class YardStatsAction < Jenkins::Model::HealthReportingAction
  display_name 'Yard Stats'
  icon 'gear.png'
end

Jenkins::Plugin.instance.register_extension(YardStatsAction)
