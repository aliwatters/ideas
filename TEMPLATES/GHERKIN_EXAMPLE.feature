# Gherkin Syntax Reference and Examples

# Basic Structure:
# - Feature: High-level description of a feature
# - Background: Common steps that run before each scenario
# - Scenario: Specific test case
# - Given: Initial context/state
# - When: Action/event that occurs
# - Then: Expected outcome
# - And/But: Additional steps

# ==============================================================================
# EXAMPLE 1: Basic User Authentication
# ==============================================================================

Feature: User Authentication
  As a user
  I want to securely log in to my account
  So that I can access my personalized dashboard

  Background:
    Given the application is running
    And I am on the login page

  Scenario: Successful login with valid credentials
    Given I have a registered account with email "user@example.com"
    When I enter email "user@example.com"
    And I enter password "SecurePass123"
    And I click the "Log In" button
    Then I should be redirected to my dashboard
    And I should see "Welcome back, User"
    And I should see my account navigation menu

  Scenario: Failed login with invalid password
    Given I have a registered account with email "user@example.com"
    When I enter email "user@example.com"
    And I enter password "WrongPassword"
    And I click the "Log In" button
    Then I should remain on the login page
    And I should see an error message "Invalid email or password"
    And the password field should be cleared

  Scenario: Failed login with unregistered email
    When I enter email "nonexistent@example.com"
    And I enter password "SomePassword123"
    And I click the "Log In" button
    Then I should see an error message "Invalid email or password"
    And I should not be able to access the dashboard

  Scenario: Password reset flow
    When I click the "Forgot Password?" link
    Then I should be redirected to the password reset page
    When I enter email "user@example.com"
    And I click the "Send Reset Link" button
    Then I should see a confirmation "Check your email for reset instructions"
    And I should receive a password reset email at "user@example.com"

# ==============================================================================
# EXAMPLE 2: E-commerce Shopping Cart (with Data Tables)
# ==============================================================================

Feature: Shopping Cart Management
  As a customer
  I want to manage items in my shopping cart
  So that I can purchase multiple products together

  Background:
    Given I am logged in as "customer@example.com"
    And the following products exist:
      | Product ID | Name                  | Price  | Stock |
      | SKU001     | Wireless Headphones   | $99.99 | 15    |
      | SKU002     | USB-C Cable           | $12.99 | 50    |
      | SKU003     | Phone Case            | $24.99 | 30    |

  Scenario: Adding items to cart
    Given my cart is empty
    When I add 2 units of "Wireless Headphones" to my cart
    And I add 1 unit of "USB-C Cable" to my cart
    Then my cart should contain:
      | Product             | Quantity | Price   |
      | Wireless Headphones | 2        | $199.98 |
      | USB-C Cable         | 1        | $12.99  |
    And the cart total should be $212.97
    And the cart badge should show "3 items"

  Scenario: Removing items from cart
    Given my cart contains:
      | Product             | Quantity |
      | Wireless Headphones | 2        |
      | USB-C Cable         | 1        |
    When I remove "USB-C Cable" from my cart
    Then my cart should contain only:
      | Product             | Quantity |
      | Wireless Headphones | 2        |
    And the cart total should be $199.98

  Scenario: Updating item quantity
    Given my cart contains 1 unit of "Wireless Headphones"
    When I update the quantity to 3
    Then my cart should show 3 units of "Wireless Headphones"
    And the cart total should be $299.97

  Scenario: Attempting to add out-of-stock item
    Given "Wireless Headphones" has 0 units in stock
    When I try to add "Wireless Headphones" to my cart
    Then I should see an error "This item is currently out of stock"
    And my cart should not be updated

# ==============================================================================
# EXAMPLE 3: Real-time Notifications (with Scenario Outlines)
# ==============================================================================

Feature: Real-time Notifications
  As a user
  I want to receive notifications for important events
  So that I stay informed about relevant activities

  Background:
    Given I am logged in as "user@example.com"
    And I have notifications enabled

  Scenario Outline: Receiving different notification types
    When a <event_type> event occurs
    Then I should receive a <notification_type> notification
    And the notification should display "<message>"
    And the notification priority should be <priority>

    Examples:
      | event_type      | notification_type | message                        | priority |
      | price_drop      | alert             | "Price dropped to $49.99!"     | high     |
      | new_message     | info              | "You have a new message"       | medium   |
      | comment_reply   | social            | "Someone replied to your post" | medium   |
      | system_update   | warning           | "System maintenance at 2 AM"   | low      |
      | security_alert  | critical          | "Unusual login detected"       | critical |

  Scenario: Notification preferences
    Given I am on the notification settings page
    When I disable "email" notifications
    And I enable "push" notifications
    Then I should only receive push notifications
    And I should not receive email notifications

# ==============================================================================
# EXAMPLE 4: API Integration Testing
# ==============================================================================

Feature: Weather API Integration
  As a user
  I want to see current weather information
  So that I can plan my day accordingly

  Background:
    Given the weather API is available
    And I have a valid API key

  Scenario: Successfully fetching weather data
    When I request weather for "San Francisco, CA"
    Then the API should return a 200 status code
    And the response should contain:
      | Field       | Type   | Required |
      | temperature | number | yes      |
      | condition   | string | yes      |
      | humidity    | number | yes      |
      | wind_speed  | number | yes      |
    And the temperature should be in Fahrenheit
    And the condition should be one of: "sunny", "cloudy", "rainy", "snowy"

  Scenario: Handling invalid location
    When I request weather for "InvalidCity123"
    Then the API should return a 404 status code
    And the error message should be "Location not found"

  Scenario: API rate limiting
    Given I have made 100 requests in the last hour
    When I make another request
    Then the API should return a 429 status code
    And the response should include a "Retry-After" header
    And I should see "Rate limit exceeded. Try again in 3600 seconds"

# ==============================================================================
# EXAMPLE 5: Multi-step Workflow
# ==============================================================================

Feature: Order Checkout Process
  As a customer
  I want to complete my purchase
  So that I can receive my ordered items

  Background:
    Given I am logged in
    And my cart contains items worth $150.00
    And I have a saved shipping address

  Scenario: Complete checkout flow with saved payment method
    When I navigate to checkout
    Then I should see the order summary showing $150.00

    When I proceed to shipping
    And I select my saved address "123 Main St, Springfield"
    And I choose "Standard Shipping" for $5.99
    Then the order total should update to $155.99

    When I proceed to payment
    And I select my saved credit card ending in "4242"
    And I enter CVV "123"
    And I click "Place Order"
    Then I should see "Order Confirmed!"
    And I should receive an order confirmation email
    And the order status should be "Processing"
    And my cart should be empty

  Scenario: Applying discount code during checkout
    Given I have a valid discount code "SAVE20" worth 20% off
    When I navigate to checkout
    And I enter discount code "SAVE20"
    And I click "Apply"
    Then the discount should be $30.00
    And the order total should be $120.00
    And I should see "Discount applied: SAVE20 (-$30.00)"

# ==============================================================================
# TIPS & BEST PRACTICES
# ==============================================================================

# 1. Use "Given" for setup/context (state before the action)
# 2. Use "When" for actions/events (what the user does)
# 3. Use "Then" for assertions (expected outcomes)
# 4. Keep scenarios focused on ONE behavior
# 5. Use data tables for complex data or multiple examples
# 6. Use Scenario Outlines for testing the same behavior with different inputs
# 7. Background steps run before EACH scenario in the feature
# 8. Write from the user's perspective, not implementation details
# 9. Be specific about expected outcomes (avoid vague "should work")
# 10. Test both happy paths and error cases
