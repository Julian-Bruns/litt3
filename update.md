# Research update — 2026-09-08, 04:47 CEST

## How close are we?

The common-cover problem is still unsolved. We have completed a substantial
exclusion for the smaller backup curve, but a major gap remains for covers
with no shared quotient. There is no reliable finish date.

## Progress this hour

The backup curve's largest outstanding calculation is finished: all405
possibilities and all20 charts are excluded. A fresh audit also passed
the proof connecting those calculations to actual maps. This includes
every required twist, not only the untwisted cases.

Two more smaller quotient types were excluded using a reusable differential
argument. The only new calculation took about2.4 seconds on one core,
with a separate replay. Seven tame and three small-wild types remain;
finishing them would still leave the coreless case.

We also identified a real limit of the current strategy: actual coreless
examples need not share a regular projective connection. Any successful
argument using one must explain why our chosen curves are different.

The separate formalization prompt is ready for the already proved
no-shared-quotient theorem using a high-degree family member. This does
not depend on the large computation and is not yet a Lean proof.

## Resources and next focus

All subagents have stopped and documented their results. The large
eighteen-representative calculation is paused with its progress preserved;
no whole representative has been excluded. Its last export hit a data-transfer
fault, not a proved mathematical obstruction. No heavy computation runs now.

I am prioritizing the coreless gap. Further jobs are limited to one CPU
core total while you sleep. No Pro request is outstanding, and no automatic
chat restart is scheduled.

[Ranked goals](Research/PRIORITIES.md) · [Exact continuation state](Research/STATE.md)
