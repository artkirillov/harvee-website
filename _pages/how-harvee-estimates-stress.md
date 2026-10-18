---
layout: default
title: "How Harvee Estimates Stress from HRV"
description: "Learn how Harvee estimates physiological stress from HRV, compares your daily average with your own 30-day baseline, and builds a usual HRV range."
permalink: /how-harvee-estimates-stress/
canonical_url: "https://harvee.app/how-harvee-estimates-stress/"
last_modified_at: 2026-10-18
---
<section class="section section-info">
    <div class="section-content">
        <h1 class="typography-info-headline">How Harvee estimates stress</h1>
        <p class="large-12 medium-12">Last updated: October 18, 2026</p>
        <ul>
            <li>Harvee estimates physiological stress from heart rate variability (HRV).</li>
            <li>Harvee calculates RMSSD from Apple Watch heartbeat data. On Apple Watch Series 12 and Ultra 4, Harvee uses Apple's Recovery HRV instead.</li>
            <li>Harvee compares your daily average HRV with your own 30-day average, not with other people.</li>
            <li>Harvee sets your usual HRV range around your 30-day average, using the smaller of one standard deviation or 20% of that average as the range in either direction.</li>
            <li>Harvee interprets a daily average below your usual range as higher-than-usual estimated stress, and above it as lower-than-usual.</li>
            <li>Harvee needs at least 30 days of HRV data to build your baseline. Until then, Harvee shows your stress level with a notice that it is still learning your baseline.</li>
        </ul>
        <h2 class="medium-8">Worked example</h2>
        <ul>
            <li>Harvee uses a 30-day average of 50 ms and an SD of 8 to set a usual range of 42-58 ms.</li>
            <li>Harvee uses a 30-day average of 50 ms and an SD of 14, capped at 20% of the average, to set a usual range of 40-60 ms.</li>
        </ul>
        <p>Harvee is a personal-baseline estimate, not a clinically validated stress measure. Harvee is not a medical device.</p>
        <!-- TODO(confirm): Apple Health shows HRV as SDNN while Harvee uses RMSSD. Confirm the user-facing explanation and what happens to the baseline when a user upgrades to a watch that uses Recovery HRV. -->
    </div>
</section>
