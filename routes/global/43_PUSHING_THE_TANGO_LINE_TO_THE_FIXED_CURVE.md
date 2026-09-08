# Tango pushdown: exact constraints and geometric escape models

Version 2, 2026-09-08: repeated pushdown and Kummer proofs combined;
the distinct statements and examples are retained. The original evidence
is COMPOSITE PASS, 2026-09-04: coordinator /root/tango_line_c7_descent,
independent checks by explicit_bx_segre and rank4_cartier_escape.
This was a split check of the two escape branches and shared numerical
backbone, not one end-to-end audit:
[audit metadata](audits/43_TANGO_PUSHDOWN_AUDIT.md).
No new independent audit is claimed.

This is the OLD auxiliary pair over k=Fbar_5, NOT the current fixed pair:

\[
 X:v^2=t^7-t+1,\qquad Y:y^{31}=x(x-1),\qquad
 V\xrightarrow[\;7\;]{\pi}C\xrightarrow[\;M\;]{c}X,\quad
 a:V\xrightarrow[\;M\;]{}Y .
\]

All maps are ACTUAL finite etale, with the SAME smooth projective V;
M≥2, g(C)=2M+1, g(V)=14M+1. The cyclic cover π has generator β,
and the triangle function x∘a is not β-invariant, as supplied by the
[equal-degree diamond](38_COPRIME_DESCENT_THROUGH_THE_CYCLIC_ATLAS.md).
Write h=cπ. Frobenius twists are suppressed in divisor notation only;
bundles B_T=F_(T,*)O_T/O_(T^(1)) live on T^(1).

The outcome is a small list of possible image ranks/degrees, NOT a
contradiction. The norm lives in Sym^7(B_C), not B_C; genuine rank-three
and formal rank-four escape models survive. The special global origin
from the triangle function must still be used.

## 1. Exact line and a common pushdown calculation

Let B_0,B_1,B_∞ be the reduced degree-M inverse images under a of the
three ramification points of Y→P¹. The triangle divisor calculation gives

\[
 \operatorname{div}(dx)=30B_0+30B_1-32B_\infty
                      =5D_x+3B_\infty,\qquad
 D_x=6B_0+6B_1-7B_\infty,\quad\deg D_x=5M .
\]

The saturated exact line L_x=k(V)^5dx∩B_V is O_(V^(1))(D_x):
a local coefficient u belongs precisely when u^5dx is regular.
For the first canonical Frobenius quotient ρ_T:F_T^*B_T→ω_T,

\[
 \rho_V(F_V^*L_x)=\omega_V(-3B_\infty).                 \tag{1}
\]

We use the [Cartier pairing, stability and filtration](22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md):
B_T is stable of slope g(T)−1, has alternating pairing into ω_(T^(1)),
and F_T^*B_T has filtration I⊃I²⊃I³⊃I⁴⊃0 with
I^i/I^(i+1)=ω_T^i. Its connection is the QUOTIENT connection on
F_T^*F_(T,*)O_T/O_T, not restriction of the connection to the evaluation
ideal.

Here is the pushdown argument used throughout. For an ACTUAL finite
etale f:U→T and a line L on U^(1), finite-etale adjunction sends
L→f^(1)*B_T to f^(1)_*L→B_T. After a Galois closure of THIS ONE MAP,
the source splits as all conjugate pullbacks of L, and the adjoint is
the sum of their inclusions. These lines have equal degree, even after
every Frobenius pullback; faithfully flat descent proves strong
semistability. Etale Riemann–Hurwitz and Riemann–Roch give

\[
 \operatorname{rk}f_*L=\deg f,\quad \deg f_*L=\deg L,
 \quad \mu(f_*L)=\deg L/\deg f.                         \tag{2}
\]

No simultaneous Galois closure of the two legs is assumed. For first
quotient images ω_U(−R_s), their sum has the coefficientwise minimum
of the sheetwise residual divisors as zero divisor.

## 2. Cyclic orbit, first quotient and norm

Let S_C be the torsion-free image of π^(1)_*L_x→B_C, with rank r
and degree d. Pulling back gives ⊕_(j=0)^6 β^(j*)L_x→B_V. By (2),
the rank-seven source has degree 5M and slope 5M/7, so

\[
 d\ge5Mr/7,\qquad d<2Mr\ (r<4),\qquad d\le8M\ (r=4).   \tag{3}
\]

This is Proposition 43.10 in the audited revision. Rank one holds
EXACTLY when the embedded saturated line L_x is β-invariant: saturated
lines sharing a generic line are equal. In that case it descends,
7 divides5M and hence M, and (1) forces β^*B_∞=B_∞. Invariance of
B_∞ alone is not asserted sufficient. Section 5 gives cyclic exact-line
orbits of ranks 2,3,4, so no representation-theoretic rank-one rule applies.

Put G=min_j β^(j*)B_∞=π^*G_C and a_0=deg G_C≤M/7. Summing
the image ideals in (1) gives the EXACT quotient and kernel degree

\[
 \operatorname{im}(F_C^*S_C\to\omega_C)=\omega_C(-3G_C),
 \qquad \deg K_C=5d-4M+3a_0.                            \tag{4}
\]

Since K_C⊂I², its HN bound yields, for r=1,2,3,4 respectively,

\[
 5d\le 4M-3a_0,\quad20M-3a_0,\quad32M-3a_0,\quad40M-3a_0.
\]

These are compatible with (3). The line quotient in (4) of the
semistable F_C^*π_*L_x has slope≥25M/7; this says only a_0≤M/7.

For N_C=Nm_(V^(1)/C^(1))(L_x), multiplication of the seven conjugate
line inclusions descends to a NONZERO map

\[
 N_C\longrightarrow\operatorname{Sym}^7B_C,\qquad
 \deg N_C=5M,\qquad\operatorname{Hom}(N_C,B_C)=0.         \tag{5}
\]

This uses symmetric multiplication, not division by7!. The Hom
vanishing follows because B_C⊗N_C^(-1) is stable of slope−3M.
If D_∞=π_*B_∞, the product of (1) retains the exact residual divisor:

\[
 F_C^*N_C\simeq\omega_C^7(-3D_\infty),\qquad
 \det(\pi_*L_x)\simeq N_C.                              \tag{6}
\]

The first equality pulls back to zeros3∑_jβ^(j*)B_∞ and has degree25M.
For the second, π_*O_V=⊕_(i=0)^6η^(-i), η^7=O, so
detπ_*O_V=η^(-21)=O. Thus the norm is the determinant of the
rank-seven SOURCE, not a subline of its rank-four target.

## 3. Pushdown to X: exact rank and Frobenius-position restrictions

Set E=h^(1)_*L_x and S=im(E→B_X), of rank r and degree d.
Equation (2) gives E strongly semistable, rank 7M, degree 5M and slope 5/7.
Moreover F_X^*S→ω_X is SURJECTIVE. Otherwise, after a one-leg Galois
closure, all sheet-pullbacks of B_∞ would contain one point. This would
put the full reduced h-fiber of 7M points in B_∞ of degree M.

The precise alternatives (Theorem 43.26) are

| r | Possible d |
|---|---|
| 2 | 2 |
| 3 | 3 or4 |
| 4 | 3,4,5,6,7 or8 |

Indeed d/r≥5/7; stability of B_X, of slope2, gives d≤2r−1
for r<4, and d≤8 for r=4. Let H=F_X^*S. Its quotient ω_X has
kernel K_2 of degree 5d−4. Rank one would require5d=4, impossible.

For r=2 or3, the second fundamental form K_2→ω_X² is nonzero:
otherwise K_2 would be horizontal, forcing its degree divisible by5,
whereas5d−4≡1 mod5. For r=2 this gives5d−4≤8, hence d=2.
For r=3 write its image Q_2=ω_X²(−D_2), e=deg D_2. Its line kernel
K_3 has degree5d−12+e and second fundamental form
K_3→Q_2⊗ω_X. If zero, K_3 descends to a line of S⊂B_X.
Every line in B_X has degree≤floor(degω_X/5)=0 by its saturated
exact-differential divisor, contradicting deg K_3≥3. Therefore

\[
 5d+2e\le24,\qquad
 (d,e)=(3,e\le4)\ \text{or}\ (4,e\le2).                 \tag{7}
\]

For r=4 the four induced line quotients are
ω_X, ω_X²(−D_2), ω_X³(−D_3), ω_X⁴(−D_4).
Writing e_i=deg D_i, the nonzero oper maps and total degree give

\[
 0\le e_2\le e_3\le e_4,\quad
 e_2+e_3+e_4=5(8-d),\quad e_2\le4,\quad e_2+e_3\le13. \tag{8}
\]

For the last two bounds, the bottom rank-two and rank-three quotients
have degrees12−e_2 and24−e_2−e_3 and are quotients of the semistable
F_X^*E of slope25/7. This is Corollary 43.37.

Every d∈{3,…,8} in the r=4 branch has an actual LOCAL-LATTICE model
S_d⊂B_X satisfying the first projection and (8), with defects
(0,0,5(8−d)); it need not be the special image of h_*L_x.
At one point choose s on X^(1), F_X^*s=t^5, and the horizontal frame
e_i=[t^i], 1≤i≤4. Replace its lattice by

\[
 \mathcal Oe_1+\mathcal Oe_2+\mathcal Oe_3+
                  \mathcal O s^{\,8-d}e_4.             \tag{9}
\]

Its colength is8−d. The first quotient e_i↦it^(i−1)dt stays
surjective via e_1. The triangular unit-diagonal change to the
diagonal-ideal frame leaves the second and third graded lattices
unchanged, multiplying the fourth by t^(5(8−d)). This proves the
full-rank models of Proposition 43.40.

## 4. Rank three: an exact pairing condition and a genuine base example

For the saturation S̄ of a rank-three S, let A=S̄^⊥ under the Cartier
pairing. Perfectness gives deg A=deg S̄−4, hence deg S̄≤4 by the
line bound just used. This independently verifies the rank-three bound.
Choosing a separating u∈k(X) whose exact line is A, the original
inclusion L_x→h^*S̄ forces

\[
 \operatorname{Cartier}(u\,dx)=0.
\]

In the p-basis expansion x=b_0^5+b_1^5u+⋯+b_4^5u^4 in k(V),
Cartier(u dx)=4b_4du. Thus b_4=0 is a GENUINE extra equation;
it has not been ruled out by the rank/degree table.

The following criterion supplies the explicit escape (Proposition 43.47).
On ANY smooth projective curve T in characteristic 5, let A⊂B_T be the
saturated exact line of a separating u, with

\[
 \operatorname{div}(du)=5D+R,\quad
 D=\lfloor\operatorname{div}(du)/5\rfloor,\quad A=O(D).
\]

All coefficients of R lie in{0,1,2,3}. Then

\[
 \deg A^\perp=2g(T)-2+\deg A,\qquad
 F_T^*A^\perp\to\omega_T\ \text{surjective}
 \Longleftrightarrow R\text{ has no coefficient 3}.      \tag{10}
\]

Proof. If ord(du)=5m+r, the first non-fifth-power Laurent term of u
has exponent5m+r+1, so r≤3. After normalization, the fiber of F_T^*A
has leading diagonal-ideal position s=r+1 in I^s/I^(s+1).
The pulled-back pairing pairs the ith and (5−i)th graded lines perfectly,
so (I²)^⊥=I⁴. The rank-three first projection fails exactly when
F_T^*A^⊥ has fiber I², equivalently F_T^*A has fiber I⁴, or r=3.
Finally B_T/A^⊥=A^∨⊗ω_(T^(1)) gives the degree formula.

For X above, set P_±=(0,±1), Q=(−1,−1) and

\[
 u=\frac{(t+3)v+3t+2}{t^2},\quad
 \operatorname{div}(du)=-4\infty-3P_-+P_++10Q .
\]

A direct certificate is

\[
 du=\frac{A+(2t+1)v}{t^3v}\,dt,\quad A=2t^7+3t^2+t+4,
 \quad A^2-(2t+1)^2(t^7-t+1)=4t^4(t+1)^{10}.
\]

At t=0 the numerator orders on the two sheets are4 and0, giving
orders1 at P_+ and−3 at P_−; at t=−1 it vanishes to order10
only at Q. The infinity order is−4. Thus

\[
 D=-\infty-P_-+2Q,\qquad R=\infty+2P_-+P_+ .
\]

The degree-zero A=O(D) is an ACTUAL embedded exact line, and A^⊥
is an ACTUAL rank-three degree-four subbundle of B_X. Formula (10)
makes its first Frobenius projection everywhere surjective. This
does not construct the special pushforward E or a second etale leg.

## 5. Generic trace coordinates, cyclic full rank and determinants

For any actual finite etale π:V→C with fields K/L and separating
u∈L, write dq=∑_(i=1)^4 c_i d(u^i), c_i∈K^5. Trivializing
the exact line at the generic point, finite-etale adjunction is

\[
 \lambda\longmapsto
 \sum_{i=1}^4\operatorname{Tr}_{K^5/L^5}(\lambda c_i)d(u^i).
\]

The nondegenerate separable trace pairing proves its rank is exactly
dim_(L^5)span{c_1,…,c_4} (Proposition 43.53).

For a connected etale cyclic-seven extension K=L(w), w^7=a,
βw=ζ_7w, take q=∑_(i=1)^4w^(5i)u^i. Four translates of dq have
determinant, up to nonzero constants,

\[
 \Bigl(\prod_{i=1}^4 w^{5i}\Bigr)
 \prod_{1\le i<j\le4}(\zeta_7^{5j}-\zeta_7^{5i})\ne0.   \tag{11}
\]

Truncation yields ranks 2 and3. In the exact basis d(u^i), the Cartier
pairing is j du when i+j=5 and zero otherwise, with Pfaffian
4·3=2≠0. Thus the pairing also allows full rank. The arithmetic
order ord_7(5)=6 does not impose a rank-one-or-rank-six alternative:
the action here is semilinear over K^5/L^5, the chosen line has no
supplied Frobenius invariance, and a constant extension may fix all
characters. The Kummer q is NOT asserted to satisfy the global triangle
divisors or define an etale map to Y.

There is no extra determinant parity. In rank four put
det S=ω_(X^(1))²(−T), R_E=ker(E→S), and
δ_h=det(h^(1)_*O_(V^(1))), with δ_h²=O by the perfect trace pairing.
Norms and (1) give, keeping the Frobenius twists explicit,

\[
 F_X^*\det R_E\simeq
 \omega_X^{7M-10}(-3h_*B_\infty+F_X^*T)\otimes F_X^*\delta_h.
                                                               \tag{12}
\]

This controls only the otherwise unconstrained kernel determinant.
The Pfaffian of the restricted form on S is the determinant inclusion:
as a section of O(T), its divisor is T, with NO evenness requirement.

## 6. The actual four-power frame retains the triangle boundary

Unlike the generic example, the original triangle function satisfies

\[
 \operatorname{div}(x)=31(B_0-B_\infty),\qquad
 \operatorname{div}(x-1)=31(B_1-B_\infty).                \tag{13}
\]

On Y, the saturated lines L_i of d(x^i), 1≤i≤4, have

\[
 \operatorname{div}(d(x^i))
  =(31i-1)P_0+30P_1-(31i+1)P_\infty,
 \quad L_i=O(6iP_0+6P_1-(6i+1)P_\infty),\quad\deg L_i=5.
\]

Their first-quotient residual divisors are
(i−1)P_0+(4−i)P_∞. They form a generic basis; the four distinct
residual orders give a unit determinant at P_0 and P_∞, and away
from the three branch fibers x is etale. Comparing

\[
 \sum_i\operatorname{div}(L_i)=60P_0+24P_1-64P_\infty,
 \qquad\det B_Y=\omega_Y^2=O(60P_0+60P_1-64P_\infty)
\]

therefore gives the EXACT determinant divisor 36P_1. After pulling
to V and pushing through h, the resulting map

\[
 h^{(1)}_*\bigl(a^{(1)*}(\bigoplus_{i=1}^4L_i)\bigr)
                       \twoheadrightarrow B_X         \tag{14}
\]

is surjective: a common determinant zero for all sheets would put
an entire 7M-point h-fiber in B_1 of degree M. By (2) its source
is strongly semistable of rank 28M, degree 20M and slope 5/7.
This proves a genuine global surjection for the four-power sum,
NOT rank-four image for the single summand h_*L_1.

For L_(j,i)=β^(j*)a^*L_i, equality of two embedded lines forces
equality of the residual divisors
(i−1)B_(0,j)+(4−i)B_(∞,j). All fourteen with i=2,3 are pairwise
distinct. A same-power equality preserves B_0 and B_∞, so replaces
x by λx; its branch values {0,1,∞} force λ=1, contrary to the
diamond's noninvariance. Equality between powers2 and3 would make
an order-seven element interchange B_0 and B_∞, impossible.
For powers1 or4, a collision can imply only invariance of one divisor
(and hence7|M) or transport B_0 to B_∞; no collision is forced.

Finally degree 5M is below the ABSOLUTE Tango upper bound

\[
 \left\lfloor\frac{2g(V)-2}{5}\right\rfloor
                    =5M+\lfloor3M/5\rfloor\quad(M\ge2).
\]

This numerical comparison does not assert n(V) attains that upper bound
or prove these lines nonmaximal for V's actual Tango invariant.
Consequently maximal-line or dormant-oper uniqueness cannot be invoked
without its precise extra hypotheses. The explicit escapes above refute
only shortcuts using ranks, slopes, generic trace or Pfaffian data;
they do not decide the actual seven-diamond or the common-cover problem.
