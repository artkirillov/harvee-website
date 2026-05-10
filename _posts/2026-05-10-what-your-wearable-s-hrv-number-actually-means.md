---
layout: post
title: "What Your Wearable’s HRV Number Actually Means"
description: "Why RMSSD and SDNN aren’t the same, how PPG compares to ECG, and how to use your own HRV baseline and trends instead of chasing someone else’s number."
date: 2026-05-10
author: "Artie"
keywords: ["HRV", "RMSSD", "SDNN", "Apple Health", "heart rate variability", "wearables", "Oura", "WHOOP", "Apple Watch", "PPG", "HRV baseline"]
image: "/images/2026-05-10.jpg"
canonical_url: "https://harvee.app/blog/what-your-wearable-s-hrv-number-actually-means"
show_reading_time: true
published: true
tags: ["HRV", "Wearables", "Apple Watch", "Recovery", "Health monitoring"]
---

Your wearable says your HRV is 47 milliseconds. A friend mentions theirs is 82. You google “average HRV” and fall into a rabbit hole that ends with you questioning your entire cardiovascular system at 11pm.

Sound familiar?

Here’s the thing: the number itself tells you almost nothing without context. And part of the confusion comes from a problem most people don’t even know exists, different devices measure HRV in fundamentally different ways, then display the result as if it’s the same thing.

It isn’t.

Let’s untangle this properly.

## First, What Is HRV Actually Measuring?

Quick recap for clarity. HRV doesn’t measure your heart rate. It measures the variation in time between consecutive heartbeats, specifically, the differences in milliseconds from one beat to the next.

If your heart beats exactly once per second, your HRV is zero. But if the gap between beats fluctuates naturally, say, 0.93 seconds, then 1.07, then 0.98, that variation is your HRV. Higher variation generally means your autonomic nervous system is flexible and adaptive. Lower variation means it’s under load.

The autonomic nervous system (ANS) controls all the background functions your body handles without you thinking about them: heart rate, breathing, digestion, immune response, stress. It has two branches: the sympathetic system (gas pedal, stress and action) and the parasympathetic system (brake pedal, recovery and repair). HRV is essentially a readout of how those two are balancing out.

When you’re rested and recovered, the parasympathetic system has more influence. Your heartbeat has room to vary. HRV goes up. When you’re stressed, overtrained, or sleep-deprived, the sympathetic system dominates. Your heart becomes more rigid and rhythmic. HRV goes down.

The key driver of this is your vagus nerve, the longest cranial nerve in your body, running from your brainstem down through your chest and abdomen. As you breathe in, vagal activity briefly decreases and your heart speeds up slightly. As you breathe out, it increases and your heart slows down. That subtle dance between breath and heartbeat is a major source of the variability you’re measuring. It’s also why slow breathing practices measurably improve HRV over time.

All of this is real, well-researched, and genuinely useful. The problem starts when you try to put a single number on it.

## The Number on Your Screen: RMSSD vs. SDNN

There isn’t one way to calculate HRV. There are several. The two you need to know are RMSSD and SDNN, because this is where devices diverge.

**RMSSD** (Root Mean Square of Successive Differences) measures short-term, beat-to-beat variability. It’s specifically sensitive to parasympathetic activity which makes it ideal for tracking day-to-day recovery. It’s also less affected by breathing rate and measurement duration, which means it’s more stable for short sessions. RMSSD is what most wearables including WHOOP and Oura use under the hood when they show you an HRV number.

**SDNN** (Standard Deviation of NN intervals) captures total variability across a recording period, both short-term and long-term fluctuations, from both branches of the autonomic nervous system. It’s traditionally used in clinical settings over 24-hour recordings. It’s more sensitive to what happens across the full day, not just the parasympathetic piece.

Apple Health reports SDNN.

This is why your Apple Health HRV and your friend’s Oura HRV are not directly comparable, even if you’re the same age, same fitness level, and measured at the same time. They’re calculating different things. Broadly speaking, SDNN values from Apple Health will often appear higher than RMSSD values from other devices or apps. Neither is wrong. They just aren’t the same metric.

## How Your Wearable Actually Takes the Measurement

Your Apple Watch doesn’t have ECG electrodes pressed against your chest. It uses photoplethysmography (PPG) the optical sensor that shines light into your wrist and detects blood flow. From the pulse-to-pulse intervals it detects, it estimates the gaps between heartbeats and calculates HRV from there.

The gold standard is a chest ECG, which directly measures your heart’s electrical activity. PPG is an estimate, not a direct measurement. That gap matters but less than you might expect, under the right conditions.

Research comparing consumer wearables against ECG shows that devices including Apple Watch, Oura, and WHOOP can produce valid HRV measurements during rest. The crucial word is *rest*. When you’re lying still and not moving, optical sensors are reasonably accurate. Movement causes what’s called motion artifact - noise in the signal that makes accurate calculation unreliable. This is why wearables measure HRV during sleep, or ask you to sit still and breathe. That’s not a limitation they’re hiding. It’s the entire design.

So for overnight or morning measurements, the data is worth trusting. For anything measured during activity, treat it with more skepticism.

## Why Your Number Means Nothing Compared to Someone Else’s

This is the part people find most frustrating, but it’s genuinely important: there is no universal “good” HRV.

HRV varies enormously between individuals based on age (it decreases over time), sex, genetics, fitness background, body size, breathing patterns, and the conditions under which it was measured. A healthy 30-year-old endurance athlete might have an RMSSD of 80ms. A healthy 50-year-old entrepreneur might have 30ms. Neither is wrong. Both are normal for their physiology.

Comparing your HRV to a population average is about as useful as comparing your resting heart rate to a stranger’s. The range of “healthy” is wide enough that the comparison tells you almost nothing.

What matters is your baseline and how your HRV moves relative to it.

## What Actually Matters: Your Personal Trend

If your typical morning HRV sits around 52ms and it drops to 34ms, that’s significant. Not because 34ms is objectively low. Because something has shifted in *your* system: inadequate recovery, accumulated stress, impending illness, a hard training block that hasn’t cleared yet.

Conversely, if your baseline climbs from 52ms to 65ms over several months of better sleep and consistent training, that’s meaningful signal. Your nervous system is adapting. Fitness is building. Recovery capacity is improving.

This is why apps that show you a number and compare it to “people your age” are often more anxiety-inducing than useful. The comparison is the wrong frame. The trend is the right one.

Most practitioners recommend tracking for at least two to four weeks before drawing any conclusions. Use that time to understand your normal range, your typical variation, and what conditions move it in either direction.

## Reading the Short-Term Signals

Once you have a baseline, day-to-day changes become informative rather than alarming.

A single dip? Normal. Bodies are noisy by design. One bad night, a hard session, a stressful afternoon - these all produce temporary drops that resolve quickly. Don’t read too much into any single morning.

A few consecutive low days? Worth noticing. This often signals that strain is stacking up: training load, poor sleep, or life stress that hasn’t been addressed.

A sustained downward trend over a week or two? Your system is telling you something clearly. Not that you’re broken, that the inputs aren’t balancing the outputs. That’s recoverable, but it needs attention.

One pattern that surprises people: HRV sometimes drops before they feel sick. Immune system activates before symptoms arrive, and that immune response suppresses HRV. A sudden unexplained crash especially paired with feeling slightly off can be an early warning worth heeding. Rest sooner. You might avoid the full hit.

## The Number Is a Starting Point, Not a Score

The biggest mistake people make with HRV isn’t misunderstanding the biology. It’s treating the number as a verdict.

High HRV doesn’t mean you’re invincible. Low HRV doesn’t mean you’re failing. HRV is a readout of your nervous system’s current flexibility, nothing more, nothing less. It’s a signal that becomes useful over time, paired with context, not a daily performance rating.

Learn whether you’re tracking RMSSD or SDNN. Establish your baseline before making any decisions. Look at trends, not snapshots. And stop comparing yourself to anyone else including your own best days.

Your heart tells a story in the spaces between beats. The number on the screen is just one word. You need the whole sentence.

---

*Want help spotting your own patterns over time? [Download Harvee on the App Store](https://apps.apple.com/app/apple-store/id6746194884?pt=126794358&ct=harvee-website&mt=8) to read between the beats.*
