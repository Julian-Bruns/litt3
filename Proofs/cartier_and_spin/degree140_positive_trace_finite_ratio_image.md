# A geometric fibre certificate controls the generic ratio

Use the exact global numerator polynomials and denominator exponents of
[the global construction](degree140_global_positive_trace_equations.md).
All arithmetic below is new continuation work; no incoming computation
has been replayed.

## Three resultants and their universal factors

Replace mu by H*u. Clear powers of H and Psi in each polynomial; powers
of q are units in K[q,q^-1]. Remove the common factor H^11 from each.
Denote the resulting polynomials in u by F0,F1,F2, of degrees15,16,16.
Their individual coefficient degrees in H are retained in the exact
degree certificate. Put
\[
R_{01}=\operatorname{Res}_u(F_0,F_1),\qquad
R_{02}=\operatorname{Res}_u(F_0,F_2),\qquad
R_{0+}=\operatorname{Res}_u(F_0,F_1+F_2).
\]
The fixed-degree Sylvester determinant convention is used, including at
specializations where a leading coefficient vanishes. These polynomials
belong to K[q,q^-1,H]. A common finite u-root forces all three to vanish.

The following are global bounds, obtained from the Sylvester matrices:

| Resultant | H-degree at most | Divisible by |
|---|---:|---|
| R01 |2419| Psi^732 |
| R02 |2506| Psi^736 |
| R0+ |2506| Psi^732 |

For the degree bound, assign to an entry its coefficient's H-degree.
Every determinant term has degree at most the maximum-weight perfect
matching. For the divisibility bound use instead the coefficient's
known Psi-order and the minimum-weight matching. Zero entries are
forbidden. The retained matching and dual potentials certify the extrema;
the construction is in
[the degree-bound source](../../scripts/arithmetic/degree140_trace_resultant_degrees_20260929.py).
Using exact coefficient cancellations improves some of the valuation
entries. Those cancellations are already part of the new global symbolic
coefficient construction, not assumptions about a generic specialization.

## One entire geometric fibre

At q=3, Psi has degree one in H and nonzero constant and leading terms.
The three resultants have degrees exactly2419,2506,2506. Their monic gcd
is the monic associate of Psi^732. Thus they have no common geometric
zero with Psi nonzero. This excludes all H and u over the algebraic
closure at this q, in particular every allowed H and nonzero mu.

The
[resultant source](../../scripts/arithmetic/degree140_positive_resultant_fibre_20260929.cpp)
constructs these univariate polynomials by exact interpolation. A coarse
degree bound3342 gives3343 distinct evaluation points, more than enough
for every resultant. The Euclidean resultant evaluation is adjusted to
the fixed-degree Sylvester convention when one leading coefficient drops.
The full three polynomials, their gcd degree732 and the residual gcd1
are in `positive_resultant_fibre_3.json` in the
[external trace directory](../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/).

## Why the generic fibre is also empty

Divide all three global resultants by the universal factor Psi^732.
Call them S0,S1,S2. They are polynomials in H over K[q,q^-1], and their
degrees in H are1687,1774,1774. Each degree is attained at q=3, and the
three specialized polynomials have gcd1.

Their gcd in K(q)[H] is therefore1. Indeed, a nonconstant generic common
factor can be chosen primitive in the UFD K[q,q^-1][H], and then divides
each Si there, by Gauss's lemma. Since each Si retains its full H-degree
at q=3, both factors in its factorization retain their H-degrees. The
common factor consequently specializes to a nonconstant common factor,
contrary to the computed gcd1. A factor specializing to a power of Psi
does not evade this argument: the universal Psi^732 was already removed,
and the remaining specialized gcd is exactly1.

A Bezout identity over K(q)[H], after clearing its finitely many
q-denominators, gives a nonzero polynomial D(q) in the ideal generated
by S0,S1,S2. Hence every allowed common zero of the traces has D(q)=0.
This proves finiteness of its ratio image without asserting that the
exceptional set is empty or computing D.

This deduction is stronger than a test at finitely many rational ratios.
It uses the global degree bounds, universal factors and attained degrees
to control generic factors. It remains a necessary-locus result, not a
construction or exclusion of the original two-map span.
