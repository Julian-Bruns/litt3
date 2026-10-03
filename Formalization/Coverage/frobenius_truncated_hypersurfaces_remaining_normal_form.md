# Remaining original-source construction

This is the one unfinished source reduction for Version1 of
`frobenius_truncated_hypersurfaces`. It is a continuation specification,
not a checked normal-form theorem or an additional active Pro request.
All binary/rank-one clauses, literal toric bases, symbolic lengths and
actual compatible-change transport are already complete.

Let K be algebraically closed of odd prime characteristic p, and let
f be an ORIGINAL member of m² in K[[x,y,z]]. Write a,b,c for its literal
x²,xy,y² coefficients and assume b²−4ac≠0. Retain the two ORIGINAL
cutoffs Q=p^n on x,y and the ORIGINAL positive cutoff R≤Q on z.
The task is to construct the actual K-algebra automorphism, not only an
equation between quadratic jets or an abstract isomorphic algebra.

Construct the unique original critical series α(z),β(z) with zero
constant coefficients, satisfying f_x(α,β,z)=f_y(α,β,z)=0. Define the
ORIGINAL critical value h(z)=f(α(z),β(z),z) by actual formal substitution.
Then construct an ACTUAL relative automorphism ψ fixing z with
ψ(f)=xy+h(z), keeping this same original h. Construction of the critical
series, the genuine inverse and the equality for the ENTIRE original f
remain required. A supplied residual series or quotient rank is insufficient.

If the original h has finite order s≥2, factor it as z^s a(z) with an
actual univariate unit a. One possible normalization uses the inverse of
a tame univariate change, as in the human proof when p∤s. A shorter
contact-equivalence route can keep z fixed: the explicit change
x↦a(z)x, y↦y, z↦z sends xy+h(z) to a(z)(xy+z^s).
Its inverse is x↦a(z)^−1x, with y,z fixed. The equality is a ring
identity, but the actual full-series automorphism, its inverse and the
order-to-unit factorization still need checked Lean constructions before
this route may enter coverage. This route would avoid a unit s-th root
and univariate inverse construction; no stronger source scope is presently
claimed. In particular the canonical Version1 prime-to-p restriction is
not silently removed.

Either checked normalization must produce actual e and unit u with
e(f)=u(xy+z^s), and e(z)=v z for an actual series unit v (v=1 if z
remains fixed). That is exactly the input of
`unequal_toric_hypersurface_length_of_positive_formal_change` and its
floor/characteristic-five consequences. The whole original ideal
(x^Q,y^Q,z^R) is then preserved by the already proved true-inverse
lower-unit invariance theorem. No new toric basis, integer calculation,
quotient transport, binary proof or rank-one proof is needed.

Pinned Mathlib has actual finite-variable formal substitution algebra
homomorphisms and their composition laws in
`Mathlib.RingTheory.MvPowerSeries.Substitution`. Its `HasSubst` premise
follows from zero constant coefficients for finite source variables.
These provide a concrete construction route for the mutually inverse
unit rescalings. No existing checked local module currently supplies the
needed arbitrary-series relative Morse/critical-value theorem. The
inventory was searched before recording this gap; the current main
common-cover research remains stopped independently of this formalization.
