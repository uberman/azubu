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

When(/^they click on an app (.*)$/) do |icon|
  p = @browser.div(:class => "appstores").a(:href => /https:\/\/#{icon}/)
  # p = @browser.a(:class => "#{icon}").image(:width => "135")
  p.exist?
  p.click
end

Then(/^the browser is redirected to the app (.*)$/) do |store|
  p = @browser.title
  puts p
  p == /#{store}/
  # (:class => "gb_Oa", :title => "Google Play")
  assert(p)
end

When(/^they search for a player's (.*) using the search feature$/) do |name|
  p = @browser.text_field(:class => "search")
  p.exist?
  p.set "#{name}"
  p.send_keys :return

end

Then(/^the browser redirects to player search results$/) do
  p = @browser.p(:class => "MagTitle04 lightgray").text
  x = p.include? "Found"
  assert(x)

end

When(/^they click on the right side of the hero carousel$/) do
  p = @browser.a(:class => "right carousel-control")
  p.exist?
  @vod_style_before = @browser.div(:class => "carousel-inner").div(:class => "item active").style
  sleep 2
  p.click
  @vod_style_after =  @browser.div(:class => "carousel-inner").div(:class => "item active").style
end

Then(/^the carousel rotates to the right$/) do
  assert(@vod_style_before != @vod_style_after)
end