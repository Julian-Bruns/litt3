# Degree-six recognition and the exclusion of its double-cover models

Version 2, 24 September 2026. Work over k=bar F5 with the fixed
genus-nine X:y^3=P(x), A=(1,21,14,22,13), theta=dx/y^2, and
tau=A^16 theta^13. Use the coefficient convention in the
[normal-form theorem](new_line_comparison_normal_form.md).
The [complete d=3 exclusion](new_line_low_pole_reconstruction.md)
leaves only d=n=6 for a jointly minimal degree-six comparison of
distinct X-fields with proportional tensor pullbacks.

Such a comparison exists if and only if the following model exists
over k. Choose g in {0,1,2}, a monic squarefree polynomial B(s)
of degree 2g+2 with B(0)!=0, and polynomials a,b,c,d satisfying
\[
\deg a,\deg c\le3,\qquad \deg b,\deg d\le2-g,\qquad b d\ne0.
\]
On the smooth proper curve S:w^2=B(s), put
\[
x_1=a+bw,\qquad x_2=(c+dw)/s^3.
\]
Require a_3^2-b_{2-g}^2!=0 and c(0)^2-B(0)d(0)^2!=0.
These conditions give pole order three at both points over infinity
for x_1, and at both points over zero for x_2. Put
Q=(d x_2/ds)/(d x_1/ds), with d w/ds=B'/(2w).
There must be kappa in k^times such that, as function identities,
\[
s A_h(c+dw,s^3)=\kappa^6 A(x_1),\qquad
Q^3P(x_1)^2=\kappa^{-21}s^{48}P(x_2)^2.
\]
Here A_h has degree four. Finally x_1:S->P1 must have only
ramification indices one and three, with all ramification values
among the ten roots of P and infinity. This is a condition at every
point, not just on a displayed derivative numerator.

For any such model, normalize y_1^3=P(x_1) over S. This gives a
connected smooth proper T of genus49. With
\[
\nu=\kappa^{-7}s^{16},\qquad
r=\nu P(x_2)/(QP(x_1)),\qquad y_2=r y_1,
\]
the maps h_i=(x_i,y_i):T->X are finite etale of degree six,
jointly generate k(T), have distinct embedded X-fields, and satisfy
h_2^*tau=kappa^5 h_1^*tau. In particular the ramification profile
of x_2 need not be imposed separately: it follows from the resulting
etale second map.

The displayed models are EMPTY for all three genera, including rational
S. In fact the two function identities and exact pole conditions alone
are incompatible; the extra ramification profile is not needed.
The exclusion uses forced local jets at both zero and infinity, all
discrete root and root-of-unity choices, and exact rank or nonzero
determinant certificates. It permits arbitrary algebraically closed
coefficients for the unknown model.

Consequently, for ANY two finite etale maps h_i:T->X of degree at
most six, equality of the two specified embedded Cartier lines,
equivalently proportional pullbacks of tau, forces equality of the
embedded X-fields. The maps then differ by an element of Aut(X)=C3.
Joint minimality may be imposed first: its common map degree divides
the original degree. The prior small-degree and entire d=3 exclusions
and the present d=n=6 exclusion cover every possibility.

Higher-degree recognition and the original unmarked common-cover
problems remain open. This theorem does not bound the degree of an
arbitrary common cover or produce a shared tensor on it.

[Proof](../../Proofs/cartier_and_spin/degree_six_new_line_models.md).
[Complete model exclusion](../../Proofs/cartier_and_spin/degree_six_tensor_exclusion.md).
