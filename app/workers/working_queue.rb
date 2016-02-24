class WorkingQueue

  include Sidekiq::Worker
  def perform()
    puts "pa lidhje"
  end
end
