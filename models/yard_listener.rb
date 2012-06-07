class YardListener
  include Jenkins::Listeners::RunListener
  
  def completed(build, task_listener)
    puts "build completed"
  end
end
