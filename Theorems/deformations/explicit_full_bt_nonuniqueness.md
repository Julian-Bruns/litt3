# Full proper-curve BT groups need not be determined by their marked BT1

Version1,21 September2026.

Let $k=\overline{\mathbf F}_5$, and take the ordinary genus-two
curve, active oper, flat twist and canonical first periodic datum of
[the cubic reference](cubic_ordinary_base_reference.md). Call this
genus-two curve $Y$. Its normalized etale double is
\[
C:\quad \kappa^2=u(u-3),\qquad
y^2=(u-1)(u-2)(u-\alpha),\qquad v=\kappa y.
\]
Here $\alpha^3+\alpha+1=0$, and the function $\kappa$ is distinct
from the abstract flat periodicity line used in the proof.
Let $q:T\to C$ be the ORIGINAL connected etale $C_5^3$ cover from
[the rank125 laboratory](elementary_covers/rank125_all_heights.md).
Thus $g(C)=3$, $g(T)=251$. Put $h=\pi q:T\to Y$, of degree250.
Choose one permitted flat fourth-root correction
on $Y$ and pull that SAME correction back to $T$.

The ordinary endpoint has its actual full normalized group $G_Y$.
Put $H_T=h^*G_Y[5]$ with this marking. There exists a second actual
full height-two, dimension-one group $G_T$ on the proper curve $T$
such that:

1. $G_T[5]\simeq H_T$ with the given first periodic datum retained.
2. Its determinant is the Teichmuller lift of that of $H_T$, and
   it is everywhere versal with the same reduced supersingular divisor.
3. Its marked second truncation is NOT isomorphic to
   $h^*G_Y[25]$.
4. It is not the pullback of ANY full group on $Y$ extending the
   specified $G_Y[5]$, even if an initially unnormalized determinant
   is allowed. Its marked BT2 likewise has no descent along $h$, or
   even along the intermediate original $q$ with its induced marking.

The group $G_T$ is obtained from the audited formal periodic tower
whose third source is $H^\dagger=H^*+[8]\nu_{39}$ and whose fourth
choice is $\tau=[105]$. These are the canonical identifiers and
exact choices of the cited theorem, not arbitrary deformation classes.
The original first periodic datum and all relative Frobenius and
coefficient identifications are retained.

In fact $H_T$ has at least SIX pairwise NON-ISOGENOUS normalized full extensions:
the pulled-back $h^*G_Y$ and at least five distinct deck translates
of $G_T$. Their second truncations already distinguish them. No
exhaustive count of full extensions is asserted.

This disproves marked full-group rigidity from BT1 on a proper curve
and prescribed full-group descent through a finite etale cover in
general, even with an indigenous-ordinary genus-two base. The
covering curve with the specified pulled oper is not indigenous-ordinary.
It does not disprove prescribed descent from the ordinary genus-two
endpoint in the outstanding two-map question. No second map to either
of the fixed common-cover candidates is constructed.

[Proof](../../Proofs/deformations/explicit_full_bt_nonuniqueness.md).
