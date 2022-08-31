require 'selenium-webdriver'
require 'test-unit'

class EcommerceTests < Test::Unit::TestCase
  def setup
    username = "{LAMBDATEST_USERNAME}"
    accessToken = "{LAMBDATEST_ACCESS_KEY}"
    gridUrl = "hub.lambdatest.com/wd/hub"

    capabilities = {
      'LT:Options' => {
        "user" => username,
        "accessKey" => accessToken,
        "build" => "Ecommerce Wait Test v.1",
        "name" => "Ecommerce Wait Tests",
        "platformName" => "Windows 11"
      },
      "browserName" => "Firefox",
      "browserVersion" => "100.0",
    }

    @my_driver = Selenium::WebDriver.for(:remote,
                                         :url => "https://" + username + ":" + accessToken + "@" + gridUrl,
                                         :desired_capabilities => capabilities)

    @my_driver = Selenium::WebDriver.for :firefox
    @url = "https://ecommerce-playground.lambdatest.io/"

    @my_driver.get(@url)

    # Set an implicit wait time
    @my_driver.manage.timeouts.implicit_wait = 30

  end

  def test_title_should_be_your_store

    # The implicit time will apply by default. i.e 30 seconds
    assert_equal(@my_driver.title, "Your Store")
  end

  def teardown
    @my_driver.quit
  end
end
