# Legal Documents - Droidtech.ai Website

**Date Added:** 2025-11-27
**Status:** Ready for deployment

## Overview

This repository now includes complete GDPR-compliant legal documentation for the **Agentic Embedded Debugger** product.

## Files Added

### Legal Documents (Public)
- `privacy-policy.html` - GDPR-compliant Privacy Policy
- `terms.html` - Software License Agreement & Terms of Service
- `cookie-policy.html` - Cookie Policy
- `dpa-template.html` - Data Processing Agreement template for enterprise customers

### Modified Files
- `index.html` - Added legal document links to footer
- `pricing.html` - Added legal document links to footer

## Features

### 1. Print-to-PDF Functionality
Each legal document includes:
- **Print button** (bottom-right corner with 📄 icon)
- **Print-optimized CSS** with `@media print` rules
- **A4 page formatting** with proper margins
- **Color-adjusted text** for black & white printing
- **Hidden navigation** elements when printing

### 2. Dark Theme Design
- Matches existing droidtech.ai design system
- Cyan accent color (#22d3ee)
- Dark gradient background
- Mobile-responsive layout

### 3. Cross-Linking
- All legal documents link to each other
- Footer links on main website pages
- Breadcrumb navigation back to home

## How to Print to PDF

**For Visitors:**
1. Click the "📄 Print to PDF" button on any legal page
2. Select "Save as PDF" in the print dialog
3. Choose destination and save

**Keyboard Shortcut:**
- Mac: Cmd+P
- Windows/Linux: Ctrl+P

## GDPR Compliance

All documents follow:
- ✅ EU GDPR requirements
- ✅ Swedish Accounting Act (7-year retention)
- ✅ Standard Contractual Clauses (SCCs) for international transfers
- ✅ Clear data subject rights information
- ✅ Transparent processor relationships

## Company Information

**Droidtech 42 AI Labs AB**
- Org.nr: 559534-0745
- VAT: SE559534074501
- Address: Co. Sandberg, Dannemoragatan 4, 4 tr, 113 44 Stockholm, Sweden
- Data Protection Contact: Lee Sandberg
- Email: info@droidtech.ai
- Support: support@droidtech.ai

## Deployment

To deploy these changes:

```bash
git add privacy-policy.html terms.html cookie-policy.html dpa-template.html
git add index.html pricing.html LEGAL_DOCUMENTS_README.md
git commit -m "Add GDPR legal documents with print-to-PDF functionality"
git push origin main
```

Changes will be live at https://droidtech.ai within minutes (GitHub Pages).

## Testing

After deployment, test:
1. ✅ All legal pages load correctly
2. ✅ Print button works on each page
3. ✅ Footer links work on index and pricing pages
4. ✅ Mobile responsiveness
5. ✅ PDF output is properly formatted

## Maintenance

### Annual Review
- Review all legal documents (November)
- Update processor list in DPA
- Verify retention periods
- Check for regulatory changes

### Quarterly Checks
- Verify all links work
- Ensure HTML/markdown versions are in sync
- Review processor DPAs

## Source Files

Original markdown and HTML files are maintained in:
`DT-Vault/02-Engineering/Embedded-AI-Debugger-Project/Legal/`

See: `Legal-Documents-Index.md` for complete documentation.

## Support

For questions about legal documents:
- Customer inquiries: support@droidtech.ai
- Legal/compliance: info@droidtech.ai
- Data protection: Lee Sandberg (lee@droidtech.ai)

---

**Last Updated:** 2025-11-27
**Version:** 1.0
