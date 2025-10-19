# Smart Alert System

> Notify users when products hit their target price or go on sale

## 📋 Overview

**User Story:**

As a user
I want to receive alerts when tracked products hit my target price
So that I can buy at the best time and save money

**Feature Description:**

The alert system monitors price changes for products in a user's watchlist and sends notifications via email (and optionally SMS) when certain conditions are met: target price reached, percentage drop detected, or special deals identified.

## 🎯 Goals

**Primary Goal:**

Deliver timely, actionable alerts that help users buy products at the best price

**Secondary Goals:**

- Avoid alert fatigue (don't spam users)
- Support multiple alert types (target price, % drop, deals)
- Multi-channel delivery (email, SMS, push)
- Smart alert grouping

## 📝 Gherkin Specification

See [`spec.feature`](./spec.feature) for the complete behavioral specification.

**Key Scenarios Covered:**

- Target price alerts when price drops below user's threshold
- Percentage drop alerts (e.g., 20% off)
- Deal alerts for Lightning Deals and sales
- Alert across multiple retailers
- Alert grouping to prevent spam
- Alert preferences and opt-out

## 🏗️ Technical Considerations

**Implementation Approach:**

Background job checks price updates and triggers alerts based on watchlist rules. Alerts are queued and sent via SendGrid (email) or Twilio (SMS).

**Data Requirements:**

- Watchlist table: product_id, user_id, target_price, alert_on_deal, alert_on_percentage_drop
- Alerts table: watchlist_id, alert_type, triggered_at, sent, sent_at
- User notification preferences

**API/Service Dependencies:**

- SendGrid API (email delivery)
- Twilio API (SMS delivery, optional)
- Background job queue (Celery/BullMQ)

**Performance Considerations:**

- Batch alert checks to avoid excessive database queries
- Rate limit alerts per user (max 1 alert per product per day)
- Queue email sends to handle volume

## ⚠️ Edge Cases & Error Handling

**Edge Cases:**

1. Price drops below target then rises again - Only alert once per price drop event
2. Multiple retailers hit target simultaneously - Send one consolidated alert
3. User already bought the item - Allow manual dismissal of watchlist item
4. Price flickers (drops/rises quickly) - Require price to be stable for 1 hour before alerting

**Error States:**

1. Email delivery failure - Retry up to 3 times, log failure
2. Invalid email address - Mark user for verification
3. User unsubscribed - Respect opt-out, don't send

## ✅ Acceptance Criteria

This feature is complete when:

- [ ] Users can set target price for watchlist items
- [ ] Email alerts sent when price hits target
- [ ] Percentage drop alerts work (e.g., 20% off)
- [ ] Deal alerts sent for Lightning Deals
- [ ] Multi-retailer alerts show all retailers at/below target
- [ ] Users can manage alert preferences
- [ ] Alert rate limiting prevents spam
- [ ] All Gherkin scenarios pass
- [ ] Email templates are clear and actionable

## 🎨 Alert Email Template

```
Subject: 🔥 Sony WH-1000XM5 is now $249 at Best Buy!

Your target: $250
Current low: $249 (Best Buy) ✓

Amazon:   $299
Best Buy: $249 ← LOWEST PRICE
Target:   $289

[View All Prices] [Buy at Best Buy]

You're watching 12 products. Manage watchlist →
Unsubscribe from this alert
```

---

**Status:** Draft

**Priority:** High

**Estimated Effort:** 8-12 hours

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
