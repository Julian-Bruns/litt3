# Actual toric hypersurface basis: independent review

Root read the two new toric definitions and all nine frozen basis/length
solution modules in full on3October2026. Verdict: **PASS for the literal
original polynomial and formal-series quotients**.

The quotient is defined only by the original relations
xy−z^s,x^Q,y^Q,z^R. Its basis is constructed, with no basis, independence,
nilpotence or rank conclusion as an input. Coefficients may lie in any
commutative ring. The basis construction needs only s>0; the finite sum
formula uses Q>0,R≤Q and a nontrivial coefficient ring. The genuine
series equivalence additionally retains R>0.

Normalization sends an original monomial x^a y^b z^c to its unchanged
axis monomial, increasing the z exponent by s min(a,b). The normal-vector
projection respects the literal toric relation and vanishes on every
power generator multiplied by an arbitrary polynomial. Span induction
therefore kills the entire original ideal, rather than only its displayed
generators.

In the actual quotient, xy=z^s derives axis normalization. The extra
cutoffs z^c x^i=0 for c≥s(Q−i), and their y counterparts, follow by
multiplying the actual x^Q/y^Q relations by opposite powers. The section
and quotient projection are inverse maps, proving independence of all
surviving original monomial classes. The basis theorem explicitly
identifies every basis vector with its original quotient monomial.

The finite index equivalence consists of a shared z-string and two
nonzero axis strings. R≤Q and s>0 imply R≤sQ, so the shared z-string
has exactly R terms. Its cardinality is
R+2∑_{j=1}^{Q−1}min(R,sj), derived from the basis by reversing the axis
index. The series/polynomial equivalence keeps the entire original toric
relation and all three original variable powers. It uses the settled
actual arbitrary-additional-relations truncation theorem.

Focused audit:
`../../../litt3-computation-data/formalization-20261003/verification/20261003T185751Z/report.json`.
It checks165transitive declarations and25local source files, with only
`Classical.choice`, `Quot.sound`, and `propext`; no forbidden dependencies
or changes during checking. Root independently rehashed all25captured
files after readback: zero mismatches. Report SHA256:
`ac0e364a13c804ceb16d415270a65ecfd00a6c7d8cfb1dad7621569f9acfa5c4`.

This review accepts the literal quotient calculation, including true
independence. Floor/remainder and p=5 arithmetic are separate later
modules. Connecting an arbitrary original nondegenerate unequal-power
series to this literal equation still requires its actual relative
splitting and univariate normalization. The balanced source clause
already assumes an actual formal type and can use genuine transport.

## Closed formulas, independently accepted

Root also read all four later arithmetic/terminal modules in full:
`ToricHypersurfaceLengthArithmetic`, `ToricHypersurfaceClosedLengths`,
`ToricHypersurfaceFiveArithmetic`, and `ToricHypersurfaceFiveLengths`.
Verdict: **PASS for the exact closed formulas of the actual quotient**.
Division gives R=sm+r and m<Q from R≤Q,s≥2. Splitting the entire symbolic
sum at m proves its doubled triangular part and saturated tail, including
r=0. An additive equality proves that the natural subtractions in the
closed formula have their intended values. R mod s=1 gives the divisible
correction (R²+s−1)/s. Powers of5 are1 modulo2 and4 uniformly in every
exponent, including exponent0. The final p=5 formulas are applied to
the actual original series quotient, rather than isolated numerical sums.

Final focused report `20261003T190632Z` checks206transitive declarations
and29local source files, with only the standard three axioms and zero
forbidden dependencies/changes. Its SHA256 is
`1ec995dd4d519df37e401426e47097462681e02cae65e646711bb5a01a1ec9a0`.
This extends the accepted literal quotient scope above; it does not
assert existence of the relative normal-form change.
