# Research update — 2026-09-06, 18:42 CEST

## How close are we?

The problem is still unsolved, and there is no reliable finishing estimate.
We now have a smaller, exact test for one important class of possible
covers. We have not yet shown that even this class is impossible; other
classes would still remain afterward.

## What changed

The 55 known distinct solutions are fully written down. Each counts eight
times in the full calculation. The remaining solutions are still being
computed. A new reduction splits that remaining search into groups of
three and cuts its number of variables substantially.

Pro's answer provides an explicit way to test whether a known solution
can produce a cover. I reduced its 96 equations to 56 throughout the
search, removed ten unnecessary choices, and proved that the extra
extension data are uniquely determined. The same argument works for
other curves in our general theorem. Both the concrete and general
reductions have passed independent mathematical audits. Sixteen exact
tests agree with the key identity; none is a solution of the final test.

## Current strategy

Save and implement the smaller cover test while the full solution searches
run. Use the examples to check the implementation, then look for a reason
the test fails throughout the parameter space. The busy processors are
doing exact equation calculations. The hourly reminder only waits.

Latest change: one optimized search now uses all ten CPU cores. I removed
an unnecessary variable, tested a lower-memory solver build, and stopped
all older searches. Retired trial files are recoverable in Trash; the
verified solutions and certificates are unchanged. Completion time and
the eventual peak memory use are still unknown.

Continue at [Research/STATE.md](Research/STATE.md).
