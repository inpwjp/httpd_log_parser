
module HttpdLogParser
  class Base
    attr_accessor :remote_host, :client_type, :user_name, :access_time, :request_code, :response_status, :object_bytes, :referer_uri, :user_agent, :request_method, :uri, :url, :query, :filters, :ignore_extentions, :call_version, :other_data
    @@format = '%d/%b/%Y:%H:%M:%S %Z'
    @@format_unicage = '%Y-%m-%dT%H:%M:%S-%Z'

    def initializer()
      @ignore_extentions = []
      @filters = []
    end


    def filters_log
      if access_time.nil?
        return nil
      end


      @ignore_extentions.each do |ignore_extention|
        if /#{ignore_extention}$/ =~ self.url
          return nil
        end
      end

      @filters.each do |filter|
        filter.call
      end

      log
    end

    def add_filter(&function)
      @filters << function
    end


    def set_delete_images()
      images = ["png", "gif", "jpg", "ico", "pdf", "mp3", "jsp"]
      @ignore_extentions += images

      self
    end


  end

end
