# Proof: an adjacent trace coefficient and a local determinant

[Statement](../../Theorems/cartier_and_spin/concentrated_quintic_exclusion.md).
The complete returned proof and its small exact certificates are retained
in the [original report](../../../litt3-computation-data/two_sheet_quintic_replies_20260927/extracted/concentrated_quintic/REPORT.md).
This proof records the decisive argument; its hypotheses are the actual
[quintic quotient constraints](pole_fifteen_quotient_constraints.md).

## Local equation and its first transverse coefficient

At zero write u=alpha+a t+..., v=b t^-3+..., z=t^3v/b and J=t d/dt.
Here a=[13]epsilon^-4 b^4/A'(alpha), b=epsilon b0_alpha xi,
xi^29=1. Set p=P'(alpha)/P(alpha), r=A''(alpha)/A'(alpha),
Lambda=a(p-r). The identity A(v)=epsilon^4 t^-13 A(u) uniquely
expresses u=U(t,z) near(t,z)=(0,1), with
\[
U=\alpha+a t z^4+2r a^2t^2z^8+O(t^3).
\]
Put H=t^30 P(bt^-3z). The differential identity of the actual two maps
is the implicit equation for V=Jz
\[
b^3(V+2z)^3P(U)^2
=\epsilon^{-17}H^2\bigl(U_t+(U_z/t)V\bigr)^3.
\]
At t=0 it becomes (V+2z)^3-3z^29(z+4V)^3=0. Its derivative in V
at(1,0) is1, so a unique V(t,z) exists in k[[t,z-1]]. With q=z-1,
\[
V(0,1+q)=2q+2q^3+2q^4+O(q^5),
\quad V(t,1+q)=V(0,1+q)+t(-\Lambda+\Lambda q+O(q^2))+O(t^2).
\]
Thus in the five actual expansions t^3v_i=b+d t+e_i t^2+f_i t^3+...,
d/b=Lambda and f_i-f_j=Lambda(e_i-e_j). In characteristic five,
sum f_i=Lambda sum e_i. These identities allow equal e_i and
arbitrarily late subsequent branch separation.

For alpha0 a root of (5,2,6,7,1), the four values of Lambda0=a0(p-r)
have ascending alpha0-coordinate rows
\[
(23,23,17,12),\ (7,4,23,0),\ (5,15,2,24),\ (1,18,18,24).
\]
Each is in F_(5^8) minus F25; Lambda=Lambda0 xi^4. Since
F_(5^8) intersect F_(5^14)=F25, Lambda is never in K0=F_(5^14).
The returned verifier checks these rows, the phase equation and field
irreducibility by exact polynomial arithmetic.

## The full traces vanish

Let M_j=sum d_c c^j for c^29=1. The common-pole trace residues are
R_u(c)=[22]d_c(epsilon^-1 c^-3-c) and
R_v(c)=[22]d_c(c-epsilon c^5). Concentration at both ends gives
Tr(u)=O(t^3) at zero, Tr(v)=O(s^3) at infinity, and at most simple
polar parts at their opposite endpoints. All other trace poles are
the displayed simple poles. Integral functions have integral trace,
including at any other wild branch.

Consequently Tr(v)=H0/t+sum R_v(c)/(t-c), where
H0=-[22](M1-epsilon M5). Comparing its constant term at zero with
sum f_i=Lambda sum e_i gives the new equation
\[
M_0-\epsilon M_4=\Lambda(M_1-\epsilon M_5).                 \tag{1}
\]
Put X=M2,Y=M6. The supplied low trace equations include
X=epsilon Y and epsilon X^625=bar(Y)^5, with bar on K0. Multiplication
by5 on the nonzero classes modulo29 has two orbits, represented by1,2;
in particular M1=Y^5,M5=Y^25,M4=Y^(5^10).

If Y=0, X=0, all nonzero-index moments vanish, and(1) gives M0=0.
Fourier inversion gives every d_c=0 modulo5. If Y is nonzero,
epsilon=X/Y lies in K0. The field separation for Lambda makes both
sides of(1) vanish separately. Thus epsilon=Y^-20, X=Y^-19 and
M0=Y^(5^10-20). The second low trace equation gives Y^402520=1.
The two integer calculations
\[
\gcd(402520,5^{14}-1)=232,\qquad
\gcd(232,4(5^{10}-20))=116
\]
use M0 in F5*. Hence Y=rho q0 with rho in F5*,q0^29=1. For
c0=q0^5, epsilon=c0^-4 and M_j=rho c0^j for all j. Fourier inversion
makes d_c zero modulo5 away from c0; at c0 its trace residue is zero
because epsilon c0^4=1. In either case ALL R_u,R_v vanish. The trace
growth and vanishing bounds then force Tr(u)=Tr(v)=0. This conclusion
concerns residues only: integer weights divisible by5 are not removed
from the actual divisors.

## A contradiction without a separation-order bound

The five elements 1,z,(u-alpha)/(a t),Jz,J^2z all have trace zero.
They are regular formal functions of(t,q), with coefficient matrix
in q^0,...,q^4 at t=0
\[
\begin{pmatrix}
1&0&0&0&0\\1&1&0&0&0\\1&4&1&4&1\\0&2&0&2&2\\0&4&0&1&0
\end{pmatrix},\qquad \det=3.
\]
For five distinct q_i(t) in t k[[t]], their evaluation determinant is
the Vandermonde product times a unit: the quotient is a formal power
series whose constant coefficient is this determinant. This follows
by expanding alternants, without dividing by a factorial. The actual
branches z_i are distinct because N=k(t,v). Their evaluation determinant
is therefore nonzero even if their first differences occur very late.
But summing its five rows gives their five traces, all zero, a nontrivial
row relation. This is the contradiction.

The field and jet checks passed locally. A separate focused mathematical
audit passed the whole argument, including its geometric scope. Exact
commands, provenance and audit conclusions are in the
[integration record](../../Research/audits/TWO_SHEET_QUINTIC_REPLIES_2026_09_27.md).
