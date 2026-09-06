# Audit: Artin--Schreier translation rank and fractional jumps

Date: 2026-09-06.
Auditor: `/root/integral_jump_degree_bound_audit`, treating this as a fresh audit.
Verdict: **PASS**. No substantive objection or counterexample found.

Audited `Solutions/Sol_translation_rank_bound.md`.
The polynomial theorem and its HKG application were checked independently.
The subsequent atlas enumeration and its two displayed degrees were outside
this bounded audit; the structural data supplied to that enumeration check.
No proof files were edited.

## Polynomial theorem

Reduction by `c x^(pj) -> c^(1/p) x^j` gives unique positive-degree
coefficients with exponents prime to `p`. Constants impose no obstruction
over algebraically closed `k`. This is valid even if the initial `f`
contains terms of degree divisible by `p`.

If `B` is not `1 mod p`, the prime-to-`p` exponent `B-1` in the difference
has coefficient `B f_B a` and cannot receive a contribution from reduction
of any higher exponent. Hence `V_f={0}`, as claimed.

For `B=1+uQ`, `u>1`, the selected `j=B-Q` is prime to `p`, and
`p j-(B-1)=p+(u(p-1)-p)Q>0`. Therefore no higher exponent of the
difference reduces to `j`. Its ordinary coefficient is a polynomial in
`a` of degree exactly `Q`; Lucas's binomial congruence gives leading
coefficient `u f_B != 0`. All lower terms of `f` contribute strictly lower
degrees. This proves `|V|<=Q` without additional restrictions on `f`.

For `B=Q+1`, the only powers of `p` among the positive exponents of the
difference are `1,p,...,Q`. Raising the reduced coefficient of `x` to
the `Q`-th power yields exactly the stated polynomial `P(a)`. Its unique
highest-degree contribution is `f_B^Q a^(Q^2)`; all other contributions
have lower degree. Thus it is nonzero and `|V|<=Q^2`. Root counting does
not require separability or linearity of this obstruction polynomial.

## HKG passage and exhaustive dichotomy

The cited HKG realization supplies a `P`-curve with rational quotient and
only one ramified point: an additional tame orbit cannot have nontrivial
inertia in a `p`-group. This input is supported by
[Bleher--Chinburg--Poonen--Symonds, Section 1.B and Proposition 4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).

Writing `S=sum_(i>=2)(|P_i|-1)`, its Hurwitz formula is
`2g(H)-2=-2+S`. For any subgroup `N`, lower subgroup compatibility gives
`2g(H)-2=2|N|g(H/N)-2+sum_(i>=2)(|N intersect P_i|-1)`.
Subtracting proves the displayed quotient-genus identity, including for
nonnormal `N`. For `N=P_2` all summands vanish, so `H/P_2` is rational.

Because `|P_2|=p`, it equals every nontrivial subsequent group through
the final break `B`. Its cyclic local extension has single lower break
`B`, necessarily prime to `p`. The first break of `P` is `1` because
`P_2<P`. Centrality follows from `[P_1,P_B] subset P_(B+1)=1`;
alternatively, a normal subgroup of order `p` is central in a `p`-group.

The degree-`p` quotient cover is unramified away from infinity, so an
Artin--Schreier generator can be chosen with reduced polynomial right
side of degree exactly `B`. The faithful action of `P/P_2` on the rational
quotient fixes infinity. Its affine multiplier character is trivial,
since `k^*` has no nontrivial `p`-power torsion. Consequently this quotient
acts by an additive translation space of order `p^r`.

For a lift `sigma`, centrality makes `sigma(w)-w` invariant under
`w -> w+1`, hence an element of `k(x)`. Its Artin--Schreier difference
is the polynomial `f(x+a)-f(x)`. A finite pole would survive on the
right with order multiplied by `p`, which is impossible. Thus the lift
uses a polynomial and every translation belongs to `V_f`.

Applying the verified polynomial bound gives precisely the dichotomy:
either `r<=v_p(B-1)` and both upper jumps of `L/L^P` are integral, or
`B=p^s+1` with `s<r<=2s`. The upper jumps are `1` and
`1+(B-1)/p^r`; these are the wild-subgroup numbering, not that of the
whole inertia extension. Also `g(H)=(p-1)(B-1)/2`, so the claimed
large-action inequality follows in the fractional case, with no
classification theorem used as an input.

## Independent exact symbolic checks

Ran a separate Sage computation for 25 pairs `(p,B)`, using the monomial
`x^B` and ten deterministically sampled monic polynomials over `F_p` for
each pair (275 total). It formed every reduced positive-degree coefficient
of `f(x+a)-f(x)`, cleared inverse Frobenius powers, took the polynomial
gcd of all resulting constraints in `a`, and factored that gcd to count
its distinct roots over the algebraic closure. Thus these were exact
geometric translation counts, not tests only on `F_p`-valued translations.

- `p=2`: `B=3,5,7,9,11,13,17`.
- `p=3`: `B=2,4,5,7,10,13,19,28`.
- `p=5`: `B=2,6,11,16,26,66`.
- `p=7`: `B=2,8,15,50`.

All counts satisfied the theorem. Every tested monomial with `B=Q+1`
had exactly `Q^2` translations, including 625 for `(5,26)` and 2401
for `(7,50)`. Cases with `B` not `1 mod p` had only the zero translation.

In the disputed `p=5,B=66` case, the unreduced coefficient of `x^61`
already supplies the explicit obstruction
`3 f_66 a^5 + 4 f_64 a^3 + 3 f_63 a^2 + 2 f_62 a`.
It cannot receive contributions from reduction, has degree five, and
therefore excludes a translation space of size 25 for every allowed `f`.

## Conclusion

This is a valid structural replacement for the classification input:
the fractional case forces `Q=p^s`, `R=p^(r-s)`, `p<=R<=Q`,
`q=p Q R`, and `c=q+(p-1)Q-2`. The apparent `B=66` pattern is eliminated
locally. No additional hypothesis of large action, abelian `P`, or
global atlas realizability is needed. There are no requested theorem
corrections; the elementary order-`p` centrality argument above is an
optional simplification.
