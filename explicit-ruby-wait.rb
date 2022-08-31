require 'selenium-webdriver'
require 'test-unit'

class EcommerceTests < Test::Unit::TestCase
  def setup
    username= "{LAMBDATEST_USERNAME}"
    accessToken= "{LAMBDATEST_ACCESS_KEY}"
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
                                      :url => "https://"+username+":"+accessToken+"@"+gridUrl,
                                      :desired_capabilities => capabilities)

    @my_driver = Selenium::WebDriver.for :firefox
    @url = "https://ecommerce-playground.lambdatest.io/"

    @my_driver.get(@url)

    # Set an implicit wait time
    @my_driver.manage.timeouts.implicit_wait = 30

    # Set the explicit wait time for a maximum wait of 60 seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 60)

  end

  def test_search_functionality_should_yield_results

    assert_equal(@my_driver.title, "Your Store")

    search_box = @my_driver.find_element(:name, "search")

    search_box.clear
    search_box.send_keys("phone")
    search_box.submit
    sleep(5)

    # Call the explicit wait time - Here, the waiting time will be set to 60s and not the 30s.
    search_title = @wait.until { @my_driver.find_element(:xpath, '//*[@id="entry_212456"]/h1') }

    # Second test assertion - title has loaded
    assert_equal("Search - phone", search_title.text)
  end

  def teardown
    @my_driver.quit
  end

end