# Analytics Setup for droidtech.ai

## Google Analytics 4 (GA4)

All pages on droidtech.ai now include Google Analytics 4 tracking.

### Setup Instructions

1. **Create GA4 Property:**
   - Go to https://analytics.google.com
   - Create new property: "Droidtech 42 AI Labs"
   - Select "Web" as platform
   - Copy your Measurement ID (format: G-XXXXXXXXXX)

2. **Update Tracking ID:**
   Replace `G-XXXXXXXXXX` with your actual Measurement ID in all HTML files:
   - index.html
   - pricing.html
   - success.html
   - cancel.html
   - download.html

3. **Events Tracked:**

#### Page Views (Automatic)
- `/` - Homepage
- `/pricing.html` - Pricing page
- `/success.html` - Payment success
- `/cancel.html` - Payment cancelled
- `/download.html` - Download page

#### Custom Events

**Pricing Page:**
- `view_pricing` - User views pricing page
- `select_plan` - User clicks on a plan (parameters: tier, billing)
- `begin_checkout` - User initiates checkout

**Success Page:**
- `purchase` - Successful payment (parameters: tier, billing, value, currency)

**Download Page:**
- `download_windows` - Windows download clicked
- `download_mac` - macOS download clicked
- `download_linux` - Linux download clicked

**Navigation:**
- `click_contact` - Contact link clicked
- `click_pricing` - Pricing link clicked

### Enhanced Ecommerce Tracking

The pricing page includes enhanced ecommerce tracking:

```javascript
// View item list
gtag('event', 'view_item_list', {
  item_list_name: "Pricing Plans",
  items: [...]
});

// Select item
gtag('event', 'select_item', {
  item_list_name: "Pricing Plans",
  items: [{
    item_id: "basic_monthly",
    item_name: "Basic Plan",
    price: 9.00,
    ...
  }]
});

// Begin checkout
gtag('event', 'begin_checkout', {
  currency: "USD",
  value: 9.00,
  items: [...]
});

// Purchase (on success page)
gtag('event', 'purchase', {
  transaction_id: "session_id",
  value: 9.00,
  currency: "USD",
  items: [...]
});
```

### Goals to Set Up in GA4

1. **Key Events:**
   - `purchase` (conversion)
   - `begin_checkout` (conversion)
   - `download_windows` (micro-conversion)
   - `download_mac` (micro-conversion)
   - `download_linux` (micro-conversion)

2. **Custom Dimensions:**
   - `plan_tier` - Basic, Pro, Team, Enterprise
   - `billing_type` - Monthly, Yearly
   - `user_role` - Customer type

3. **Conversion Funnels:**
   ```
   Homepage → Pricing → Checkout → Success
   Pricing → Download
   ```

### Testing Analytics

**Test in Real-time:**
1. Open GA4 → Reports → Realtime
2. Open droidtech.ai in another tab
3. Navigate through pages
4. Verify events appear in real-time report

**Use GA4 DebugView:**
1. Install Google Analytics Debugger extension
2. Open browser console
3. Check for `gtag` calls
4. Verify events in GA4 DebugView

### Privacy & GDPR

**Cookie Consent (Optional):**
If operating in EU, consider adding cookie consent:

```html
<script src="https://cdn.jsdelivr.net/npm/cookieconsent@3/build/cookieconsent.min.js"></script>
<script>
window.cookieconsent.initialise({
  "palette": {
    "popup": {"background": "#0f172a"},
    "button": {"background": "#22d3ee"}
  },
  "theme": "classic",
  "content": {
    "message": "We use cookies to analyze site traffic.",
    "dismiss": "Got it!",
    "link": "Learn more"
  }
});
</script>
```

### Alternative: Plausible Analytics

For privacy-focused alternative:

```html
<script defer data-domain="droidtech.ai" src="https://plausible.io/js/script.js"></script>
```

## Conversion Tracking

### Stripe Conversion Tracking

Already implemented via success page - tracks when user completes payment.

### Email Conversion Tracking

Track email opens and link clicks in license delivery emails:

```html
<!-- In email template -->
<img src="https://api.droidtech.ai/track/email-open?id={{email_id}}" width="1" height="1" />

<!-- Track download link clicks -->
<a href="https://download.droidtech.ai/?track={{email_id}}">Download</a>
```

## Dashboards to Create

1. **Sales Funnel:**
   - Homepage visitors
   - Pricing page views
   - Checkout initiations
   - Completed purchases
   - Conversion rate at each step

2. **Product Performance:**
   - Plan selection breakdown (Basic/Pro/Team/Enterprise)
   - Monthly vs Yearly preference
   - Average order value
   - Revenue by plan

3. **User Behavior:**
   - Time on pricing page
   - Scroll depth
   - Exit pages
   - Download page engagement

## Current Measurement ID

Replace `G-XXXXXXXXXX` in all files with your actual GA4 Measurement ID.

**Files to update:**
- /index.html
- /pricing.html
- /success.html
- /cancel.html
- /download.html

```bash
# Quick replace command:
sed -i 's/G-XXXXXXXXXX/YOUR-ACTUAL-ID/g' *.html
```
