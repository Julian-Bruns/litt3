# The ten-Tango Hoshi curve: exact count, symmetries and quotient

Version 2, 2026-09-08. Consolidated AUTHOR proofs and exact certificates
from 2026-09-05: the count, Kummer p-rank, reflections and genus-two
quotient. No whole-note independent audit is claimed. The later
[audited zero-Tango twist](HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO.md)
retains its separate scope. These auxiliary curves do not replace the
fixed pair or provide a counterexample to Litt.

## 1. Geometry and independent p-rank evidence

Over the algebraic closure of F_5, let Y be the smooth normalization of

\[
 E:y^2=x^3+3x+2,\quad P=(1,1),\quad
 w^6=f=(x+3)y+4x^2+4x+3.
\]

Writing f=A+By, one has A²−B²(x³+3x+2)=4(x−1)^5,
f(P)=0, f(−P)=2, and df/f=dx/(2y). The only pole is O, of order
five, so div_E(f)=5P−5O. Coprimality of ±5 with six proves connectedness
and total tame ramification precisely over P,O; Riemann--Hurwitz gives
g(Y)=6. For their unique preimages P_Y,O_Y,

\[
 \beta=dw/w=\pi^*(dx/(2y)),\quad
 \operatorname{div}(w)=5P_Y-5O_Y,\quad
 \operatorname{div}(\beta)=5P_Y+5O_Y,\quad
 \operatorname{div}(dw)=10P_Y.                          \tag{1}
\]

This is Hoshi's q=5,n=1 construction
([Theorem 3 and Remark 10](https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1917.pdf)).
The [point-count/divisor certificate](HOSHI_GENUS6_F5_KUMMER_P_RANK_CERTIFICATE.sage)
gives counts 2,44,158,572,3082,16574 over F_(5^n), n=1,…,6. Newton
identities and the functional equation yield

\[
 P_Y(T)=(T^2-4T+5)(T^2-3T+5)(T^2-T+5)(T^2+4T+5)(T^2+5)^2.
\]

A seventh count is checked separately. Thus γ(Y)=4, not one.
The bounded short-Weierstrass search with #E(F_5)=5 is also complete:
only (a,b)=(3,2),(3,3), isomorphic over F_5, and all four nonzero points
on each, with xy coefficient normalized to one. Every resulting Kummer
curve has rank four; scalar multiples of f do not change geometric rank.
This says nothing about arbitrary F_25 elliptic models.

## 2. A complete regular differential basis

For (x',y')=Q−P on E, put

\[
 s=(y+1)/(x-1),\quad x'=s^2-x-1,\quad y'=-y+s(x-x'),
\]
\[
 v_2=x'-1,\qquad v_3=y'-2x'-2,\qquad
 v_4=y'+2(x')^2+4x'.
\]

The sole pole of v_j is P, of order j; its zero order at O is j−1.
The latter follows by exact jets at (x',y')=(1,4). Therefore, with
η_j=v_jw^jβ, the six regular differentials

\[
 \beta,\ w\beta,\ \eta_2,\ \eta_3,\ \eta_4,\ w^{-1}\beta    \tag{2}
\]

form a basis: η_j has orders 5−j,j−1 at P_Y,O_Y, and the six Kummer
characters are distinct. The [ten-Tango certificate](HOSHI_GENUS6_EXACT_TANGO_COUNT_CERTIFICATE.py)
checks the jets and the exact Cartier identities

\[
 C\beta=\beta,\quad C(w\beta)=C(w^{-1}\beta)=0,\quad
 C\eta_2=4\eta_4,\quad C\eta_3=3\eta_3,\quad C\eta_4=4\eta_2. \tag{3}
\]

This independently gives stable Cartier dimension four.

## 3. All geometric dormant connections and exactly ten Tango structures

Use the specified field and constants

\[
 k_0=\mathbf F_5[u]/(u^4+4u^2+4u+2),\quad
 \lambda=2u^3+2u^2+2u,\quad \mu=3u^3+u^2+3u+1.
\]

Then λ^4=4, μ^4=3. The four forms

\[
 b_0=\beta,\quad b_1=\eta_2-\eta_4,\quad
 b_2=\lambda(\eta_2+\eta_4),\quad b_3=\mu\eta_3             \tag{4}
\]

are Cartier-fixed and independent. Since the geometric fixed space
has F_5-dimension four, these give ALL fixed forms over any constant
extension, not just a finite-field subset.

Let ∇_0 declare dw horizontal. Equation (1) makes it globally regular:
a horizontal frame with five-divisible divisor has logarithmic
coefficient regular at every point. It is dormant. By the
[connection/root dictionary](111_P_RANK_ONE_TANGO_DESCENT.md), all dormant
regular canonical connections are uniquely ∇_0+∑c_i b_i for c∈F_5^4.
Their coefficients in the frame dw are

\[
 a_c=c_0/w+c_1(v_2w-v_4w^3)
       +c_2\lambda(v_2w+v_4w^3)+c_3\mu v_3w^2.           \tag{5}
\]

The certificate uses the separating presentation

\[
 k_0(Y)=k_0(w)[z]/(4z^5+(2z^2+z+3)w^6+w^{12}),\quad z=x-1.
\]

For D=d/dw, a horizontal h dw has D^4h=P_4(a_c)h, where
P_4(a)=a^4−a²Da+3(Da)²+4aD²a−D³a. Thus P_4=0 is exactly the Tango
condition on these already globally regular dormant connections.

All 625 tuples are tested at one specified regular point with every
denominator checked. Nonzero evaluation rejects 615; the remaining ten
are checked IDENTICALLY in the function field. They are

\[
\begin{gathered}
 (0,0,0,0),(2,0,0,0),(3,0,0,0),(4,0,0,0),\\
 (3,2,0,0),(4,2,0,0),(3,4,2,0),(4,4,2,0),
 (3,4,3,0),(4,4,3,0).
\end{gathered}
\]

Different connections give different embedded roots, so the geometric
Tango count is TEN. The four β-line points are the known structures;
the missing (1,0,0,0) has β horizontal, hence is not Cartier-zero.
The count refutes a universal p−1 bound, not the
[rank-one or sharper all-rank bounds](111_P_RANK_ONE_TANGO_DESCENT.md).

## 4. Exact Kummer and reflection actions

The ten points span the hyperplane c_3=0 over F_5. One has λ²=3 and
ζ=λ+3 of order six. The automorphism σ:w↦ζw fixes ∇_0 because dw
scales by a constant. Its form weights are 0,2,3,4 and its action is

\[
 \sigma^*c=(c_0,2c_1+3c_2,c_1+2c_2,-c_3).
\]

The four β-line points are fixed; the other six form two length-three
orbits (a,2,0,0)→(a,4,2,0)→(a,4,3,0), a=3,4. In particular the
order-two Kummer subgroup fixes all ten; there is no orbit of six.

For the elliptic involution ι(Q)=P−Q, exact substitution gives
f(ιQ)=4/f(Q). Its six involutive lifts are

\[
 \tau_a:(Q,w)\mapsto(P-Q,a/w),\qquad a=2\zeta^j,\ j\bmod6.
\]

Kummer conjugation multiplies a by ζ^(2m), giving even and odd classes,
represented by a=2 and a=2ζ. The four fixed Q with 2Q=P are (2,4),
where f=2, and the three points

\[
 x^3+3x^2+2=0,\qquad y=3x^3+x^2+x+4,\qquad f=3.
\]

The cubic is separable and irreducible over F_5. None is P or O.
Above such a Q, w²=a has two solutions precisely when f(Q)=a³.
Consequently:

| Lift | Fixed points | Quotient genus | Quotient p-rank |
|---|---:|---:|---:|
| a=2 | 6 | 2 | 1 |
| a=2ζ | 2 | 3 | 2 |

The genus follows from 10=2(2g(B)−2)+#Fix. The ranks follow from the
invariant Cartier-fixed forms below: tame invariant regular forms descend
to the actual quotient. Different fixed-point counts preclude conjugacy
even under the full automorphism group.

Both reflections send β to −β. Since τ_a^*dw=−aw^(−2)dw, their action
on connections has the ESSENTIAL translation τ_a^*∇_0=∇_0+2β:

\[
 \tau_{\rm even}^*c=(2-c_0,c_1,-c_2,-c_3),\qquad
 \tau_{\rm odd}^*c=(2-c_0,2c_1+3c_2,4c_1+3c_2,c_3).       \tag{6}
\]

Their linear invariant dimensions are one and two. A fixed connection
would have c_0=1, absent among the ten Tango points; each reflection
therefore permutes them as five transpositions. Formula (6) and the
listed ten points specify every transposition, all checked by the
[reflection certificate](HOSHI_GENUS6_REFLECTION_CERTIFICATE.py).

## 5. The exact genus-two quotient and quadratic generator

For τ=τ_even, the invariant forms
ν_1=(w−2/w)β and ν_2=η_2−η_4 are independent. Set INSIDE k(Y)

\[
 t=\nu_2/\nu_1,\qquad v=dt/\nu_1,\qquad h=t^5(w-2/w).
\]

The [quotient certificate](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py)
checks, as exact function-field identities,

\[
 B:v^2=F(t)=2t^6+2t^4+3t^2+4,\qquad
 h^2=e=A(t)+B_0(t)v,
\]
\[
 A=2t^8+4t^6+2,\quad B_0=t^2+4,\quad
 A^2-B_0^2F=4t^{10}(t^6+4t^4+4t^2+2).                  \tag{7}
\]

The displayed hyperelliptic curve is smooth of genus two: F is squarefree.
The map from Y/τ to it is separable because dt≠0; Riemann--Hurwitz
between genus-two curves forces degree one, proving this is the WHOLE
quotient. Since h is nonzero and anti-invariant, it generates the
quadratic extension; normalized equations reconstruct Y, regardless
of singularities of a chosen affine chart. The factor t^10 in the norm
is even, not ten additional branch points.

Moreover F=2(t²+2)(t²+2t+4)(t²+3t+4), with all three quadratic
factors irreducible over F_5. Hence all six roots and all fifteen
nonzero geometric J(B)[2] classes are over F_25. Cartier in the basis
dt/v,t dt/v is diag(0,1), confirming γ(B)=1.

## 6. The actual twist boundary and retained evidence

For EITHER reflection, every connected unramified double B'→B gives
[the actual two-leg construction](120_TANGO_FIXED_STRUCTURES_UNDER_UNRAMIFIED_TWISTING.md):
W=Y×_B B' is smooth connected of genus eleven, and its product-involution
quotient X has genus six; W→Y and W→X are etale doubles.
The ten pulled-back Tango structures remain distinct and are permuted
without fixed points by the X-deck involution, so none descends to X.
This alone does NOT exclude additional Tango structures on W or X.
The selected [zero-Tango twist theorem](HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO.md)
supplies the separate exhaustive calculation, not an inference from that
permutation argument.

All linked executable certificates are retained unchanged in mathematical
content. The ten-count, reflection and quotient scripts replayed PASS
2026-09-08; this is regression evidence, not a new independent audit.
No claim about novelty of the exact count in the literature is made.
