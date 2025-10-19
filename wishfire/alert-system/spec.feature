Feature: Smart Alert System
  As a user
  I want to receive alerts when tracked products hit my target price
  So that I can buy at the best time

  Background:
    Given I am a registered user with email "user@example.com"
    And I have added "Sony WH-1000XM5 Headphones" to my watchlist
    And I set a target price of $250

  Scenario: Target price reached on any retailer
    Given the current prices are:
      | Retailer  | Price |
      | Amazon    | $299  |
      | Best Buy  | $278  |
      | Target    | $289  |
    When Best Buy price drops to $249
    Then I should receive an email alert within 1 hour
    And the email subject should be "🔥 Sony WH-1000XM5 is now $249 at Best Buy!"
    And the email should include the current price "$249"
    And the email should include a direct link to Best Buy
    And the alert should be marked as sent in the database

  Scenario: Multiple retailers hit target simultaneously
    Given Amazon price is $251
    And Best Buy price is $248
    And Target price is $245
    When I check my alerts
    Then I should receive ONE consolidated email alert
    And the email should list all retailers below my target:
      | Retailer  | Price |
      | Target    | $245  |
      | Best Buy  | $248  |
    And the email should highlight Target as the lowest price
    And I should not receive multiple separate emails

  Scenario: Price drops below target then rises again
    Given I received an alert yesterday when price was $245
    And I did not purchase the item
    When the price rises back to $275
    Then I should not receive another alert
    But my watchlist should show "Last low: $245 (Best Buy, 1 day ago)"

  Scenario: Re-alert when price drops again after rising
    Given I received an alert when price was $245
    And the price rose to $280
    When the price drops to $240
    Then I should receive a new alert
    And the email should say "Price dropped again to $240!"

  Scenario: Percentage drop alert
    Given I set an alert for "20% or more price drop"
    And the current price is $300
    When the price drops to $239
    Then I should receive an alert
    And the email should say "Sony WH-1000XM5 dropped 20% to $239!"
    But if the price drops to $241
    Then I should not receive an alert (only 19.7% drop)

  Scenario: Deal alert for Lightning Deal
    Given I have "alert on deals" enabled
    And the product is currently $299
    When Amazon creates a Lightning Deal for $279
    Then I should receive an alert
    And the email should say "⚡ Lightning Deal: Sony WH-1000XM5 now $279 (ends in 4 hours)"
    And the email should include the deal end time

  Scenario: Deal alert for Prime Exclusive Deal
    Given I have "alert on deals" enabled
    When Best Buy creates a "Deal of the Day" at $259
    Then I should receive an alert
    And the email should say "🎯 Deal of the Day: Sony WH-1000XM5 now $259"

  Scenario: User alert preferences - email only
    Given I have disabled SMS alerts
    And I have enabled email alerts
    When a price alert is triggered
    Then I should receive an email
    And I should not receive an SMS

  Scenario: User alert preferences - all alerts disabled
    Given I have disabled all alerts for this product
    When the price drops below my target
    Then I should not receive any notification
    But the watchlist should still track the price drop

  Scenario: Alert rate limiting
    Given the price drops below my target at 9:00 AM
    And I receive an alert
    When the price drops further at 9:30 AM
    Then I should not receive another alert (too soon)
    But when the price drops further at 10:00 AM the next day
    Then I should receive a new alert

  Scenario: Unsubscribe from alerts
    Given I click "Unsubscribe" in an alert email
    Then I should be unsubscribed from all price alerts
    And I should see a confirmation page
    And I should not receive future alerts
    But my watchlist should remain active for manual checking

  Scenario: Alert for out-of-stock to in-stock transition
    Given the product is out of stock at Best Buy
    And I have "alert when back in stock" enabled
    When Best Buy shows the product as in stock
    Then I should receive an alert
    And the email should say "Back in stock: Sony WH-1000XM5 at Best Buy ($299)"

  Scenario: Grouped alerts for multiple products
    Given I have 5 products in my watchlist
    And 3 of them hit their target price within the same hour
    When alerts are sent
    Then I should receive ONE consolidated email
    And the email should list all 3 products with their prices
    And the subject should be "🔥 3 of your watched items are on sale!"

  Scenario: Alert delivery failure handling
    Given an alert is triggered
    When the email delivery fails
    Then the system should retry up to 3 times
    And if all retries fail, log the error
    And mark the alert as "failed" in the database
    And notify the system admin

  Scenario: Alert includes price history context
    Given the product has been tracked for 30 days
    And the average price is $320
    And the lowest price was $260
    When a target price alert is sent at $249
    Then the email should say "Lowest price in 30 days!"
    And the email should include a small price history chart

  Scenario: Custom alert message for first-time price drop
    Given this is the first time the price dropped below target
    When the alert is sent
    Then the email should say "Great news! Price just hit your target for the first time"

  Scenario: Alert timing preferences
    Given I set "quiet hours" from 10 PM to 8 AM
    When an alert is triggered at 11 PM
    Then the alert should be queued
    And sent at 8:01 AM the next day
