# Direct common-source traces do not require a cubic quotient

27 September2026. This proof concerns the ACTUAL comparison normal
form for h1,h2:T->X, finite etale from the same smooth projective curve.
It does not assume that k(x1,x2) has index three in k(T). Write u=x1,
v=x2, and use t,epsilon,eta_geo in the normal form
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
\theta_2=\eta_{geo}t^{16}\theta_1,\qquad\eta_{geo}^3=\epsilon^{-17}.
\]
Suppose t is nonconstant, has3m simple zeros and poles with m>=1,
and its endpoint phase
multisets are balanced as INTEGER multisets across the three cubic
sheets above each A-root. Let L0,Linfinity be the resulting m-label
multisets. The local leading terms have exactly the usual root/phase
labels; no choice of a curve quotient is made.

Put eta0=[22], K0=F_(5^14), and bar(z)=z^(5^7) on K0. For the
fixed endpoint rows c,e,f0,f1 and phases xi, define C,E,U,V as in
[the complete sextic proof](pole_eighteen_complete_exclusion.md).
At a common infinity point p let c_p=t(p), so c_p^29=1. Define
\[
l_c=\#\{p\in\min(h_1^*O,h_2^*O):t(p)=c\},\quad
M_j=\sum_c l_c c^j,\quad X=M_2,\quad Y=M_6.
\]
Then the actual data satisfy ALL four trace identities
\[
\epsilon(E_0-\eta_0\bar X)=C_\infty-\eta_0\bar Y,\qquad
\epsilon(C_0-\eta_0Y)=E_\infty-\eta_0X,
\tag{1}
\]
\[
\epsilon U_0+V_0=\eta_0(\epsilon X^{625}-\bar Y^5),\qquad
U_\infty+\epsilon V_\infty
=\eta_0(\bar X^{625}-\epsilon Y^5).
\tag{2}
\]
The same X,Y occur in all equations. Their membership in K0 follows
from the integer weights and mu29 alone. There is no field-of-definition
assumption on T or on its maps.

## A local trace bound that includes wild ramification

Work at a common infinity p and set T0=t-c. Since the original maps
are etale, u and v have pole order exactly three. The normal form gives
ord_p(T0)=j>=2. For a uniformizer z, ord(dT0)>=j-1, including the
wild case. Consequently
\[
\operatorname{ord}_p(T_0u\,dT_0)\ge2j-4\ge0,
\qquad \operatorname{ord}_p(T_0v\,dT_0)\ge0.
\]
Trace of a regular differential through a finite separable map is
regular, by the inverse-different description. Therefore each local
contribution to Tr(u) and Tr(v) has at most a simple pole at c.
At points where u or v is regular, trace of that function is regular.
Thus extra ramification values create no extra poles. This argument
uses the original map t:T->P1; it uses neither tame inertia nor a
factorization of t through another curve.

The residue is equally direct. Choose z so u=z^-3, permissible because
three is invertible. Write
\[
v=\ell z^{-3}/h(z),\quad t=cq(z),\quad h(0)=q(0)=1,
\quad\ell=\epsilon c^4.
\]
The two local comparison identities in
[the earlier trace proof](quartic_trace_obstruction.md) are formal
consequences of the displayed normal form and remain valid here with
e=3. They give q1=h1=0, q2=3h2 and
\[
q_3=4P_9(1-\ell^{-1}).
\]
Residue commutes with trace of differentials. Since
res_p(u dt)=3c q3, the residue of the local Tr(u) is
3a c(1-ell^-1), with a=4P9=[8]. Also v-ell u has pole order at
most one, so (v-ell u)dt is regular when j>=2. Its traced differential
has zero residue. The local residue for Tr(v) is consequently ell
times the preceding one.

Divide the GLOBAL traces by three, a nonzero constant in characteristic
five. Their residues at c are therefore
\[
R_u(c)=\eta_0l_c(\epsilon^{-1}c^{-3}-c),\qquad
R_v(c)=\eta_0l_c(c-\epsilon c^5).
\tag{3}
\]
No division by the degree3m or a group order occurs. The use of the
factor three reflects only the actual balanced endpoint multiplicity.

## Endpoint coefficients and partial fractions

Set Utr=Tr_(k(T)/k(t))(u)/3, Vtr=Tr_(k(T)/k(t))(v)/3. At the
simple endpoint fibres, trace is the sum of the actual formal germs.
The local coefficient formulas c(alpha)xi^5j and e(alpha)xi^8j are
independent of the cubic sheet. Integer phase balance makes their
sums, after division by three, exactly C_L and E_L.

At zero v has pole order three, and at infinity u has pole order
three. At the opposite end each is regular. Hence Utr has a polynomial
part of degree at most three, while Vtr has a Laurent part with powers
t^-3,t^-2,t^-1 and a constant. The only other principal parts are(3).
Comparing the t^2 coefficient of Utr at zero with its polynomial
part at infinity, and the reciprocal coefficients for Vtr, gives(1),
exactly by the partial-fraction calculation in the earlier proof.

The fourth endpoint coefficient is also universal on these actual
germs. For Z=epsilon^-1 t^3v the coefficient Z4 is
xi^(17j)f0(alpha)+epsilon^-1 xi^(4j)f1(alpha), independently of the
free resonant coefficient Z2. This follows from the triangular formal
calculation in [the fourth-coefficient theorem](klein_four_fourth_endpoint_trace.md),
whose equations are just the cubed normal form; no quotient hypothesis
enters that calculation. Thus [t]Vtr=epsilon U0+V0.
Its partial fractions instead give
\[
[t]Vtr=-\sum_cR_v(c)c^{-2}
=\eta_0(\epsilon M_3-M_{-1}).
\]
The integer weights imply M3=X^625 and M_-1=bar(Y)^5. This is the
first equation(2); interchanging the two actual maps proves the second.
All equations therefore hold on the original source, regardless of
the index of its embedded x-fields.

## What is still required for an application

The fresh bounded independent audit by /root/audit_direct_source_trace
passed on27September2026. It checked the local coefficients, wild
trace bound, normalization, both partial-fraction signs, all four
Frobenius substitutions, and the absence of hidden cubic descent.
The same audit checked the pole21 phase/scalar application, taking
the already established finite arithmetic certificates as inputs.
Its scope is recorded in the current integration audit.

This lemma does NOT assert integer endpoint balance in arbitrary
degree, does not construct a comparison, and does not extract a
shared tensor from an unmarked common cover. Its genuine added point
is that, once integer balance is proved, a separate cubic-descent
theorem is unnecessary for applying the four-trace obstruction.
