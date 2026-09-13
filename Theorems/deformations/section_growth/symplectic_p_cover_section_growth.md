# Symplectic defect growth and cyclic refinements of a simple zero

Version5,2026-09-13. Let C be a smooth projective connected curve over
an algebraically closed field of odd characteristic p, and let E have
a perfect alternating pairing E tensor E->omega_C. Put r=h0(C,E).

1. For a connected finite etale Galois cover h:T->C with nontrivial
   p-group P, put d=dim_Fp Hom(P,Fp). The first socle bundle
   F_C subset h_*O_T is an extension of O_C^d by O_C, with classes
   alpha_i. Let B_i be their alternating cup forms on H0(E), using
   Serre duality, and R=intersection_i rad(B_i). Then

       h0(T,h*E)>=h0(E tensor F_C)=rd+dim R.

   In particular r=1 gives h0(T,h*E)>=1+d. If the cover preserves
   r>0 sections, then P is cyclic and r is even.

2. An odd r increases by at least one under every nontrivial connected
   finite etale cover whose Galois closure has p-group order. Such a
   cover preserves zero sections. It cannot have exactly one section
   upstairs, regardless of the downstairs dimension.

3. For any connected finite etale h:T->C with m=h0(T,h*E)>0, every
   nontrivial p-subgroup P of Deck(T/C) satisfies d(P)<=m-1. Thus
   m=1 makes the deck group prime to p; m=2 makes all its p-subgroups
   cyclic. This bounds actual deck groups, not Galois-closure monodromy.

4. If h is Galois, r=0 and m=1, its section has a nontrivial quadratic
   deck character. There is a distinguished etale double C_L->C with
   h0(E tensor L)=1, for nonzero L in Pic(C)[2]. The remaining Galois
   cover T->C_L has prime-to-p degree and adds no sections.

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

For a coreless such witness, strictness also makes the X connection
ordinary. The later
[defect-preserving descent theorem](../defect_preserving_etale_descent.md)
excludes this whole Galois one-defect branch for the selected main pair.

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

The rank and image formulas also transfer along any connected
prime-to5 etale map Z->C preserving defect one. The base changes
Z_n=Z times_C C_n are connected and have the same defect ell; formulas
(8)--(9) hold with C replaced by Z. If Z carries two actual etale maps,
these refinements retain both. A nonzero actual mixed canonical W3
difference in ker Psi_Z stays nonzero and obeys(9). Thus it can lie
arbitrarily deep in finite Psi images after refinement without entering
the stable image or repairing the original diagram's nonliftability.
This supplies no example realizing a nonzero mixed difference.

[Proof](../../../Proofs/deformations/section_growth/symplectic_p_cover_section_growth.md) ·
[First-socle audit](../../../Research/audits/FIRST_SOCLE_SECTION_FORMULA_AUDIT_2026_09_13.md) ·
[Cyclic-tower audit](../../../Research/audits/SIMPLE_ZERO_CYCLIC_TOWERS_AUDIT_2026_09_10.md).
