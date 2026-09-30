# Proper polar replacement for the small critical traces

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_fixed_endpoint_residue_traces.md).
The family, its primitive open chart and its two infinity branches are
the accepted inputs of [normalized critical traces](degree140_normalized_critical_trace.md).
Write
\[
S=aW^3+bW^2+cW+e,\quad \phi=W^5+\bar Q,\quad T=t^3,
\quad \Lambda=-S/\phi-T/\phi^2,
\]
and let delta be division of differentials by omega0. On the critical
curve S_W=0, so coefficient differentiation with W held fixed computes
delta S. Put B=delta(phi)=3A^2 and N=delta T-BS. Then
\[
\delta\Lambda=\phi^{-3}(2TB-N\phi-(\delta S)\phi^2).
\]
Retaining the minus sign in N is essential. The different expression
delta T+BS in the earlier positive-trace formula occurs only after its
principal part has been expanded.

## A universal principal part

For n>=0 and m in {0,-1}, put k=4-m-2n and define
\[
\Omega_n=f\eta\phi^m(\delta\Lambda)^2\Lambda^{-n-1}\omega_0.
\]
Let D0,...,D4 be the coefficients of
(2TB-Nz-(delta S)z^2)^2 in z. Explicitly,
\[
(D_0,D_1,D_2,D_3,D_4)=
(4T^2B^2,-4TBN,N^2-4TB\delta S,2N\delta S,(\delta S)^2).
\]
For 0<=j<k set
\[
C_j(W)=(-1)^{n+1}\sum_{r=0}^{\min(j,4)}
D_r\binom{-n-1}{j-r}S^{j-r}T^{-n-1-j+r}.
\]
These are polynomials in W with coefficients rational on X, having
possible finite coefficient poles only at t=0. If k<=0 the sum below
is empty. Otherwise perform ordinary monic polynomial division in W:
\[
H_n(W)=\sum_{j=0}^{k-1}
\operatorname{quo}_W(C_j(W),(W^5+\bar Q)^{k-j}),
\]
\[
\Psi_n=f\eta\left(\sum_{j=0}^{k-1}
\frac{C_j(W)}{\phi^{k-j}}-H_n(W)\right)\omega_0.
\]
At a finite phi-zero with T nonzero, expanding
(T+S phi)^(-n-1) shows that Omega_n-Psi_n is regular. Subtracting H_n
does not change that principal part. It makes every summand proper as a
rational function of W: its numerator degree is strictly less than the
denominator degree. Hence Psi_n is regular at W=infinity away from t=0.
Here eta is regular, since, writing z=1/W, the critical equation gives
a=bz+3cz^2 and eta=(3b-aW)/2=b+O(z).

Thus, outside infinity, Psi_n can have poles only at the phi-zeros just
used or over t=0. This remains a statement on the actual smooth critical
curve, rather than on an unreduced quadratic coordinate model.

## Removing every moving residue

Write Tr(f phi^m v)=sum_n c_n ell^n. Trace-residue compatibility gives
\[
c_n=-\sum_{\Lambda(P)=\infty}\operatorname{Res}_P\Omega_n.
\]
At a generic parameter, the poles consist of O4,O7, ordinary phi-zeros,
and one type-A point over each of the nine endpoints. Denote that last
set by E_pole and the full inverse image of the endpoints by E_all.
Replacing the ordinary phi-zero residues by those of Psi_n and applying
the residue theorem yields
\[
c_n=\sum_{P=O_4,O_7}\operatorname{Res}_P(\Psi_n-\Omega_n)
+\sum_{P\in E_{\rm all}}\operatorname{Res}_P\Psi_n
-\sum_{P\in E_{\rm pole}}\operatorname{Res}_P\Omega_n.
\]
It is important to sum Psi_n on BOTH critical branches over an endpoint;
only the Lambda-pole branch enters the final Omega_n sum. Replacing the
former sum by its pole branch alone is generally incorrect.

At a type-A endpoint, ord(phi)=3, ord(Lambda)=-1, eta is a unit and
ord(delta Lambda)=-2. Therefore ord(Omega_n)>=3m+n-3. Its residue
vanishes for n>=3-3m. For such n, k<=0 also, so Psi_n=0. This proves
the asserted cutoffs2 and5. Multiplication by affine regular f cannot
decrease these orders.

The construction proves an identity over the rational parameter field.
The incoming primitive trace presentation identifies its left side with
the trace on the normalization and supplies continuation on other valid
charts. A type-B endpoint must not be evaluated by inverting the type-A
linear coefficient. Either cancel the parameter denominator first or use
the actual normalized trace presentation at that specialization.

## New implementation evidence

The [infinity engine](../../scripts/arithmetic/degree140_low_trace_infinity_20260929.hpp)
implements the proper polar replacement. The
[endpoint prototype](../../scripts/arithmetic/degree140_endpoint_trace_local_20260929.sage)
expands at the three x-endpoints over their actual cubic residue fields;
the cubic field trace retains all nine sheets. At h=2,w=3 the resulting
T1,Tx,Q1,Qx,Qx2 agree coefficientwise with the already retained
function-field trace profile. This is a focused check of this NEW
algorithm, not a replay of the incoming programs. The formula is proved
by the residue argument above, not inferred from that comparison.

The compact comparison receipt is
`../../../litt3-computation-data/seventeen_hour_continuation_20260929/traces/low_trace_residue_check_2_3.json`.
The new construction has not yet been used to exclude all remaining
geometric ratios or to decide the unmarked common-cover problem.
