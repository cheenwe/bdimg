class DownloadFileWorker
  include Sidekiq::Worker

  # DownloadFileWorker.perform_async(url, directory, filename)
  def perform(url, directory, filename)
    # Crawler.download_file(url, directory, filename)
    file = directory + filename

    File.open(file, "wb") { |s|
      res = RestClient.get(url)
      s.write(res)
      s.close()
    } rescue ''
  end
end
