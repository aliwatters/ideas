Feature: Universal URL Parser
  As a user
  I want to paste any product URL from supported retailers
  So that wishfire can automatically identify and track the product

  Background:
    Given the URL parser is initialized
    And the following retailers are supported:
      | Retailer  | ID Type |
      | Amazon    | ASIN    |
      | Best Buy  | SKU     |

  Scenario: Parse Amazon product URL
    When I submit the URL "https://www.amazon.com/dp/B08N5WRWNW"
    Then the parser should identify retailer as "Amazon"
    And the parser should extract product ID "B08N5WRWNW"
    And the ID type should be "ASIN"

  Scenario: Parse Amazon URL with gp/product format
    When I submit the URL "https://www.amazon.com/gp/product/B08N5WRWNW/ref=xyz"
    Then the parser should identify retailer as "Amazon"
    And the parser should extract product ID "B08N5WRWNW"

  Scenario: Parse Amazon mobile URL
    When I submit the URL "https://m.amazon.com/dp/B08N5WRWNW"
    Then the parser should identify retailer as "Amazon"
    And the parser should extract product ID "B08N5WRWNW"

  Scenario: Parse Amazon URL with query parameters
    When I submit the URL "https://www.amazon.com/Sony-WH-1000XM5/dp/B09XS7JWHH?tag=affiliate-20&ref=xyz"
    Then the parser should identify retailer as "Amazon"
    And the parser should extract product ID "B09XS7JWHH"

  Scenario: Parse Best Buy product URL
    When I submit the URL "https://www.bestbuy.com/site/sony-wh-1000xm5/6505727.p"
    Then the parser should identify retailer as "Best Buy"
    And the parser should extract product ID "6505727"
    And the ID type should be "SKU"

  Scenario: Parse Best Buy URL with query parameters
    When I submit the URL "https://www.bestbuy.com/site/product/6505727.p?skuId=6505727"
    Then the parser should identify retailer as "Best Buy"
    And the parser should extract product ID "6505727"

  Scenario Outline: Parse multiple retailer URLs
    When I submit the URL "<url>"
    Then the parser should identify retailer as "<retailer>"
    And the parser should extract product ID "<product_id>"

    Examples:
      | url                                                | retailer  | product_id  |
      | https://www.amazon.com/dp/B0ABCDEF12               | Amazon    | B0ABCDEF12  |
      | https://www.amazon.co.uk/dp/B0ABCDEF12             | Amazon    | B0ABCDEF12  |
      | https://www.bestbuy.com/site/product/1234567.p     | Best Buy  | 1234567     |

  Scenario: Reject invalid URL format
    When I submit the URL "not-a-valid-url"
    Then the parser should return an error
    And the error message should be "Please enter a valid product URL"

  Scenario: Reject unsupported retailer
    When I submit the URL "https://www.target.com/p/some-product/-/A-12345678"
    Then the parser should return an error
    And the error message should be "This retailer is not yet supported"

  Scenario: Reject URL without product ID
    When I submit the URL "https://www.amazon.com/"
    Then the parser should return an error
    And the error message should be "Could not find product in this URL"

  Scenario: Reject empty input
    When I submit an empty URL
    Then the parser should return an error
    And the error message should be "Please enter a product URL"

  Scenario: Parse URL and prepare for product lookup
    When I submit the URL "https://www.amazon.com/dp/B08N5WRWNW"
    Then the parser should extract product ID "B08N5WRWNW"
    And the system should be ready to fetch product details from Amazon API
    And the system should be ready to search for the product on other retailers
