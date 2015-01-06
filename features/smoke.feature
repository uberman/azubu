@frontend @smoke
Feature: Azubutv home navigation functionality
  Scenario Outline: New visitors can navigate to the main areas of the site
    Given a visitor to the Azubutv home page
    When the visitor clicks on the navigation <button>
    Then the visitor will get redirected to the main <area>
    And the visitor sees the page has a new <title>
  Examples:
    |button|area|title|
    |GAMES |games|Games \| Azubu|
    |CHANNELS|channels|Live eSports channels \| Azubu|
    |VIDEOS|vod|Video on demand (VOD) \| Azubu|
    |NEWS|news|Azubu Content - Home|

  Scenario: New visitors can subscribe to Azubu 2.0
    Given a visitor to the Azubutv home page
    When the visitor clicks on JOIN HERE
    Then they can enter their email to start Azubutv subscription

  Scenario: New visitors who completed their subscription to Azubu 2.0 can log in
    Given a visitor to the Azubutv home page
    When the visitor inputs their credentials
    And then clicks SIGN IN
    Then they get logged into Azubu

  Scenario Outline: Visitors can navigate to the various areas of the Footer Links Section
    Given a visitor to the Azubutv home page
    When they click on the footer <link>
    Then they get redirected to a new footer page <area>
  Examples:
    |link|area|
    |Advertise   |advertise|
    |Partner  |partner|
    |FAQ|faq|
    |Company Profile|company-profile|
    |Contact Us    |contact-us      |
    |Azubu Blog|blog|
    |Terms & Conditions|terms|
    |Privacy Policy|policy|
