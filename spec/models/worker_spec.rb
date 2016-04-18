require 'rails_helper'

RSpec.describe Worker, type: :model do

  before(:each) do
    @unique_id = 'foo'
  end
  it 'works on a work job for a fixed amount of time' do
    duration = 10
    worker = Worker.create(name: 'encode', duration: duration)
    # expect the job to take some time
    expect(Kernel).to receive(:sleep).with(duration).exactly(1).times
    worker.work(@unique_id)
  end

  it 'knows who the next worker is' do
    last_worker_name = 'transcode'

    last_worker = Worker.create(name: last_worker_name, duration: 30)
    worker = Worker.create(name: 'ingest', next_worker: last_worker, duration: 60)
    expect(worker.next_worker_name).to match(last_worker_name)
    expect(worker.next_worker_id).to match(last_worker.id)
  end

  it 'doesn\'t explode if you ask it the name of the next worker and there is none' do

  end

  it 'doesn\'t explode if you ask it the ID of the next worker and there is none' do

  end

  it 'passes the work job on to the next worker when it\'s done' do
    next_worker_name = 'convert'
    duration = 10
    next_worker = Worker.create(name: next_worker_name, duration: 30)
    worker = Worker.create(name: 'encode',
                           duration: duration,
                           next_worker: next_worker)
    # expect the job to take some time
    allow(Kernel).to receive(:sleep)
      .with(duration).exactly(1).times
    expect(WorkJob).to receive(:set)
      .with(queue: next_worker_name).and_return(WorkJob)
    worker.work(@unique_id)
  end

  it 'does some activity if we ask it to' do
    cmd = 'ls'
    worker = Worker.create(name: 'ingest', duration: 1, work_cmd: cmd)
    expect(Kernel).to receive(:system).with(cmd)
    worker.work(@unique_id)
  end

  it 'logs when the next job gets enqueued' do
    skip('fun with mocks')
  end

end
