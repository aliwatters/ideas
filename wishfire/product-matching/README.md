# Cross-Retailer Product Matching

> Match the same product across different retailers using universal identifiers

## 📋 Overview

**User Story:**

As a user
I want wishfire to automatically find the same product across all retailers
So that I can compare prices without manually searching each site

**Feature Description:**

Uses universal product identifiers (UPC, GTIN, EAN) to match products across different retailers. When a user adds a product from one retailer (e.g., Amazon), the system automatically finds and tracks the same product on other retailers (Best Buy, Target, etc.).

## 🎯 Goals

**Primary Goal:**

Accurately match products across retailers to enable multi-retailer price comparison

**Secondary Goals:**

- Handle product variants (colors, sizes) correctly
- Fall back to fuzzy matching when UPC unavailable
- Minimize false matches

## 📝 Gherkin Specification

See [`spec.feature`](./spec.feature) for the complete behavioral specification.

**Key Scenarios Covered:**

- Match product via UPC across retailers
- Handle missing UPCs with fuzzy title matching
- Match product variants (e.g., different colors of same product)
- Detect when same product has different UPCs across regions
- Reject false matches (similar but different products)

## 🏗️ Technical Considerations

**Implementation Approach:**

1. Extract UPC from source retailer API
2. Query other retailer APIs with UPC to find matches
3. If no UPC, use title + brand + category fuzzy matching
4. Verify matches with confidence score

**API/Service Dependencies:**

- Amazon PA-API 5.0 (UPC in ItemInfo.ExternalIds)
- Best Buy Products API (UPC field)
- RedCircle API (UPC to TCIN conversion for Target)

---

**Status:** Draft

**Priority:** High

**Estimated Effort:** 12-16 hours

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
