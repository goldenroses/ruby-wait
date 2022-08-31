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

    # @my_driver = Selenium::WebDriver.for :firefox
    @url = "https://ecommerce-playground.lambdatest.io/"

    @my_driver.get(@url)

    # We define the exception we expect
    exception = Selenium::WebDriver::Error::NoSuchElementError

    # Set a fluent wait time for a maximum wait of 45 seconds  - for use later in the tests
    # Here, the error NoSuchElementError is expected to be thrown, but we don't want to fail the test if it does, so we use the rescue block
    @fluent_wait = Selenium::WebDriver::Wait.new(timeout: 45, interval: 5, message: 'Timed out after 45 secs', ignore: exception)

  end

  def test_search_functionality_with_fluent_wait

    # Call the explicit wait time
    assert_equal(@my_driver.title, "Your Store")

    # Here we call an element that does not exist and check that the fluent wait works as expected, we
    # ignore the NoSuchElementError exception and rescue the TimeOutError exception to proceed with the test
    begin
      @fluent_wait.until { @my_driver.find_element(:name, "search-box-doesnt-exist") }
    rescue Selenium::WebDriver::Error::TimeoutError
      puts "Element not found"
    end

  end

  def teardown
    @my_driver.quit
  end

end