
module HttpdLogParser
  class Base
    attr_accessor :remote_host, :client_type, :user_name, :access_time, :request_code, :response_status, :object_bytes, :referer_uri, :user_agent, :request_method, :uri, :url, :query
    @@format = '%d/%b/%Y:%H:%M:%S %Z'

    def filter_log
      if access_time.nil?
        return nil
      end

      yield

      log
    end

    def delete_images()
      filter_log do
        images = ["js", "css", "json", "png", "gif", "jpg","woff", "ico", "pdf", "mp3", "jsp", "xml"]
        images.each do |image|
          if /#{image}$/ =~ self.url
            return nil
          end
        end
      end
    end
  end
end
