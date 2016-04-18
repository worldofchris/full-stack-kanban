require 'rails_helper'

RSpec.describe WorkJob, type: :job do
  before (:each) do
    @unique_id = 'boff'
  end

  it 'gets a worker to do the work based on the name of the queue the work came off' do
    # expect the right worker to be retrieved
    worker = instance_double('Worker')
    expect(Worker).to receive(:find_by).with(name: 'encode').and_return(worker)
    # expect that worker to get prodded
    expect(worker).to receive(:work)

    WorkJob.set(queue: :encode).perform_later
  end

  it 'logs the start and end time of the job' do
    expect(Rails.logger).to receive(:info)
      .with("name: encode state: start unique_id: #{@unique_id}")
    expect(Rails.logger).to receive(:info)
      .with("name: encode state: end unique_id: #{@unique_id}")

    WorkJob.set(queue: :encode).perform_later(@unique_id)
  end
end
