# Independent audit: etale roots and the contact bound

Auditor: /root/contact_root_extension_audit, 2026-09-06.
Verdict: PASS. No major objections to
[the theorem](../../../Solutions/Sol_etale_root_contact_bound.md). The final
consistency read includes its linear bound, torsion-order refinement,
and primitive-weight identification. The first version's weaker
quadratic and component-sensitive bounds were also valid.

The audit read the original contact theorem and the new root-reduction
proof directly, without relying on the earlier contact audit.

## Checked points

1. With FX={x} times Y and FY=X times {y}, C.FX=a and C.FY=b.
   D=C-b FX-a FY is orthogonal to the ample class FX+FY. Hodge index
   gives C^2<=2ab in positive characteristic as well. Adjunction and
   etale Riemann--Hurwitz give delta(C)=C^2/2+t. Thus removing the
   Jacobian Hom hypothesis supplies precisely the upper bound needed
   by the existing contact argument.
2. The section s_X with divisor d D_X is a nowhere-zero section of
   (omega_X(-D_X))^d. Its root torsor is finite etale because 5 does
   not divide d. The tautological root maps to a regular differential
   with exactly the reduced inverse-image zero divisor. The analogous
   constructions over Z coincide via actual differential pullback;
   no independent scalar adjustment or arbitrary choice of roots is
   necessary.
3. Disconnected torsors are harmless. Their connected components are
   torsors under subgroups of mu_d. Their degrees hX,hY,c divide d,
   and c divides hX and hY. The maps between the chosen components
   are restrictions of finite etale base changes and are surjective.
4. In the chosen component field, k(W)=k(Z)(xi_X) and
   k(X')=k(X)(xi_X). The common tautological differential identifies
   xi_Y with a nonzero k(Z)-multiple of xi_X. Since the two endpoint
   fields already generate k(Z), they generate k(W). This verifies
   joint minimality even when the defining binomials factor.
5. The degree formulas bc/hY and ac/hX and endpoint genus factors
   hX sX and hY sY give the stated inequalities. The genus-nine
   specializations 640 and 2560 are valid for d=2 and d=4.
6. The identification of hX,hY with the orders of L_X,L_Y follows
   from the Kummer exact sequence: over the algebraically closed
   constant field, H^1(X,mu_d)=Pic(X)[d], and the torsor character has
   image order equal to the order of its class. For primitive shared
   weight d, the constructed tensors at weight lcm(hX,hY) have the
   same actual pullback divisor; their ratio is a constant on the
   connected projective curve Z. Scaling gives a shared tensor at
   that weight. Minimality of d and lcm(hX,hY)|d imply equality.

## A stronger bound is available

The same argument, applied to a reduced union of joint-image curves,
in fact gives

    b <= 20 lcm(hX,hY) sX <= 20 d sX,
    a <= 20 lcm(hX,hY) sY <= 20 d sY.

Here is a complete justification of the additional step. Put
h=gcd(hX,hY). The stabilizers of X', Y', and W under the respective
mu_d actions are mu_hX, mu_hY, and mu_c. Under the diagonal action,
the chosen pair (X',Y') has stabilizer mu_h. Its orbit of W consists
of r=h/c distinct source components, all mapping to X' times Y'.
Take the reduced union C* of their joint images. These images are
distinct: generically the pair of endpoint coordinates determines the
point of Z by original joint minimality, and either root coordinate
then determines the point of the common root torsor. Each component
is birational to its source component by the checked field argument.

The normalization of C* is consequently the disjoint union of these
r source components. Its two projection degrees and total genus term
are

    A=a h/hX, B=b h/hY,
    T=sum_i (g(W_i)-1)=h t=A(g(X')-1)=B(g(Y')-1).

The contact proof holds without change for this reduced reducible
curve. All branches are smooth etale graphs and preserve the SAME
tautological forms. The number of branches over the zero grid is 2T,
and its square divided by the two endpoint zero counts is AB.
Adjunction and normalization Euler characteristics give

    delta(C*)=C*^2/2+T <= AB+T.

This identity holds also for a reducible or disconnected divisor:
the number of normalization components cancels from the Euler
characteristic calculation. Hodge index supplies the displayed upper
bound exactly as before. The simple-form contact lower bound is
delta(C*) >= (5/4)AB-4T, hence AB<=20T. Therefore
B<=20 hX sX, which rearranges to the stronger bound above; the other
inequality is symmetric. In genera nine and twenty-five this improves
the d=2 and d=4 bounds to M<=320 and M<=640, respectively.

This strengthening remains parameterized by d and does not address
different zero-to-weight ratios or the unbounded-weight branch.

Final consistency note: in Section 4, the set of normalized points
over the endpoint zero grid has size 2T; the grid itself has size
deg(D_X') deg(D_Y'). Reading its phrase "shared zero grid has size 2T"
as this inverse-image set is required and is an editorial correction,
not a gap in the calculation.
