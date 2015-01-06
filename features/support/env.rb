$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'cucumber'
require 'test/unit/assertions'
include Test::Unit::Assertions
require 'watir-webdriver'
require 'selenium-webdriver'
require 'webdriver-user-agent'
require 'minitest'
require 'minitest/assertions'
require 'minitest-extra-assertions'
require 'selenium/webdriver/phantomjs'
require 'pry'

def environment
  (ENV['ENVIRONMENT'] ||= 'prod').downcase.to_sym
end

def browser_name
  (ENV['BROWSER'] ||= 'ff').downcase.to_sym
end

Before do |scenario|
  # p "Starting #{scenario}"
  if environment == :prod
    @browser = Watir::Browser.new browser_name
    @browser.window.resize_to(1024,1000)
    @browser.goto "www.azubu.tv"
    @browser.send_keys :return
  elsif environment == :droidphone
    driver = UserAgent.driver(:browser => "chrome", :agent => "Nexus", :orientation => "landscape")
    @browser = Watir::Browser.new browser_name
    @browser.goto "www.azubu.tv"
    @browser.send_keys :return
  elsif environment == :iphone
    driver = UserAgent.driver(:browser => "chrome", :agent => "iphone", :orientation => "landscape")
    @browser = Watir::Browser.new browser_name
    @browser.goto "www.azubu.tv"
    @browser.send_keys :return
  else
    @browser = Watir::Browser.new browser_name
    @browser.goto "http://qa1.atmysite.com:80"
    @browser.send_keys :return
  end
end

After do |scenario|
  @browser.close
end
