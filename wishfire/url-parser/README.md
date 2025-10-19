# Universal URL Parser

> Extract product identifiers from retailer URLs

## 📋 Overview

**User Story:**

As a user
I want to paste any product URL from any supported retailer
So that wishfire can automatically identify and track the product

**Feature Description:**

The URL parser accepts product URLs from supported retailers (Amazon, Best Buy, Target, Walmart, etc.) and extracts the unique product identifier (ASIN, SKU, TCIN, etc.) using regex patterns. This enables the system to fetch product details and match across retailers.

## 🎯 Goals

**Primary Goal:**

Accept URLs from multiple retailers and reliably extract product identifiers without requiring users to know retailer-specific formats

**Secondary Goals:**

- Support URL variations (with/without query params, mobile vs desktop URLs)
- Provide clear error messages for unsupported URLs
- Be extensible for adding new retailers

## 📝 Gherkin Specification

See [`spec.feature`](./spec.feature) for the complete behavioral specification.

**Key Scenarios Covered:**

- Parse Amazon URLs (ASIN extraction)
- Parse Best Buy URLs (SKU extraction)
- Parse Target URLs (TCIN extraction)
- Parse Walmart URLs (product ID extraction)
- Handle URL variations (mobile, query params, etc.)
- Reject invalid/unsupported URLs

## 🏗️ Technical Considerations

**Implementation Approach:**

Use regex patterns to match each retailer's URL format and extract the product ID.

**Supported Retailers (MVP):**

- Amazon: Extract ASIN from `/dp/{ASIN}` or `/gp/product/{ASIN}`
- Best Buy: Extract SKU from `/site/{name}/{sku}.p`

**Data Requirements:**

- Retailer-specific regex patterns
- Product ID validation rules
- Retailer identifier mapping

**Performance Considerations:**

- URL parsing should be near-instant (< 10ms)
- Cache compiled regex patterns

## ⚠️ Edge Cases & Error Handling

**Edge Cases:**

1. Amazon URLs with multiple formats (`/dp/`, `/gp/product/`, `/o/ASIN/`) - Extract ASIN from all
2. Mobile URLs (m.amazon.com, m.bestbuy.com) - Handle mobile domain variations
3. URLs with tracking params (`?tag=affiliate-20`) - Extract ID regardless of query params
4. Shortened URLs (amzn.to) - May need to resolve redirects first

**Error States:**

1. Invalid URL format - Return error: "Please enter a valid product URL"
2. Unsupported retailer - Return error: "This retailer is not yet supported"
3. URL without product ID - Return error: "Could not find product in this URL"

## ✅ Acceptance Criteria

This feature is complete when:

- [ ] Amazon URLs can be parsed for ASIN
- [ ] Best Buy URLs can be parsed for SKU
- [ ] Mobile and desktop URL variations are supported
- [ ] Query parameters don't break parsing
- [ ] Clear error messages for invalid/unsupported URLs
- [ ] Unit tests cover all regex patterns
- [ ] All Gherkin scenarios pass

---

**Status:** Draft

**Priority:** High

**Estimated Effort:** 4-8 hours

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
