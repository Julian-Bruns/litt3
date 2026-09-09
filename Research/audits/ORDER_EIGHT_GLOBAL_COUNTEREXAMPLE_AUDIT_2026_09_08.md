# Genus-33 exact-form order-eight counterexample — audit receipt

- Verdict: **PASS**, as an ordinary independent prose audit, not Lean verification.
- Auditor: `/root/audit_order8_global_counterexample`.
- Date: 2026-09-08.
- Scope: the complete latest user-supplied construction with
  `S=k(z,w)`, `w²=z⁸+3`, `u⁵-u=2x²`, `r⁹=ux²`,
  `v=xy-u`, `s⁹=vy²`, and the specified compositum
  `L=S(u,r,s)=K_XK_Y`, over `k=overline(F_5)`.
- Breaking objections: none found.
- Nonbreaking objections: none requiring a change to the argument.
  The detailed local branch checks and separability justification below
  make explicit steps that the submitted proof compresses.

## Proof-specific findings

1. **Global fields and endpoint divisors.** The displayed formulas recover
   `z,w` from `x,y`; they give `x-y=z⁵`, `z²=3xy`, and the stated
   Artin–Schreier equation for `v`. The Artin–Schreier extension defining
   `E` has degree five, since `2x²` has pole order two. Equivalently its
   squarefree degree-five hyperelliptic model gives genus two. At the
   five points over `x=0`, `u` has order two on the zero branch and order
   zero on the four nonzero branches. At infinity `ord(u)=-2` and
   `ord(x)=-5`. Thus the divisor of `ux²` is exactly the stated divisor.
   Its order four at `P_0` forces degree nine for the Kummer extension.
   The five indices nine and three indices three give precisely eight
   zeros of order eight for `dx`, with no further zeros or poles.
   Therefore the endpoint genus is 33. The same reasoning applies to Y.

2. **Actual local fields and both étale legs.** On C one can compute
   `dx=dy=4 dz/w`, so the differential divisor is `2A+2B` and the
   claimed projection ramification is exhaustive. At A the Hensel root
   of `b⁵-b=2y²` exhibits the degree-five Artin–Schreier extension over
   `k((1/x))` inside `S_A`; equality follows from the degree. This
   also works for every Artin–Schreier conjugate. After base change to
   `S_A`, the x-side ninth-root radicand has order `-12`. On the y-side
   the radicand has order 12 on the branch `v=0` at the closed point,
   and order 6 on every nonzero branch. All these ninth-root extensions
   have tame degree three. At B the same check is symmetric. At each
   `R_±`, radicand orders are four or two, so all factors have tame
   degree nine. Elsewhere both extensions split completely locally.
   Since the residue field is algebraically closed and nine is prime
   to five, units have ninth roots and each tame extension of a given
   degree is the same subfield of a fixed local separable closure.
   Thus the two entries in every row are equal embedded local fields,
   not merely equal ramification indices. For any place of the actual
   compositum L, its completion is their compositum and adds nothing.
   Comparing with the contained X completion gives degree 15 at A,
   degree nine at B and `R_±`, and degree one elsewhere, over the
   corresponding rational base completion. The contained completion
   therefore equals the L completion. This proves trivial completed
   extensions for `Z→X`; symmetry proves the same for `Z→Y`.

3. **Seed no-core proof.** The exchange involution is realized by
   `(z,w)↦(-z,-w)` and commutes with D because `Dx=Dy=1`. Its fixed
   subfield of a nonconstant intersection is nonconstant. If D vanished
   there, every invariant equality `R(x)=R(y)` would admit an invariant
   fifth root in both rational fields, indefinitely, contradicting the
   positive rational-function degree. Thus Lüroth's generator q has
   `Dq≠0`, and `k(x)/k(q)` is separable. This justifies both injectivity
   of pullback on rational differentials and use of Cartier naturality.
   A zero of `β=dq/a(q)` would pull back to a zero of dx, since local
   differential order is `e m + different`. A zero-free differential on
   a rational curve has the two stated possible pole divisors; Cartier
   zero excludes simple poles, leaving a coordinate primitive `dt`.
   The ensuing degree descent is valid for rational, not just polynomial,
   P. The infinity argument forces a pole of P there; ordinary fourth
   differentiation creates no new finite poles, gives bounds `n_c+4`,
   and strictly lowers the contribution at infinity. The fifth ordinary
   derivative is zero in characteristic five, so `R_1'=1`. Consequently
   the resulting smaller function contradicts minimality and proves
   `k(x)∩k(y)=k` in S.

4. **Endpoint intersection in the specified L.** The degree-five seed
   polynomial has square discriminant and the local pattern `(3,1,1)`
   supplies a three-cycle. Its transitive Galois group inside A5 is A5:
   a proper subgroup with order divisible by 15 would have order 15
   or 30, both impossible. The endpoint normal closure is an abelian
   Kummer extension over the cyclic degree-five Artin–Schreier field,
   hence solvable. The intersection of these two Galois closures is
   Galois over the rational base; simplicity of A5 and solvability force
   that intersection to be the base. This proves the needed linear
   disjointness, separately over `k(x)` and `k(y)`. For any actual
   `a∈K_X∩K_Y⊂L`, irreducibility after base change identifies its monic
   S-minimal polynomial both with its `k(x)`-minimal polynomial and its
   `k(y)`-minimal polynomial. Its coefficients therefore lie in the seed
   intersection k. Algebraic closedness forces `a∈k`. No simultaneous
   Galois closure of the span, or replacement of either upper map, is
   used.

## Scope of the conclusion

The example disproves the genus-independent claim that uniform zero order
eight for a shared exact regular differential forces a core in an actual
finite étale span. It does not construct a span for the specific canonical
seventh-root endpoints of genera 225 and 29, and does not solve the
unmarked common-cover problem. This audit neither verifies the external
links bibliographically nor claims machine-checked verification; the
proof-specific mathematical implications above were checked directly.

## Bounded extension: arbitrary odd tame exponent divisible by three

Additional verdict: **PASS**, checked by the same auditor on 2026-09-08.
Replace both ninth roots by a-th roots, where `a=3n`, n is a positive
odd integer, and `5∤n`. Keep S, u, v, the actual compositum, and the
endpoint embeddings unchanged. No hidden coprimality or local-field
obstruction was found.

- `gcd(a,4)=gcd(a,2)=1` makes the endpoint Kummer extension have degree
  a and makes all five points over `x=0` totally ramified of index a.
- `gcd(a,12)=3` gives exactly three points above the unique infinity
  of E, each of index `a/3=n`. At those points the differential order
  is `n(2+1)-1=a-1`, the same as at the five points of index a above
  `x=0`. Thus `div(dx)=(a-1)D_X`, `deg(D_X)=8`,
  `[K_X:k(x)]=5a`, and `g(X)=4a-3=12n-3`; likewise for Y.
- At A and B all radicand orders are among `-12,12,6`.
  Since `gcd(a,12)=gcd(a,6)=3`, every completed factor over S has
  tame degree n. At `R_±` the orders two and four give tame degree a.
  Elsewhere the factors are trivial. Uniqueness of the embedded tame
  extensions therefore proves the same exact local matching. The
  comparison with endpoint completions is `5n` at A, a at B and
  `R_±`, and one elsewhere on the x-side; the y-side is symmetric.
  The case `n=1` is included: the local extension over S at A and B
  is trivial, and the corresponding endpoint comparisons still agree.
- All a-th roots of unity belong to k and `5∤a`. Adjoining roots of
  all five Artin–Schreier conjugate radicands still gives an abelian
  Kummer extension over the cyclic degree-five field, hence a solvable
  normal closure. The seed A5 argument and the seed intersection proof
  are independent of a. Consequently both upper maps are actual finite
  étale maps from the same smooth projective source, and their embedded
  endpoint fields intersect in k throughout this family.

In particular `a=3` gives genus-nine endpoints and exactly eight zeros
of order two; `a=9` recovers the supplied genus-33/order-eight example.
These are existential endpoint examples; this extension asserts nothing
about identifying either endpoint with a separately prescribed curve.
