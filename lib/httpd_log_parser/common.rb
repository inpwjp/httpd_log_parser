require 'rubygems'
require 'csv'
require 'date'
require 'digest/md5'

module HttpdLogParser
  class Common < HttpdLogParser::Base
    def set_string(str)
      str.gsub!(/\[(\d+\/[a-zA-Z]{3}\/\d+.+?)\]/, "\"\\1\"")
      if str.include?(' ')
        begin
          line = CSV::parse_line(str, {col_sep: ' ', skip_blanks: true})
          self.remote_host = line[0]
          self.client_type = line[1]
          self.user_name = line[2]
          self.access_time = DateTime.strptime(line[3], @@format)
          self.request_code = line[4]
          self.response_status = line[5]
          self.object_bytes = line[6]
          request_datum = self.request_code.split(" ")
          self.request_method = request_datum[0]
          self.uri = request_datum[1]
          if ! self.uri.nil?
            self.url, self.query = self.uri.split('?')
          end
        rescue => e
          $stderr.puts e
          $stderr.puts line
          return self
        end
      end
      self
    end

    def uniq_hash
      Digest::MD5.hexdigest(self.user_name.to_s + self.remote_host)
    end

    def log
      "#{self.remote_host} #{self.client_type} #{self.user_name} [#{self.access_time.strftime(@@format)}] \"#{self.request_code}\" #{self.response_status} #{self.object_bytes}"
    end
  end
end
