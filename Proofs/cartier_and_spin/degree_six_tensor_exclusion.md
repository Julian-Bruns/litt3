# Two-end exclusion of the degree-six models

Integrated 24 September 2026. This proves the emptiness assertion in
[the degree-six theorem](../../Theorems/cartier_and_spin/degree_six_new_line_models.md).
The earlier proof there establishes the exact reconstruction of both
etale maps. The present argument needs only its pole conditions and two
tensor identities. It does not assume an extra ramification profile.

The unchanged returned report and certificates are preserved in
[the evidence directory](../../../litt3-computation-data/degree_six_actual_return_20260924/originals/degree6/degree_six_tensor/REPORT.md).
The complete local replay passed. This proof records the geometric
exhaustiveness argument and the precise finite algebra it requires.

## Fields and the forced jets

Use \(F=\mathbf F_{25}\), \(\beta^2-\beta-3=0\), with ascending
coefficient codes \(a_0+5a_1=a_0+a_1\beta\). The fixed rows are
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\qquad A=(1,21,14,22,13).
\]
The polynomial \(A\) is irreducible of degree four; its monic row is
\((5,2,6,7,1)\). Let \(K=F(\alpha)\), with roots
\(\alpha_i=\alpha^{25^i}\). Put
\[
H=A'^3P^2\bmod A=(3,21,7,14),\qquad C=3/A_4^3=[14].
\]
The four \(H(\alpha_i)\) are nonzero and pairwise distinct. Since
\(\gcd(29,25^4-1)=1\), define
\[
h_i=(CH(\alpha_i))^{67349},\quad
f_i=A_4h_i^4/A'(\alpha_i),\quad
g_i=h_if_iJ_i,\quad \ell_i=f_i^2K_i,
\]
where \(J_i=(P'/P-A''/A')(\alpha_i)\) and
\(K_i=(4P'/P+3A''/A')(\alpha_i)\). The exponent 67349 is the inverse
of 29 modulo \(25^4-1\). All these constants belong to \(K\).

Choose a primitive 29th root \(\zeta\). Its degree over \(F\) is seven;
one irreducible defining row is \((4,5,22,21,20,24,9,1)\).
Consequently \(K\) and \(F(\zeta)\) are linearly disjoint. Exact boundary
calculations take place in their compositum, with basis
\(\alpha^i\zeta^j\), \(0\le i<4,0\le j<7\). This restricts only the
forced boundary constants, not arbitrary coefficients of a putative
curve.

At a point over \(s=0\), write \(X=x_1,\ Y=s^3x_2\), and \(D=Y(0)\ne0\).
The quartic identity forces \(X(0)=\alpha_i\) and
\[
X=\alpha_i+\eta s+X_2s^2+O(s^3),\qquad
\eta=\kappa^{-6}A_4D^4/A'(\alpha_i).
\]
The differential identity, with denominators cancelled, is
\[
\kappa^{21}(sY'-3Y)^3P(X)^2=X'^3P_h(Y,s^3)^2.
\]
Its constant and next coefficients, together with the quartic identity,
give
\[
D^{29}=\kappa^{39}CH(\alpha_i),\qquad
Y_1=D\eta J_i,\qquad X_2=\eta^2K_i.
\]
The same calculation at infinity swaps the two legs and replaces
\(s,\kappa\) by \(s^{-1},\kappa^{-1}\). These coefficient identities
were also verified symbolically.

Write \(m=2-g\). Necessarily \(d_*(0)\ne0\) and \(b_{*,m}\ne0\).
For example, if \(d_*(0)=0\), both zero branches have the same \(D\).
Injectivity of \(H\) on the four roots and the jet identities force
their \(X\)-expansions to agree through order two. Their difference
is \(2b_*(s)w(s)\), with \(w(0)\ne0\). Thus \(s^3\mid b_*\), impossible
for \(0\ne b_*\) of degree at most two. The infinity proof uses the
swapped polynomial \(r^m d_*(1/r)\). This argument does not assume
\(b_*(0)\ne0\) or maximal degree for \(d_*\); repeated endpoint roots
are retained.

## Exhaustive boundary choices

Choose \(\delta^{29}=\kappa^{39}\), and set \(\Lambda=\kappa^{-6}\delta^4\).
Absorb one root of unity in \(\delta\). The remaining choices are four
root indices \(i,j,k,l\) and \(u,t,v\in\mu_{29}\). Define
\[
\begin{aligned}
a&=\alpha_i-\alpha_j,&b&=\alpha_k-\alpha_l,\\
F_0&=h_i-h_ju,&F_1&=f_i-f_ju^4,&
F_2&=g_i-g_ju^5,&F_3&=\ell_i-\ell_ju^8,\\
G_0&=v(h_k-h_lt),&G_1&=v^4(f_k-f_lt^4),&
G_2&=v^5(g_k-g_lt^5),&G_3&=v^8(\ell_k-\ell_lt^8).
\end{aligned}
\]
The branch differences at zero and infinity are
\[
\begin{aligned}
\Delta x_1&=a+\Lambda F_1s+\Lambda^2F_3s^2+O(s^3),\\
\Delta(s^3x_2)&=\delta F_0+\delta\Lambda F_2s+O(s^2),\\
\Delta x_2&=b+\Lambda^{-1}G_1r+\Lambda^{-2}G_3r^2+O(r^3),\\
\Delta(r^3x_1)&=\delta^{-1}G_0+\delta^{-1}\Lambda^{-1}G_2r+O(r^2).
\end{aligned}
\]
Here \(F_0G_0\ne0\). Exactly the tuples \(i=j,u=1\) and \(k=l,t=1\)
are removed. Frobenius permits \(i=0\), leaving 1,534,100 tuples.
Further quotienting by \(25^4\)-Frobenius on \(\mu_{29}\) gives
219,188 representatives. This is exhaustive over the algebraic closure.
The scalars \(\delta,\Lambda\) remain unrestricted.

## Constant and linear ratios

For \(g=2\), \(q=d_*/b_*\) is constant and forces \(F_0G_0=ab\).
Both root pairs are then distinct. Expand
\[
(h_ih_k,-h_ih_l,-h_jh_k,h_jh_l,-ab)
\]
in the four-dimensional \(F\)-basis of \(K\). Its \(4\times5\) matrix
must annihilate \((1,t,u,tu,v^{-1})\). All 144 matrices were reconstructed:
120 have rank four and 24 have rank three. None kills the all-ones
vector. In rank four the normalized kernel vector is defined over \(F\);
its root-of-unity coordinates would all equal one. In rank three the
normalized kernel is an affine line over \(F\), and the condition that
its fourth coordinate is the product of its second and third coordinates
is a nonzero polynomial of degree at most two. A solution in the
degree-seven field \(F(\zeta)\) would be in \(F\), giving the same
contradiction. This also excludes proportional \(b_*,d_*\) in the other
two genera.

For \(g=1\), \(q\) is a ratio of linear polynomials. If \(a\ne0\), the
identity between its two endpoint derivatives and endpoint values forces
\[
(aF_2-F_0F_1)(G_1G_0-bG_2)+(ab-F_0G_0)^2=0.
\]
If \(a=0\), then \(F_1\ne0\) and \(q=q_\infty+q_{-1}/s\). Its constant
and first opposite-end coefficients force
\[
(F_2F_1-F_0F_3)G_0-bF_1^2=0,\qquad
(G_1G_0-bG_2)F_1-F_0G_0^2=0.
\]
The exact direct computation excludes all 1,534,100 tuples. A nonzero
coordinate witness for each of the 219,188 orbits is retained. The first
displayed condition in the repeated-root case already suffices in all
those cases. No arbitrary curve parameter is left in these tests.

## Quadratic ratio and genus zero

Normalize \(z=\Lambda s\) and write \(W^2=z^2+pz+q\), with \(q\ne0\)
and \(\rho^2=q\). Put \(\epsilon=\delta\Lambda^3\). Abbreviate
\[
(c,d,e,f,h,i,j,k)=(F_1,F_2,F_3,F_0,G_0,G_1,G_2,G_3).
\]
Expanding the two degree-two polynomials times \(W\) at both ends gives
the following necessary identities, where \(T=\rho/\epsilon\),
\(N=p/2\), and \(V=N/q\):
\[
\begin{aligned}
c&=Tj-TNh+Va,& d&=Ti-TNb+Vf,\\
e&=Th+Vc+V^2a+a/(2q),&
k&=f/T+Ni+(q/2+N^2)b.
\end{aligned}
\]
These equations use global polynomial degree two, not just formal jets.
If \(p=0\), the first two force \(U_0=jd-ic=0\). The certificate shows
\(U_0\ne0\) for every boundary tuple.

For \(p\ne0\), put \(U=TN\). With
\[
\Delta=hi-bj,\quad
T_n=hd-bc+(ab-hf)V,\quad U_n=jd-ic+(ia-jf)V,
\]
the same certificate gives \(\Delta\ne0\). The first two equations give
\(T=T_n/\Delta,\ U=U_n/\Delta,\ q=U/(TV)\). The other two then imply
that \(V\) is a common root of
\[
\begin{aligned}
R&=2e\Delta U_n-2hT_nU_n-2c\Delta U_nV
       -2a\Delta U_nV^2-a\Delta T_nV,\\
S&=2kT_n^2V-2f\Delta T_nV-2iT_nU_nV
       -2bU_n^2V-bT_nU_n.
\end{aligned}
\]
These have degree at most three. Pad their coefficients to degree three,
write \(c_{ij}=r_is_j-r_js_i\), and form
\[
\mathcal B=
\begin{pmatrix}
c_{10}&c_{20}&c_{30}\\
c_{20}&c_{21}+c_{30}&c_{31}\\
c_{30}&c_{31}&c_{32}
\end{pmatrix}.
\]
The Bezout identity shows that a common root \(v_0\), even after any
field extension and even if the degrees drop, makes
\(\mathcal B(1,v_0,v_0^2)^t=0\). All 219,188 retained records have
\(\Delta\ne0,\ U_0\ne0,\ \det\mathcal B\ne0\). Hence neither branch has
a solution. Denominator clearing is used only as a necessary implication.

## Evidence and scope

The local complete replay checked every finite-field construction,
all 144 genus-two matrices, the unreduced genus-one tuples and their
orbit witnesses, and all 219,188 genus-zero determinant records. It
also checked the symbolic jet identities, 64 independent field products,
and 35 independently recomputed determinant records. The latter are
cross-checks of the exhaustive verification, not replacements for it.

Unchanged source is retained under
[the source directory](../../scripts/arithmetic/pro_degree6_actual_return_20260924/degree6).
The original certificates and the complete local output are linked in
[the focused audit](../../Research/audits/DEGREE_SIX_ACTUAL_RETURN_FOCUSED_2026_09_24.md).
No finite-field search over possible curve coefficients is used.
Together with the already proved lower-degree and pole-degree-three
exclusions this completes recognition through degree six. It does not
solve unrestricted recognition or either original unmarked common-cover
problem.
