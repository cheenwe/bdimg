class PhotoCreateWorker
  include Sidekiq::Worker

  # PhotoCreateWorker.perform_async(data)
  def perform(data)
      Photo.create(data) rescue ''
  end
end
