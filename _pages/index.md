---
layout: default
title: "Harvee: HRV Stress and Recovery App for Apple Watch"
description: "Harvee is an HRV-based stress and recovery app for iPhone and Apple Watch. It compares your HRV with your own 30-day average, not with other people."
permalink: /
canonical_url: "https://harvee.app/"
---
<section class="section section-hero module-1-up-super">
    <div class="section-content">
        <img class="image-chiclet" src="{{ '/images/icon.webp' | relative_url }}" alt="Harvee icon" width="164" height="164" decoding="async" />
        <h1 class="typography-headline">When you understand your body, you stop guessing.</h1>
        <div class="wrapper">
            <p class="typography-intro-elevated">Harvee is an HRV-based stress and recovery app for iPhone and Apple Watch.</p>
            <p class="typography-intro-elevated">Harvee reads the HRV, heart rate, sleep and activity data your Apple Watch already records in Apple Health.</p>
            <p class="typography-intro-elevated">Harvee requires no additional wearable or chest strap.</p>
            <p class="typography-intro-elevated">Read Between the Beats.</p>
            <picture>
                <source media="(max-width: 800px)" srcset="{{ '/images/main-small.webp' | relative_url }}" />
                <source srcset="{{ '/images/main-large.webp' | relative_url }}" />
                <img class="image-headline" src="{{ '/images/main-large.webp' | relative_url }}" alt="Harvee stress monitoring dashboard" width="1960" height="1336" fetchpriority="high" decoding="async" />
            </picture>
        </div>
    </div>
</section>
<section class="section module-river-base-left">
    <div class="section-content">
        <div class="row-item copy-block large-6 small-12">
            <h2 class="typography-headline">Monitor Your Daily Stress</h2>
            <p class="typography-intro intro">Harvee estimates physiological stress from heart rate variability (HRV).</p>
            <p class="typography-intro intro">Harvee compares your daily average HRV with your own 30-day average, not with other people.</p>
            <p class="typography-intro intro">Harvee needs at least 30 days of HRV data to build your baseline.</p>
            <p class="typography-intro intro"><a href="{{ '/how-harvee-estimates-stress/' | relative_url }}">How Harvee estimates stress</a></p>
        </div>
        <div class="row-item large-5 small-12 large-offset-2 small-offset-0">
            <img class="image-example" src="{{ '/images/example-01.webp' | relative_url }}" alt="Harvee stress monitoring interface" width="500" height="1021" loading="lazy" decoding="async">
        </div>
    </div>
</section>
<section class="section module-river-base-left">
    <div class="section-content">
        <div class="row-item copy-block large-6 small-12">
            <h2 class="typography-headline">Get Personalized Recovery Tips</h2>
            <p class="typography-intro intro">Harvee tracks HRV trends and gives daily recovery recommendations.</p>
            <p class="typography-intro intro">Harvee recommends daily windows for morning light, outdoor walks and evening wind-down.</p>
        </div>
        <div class="row-item large-5 small-12 large-offset-2 small-offset-0">
            <img class="image-example" src="{{ '/images/example-03.webp' | relative_url }}" alt="Harvee recovery tips interface" width="500" height="1022" loading="lazy" decoding="async">
        </div>
    </div>
</section>
<section class="section module-river-base-left">
    <div class="section-content">
        <div class="row-item copy-block large-6 small-12">
            <h2 class="typography-headline">Track Core Health Habits</h2>
            <p class="typography-intro intro">Harvee shows steps, exercise minutes, mindfulness minutes, time in daylight and stand hours.</p>
            <p class="typography-intro intro">Harvee logs caffeine, alcohol and water intake.</p>
        </div>
        <div class="row-item large-5 small-12 large-offset-2 small-offset-0">
            <img class="image-example" src="{{ '/images/example-02.webp' | relative_url }}" alt="Harvee habit tracking interface" width="500" height="1021" loading="lazy" decoding="async">
        </div>
    </div>
</section>
<section class="section module-river-base-left margin-bottom-40">
    <div class="section-content">
        <div class="row-item copy-block large-6 small-12">
            <h2 class="typography-headline">Discover Stress Patterns &amp; Trends</h2>
            <p class="typography-intro intro">Harvee shows a daily stress level, HRV trends, sleep stages and your lowest overnight heart rate.</p>
            <p class="typography-intro intro">Harvee+ adds deeper analytics, long-term pattern history, 7-day and 28-day stress heat maps, the local UV index to daylight recommendations, and sleep-time advice.</p>
        </div>
        <div class="row-item large-5 small-12 large-offset-2 small-offset-0">
            <img class="image-example" src="{{ '/images/example-05.webp' | relative_url }}" alt="Harvee trends and patterns interface" width="500" height="1021" loading="lazy" decoding="async">
        </div>
    </div>
</section>
<section class="section section-info">
    <div class="section-content">
        <h2 class="typography-info-headline">How Harvee estimates stress</h2>
        <ul>
            <li>Harvee estimates physiological stress from heart rate variability (HRV).</li>
            <li>Harvee calculates RMSSD from Apple Watch heartbeat data. On Apple Watch Series 12 and Ultra 4, Harvee uses Apple's Recovery HRV instead.</li>
            <li>Harvee compares your daily average HRV with your own 30-day average, not with other people.</li>
            <li>Harvee sets your usual HRV range around your 30-day average, using the smaller of one standard deviation or 20% of that average as the range in either direction.</li>
            <li>Harvee interprets a daily average below your usual range as higher-than-usual estimated stress, and above it as lower-than-usual.</li>
            <li>Harvee needs at least 30 days of HRV data to build your baseline. Until then, Harvee shows your stress level with a notice that it is still learning your baseline.</li>
        </ul>
        <p><a href="{{ '/how-harvee-estimates-stress/' | relative_url }}">Read the method and worked example.</a></p>
        <h2 class="typography-info-headline">What Harvee does</h2>
        <ul>
            <li>Harvee shows a daily stress level.</li>
            <li>Harvee tracks HRV trends and gives daily recovery recommendations.</li>
            <li>Harvee breaks sleep into stages and shows your lowest overnight heart rate.</li>
            <li>Harvee recommends daily windows for morning light, outdoor walks and evening wind-down.</li>
            <li>Harvee runs breathing sessions with haptic guidance on Apple Watch and saves them to Apple Health.</li>
            <li>Harvee tracks menstrual cycles, including ovulation window and period delays, with phase-based recommendations. Predictions can be turned off.</li>
            <li>Harvee logs caffeine, alcohol and water intake.</li>
            <li>Harvee shows steps, exercise minutes, mindfulness minutes, time in daylight and stand hours.</li>
            <li>Harvee has iPhone widgets, Apple Watch complications, Shortcuts and Spotlight support.</li>
            <li>Harvee's recommendations are generated by Apple Intelligence on supported devices and languages.</li>
        </ul>
        <h2 class="typography-info-headline">Facts</h2>
        <ul>
            <li>Harvee is free to download.</li>
            <li>Harvee+ adds deeper analytics and long-term pattern history.</li>
            <li>Harvee+ adds 7-day and 28-day stress heat maps.</li>
            <li>Harvee+ adds the local UV index to Harvee's daylight recommendations.</li>
            <li>Harvee+ adds sleep-time advice.</li>
            <li>Harvee+ is available monthly, yearly, or as a lifetime purchase.</li>
            <li>Harvee requires iOS 18 or later and watchOS 10 or later.</li>
            <li>Harvee is available in 12 languages: English, French, German, Hindi, Italian, Japanese, Korean, Portuguese, Russian, Simplified Chinese, Spanish, Ukrainian.</li>
            <li>Harvee was a 2026 Apple Design Award finalist in Social Impact and is an App Store Editors' Choice.</li>
            <li>Harvee is made by Peak Labs Ltd, a UK company.</li>
            <li>Harvee is not a medical device and does not diagnose or treat any condition.</li>
        </ul>
    </div>
</section>
