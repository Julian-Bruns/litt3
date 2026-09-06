# Exact cored ring and marking data, without a Galois assumption on the legs

Author: `/root`, 2026-09-06. Status: major independent audit PASS,
`/root/cored_ring_normality_major_check`, 2026-09-06.
[Audit record](../Research/audits/CORED_RING_AND_LOCAL_NORMALITY_MAJOR_AUDIT_2026_09_06.md).
Canonical statement: [cored_ring_and_marking_spectrum](../Theorems/Thm_cored_ring_and_marking_spectrum.md).

## 1. The common quotient remembers both maps

Use the [cored-orbifold bridge](Sol_cored_orbifold_bridge.md) to obtain
a connected finite etale W -> Z, Galois over X,Y. Put A=Gal(W/X),
B_0=Gal(W/Y), G=<A,B_0>, and S=[W/G], with coarse curve B=W/G.
Every invariant object in this proof is tested on this SAME W.
No simultaneous Galois refinement was presumed for a coreless span.

For each d, the endpoint spaces embed in H^0(W,omega_W^d) as the
A-invariant and B_0-invariant spaces. This is etale descent, valid
even when group orders are divisible by the characteristic. Their
intersection is exactly the G-invariant space. Thus the shared
canonical ring is R(S), respecting multiplication in every degree.

Any G-invariant rational weight-d tensor on W descends to a rational
tensor beta on B. Indeed separability identifies the rational canonical
line with the pullback of that on B, so invariant coefficients are in
k(B). At a point over b_i its valuation is

    e_i ord_(b_i)(beta)+d delta_i.

Regularity is therefore precisely
ord_(b_i)(beta)>=-floor(d delta_i/e_i); away from the exceptional locus
it is the usual regularity condition. This gives the asserted graded
section ring directly and the dimension formula on P^1.

The d=1 case was already proved in the retained
[zero-one-form signature reduction](../routes/global/CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md).
The full-weight formula is its direct valuation extension, not a claim
to originate the canonical-divisor theory of wild stacks. Nothing here
replaces a wild different contribution with its tame value.

## 2. All compatible reduced divisors descend

Suppose f*D_X=g*D_Y. Their further pullbacks to W are the SAME reduced
divisor D_W, since W -> X,Y are etale. Its finite point set is invariant
under A and B_0, hence G. Its ideal, with its natural G-action, descends
along the etale G-torsor W -> S to an effective Cartier divisor D_S.
It is reduced because that property can be checked after etale base
change. Conversely every reduced D_S pulls back to compatible reduced
divisors on the two endpoints. The correspondence is bijective by
faithfully flat descent of the ideals.

A reduced divisor on S consists of m distinct ordinary points and an
arbitrary subset I of its finitely many exceptional residual gerbes.
There are enough ordinary points for every m>=0 over an algebraically
closed field. An ordinary point has degree one; an exceptional gerbe
has degree 1/e_i. Pullback along X -> S multiplies degree by n_X;
in particular e_i divides n_X and that fiber has n_X/e_i points.
This proves the exact marking-degree spectrum.

Since deg(omega_S)=(2g(X)-2)/n_X=(2g(Y)-2)/n_Y, its membership in
the displayed spectrum is exactly the simultaneous canonical-size
condition. The minimum nonzero stack divisor degree is
1/max(1,e_1,...,e_r). This gives the immediate nonexistence test.

This divisor statement needs no torsion or finite-field hypothesis.
Using such a marking to construct a tensor by killing omega(-D) DOES
need the separate torsion hypothesis; it is automatic over Fbar_p,
as in the canonical-marked-quotient theorem.

## 3. The large fixed-genus signatures as tests

The [checked two-branch atlas theorem](Sol_fixed_x_two_branch_bound.md)
retains the two tuples in the statement as necessary possibilities,
not realized examples. The associated canonical degrees are

    -2+1143/1000+6/7=1/7000,
    -2+3143/3000+20/21=1/21000.

They are respectively one seventh of the smallest exceptional point
degrees 1/1000 and 1/3000. The wild fibers on X both have 112 points;
the tame fibers have 16000 points, and an ordinary fiber has n_X points.
No nonempty compatible marking can have only 16 points.

For the first tuple the dimension in weight d is

    max(0,1+floor(143d/1000)-ceil(d/7)).

It vanishes for 1<=d<7, and at d=7 it equals one. Having dimension
at least two requires
floor(143d/1000)-ceil(d/7)>=1. The left side is at most d/7000,
so d>=7000 is necessary; equality d=7000 attains one and gives two
sections. This proves the two claimed minimal weights.

For the second tuple replace the floor denominator by 3000 and the
ceiling denominator by 21. At 1<=d<21 the floor is zero and the
ceiling one; at d=21 both are one. The difference is at most d/21000,
and at d=21000 it is exactly one. The minimal weights are thus 21
and 21000. An exact rational/integer enumeration through weight21000
independently checks these arithmetic minima, but the inequalities
just given prove them without a finite-search cutoff.

## What this changes, and what it does not

The missing marking hypothesis is not merely unproved in these large
cored cases: the specified core signatures would forbid it. Trying
to manufacture a compatible canonical-size reduced marking in those
cases cannot close the argument. A useful extension must retain the
actual allowed marking sizes or higher tensor weights instead.

This does not rule out another route to excluding the signatures, and
it says nothing about clump existence for coreless spans. It also does
not claim that an arbitrary common quotient is the full core quotient:
the G=<A,B_0> condition is what ensures every compatible divisor descends.
