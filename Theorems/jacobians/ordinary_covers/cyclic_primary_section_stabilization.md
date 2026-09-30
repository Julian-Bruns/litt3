# Uniform section stabilization on cyclic characteristic-primary covers

Version2, 22 September2026. Focused author proof check; no independent
agent audit.

Let C be a smooth proper connected curve over an algebraically closed
field k of characteristic p. Suppose its Jacobian is geometrically
simple. Let E be a vector bundle with Euler characteristic zero which
admits a proper generalized theta divisor on Pic0(C). There are integers
R and M, depending only on (C,E), with the following properties.

Every connected cyclic finite etale cover q:D->C of degree p^r satisfies
\[
h^0(D,q^*E)\le M.
\]
For every compatible connected cyclic tower D_r->C of degrees p^r,
and every r>=R, pullback gives an isomorphism
\[
H^0(D_R,q_R^*E)\xrightarrow{\sim}H^0(D_r,q_r^*E).
\]
The SAME R works for every tower. Every finite cyclic p-power cover
extends to such a tower. One can choose M<p^R.

The conclusion also holds for a fixed finite family of such bundles,
with common R and M. No numerical value for these bounds is asserted.

More generally, omit the proper-theta hypothesis and put
\[
\delta_E=\min_{L\in\operatorname{Pic}^0(C)}h^0(C,E\otimes L).
\]
There are uniform R and M such that in every cyclic tower
\[
h^0(D_r,q_r^*E)=\delta_Ep^r+c_\chi\quad(r\ge R),
\qquad 0\le c_\chi\le M<p^R.
\]
The constant c_chi depends on the tower, through finite character data.
In particular the boundedness criterion is EXACTLY delta_E=0.

For an arbitrary fixed finite etale refinement f:Z->C, apply this
to E=f_*B_Z on the relative twists. It gives
\[
a(Z\times_C D_r)=\delta_f p^r+c_\chi,
\qquad
\delta_f=\operatorname{generic}_{L\in J(C^{(1)})}
h^0(Z^{(1)},B_Z\otimes f^{(1)*}L).
\]
The left side is the sum over the connected components if the fiber
product is disconnected. Thus simplicity of J(C) alone does NOT
bound a-numbers after arbitrary refinements: delta_f can be positive.

For the Cartier bundle on C^(1), Raynaud's theta theorem applies.
Consequently the a-numbers of all connected cyclic etale p-power
covers of a curve with simple Jacobian are uniformly bounded and
stabilize uniformly along towers. When p is odd their eventual values
are even, by the canonical alternating pairing and cyclic block parity.

For the fixed genus-nine curve X, there is a uniform R_X such that
every actual finite etale map h:D_r->X from a cyclic tower over X,
with r>=R_X, factors as an ACTUAL finite etale map through D_(R_X).
Indeed all three pulled-back original exact forms descend, and the
two-form recognition theorem descends h. In particular the possible
reduced self-correspondences obtained from these cyclic towers form a
finite set. Here reduction means replacing a sufficiently high source
by that intermediate cyclic cover, with both maps retained.

There is also a mixed-prime extension. Assume k=bar(F_p), fix a finite
set S of primes, and retain the proper-theta hypothesis on E. There
is a uniform bound for h0(T,q^*E) over ALL connected abelian etale
covers q:T->C whose prime divisors lie in S and whose p-Sylow is
cyclic. Moreover every such cover has an actual intermediate cover
T_0->C of uniformly bounded degree such that
\[
H^0(T_0,E|_{T_0})\xrightarrow{\sim}H^0(T,E|_T).
\]
The prime-to-p part of the group need not be cyclic. For E=B_C and
the fixed X, every actual second map T->X descends to T_0. Thus the
reduced self-correspondences arising in this whole mixed-prime family
form a finite set. The bound depends on S; taking the union over all
finite S is NOT allowed. This combines the new characteristic-primary
argument with the previously established finite-support Boxall theorem.

These statements give no uniform bound for unrestricted prime-to-p
cyclic degrees, arbitrary p-groups, or nonabelian alternating towers.
They do not replace the original two-leg common-cover problem by an
abelian one.

[Proof](../../../Proofs/jacobians/ordinary_covers/cyclic_primary_section_stabilization.md).
