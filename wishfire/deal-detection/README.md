# Deal Detection

> Automatically identify Lightning Deals, sales, and special promotions

## 📋 Overview

**User Story:**

As a user
I want wishfire to automatically detect when products are on special deals
So that I can take advantage of limited-time offers

**Feature Description:**

Monitors retailer APIs and product pages for special deal indicators like Amazon Lightning Deals, Prime Exclusive Deals, Best Buy Deal of the Day, Target Cartwheel deals, etc. Displays deal badges on tracked products and sends alerts for time-sensitive offers.

## 🎯 Goals

**Primary Goal:**

Detect all types of deals and promotions across retailers to help users save money

**Secondary Goals:**

- Identify deal end times for urgency
- Track deal velocity (% claimed, units remaining)
- Learn deal patterns (e.g., "This product goes on Lightning Deal every 3 months")

## 📝 Gherkin Specification

See [`spec.feature`](./spec.feature) for the complete behavioral specification.

**Key Scenarios Covered:**

- Detect Amazon Lightning Deals via OffersV2.Listings.DealDetails
- Detect Best Buy Deal of the Day
- Detect percentage-off sales
- Display deal end times
- Track deal history and patterns
- Alert users of expiring deals they're watching

## 🏗️ Technical Considerations

**Implementation Approach:**

- Amazon: Use PA-API OffersV2.Listings.DealDetails for Lightning Deals, Prime Exclusive
- Best Buy: Check for "Deal of the Day" and "Hot Deal" badges in API response
- General: Detect significant price drops (>15% in 24 hours) as potential deals
- Store deal metadata: type, start_time, end_time, discount_percentage

**API/Service Dependencies:**

- Amazon PA-API 5.0 (OffersV2.Listings.DealDetails)
- Best Buy Products API (onSale, dollarSavings fields)

**Performance Considerations:**

- Check for deals during regular price fetch jobs
- No additional API calls needed for Amazon/Best Buy
- Cache deal status to avoid redundant checks

---

**Status:** Draft

**Priority:** Medium

**Estimated Effort:** 8-10 hours

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
