# Proof record: All effective orbifold quotients of the fixed genus-nine curve

Canonical statement: [`fixed_x_orbifold_bound`](../Theorems/Thm_fixed_x_orbifold_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Every effective orbifold quotient of the fixed genus-nine curve is bounded

Author: /root, 2026-09-06. Status: independently audited PASS by
`/root/integral_jump_degree_bound_audit`, including assertion 3, 2026-09-06.
[Audit record](../routes/global/audits/GENUS9_ALL_EFFECTIVE_ORBIFOLD_QUOTIENTS_AUDIT_2026_09_06.md).
This removes ALL hypotheses on the second endpoint from the
earlier cored degree bound. Its reusable new ingredient is the full
self-fiber-product contact bound, not a new cutoff in local group order.

## Theorem

Let X be the exact genus-nine curve of file76. For every representable
finite etale atlas X -> S of a smooth proper connected effective
Deligne--Mumford orbifold curve over Fbar_5,

    deg(X/S) <= 336000.

Wild stabilizers and non-Galois atlases are allowed. Consequently:

1. For ANY smooth projective hyperbolic Y, every jointly minimal CORED
   finite bi-etale span X <- Z -> Y has deg(Z/Y)<=336000.
2. For each fixed genus h>=2, only finitely many isomorphism classes of
   Y of genus h admit a cored common cover with X.
3. No CORELESS finite bi-etale span involving X and any hyperbolic Y
   has a nonzero shared regular one-form, even a Cartier-zero one.

There is no ordinarity, Jacobian simplicity, or Hom-zero hypothesis on Y.
This does not exclude a coreless span, nor all bounded cored spans.

## 1. A parameterized contact bound for an orbifold atlas

Let C be a smooth projective hyperbolic curve in characteristic p>=5,
and C -> S a representable finite etale atlas of degree n of an
effective proper smooth orbifold. Suppose a rational differential beta
on the coarse curve B pulls back to a regular one-form alpha on C
with only simple zeros. Then

    n <= (4p/(p-4)) (g(C)-1).                         (1)

The atlas need not be Galois and its degree can be divisible by p.

This is now the parameterized atlas corollary in the
[contact theorem](Sol_contact_degree_bound.md).
Its proof identifies C x_S C with the normalization of (C x_B C)_red,
then counts contacts between ALL branches, including distinct
components. Keeping that proof in the general note removes a
curve-specific dependency from the new canonical-quotient theorem.

## 2. Uniform exact forms on X also have simple zeros

Every nonzero regular form on X with C(omega)=0 and a uniform positive
zero multiplicity has only simple zeros.

Indeed, use the Cartier coordinates of
[the checked eigenform theorem, Section1](Sol_fixed_x_cartier_eigenforms.md):

    omega=(A y+B) theta, theta=dx/y²,
    deg A<=2, deg B<=5.

Its block M has rank3, since the recorded matrix N M^[5] is invertible.
Thus Cartier zero forces A=0 and N B=0. If b=deg B, the order at the
unique point O at infinity is exactly16-3b>0. If every zero has the
same order e, it follows that

    e=16-3b, e divides16, 0<=b<=5.

The possible values are e=1,4,16. A Cartier-zero differential cannot
have a zero of order4 modulo5: its leading term would survive Cartier.
Thus e!=4. For e=16 the polynomial B is a nonzero constant, whereas
N B has nonzero first coordinate F_4 B=(3a+4)B. This excludes e=16.
Only e=1 remains. This is an algebraic-closure argument, not a search.

## 3. Complete coarse-signature split, now without a second curve

Write n=deg(X/S), h_X=16, and B for the coarse curve. Uniform local
atlas data give h_X=n(2g(B)-2+sum delta_i/e_i).

If g(B)>=2, then n<=8. If g(B)=1, some stacky point is necessary,
and delta_i/e_i>=1/2 gives n<=32. Assume henceforth B=P1.

There cannot be TWO distinct wild branch points. Put them at0,infinity.
The pullback of dz/z is regular: its only poles downstairs occur at
these two points and the pullback order there is delta_i-e_i>=3.
It is Cartier-fixed and has a zero of order at least3, contradicting
the checked theorem that every nonzero-eigenvalue Cartier eigenform
on X has only simple zeros. Extra branch points cause no poles.

If there are no wild points, the tame signature bound gives n<=672.
Suppose there is exactly one wild point, of index e and different delta.

* If delta/e>=2 and there is another branch point, its tame contribution
  is at least1/2, so n<=32.
* If the wild point is the ONLY branch point, necessarily delta/e>2.
  Put it at infinity. The nonzero exact form alpha=d(z o f) has divisor
  (delta-2e)E, where E is the reduced infinity fiber, and has no other
  zeros or poles. Section2 makes these zeros simple. Section1 therefore
  gives n<=20*(9-1)=160.
* It remains that 1<delta/e<2 and there is at least one tame point.
  With two tame points other than(2,2), n<96; with three or more, n<32.
  The (2,2) case gives16=(n/e)(delta-e), impossible because
  delta-e=-1 mod4 and no divisor of16 has that residue.
* The final case is exactly two branch points, one wild with
  1<delta/e<2 and one tame. Sections1--4 of the checked
  [complete two-branch calculation](Sol_fixed_x_two_branch_bound.md)
  give n<=2240 or n=112000,336000.

For precision, the last input does not secretly require Y: after its
initial signature reduction, that calculation uses ONLY h_X=16, local
ramification of this atlas, and the checked two-point torsion obstruction
on X. Those are exactly the present hypotheses. Its first-layer theorem
has no ordinarity assumption, nor an assumption on an auxiliary atlas.
Thus all its non-large and large cases apply verbatim here.

This exhausts every effective orbifold quotient and proves the bound.

## 4. Actual cored spans and parameterized partners

A cored span has a simultaneous etale Galois refinement W, giving
X=W/A,Y=W/B,S=[W/<A,B>] by the
[checked refinement argument](Sol_cored_orbifold_bridge.md).
Joint minimality gives Z=W/(A intersect B). Therefore

    deg(Z/Y)=[B:A intersect B] <= [<A,B>:A]=deg(X/S),

which proves assertion1. Applying the
[checked bounded-atlas finiteness theorem](Sol_bounded_atlas_partner_finiteness.md)
to X and B=336000 proves assertion2. The Galois closure used there is
over an orbifold already supplied by the cored hypothesis. No such
closure has been asserted for a coreless correspondence.

Finally, in a coreless span any nonzero shared one-form spans its entire
degree-one intersection, and has uniform zeros, by the checked
[canonical-intersection and unique-clump classification](Sol_canonical_intersection.md).
Cartier preserves this line, so its generator is a Cartier eigenform,
with eigenvalue possibly zero. Section2 and the retained nonzero-
eigenvalue theorem both force simple zeros on X. The
[checked simple-root/core theorem](Sol_shared_tensor_core.md)
then contradicts corelessness. This proves assertion3 without assuming
ordinarity of Y. It does not produce a degree-one invariant when only a
higher-weight one is given, or produce the first invariant at all.
