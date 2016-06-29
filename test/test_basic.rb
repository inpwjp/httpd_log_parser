$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'httpd_log_parser'
require 'date'

require "test/unit"

class TestBasic < Test::Unit::TestCase
  class << self

    def shutdown
    end
  end

  sub_test_case "combined test" do
    setup do 
      log_text = '192.168.1.1 user-identifier root [13/May/2016:13:47:42 +0900] "GET /test/?query1=data1&query2=true HTTP/1.1" 200 1234 "/referer/from" "test_agent" "192.168.2.1"' 
      @apache_log = HttpdLogParser::Combined.new
      @apache_log.set_string(log_text)
      log_text = '192.168.1.1 - root [13/May/2016:13:47:42 +0900] "GET /test/?query1=data1&query2=true_data HTTP/1.1" 200 1234 - "test_agent" "192.168.2.1"' 
      @apache_log2 = HttpdLogParser::Combined.new
      @apache_log2.set_string(log_text)
    end

    test "check remote host" do
      assert_equal( @apache_log.remote_host, "192.168.1.1")
    end

    test "check client_type" do
      assert_equal( @apache_log.client_type, "user-identifier")
    end

    test "check user_name" do
      assert_equal( @apache_log.user_name, "root")
    end

    test "check access_time" do
      assert_equal( @apache_log.access_time, DateTime.parse("2016-5-13T13:47:42 +0900"))
    end

    test "check request_code" do
      assert_equal( @apache_log.request_code, "GET /test/?query1=data1&query2=true HTTP/1.1")
    end

    test "check request_method" do
      assert_equal( @apache_log.request_method, "GET")
    end

    test "check response_status" do
      assert_equal( @apache_log.response_status, "200")
    end

    test "check object_bytes" do
      assert_equal( @apache_log.object_bytes, "1234")
    end

    test "check referer_uri" do
      assert_equal( @apache_log.referer_uri, "/referer/from")
    end

    test "check user_agent" do
      assert_equal( @apache_log.user_agent, "test_agent")
    end

    test "check to_unicage" do 
      assert_not_nil(@apache_log.to_unicage)
    end

    test "check to_unicage2" do 
      assert_not_nil(@apache_log2.to_unicage)
    end
  end

  sub_test_case "common test" do
    setup do 
      log_text = '192.168.1.1 user-identifier root [13/May/2016:13:47:42 +0900] "GET /test/?query1=data1&query2=true HTTP/1.1" 200 1234 "/referer/from" "test_agent" "192.168.2.1"' 
      @apache_log = HttpdLogParser::Common.new
      @apache_log.set_string(log_text)
    end

    test "check remote host" do
      assert_equal( @apache_log.remote_host, "192.168.1.1")
    end

    test "check client_type" do
      assert_equal( @apache_log.client_type, "user-identifier")
    end

    test "check user_name" do
      assert_equal( @apache_log.user_name, "root")
    end

    test "check access_time" do
      assert_equal( @apache_log.access_time, DateTime.parse("2016-5-13T13:47:42 +0900"))
    end

    test "check request_code" do
      assert_equal( @apache_log.request_code, "GET /test/?query1=data1&query2=true HTTP/1.1")
    end

    test "check request_method" do
      assert_equal( @apache_log.request_method, "GET")
    end

    test "check response_status" do
      assert_equal( @apache_log.response_status, "200")
    end

    test "check object_bytes" do
      assert_equal( @apache_log.object_bytes, "1234")
    end

    test "check to_unicage" do 
      assert_not_nil(@apache_log.to_unicage)
    end
  end

  sub_test_case "long logdata test" do
    setup do 
      log_text = '192.168.1.1 user-identifier root [13/May/2016:13:47:42 +0900] "GET /test/?query1=0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789 HTTP/1.1" 200 1234 "/referer/from" "test_agent" "192.168.2.1"' 
      @apache_log = HttpdLogParser::Combined.new
      @apache_log.set_string(log_text)
    end

    test "check request_code" do
      assert_equal( @apache_log.request_code, "GET /test/?query1=0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789 HTTP/1.1")
    end

    test "check request_method" do
      assert_equal( @apache_log.request_method, "GET")
    end

    test "check response_status" do
      assert_equal( @apache_log.response_status, "200")
    end

    test "check object_bytes" do
      assert_equal( @apache_log.object_bytes, "1234")
    end

    test "check referer_uri" do
      assert_equal( @apache_log.referer_uri, "/referer/from")
    end

    test "check user_agent" do
      assert_equal( @apache_log.user_agent, "test_agent")
    end
  end
end
