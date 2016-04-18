class Worker < ActiveRecord::Base
  has_one :next_worker, class_name: 'Worker', foreign_key: 'next_worker'

  def work(unique_id)
    Kernel.sleep(duration)
    unless work_cmd.nil?
      Kernel.system(work_cmd)
    end
    return if next_worker.nil?

    logger.info("name: #{next_worker_name} state: enqueued unique_id: #{unique_id}")

    WorkJob.set(queue: next_worker_name).perform_later(unique_id)
  end

  def next_worker_id
    if next_worker.nil?
      nil
    else
      next_worker.id
    end
  end

  def next_worker_name
    if next_worker.nil?
      nil
    else
      next_worker.name
    end
  end

end
