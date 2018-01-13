class Search < ApplicationRecord
    has_many :photos


    PER_PAGE = 30

    APP_ROOT = Rails.root.join('download')

    def search_url(rn, pn)
      URI::escape("https://image.baidu.com/search/acjson?tn=resultjson_com&ct=201326592&ipn=rj&face=0&word=#{self.name}&rn=#{rn}&pn=#{pn}")
    end

    def request_url(url)
      RestClient::Request.execute(method: :get, url: url)
    end

    # 获取总记录条数
    def get_total_numbers(num)
        result = request_url(search_url(1, 1))
        total_num = JSON.parse(result)["displayNum"]
        if num.to_i > total_num.to_i
            total_num.to_i
        else
            num.to_i
        end
    end

    def search_info
        total_nums = get_total_numbers(self.number)

        (0..(total_nums/PER_PAGE).to_i).each_with_index do |page, index|

          puts "---------------- 第 #{page} 页数据 ----------------"
          url = search_url(PER_PAGE, page)
          # p url
          result = request_url(url)

          JSON.parse(result)["data"].each_with_index do |list, index|
            # write_pic_file(list["middleURL"], @down_dir, i.to_s) unless list["middleURL"].nil?

            PhotoWorker.perform_async(self.id, list["middleURL"] ) unless list["middleURL"].nil?
          end
        end
    end

    # 创建文件夹
    def create_down_folder
      @down_dir = "#{APP_ROOT}/BDownload/#{self.name}-#{Time.now.strftime("%Y%m%d %R")}-#{self.number}/"
      FileUtils.mkdir_p @down_dir
      @down_dir
    end

    def download_info
        directory =  create_down_folder

        self.photos.find_in_batches(batch_size: 200) do |group|
          group.each do |photo|
            DownloadFileWorker.perform_async(photo.url, directory, "#{photo.id}.jpg")
          end
          # group.each { |person| DownloadFileWorker.perform_async(person) }
        end

    end
end
