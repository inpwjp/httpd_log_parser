require 'httpd_log_parser/base'
require 'httpd_log_parser/common'
require 'httpd_log_parser/combined'

class String
  def to_unicage_str
    return self.gsub(/_/, "\\_").gsub(/ /, "_")
  end

  def to_unicage_nullchk
    if self == "-"
      return "_"
    end

    return self
  end
end
