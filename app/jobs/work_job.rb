class WorkJob < ActiveJob::Base
  attr_reader :worker
  queue_as :default

  def perform(*args)
    # Get worker based on Queue Name and get it to do the work
    @worker = Worker.find_by(name: @queue_name)
    @worker.work
  end
end
