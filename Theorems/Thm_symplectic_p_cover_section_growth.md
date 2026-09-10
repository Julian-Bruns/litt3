# Symplectic defect growth and cyclic refinements of a simple zero

Version4,2026-09-10. NEW Section8 and the cyclic-tower conclusions have
focused medium audit PASS /root/audit_simple_zero_towers. Earlier growth
statements remain author-checked, not independently audited here.
Nothing here is Lean verified.
Let C be a smooth projective connected curve over
an algebraically closed field of odd characteristic p, and let E have
a perfect alternating pairing E tensor E -> omega_C. Put r=h0(C,E).

1. If r is odd and h:T->C is a nontrivial connected finite etale cover
   whose Galois closure group is a p-group, then

                       h0(T,h*E)>=r+1.

   The original cover need not be Galois. If r=0, such a cover still
   has h0(T,h*E)=0.

2. If r=1 and h is Galois with finite p-group P, put
   d(P)=dim_Fp Hom(P,Fp). Then the stronger lower bound is

                       h0(T,h*E)>=1+d(P).

   There is no degree bound, theta-properness hypothesis, genus-two
   hypothesis, or Frobenius-rank calculation in these assertions.

3. Consequently a nontrivial cover with p-group Galois closure CANNOT
   have h0(T,h*E)=1, regardless of h0(C,E). For ANY finite etale cover
   h with h0(T,h*E)=1, its DECK group has order prime to p. This last
   assertion concerns automorphisms of T/C, NOT the possibly much larger
   Galois-closure monodromy group.

4. If h:T->C is Galois, h0(C,E)=0 and h0(T,h*E)=1, then its
   unique section has a NONTRIVIAL QUADRATIC deck character. Hence h
   factors through a distinguished etale double C_L->C, for nonzero
   L in Pic(C)[2], with h0(C,E tensor L)=1. The remaining Galois cover
   T->C_L has order prime to p and adds no sections. This applies to
   arbitrary Galois groups, not only elementary abelian2-groups.

## Application to actual connection defects in characteristic five

The dormant tangent bundles V_d and admissible active tangent bundles
E_r have perfect omega-valued alternating pairings on C^(1), in every
genus>=2. Apply the theorem to h^(1). Thus an odd dormant, respectively
active nilpotent, tangent defect increases under every nontrivial
5-group-Galois-closure cover. A source with defect exactly one has no
5-torsion in either actual leg's deck group. This does not assert that
either leg is Galois or that its monodromy order is prime to five.

There is also a TWO-leg strictness statement. For an ACTUAL coreless
bi-etale span X<-Z->Y with matching admissible active connections, if
Z->Y is Galois and the X-connection has positive defect d_X, then

                              d_Z>d_X.

This uses the inverse-Cartier kernel of regular quadratics and a finite
Galois norm in the actual field. No Hom-zero, genus-two, or Jacobian-
ordinariness assumption is required for this strictness statement.

For the explicit F625 example, the two sections on its cyclic5 covers
are the SMALLEST possible positive growth. The separate all-abelian
node theorem proves their higher cyclic towers stay at defect two;
the present theorem explains why an odd plateau would be impossible.

For the high-degree Y_t of genus_two_active_twists, ANY Galois cover
with source active defect one therefore factors through one of that
table's ten bad doubles. The endpoint connection is one of the five
exceptional connections. The source additionally satisfies

                       rank(Psi_T²)=rank(Psi_T).

Thus the simple-zero hypothesis of the current two-leg question covers
ALL Galois Y-leg witnesses of source defect one in the selected family,
not just the first degree-two examples. No claim is made for arbitrary
non-Galois Y-leg witnesses.
For a CORELESS such witness the strictness statement also forces the
other endpoint connection to be ordinary. Thus BOTH of the new prompt's
restrictions hold automatically in this whole Galois one-defect branch.

## Exact cyclic towers from a simple zero

Let (C,r) be any admissible active pair with dim ker(Psi_C)=1 and
rank(Psi_C^2)=rank(Psi_C). Write D=dim H1(C,T_C). Suppose a connected
cyclic5 etale cover has defect ell<5, and extend it to ANY nested cyclic
5^n tower C_n->C. Put q=5^n. Then the SEMILINEAR iterates satisfy

    rank(Psi_(C_n)^j)=(D-1)q+max(q-j*ell,0),  j>=0.       (8)

In particular the defect stays ell at every level, while the nilpotent
part has dimension q and nilpotence index ceil(q/ell). For every
nonzero v in ker(Psi_C), its nonzero pullback v_n satisfies EXACTLY

    v_n in im(Psi_(C_n)^j) iff j*ell<=q-1.                (9)

These conclusions concern actual cohomology and Frobenius-semilinear
composition, not just Smith equivalence of a coefficient matrix.

For each of the ten bad doubles C_L->Y_t above, at least TWO of the six
cyclic5 covers of Y_t pull back to such towers on C_L, with ell=2 or4.
No genus-three no-theta theorem is assumed: apply the genus-two theta
argument to E_(r_Y) tensor L on Y_t itself. The twist L has order two.

Finally suppose an ACTUAL coreless jointly minimal span X<-Z->Y_t has
a Galois Y-leg and source defect one. Its other endpoint is ordinary
as above. Apply the same two or more cyclic towers to BOTH original
legs, by base-changing Z over Y_t. All resulting sources Z_n are
connected; their defect is the SAME fixed ell=2 or4, and (8)--(9) hold
with C replaced by Z. If the actual mixed canonical W3 difference
delta on Z is nonzero, its pullback delta_n remains nonzero and obeys(9).
Thus it lies arbitrarily deep in images of Psi after refinement, but
never in the stable image. Neither original map is dropped and the
diagram's nonliftability is not repaired.

This is a conditional statement about a hypothetical nonzero mixed
obstruction, not an example realizing one. No second endpoint,
simultaneous higher lift, or common-cover nonexistence is proved.
The actual two-leg simple-zero scalar remains undecided.

[Proof](../Solutions/Sol_symplectic_p_cover_section_growth.md) ·
[Section8 audit](../Research/audits/SIMPLE_ZERO_CYCLIC_TOWERS_AUDIT_2026_09_10.md).
