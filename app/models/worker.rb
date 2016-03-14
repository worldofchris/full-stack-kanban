class Worker < ActiveRecord::Base
  has_one :next_worker, class_name: 'Worker', foreign_key: 'next_worker'

  def work
    Kernel.sleep(duration)
    return if next_worker.nil?
    WorkJob.set(queue: next_worker_name).perform_later
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
