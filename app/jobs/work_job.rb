class WorkJob < ActiveJob::Base
  attr_reader :worker
  queue_as :default

  def perform(*unique_id)
    # Log start with correlation ID
    logger.info("name: #{queue_name} state: start unique_id: #{unique_id[0]}")
    # Get worker based on Queue Name and get it to do the work
    @worker = Worker.find_by(name: @queue_name)
    unless @worker.nil?
      @worker.work(unique_id[0])
    end
    # Log end with correlation ID
    logger.info("name: #{queue_name} state: end unique_id: #{unique_id[0]}")
  end
end
