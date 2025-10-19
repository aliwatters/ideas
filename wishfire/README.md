# wishfire - Multi-Retailer Price Tracker & Alert System

> Track product prices across all major e-tailers and get alerts when prices drop

**Domain:** wishfire.com (owned)

## 🎯 Problem Statement

**What problem does this solve?**

Price tracking tools like CamelCamelCamel only work for Amazon. Shoppers who want to find the best deal across multiple retailers (Best Buy, Target, Walmart, Home Depot, etc.) must manually check each site. This is time-consuming and users often miss the best deals.

**Who is it for?**

- Smart shoppers who want to save money by buying at the right time
- Deal hunters who monitor prices across multiple retailers
- Anyone with a wishlist of products they're waiting to buy

**Why now?**

- E-commerce is fragmented across many retailers
- Consumers are price-conscious and comparison shop more than ever
- Official APIs are available for major retailers (Amazon PA-API, Best Buy Products API)
- Opportunity to own wishfire.com domain

## 💡 Solution

**Core Value Proposition:**

Universal price tracking that works across ALL major retailers, not just Amazon. Paste any product URL and instantly see prices everywhere, track price history, and get alerted when it's the best time to buy.

**Key Features:**

1. **Universal URL Parser** - Accept product URLs from any supported retailer
2. **Cross-Retailer Product Matching** - Find the same product across all retailers using UPC/GTIN
3. **Multi-Retailer Price Tracking** - Real-time prices and historical charts for all retailers
4. **Smart Alert System** - Get notified via email/SMS when price hits your target
5. **Deal Detection** - Automatically detect Lightning Deals, sales, and special promotions

## 🔍 Research

**Existing Solutions:**

| Solution | Pros | Cons | Pricing |
|----------|------|------|---------|
| CamelCamelCamel | Great Amazon tracking, free | Amazon only | Free |
| Keepa | Detailed Amazon data, charts | Amazon only | Free/Premium |
| Honey | Browser extension, coupons | Limited historical data | Free |
| SlickDeals | Community deals | No personalized tracking | Free |

**Key Differentiators:**

- **Multi-retailer support** - Not just Amazon
- **Universal product matching** - Same product tracked everywhere via UPC
- **Beautiful price history visualization** - Easy to see trends across all retailers
- **Smart alerts** - Target price, % drops, deal detection

**Technical Feasibility:**

- [x] Required APIs are available and documented (Amazon PA-API 5.0, Best Buy Products API)
- [x] Tech stack is familiar/learnable (Python/Node.js, PostgreSQL, React)
- [x] No major technical blockers identified (some retailers require paid APIs or scraping)

## 🏗️ Technical Overview

**Potential Tech Stack:**

- **Frontend:** Next.js/React with Recharts for price history visualization
- **Backend:** Python (FastAPI) or Node.js (Express)
- **Database:** PostgreSQL (price history, users) + Redis (caching)
- **Job Queue:** Celery (Python) or BullMQ (Node.js) for scheduled price scraping
- **APIs/Services:**
  - Amazon PA-API 5.0 (free with Associates account)
  - Best Buy Products API (free)
  - RedCircle API for Target ($15-50/mo)
  - ScraperAPI for retailers without APIs ($50-100/mo)
- **Alerts:** SendGrid (email), Twilio (SMS optional)
- **Hosting:** Vercel (frontend) + Railway/Render (backend + DB)

**Key Integrations:**

- **Amazon PA-API 5.0**: Product search, pricing, ASIN lookup, deal detection via OffersV2
  - Docs: https://webservices.amazon.com/paapi5/documentation/
  - SDK: `python-amazon-paapi`

- **Best Buy Products API**: 1M+ products, real-time pricing, SKU lookup
  - Docs: https://bestbuyapis.github.io/api-documentation/
  - SDK: `bestbuy-sdk-js`

- **RedCircle API (Target)**: UPC→TCIN conversion, pricing, inventory
  - Docs: https://www.redcircleapi.com/docs
  - Cost: $15/mo for 500 requests

**Estimated Complexity:**

- [x] Medium (1-4 weeks for MVP with Amazon + Best Buy)

## 📊 Effort vs. Impact

| Dimension | Rating (1-5) | Notes |
|-----------|--------------|-------|
| Effort | 3 | MVP doable in 2-4 weeks; full coverage needs API integrations |
| Impact | 4 | High value for shoppers; clear pain point solved |
| Feasibility | 4 | Free APIs available for MVP; some retailers need paid APIs |
| Learning | 4 | API integrations, job queues, data visualization, alert systems |

## 📝 Feature Breakdown

1. **[Universal URL Parser](./url-parser/)** - Extract product IDs from retailer URLs
   - Spec: `url-parser/spec.feature`

2. **[Cross-Retailer Product Matching](./product-matching/)** - Match products via UPC/GTIN
   - Spec: `product-matching/spec.feature`

3. **[Multi-Retailer Price Tracking](./price-tracking/)** - Fetch and store prices across retailers
   - Spec: `price-tracking/spec.feature`

4. **[Smart Alert System](./alert-system/)** - Notify users on target price, deals, % drops
   - Spec: `alert-system/spec.feature`

5. **[Deal Detection](./deal-detection/)** - Identify Lightning Deals, sales, promotions
   - Spec: `deal-detection/spec.feature`

## 🚀 Implementation Plan

See [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) for detailed architecture and development roadmap.

**MVP Scope (Phase 1):**

Support only Amazon + Best Buy (both have free APIs):
- URL parser for both retailers
- Product matching via UPC
- Hourly/daily price scraping
- Simple price history chart
- Email alerts on target price
- Deal detection (Amazon OffersV2)

**Phase 2: Full Retailer Coverage**

Add Target, Walmart, Home Depot, eBay, Etsy
- Integrate paid APIs (RedCircle, BigBox)
- Implement scraping fallback for retailers without APIs
- Enhanced deal detection

**Future Enhancements:**

- Browser extension with overlay on product pages
- Mobile app with push notifications and barcode scanner
- ML price predictions ("best time to buy")
- Social features (share watchlists, community alerts)
- Deal aggregator page
- Developer API

## 📚 Resources

**API Documentation:**

- Amazon PA-API 5.0: https://webservices.amazon.com/paapi5/documentation/
- Best Buy Products API: https://bestbuyapis.github.io/api-documentation/
- RedCircle (Target): https://www.redcircleapi.com/docs
- eBay API: https://developer.ebay.com/
- Etsy Open API v3: https://developers.etsy.com/

**SDKs:**

- Python: `python-amazon-paapi`
- Node.js: `amazon-paapi`, `bestbuy-sdk-js`

**Inspiration:**

- CamelCamelCamel - Amazon price tracker
- Keepa - Amazon price history
- Honey - Browser extension for deals

## 🎯 Success Metrics

**How will we know this is successful?**

- 100+ users tracking products within first month
- Average of 3+ retailers tracked per product
- 50%+ of users set at least one price alert
- 10%+ conversion rate on affiliate links

## 📈 Business Model

1. **Freemium**
   - Free: 5 watched products, email alerts
   - Pro ($5/mo): Unlimited products, SMS alerts, advanced charts

2. **Affiliate Revenue**
   - Amazon Associates links
   - Best Buy affiliate program

3. **API Access**
   - Developer tier for price data access

## 📅 Next Steps

- [x] Create project structure in ideas repo
- [ ] Prototype URL parser for Amazon + Best Buy
- [ ] Set up dev environment (PostgreSQL, Redis)
- [ ] Build API client wrappers for PA-API 5.0 + Best Buy API
- [ ] Design database schema and create migrations
- [ ] Implement basic product matching via UPC
- [ ] Build simple frontend with price comparison view
- [ ] Implement price scraper background job
- [ ] Add email alerts via SendGrid
- [ ] Deploy MVP to wishfire.com

---

**Status:** Specification

**Created:** 2025-10-18

**Last Updated:** 2025-10-18
