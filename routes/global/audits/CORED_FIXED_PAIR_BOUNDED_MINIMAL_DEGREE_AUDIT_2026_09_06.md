# Major audit: two-primary W2 and bounded minimal cored degree

Date: 2026-09-06. Auditor: `/root/integral_jump_degree_bound_audit`.
Verdict: **PASS**, after correcting one displayed arithmetic coefficient.

Audited `Solutions/Sol_two_primary_w3.md`,
`GENUS9_TWO_PRIMARY_W2_CERTIFICATE.sage`,
`Solutions/Sol_fixed_x_two_branch_bound.md`, and
`GENUS9_FIRST_LAYER_SIGNATURE_CERTIFICATE.py`.
This audit covers both new implications, not just their numerical checks.

Retained inputs: the actual curve and Weil polynomial in file76; the
checked first-layer theorem and Swan divisibility; the checked integral-
jump bound, zero-one-form signature reduction, and cored refinement.
Their relevant statements were inspected. File76's full zeta computation
and the earlier global eigenform theorem were not rerun. The elementary
finite-field translation lemma was read and its application checked.

## Two-primary torsion theorem

The low-degree-map argument is valid over the algebraic closure. A map of
degree 2 or 4 together with the degree-3 map generates the function field:
the degree over the compositum divides both map degrees. The resulting
birational map to a curve of bidegree `(3,e)` gives
`g(X)<=(3-1)(e-1)<=6`, contradicting genus 9. These map degrees are
prime to characteristic 5. Thus a nonzero relation `2(E-F)` principal,
after cancelling common components of the degree-2 divisors, would give
an impossible function of degree 2 or 4. This really does exclude every
intersection of `W2` with a nonzero `J[2]` translate.

For `4[E-2O]=0`, the putative principal divisor `4E-8O` has its sole
pole of order 4 or 8 unless `E=2O`. The smooth affine coordinate ring
has the basis form `A(x)+B(x)y+C(x)y^2`; its three parts have distinct
pole residues modulo 3. Hence `L(8O)=<1,x,x^2>` and pole orders 4 and 8
are gaps. Therefore `W2 intersect J[4]={0}` as asserted.

The certificate's integral conclusion is justified on the actual Tate
module. A monic integral remainder for `T^342-1 mod P` is divisible by
4, and after dividing its reduction modulo 2 is coprime to `P mod 2`.
Cayley--Hamilton then gives `pi^342-I=4U` with `U` an invertible integral
Tate-module endomorphism. No integral conjugacy to a companion matrix is
being assumed. The fixed subgroup on all two-primary torsion is exactly
`J[4]`, since an invertible `U` preserves exact orders.

The translation lemma applies to `M=pi^342`, which fixes `J[4]` and
preserves `W2` because the curve and `O` are defined over F25. For a point
outside `J[4]`, let `2^s` be the exact order of `(M-I)a`. The binomial
identity in that lemma makes `(M^(2^(s-1))-I)a` a nonzero two-torsion
point. Both conjugate points lie in `W2`, contradicting the disjointness
already proved. This establishes `W2 intersect J[2^infinity]={0}` for
all geometric points, with no torsion-order search or bound.

Finally `div(dx/y^2)=16O`: at every finite branch point the numerator
and denominator orders cancel, and at infinity their orders are `-4`
and `-20`. A regular weight-d tensor with divisor `8d(P+Q)` consequently
makes `[P+Q-2O]` two-primary for power-of-two `d`. The W2 theorem forces
that class to vanish, and the absence of degree-2 functions forces
`P+Q=2O`. Distinct `P,Q` are therefore impossible.

## Local arithmetic and the global differential bridge

The non-large hypothesis gives precisely the lower estimate needed for
the existing small-side bound `m<=floor(26D/18)`; no integrality of upper
jumps is used in this step. For `q>=125`, the monotone first-break bound,
Swan divisibility `5^ceil(r/2)|D+(b+1)m`, and tame graded-character
divisibility give a finite first-layer sieve without bounding total `q`.
The supplied four rows are complete. The stated parity and modulo-4
arguments remove three, leaving only
`(D,m,t0,b,r)=(8,1,3,1,2)` and `c=3q+8`.

Here the first tame quotient forces `t|24`, so `g0|8`, and `c<qt`
excludes `g0=1`. Put `d=g0` in `{2,4,8}`. The atlas has degree `6dq`,
wild index `3dq`, and therefore exactly two distinct wild preimages.
The tame index is `d`. Pulling back `(dz)^d/z^(d-1)` gives order zero
at every tame preimage and order
`-(3dq)(d+1)+d(3dq+c)=8d` at each wild preimage. It has no other zeros
or poles and is nonzero because the coarse map is separable. Thus its
divisor is exactly `8d(P+Q)`, the configuration excluded by the new W2
theorem. This removes the whole non-large branch for arbitrarily large
deeper wild groups; it is not an application of the earlier order-p bound.

In the large branch, the retained first-layer theorem gives `b=1,r=2`,
`t|24`, and `S>=4q/25`. Its finite tame sieve has exactly the stated
three rows. The parity and modulo-8 exclusions leave `(D,m,t0)=(1,7,8)`.
Then `S=(q+15)/7>=4q/25` implies `q<=125`, so `q=125,c=143`.
The second group has order 5 and its final lower break is 6. The two
allowed values `g0=1,3` give atlas degrees 112000 and 336000. There is
no missing assumption on commutativity or deeper ramification here.

## Certificate replay and independent arithmetic

Both supplied certificates passed. Independent Python calculations using
coefficient-list multiplication and monic long division modulo 8 gave
nonzero remainder coefficients exactly at
`{0,2,3,7,10,11,12,16}`, each equal to 4. Independent binary-polynomial
arithmetic verified irreducibility using the degree-18 Rabin conditions,
root order 171 using its prime factors 3 and 19, and coprimality of the
unit polynomial. This did not use Sage or a companion matrix.

A separate divisor-based arithmetic sieve reproduced the non-large rows
`(2,1,3,2,2,5)`, `(8,1,3,1,2,10)`, `(8,1,9,6,2,15)`,
`(16,2,3,1,2,20)` and the large rows
`(1,2,3)`, `(1,7,8)`, `(16,2,3)`. Testing the full periodic set of
power-of-five residues modulo `4m` independently confirmed that only
the stated non-large row survives integrality and `c=3 mod4`.

One real correction was required: Section 4 wrote `n=112g0 q` while
reporting the correct endpoint values. The original genus formula gives
`n=16*q*g0*8*7=896g0 q`. With explicit author authorization, this audit
corrected that coefficient to 896; neither endpoint degree changed.

## Verdict and scope

The new results prove that every jointly minimal **cored** span of the
fixed pair has `M<=336000`, since the retained cored reduction gives
`M<=n`. More precisely, the associated atlas satisfies `n<=2240` or
`n=112000,336000`. No substantive gap remains in either new implication.
This does not establish nonexistence at the bounded degrees, exclude any
coreless span, or bound redundant source refinements. Apart from the
authorized coefficient correction, no proof text was changed.
