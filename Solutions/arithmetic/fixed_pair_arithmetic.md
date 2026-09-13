# Proof: geometry and Jacobians of the fixed pair

[Statement](../../Theorems/arithmetic/fixed_pair_arithmetic.md).
Use the defining models X:y³=F(x) and Y:z²=L(t)(L(t)−1)(t−4),
where L=t²⁵+t⁵+t, from the [fixed-pair definition](../../Definitions/Def_fixed_pair.md).
The [exact arithmetic certificate](../../routes/global/76_EXPLICIT_R3_REDESIGN_CERTIFICATE.sage)
checks the polynomial inputs below.

## 1. Geometry and canonical frame

F is squarefree of degree 10. The tame cubic map is totally ramified
at its ten roots and unique rational infinity O, so
2g(X)−2=−6+11·2=16. A degree-two pencil would generate k(X) with
the cubic pencil, forcing g(X)≤(3−1)(2−1)=2 by Castelnuovo–Severi.
Thus X is nonhyperelliptic. At infinity x,y have poles 3,10;
the differential theta=dx/y² has order 16. At a finite branch point,
y is a parameter and dx has order 2; elsewhere dx/y² is a unit.
Hence div(theta)=16O.

Since L′=1 and L(4)=2, the degree-51 polynomial defining Y is squarefree,
so g(Y)=25. On F125, L is the trace to F5; its two fibers L=0,1 have
25 rational points each. Together with 4 and infinity these give all
52 rational Weierstrass points.

## 2. A root-ratio test for absolute simplicity

If an abelian variety has irreducible Frobenius polynomial P of degree 2g,
and no ratio of distinct roots is a root of unity, then its Frobenius
polynomial over every finite extension stays irreducible: the powers
of its roots remain distinct and form one Galois orbit. Any geometric
abelian subvariety descends to a finite extension, so the variety is
geometrically simple. This argument does not require ordinarity.

The 25-power Frobenius polynomial of X is

\[
\begin{aligned}
P_X(T)={}&T^{18}-2T^{17}-29T^{16}+57T^{15}-124T^{14}
 +3716T^{13}+3083T^{12}\\
&-94215T^{11}+141450T^{10}+601875T^9+3536250T^8
 -58884375T^7\\
&+48171875T^6+1451562500T^5-1210937500T^4
 +13916015625T^3\\
&-177001953125T^2-305175781250T+3814697265625.
\end{aligned}
\]

It is irreducible modulo 2. The exact factorization of
Res_U(P_X(U),P_X(zU)), up to a nonzero rational scalar, has the
following monic irreducible factors:

| Degree | Multiplicity | Coefficient denominator |
| --- | --- | --- |
|1|18|1; the factor is z−1|
|18|1|5¹²|
|72|2|5³⁰|
|72|2|5³⁶|

A root of unity has an integral monic minimal polynomial. Thus none
of the last three factors is cyclotomic, and the root-ratio criterion
proves geometric simplicity of J(X).

## 3. One residue-degree pattern for the genus-25 Jacobian

Write P_Y(T)=T²⁵Q_Y(T+5/T), where

\[
\begin{aligned}
Q_Y(U)={}&U^{25}-2U^{24}-120U^{23}+236U^{22}+6300U^{21}
-12172U^{20}\\
&-190024U^{19}+360412U^{18}+3635782U^{17}-6767504U^{16}
-45967432U^{15}\\
&+84017092U^{14}+387818812U^{13}-697588276U^{12}
-2152004856U^{11}\\
&+3830395252U^{10}+7526742721U^9-13422653422U^8
-15169333376U^7\\
&+27936617472U^6+14306622112U^5-29892350656U^4
-2589320704U^3\\
&+11661025280U^2-962499328U-933754368.
\end{aligned}
\]

The certificate computes this Frobenius polynomial, checks its
irreducibility modulo 47 and its middle coefficient −135307468,
which is prime to 5. Thus J(Y) is ordinary and simple. The real field
K⁺=Q(pi_Y+5/pi_Y) has degree 25. Modulo 173, Q_Y has squarefree
factorization degrees (1,24).

More generally, a degree-g number field with an unramified prime of
residue degrees (1,g−1), g>2, has no nontrivial proper subfield and is
not Galois. Indeed, a proper nontrivial intermediate L gives degrees
a=[K⁺:L]>1 and b=[L:Q]>1. Then
the residue degree g−1=ab−1 factors as f₁f₂ with f₁≤a and f₂≤b.
At least one inequality is strict, giving f₁f₂≤ab−min(a,b)<ab−1,
a contradiction. Unequal residue degrees exclude Galoisness.

In particular K⁺ is not a cyclotomic maximal real subfield. Finally
P_Y has nonzero T⁴⁹ coefficient −2, so is not T⁵⁰+cT²⁵+5²⁵.
These are exactly the hypotheses of
[Howe–Zhu, Lemma 8](https://arxiv.org/html/math/0002205v1#S5),
which proves geometric simplicity of J(Y). The distinct dimensions
then give Hom_k(J(X),J(Y))=0.

The arithmetic polynomial computations retain author-prose status.
The [bounded refinement audit](../../Research/audits/FIXED_ARITHMETIC_SIMPLIFICATION_AUDIT_2026_09_13.md)
checks only the two shorter simplicity arguments, not the inherited
Frobenius computations. The reconstruction now uses a modulus larger
than twice the Weil coefficient bound, ensuring unique integer recovery.
