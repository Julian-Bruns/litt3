# Research update — 2026-09-06, 21:17 CEST

## How close are we?

The problem is still unsolved. Completing this calculation would finish
a useful candidate list, not the proof. We would still have to exclude
the corresponding covers, handle the remaining kinds of covers, and
overcome a separate major gap for covers without a common quotient.
There is no reliable percentage-to-proof or finishing estimate.

## What changed

We proved exact rules for recognizing a complete calculation and for
separating distinct answers from their repeated counts. These rules passed
an independent audit. The55 known answers count eight times each, so they
cannot account for the total29375 by themselves.

We also found an explicit description of the differential equation and
removed an exceptional case for a whole family of curves. This has not yet
become a faster complete search. A12-variable trial made the equations much
larger; it was not adopted. Its short mathematical record is preserved.

A testing discrepancy was traced to Sage treating a zero rational function
as nonzero. Corrected exact checks pass all125 examples; no earlier
certificate was found affected.

## Current strategy and pause

The original optimized calculation is still running, now in degree8.
Its pending pairs are checks between equations, not candidate answers.
The live display remains available.

As requested, active research is paused. A one-shot watcher waits without
model calls and will notify you and resume this exact chat when the
calculation ends. Its final result must then be checked before use.

The [post-enumeration roadmap](Research/AFTER_ENUMERATION.md) explains
precisely what still needs proving, for you and the next agent.
Continue at [Research/STATE.md](Research/STATE.md).
