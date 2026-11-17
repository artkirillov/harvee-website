# pSEO Editorial and Indexing Workflow

Every page in `_pseo/` is generated as a public page but is **not eligible for search indexing by default**. This deliberately separates drafting from publication: a page may be written, reviewed, and shared directly while it is still protected from organic-search indexing.

## Approval record

Keep `indexable: false` while a page is incomplete, unreviewed, stale, insufficiently differentiated, or awaiting evidence. Change it to `true` only after the page contains the following front matter and its rendered content has been reviewed.

```yaml
---
layout: pseo
permalink: /example/
canonical_url: https://harvee.app/example/
indexable: true
last_modified_at: 2026-08-26
reviewed_by: "Harvee Editorial Team"
reviewed_at: 2026-08-26
source_urls:
  - https://support.apple.com/...
  - https://pubmed.ncbi.nlm.nih.gov/...
methodology_url: /methodology/
medical_disclaimer: true
testimonial_ids:
  - good-tracker
---
```

The `last_modified_at` date must reflect the last material content change, not the deployment time. The `reviewed_at` date records the factual and editorial check. Both dates must be current, must not be in the future, and `last_modified_at` must be the same day as or later than `reviewed_at`.

## Page-specific value

An approved page must give a reader something that adjacent pages do not. Device pages need model-specific compatibility, setup, limitations, and change guidance. Use-case pages need a practical workflow, clear safety boundaries, evidence-backed claims, and a useful next step. Comparison pages need a dated method, source-backed feature or price claims, explicit limitations, and a fair explanation of when the alternative may fit better.

Testimonials are optional. When used, `testimonial_ids` must identify reviews that are relevant to that page's intent. Do not use the default carousel or recycle a competitor-specific review across unrelated device and use-case pages.

## Claim governance

Public recognition and App Store rating claims are intentionally absent until they are added to the relevant `_data/pseo_*.yml` record with a public `source_url`, a `verified_at` date, and—when the claim is time-sensitive—an `expires_at` date. Expired or incomplete claims are suppressed automatically.

The layout renders an on-page review and sources module whenever those fields are present. All pSEO leaf pages also display a wellness notice. This notice sets user expectations but does not replace evidence, careful wording, or professional medical advice where appropriate.

## Validation

Run the following after changing pSEO content or templates:

```bash
bundle exec jekyll build --trace
ruby scripts/validate_pseo_seo.rb
```

The validation script checks the source approval record for any indexed page and the built output for robots/indexability parity, one canonical URL, one H1, valid JSON-LD, and truthful sitemap inclusion. The same check runs for pull requests targeting `main`.
