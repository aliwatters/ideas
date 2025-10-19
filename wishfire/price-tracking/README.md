# Multi-Retailer Price Tracking

> Track and visualize price history across all retailers

## 📋 Overview

**User Story:**

As a user
I want to see price history for products across all retailers
So that I can identify trends and know when to buy

**Feature Description:**

Periodically fetches current prices from all retailers and stores them in a time-series database. Displays price history as interactive charts showing trends over time (7 days, 30 days, 90 days, all time). Users can see which retailer historically has the best prices and when prices typically drop.

## 🎯 Goals

**Primary Goal:**

Provide accurate, up-to-date price data and historical trends for informed purchasing decisions

**Secondary Goals:**

- Beautiful, interactive price charts
- Efficient data storage for price history
- Minimize API costs with smart caching
- Detect price anomalies (errors, outliers)

## 📝 Gherkin Specification

See [`spec.feature`](./spec.feature) for the complete behavioral specification.

**Key Scenarios Covered:**

- Fetch current prices from all retailers
- Store price history in time-series format
- Display price charts with multiple time ranges
- Show retailer-by-retailer comparison
- Detect and filter price anomalies
- Handle out-of-stock products

## 🏗️ Technical Considerations

**Implementation Approach:**

Background job runs hourly/daily to fetch prices from retailer APIs. Prices stored in PostgreSQL with indexed timestamps. Charts rendered with Recharts or Chart.js.

**Data Requirements:**

- price_history table: listing_id, price, recorded_at, is_available
- Indexed on (listing_id, recorded_at) for fast queries
- Aggregate views for common time ranges

**Performance Considerations:**

- Batch API requests to minimize rate limit issues
- Cache current prices in Redis (TTL: 1 hour)
- Pre-aggregate data for 30-day, 90-day views
- Compress old data (daily avg for data > 90 days old)

---

**Status:** Draft

**Priority:** High

**Estimated Effort:** 10-14 hours

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
