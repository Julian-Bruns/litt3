# Proof: the bicanonical conic is forbidden to the joint tangent space

[Statement](../Theorems/Thm_genus_two_joint_tangent_conic.md).
Author /root, 2026-09-09. No numerical computation is used.
Fresh medium audit PASS, /root/audit_joint_tangent_conic, same date;
no blocking objection. Audit covers the new conic argument and its
application of existing inputs, not a re-audit of those inputs.

Write omega=omega_Y. We use precisely Section2 of
[the pointed-extension theorem](Sol_joint_tangent_clump_dormancy.md):
a matching pair of pointed extensions 0->O->E_i->omega_i->0 on the
two actual endpoints cannot have normalized strongly semistable bundles
when the specified span is coreless. Its proof uses finite-field
projective frames and preserves both original embedded fields.
Semistability, and hence strong semistability, is preserved and reflected
by the finite etale legs. Thus strong semistability on Y alone suffices
to contradict a nonzero shared tangent.

## 1. Evaluation classes are strongly semistable

For a point Q in Y(k), put N=omega(-Q), of degree one. Pullback of
extensions along N->omega gives the cohomology map

    H^1(omega^-1) -> H^1(N^-1).

The exact sequence 0->omega^-1->omega^-1(Q)->k_Q->0 and negativity
show that its kernel is a one-dimensional line ell_Q. By Serre duality
this is exactly the evaluation line at Q: its annihilator in
H^0(omega^2) is H^0(omega^2(-Q)).

Let 0!=xi in ell_Q and let 0->O->E_xi->omega->0 be its pointed extension.
The pulled-back extension splits, so N->omega lifts to N->E_xi.
Every nonsplit extension of this kind in genus two is semistable:
a destabilizing saturated line would have degree>=2, could not map to O,
and its nonzero map to the degree-two quotient omega would force equality
and split the extension. A larger degree is impossible.

The lift of N is therefore saturated in E_xi. Indeed, any positive
increase in its degree upon saturation would give a line of degree>=2,
contradicting semistability. Taking determinants now gives an exact sequence

    0 -> omega(-Q) -> E_xi -> O(Q) -> 0.                    (1)

After tensoring by the inverse of any theta characteristic, the two
end terms in (1) have degree zero. Every Frobenius pullback is still
an extension of two degree-zero lines, hence is semistable. Thus E_xi
is normalized strongly semistable, including at arbitrarily high
Frobenius stages. No inference from finitely many tested stages is used.

## 2. Every projective line meets these evaluation classes

In genus two the canonical map is the hyperelliptic degree-two map.
The three products of a basis of H^0(omega) form a basis of H^0(omega^2),
so the bicanonical image in P H^0(omega^2)^* is the degree-two Veronese
image of P^1. In corresponding coordinates it is the smooth conic

                         X0 X2-X1^2=0.                    (2)

The evaluation lines ell_Q, as Q varies, are all its geometric points.
By Section1 and the two-leg pointed-extension obstruction, no nonzero
joint tangent may lie on this conic.

If dim T_joint>=2, its injective image in the three-dimensional
H^1(Y,T_Y) contains a two-dimensional vector subspace. Its projective
line intersects the conic over the algebraically closed field k:
restricting (2) to that line gives a homogeneous quadratic in two
variables, which either vanishes identically or has a projective root.
That root would be a prohibited nonzero joint tangent. Contradiction.
This proves dim T_joint<=1.

## 3. Exact deformation consequence and limitation

[Etale refinement and deformation theory](Sol_etale_refinement_deformations.md)
represent the simultaneous marked problem by a complete Noetherian local
W(k)-algebra with at most dim T_joint parameters. Thus it is a quotient
of W(k)[[z]] (and of W(k) when T_joint=0). For the selected main pair,
the already proved absence of every simultaneous mixed-characteristic
lift makes5 nilpotent in this ring.

Nothing above excludes a lone tangent OFF the conic. Nor does it exclude
a vertical formal curve: W(k)[[z]]/(5^e), for example, has the permitted
parameter count and nilpotent5 but infinite length. This is a limitation
of the argument, not an assertion that this ring is realized by a span.

The finite-field hypothesis is used in the two-leg strong-semistability
obstruction, not in the conic calculation. We make no extension of that
obstruction to arbitrary algebraically closed characteristic-five fields.
