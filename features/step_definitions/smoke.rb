Given(/^a visitor to the Azubutv home page$/) do
  p = @browser.div(:id => "logo").div(:class => "desktop")
  p.wait_until_present
  new_user = p.exist?
  assert(new_user)
end

When(/^the visitor clicks on the navigation (.*)$/) do |button|
  p = @browser.span(:class => "mainmenu").a(:text => "#{button}")
  p.wait_until_present
  navtabs_check = p.exist?
  assert(navtabs_check)
  p.click
end

Then(/^the visitor will get redirected to the main (.*)$/) do |area|
  p = @browser.span(:class => "small", :text => "© Azubu 2014")
  p.wait_until_present
  check_copyrt = p.exist?
  assert(check_copyrt)
  @browser.url ==  "www.azubu.tv/#{area}"
end

And(/^the visitor sees the page has a new (.*)$/) do |title|
  page_title = @browser.title
  check_page = page_title.include?("#{title}")
  assert(check_page)
end

When(/^the visitor clicks on JOIN HERE$/) do
  p = @browser.a(:class => "home-page-form-registration-show-btn  linkmain", :text => "JOIN HERE")
  p.wait_until_present
  check_subscribe = p.exist?
  assert(check_subscribe)
  p.click
end

Then(/^they can enter their email to start Azubutv subscription$/) do
  rng = rand(0..99)
  test_email = "visitor_#{rng}@mailinator.com"
  puts test_email
  p = @browser.text_field(:id => "home-page-form-registration-email-field")
  p.wait_until_present
  check_form = p.exist? && p.visible?
  assert(check_form)
  p.set "#{test_email}"
  p2 = @browser.a(:id => "home-page-form-registration-send-btn")
  p2.when_present.click

end

When(/^the visitor inputs their credentials$/) do
  p = @browser.text_field(:id=> "home-page-form-login-email-field", :name => "username")
  p.when_present.set "visitor_91"
  p2 = @browser.text_field(:id => "home-page-form-login-paswd-field", :name => "password")
  p2.when_present.set "password1"
end

And(/^then clicks SIGN IN$/) do
  p = @browser.a(:id => "home-page-form-login-send-btn")
  p.when_present.click
  sleep 5
end

Then(/^they get logged into Azubu$/) do
  @browser.goto "www.azubu.tv/profile"
  p = @browser.span(:class => "top-user-name")
  p.text == "visitor_91"
end

When(/^they click on the footer (.*)$/) do |link|
  p = @browser.a(:class => "linkfooter", :text => "#{link}")
  p.when_present.click
end

Then(/^they get redirected to a new footer page (.*)$/) do |area|
  p = @browser.url
  p == "www.azubu.tv/#{area}"
end