class PhotoWorker
  include Sidekiq::Worker

  # PhotoWorker.perform_async(search_id, data)
  def perform(search_id, url)
    # Do something
    # lists = JSON.parse(result)["data"]

    # lists.each_with_index do |list, index|
      data = {
        search_id: search_id,
        url: url
      }
      # PhotoCreateWorker.perform_async(data)
      Photo.create(data)
    # end unless lists.size >2

  end
end
