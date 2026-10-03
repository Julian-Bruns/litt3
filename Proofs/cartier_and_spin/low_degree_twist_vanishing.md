# Proof: sharp line bounds, cubic symmetry and the required higher powers

[Statement](../../Theorems/cartier_and_spin/low_degree_twist_vanishing.md).
All lines and section spaces below are geometric. Write
$\mathbf F_{25}=\mathbf F_5[a]/(a^2-a-3)$ and $[i+5j]=i+ja$.
The actual extension and its rational transition are
\[
0\longrightarrow O_X(-5O)\longrightarrow K\longrightarrow O_X(6O)
\longrightarrow0,\qquad (u,v)\longmapsto(u-ev,v),
\]
where $X:y^3=P(x)$, $\operatorname{ord}_O(x)=-3$,
$\operatorname{ord}_O(y)=-10$ and
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad
e=y^2E,\quad E=\sum_{m=1}^{10}[c_m]x^{-m},\quad
c=(2,16,16,7,1,2,7,1,24,11).
\]
Coefficients of P are in ascending order. The later
[sharp line theorem](small_shift_line_twist_vanishing.md) gives
maximum line degree $-4$, and $H^0(K(3O)\otimes L)=0$ for every
$L\in\operatorname{Pic}^0(X)$. All smaller shifts follow by inclusion.

## Cubic linearization and orbit products

Let $\gamma(x,y)=(x,\zeta y)$, with $\zeta^3=1$, $\zeta\ne1$.
Since $\gamma^*e=\zeta^2e$, the transition satisfies
$T(e)H=HT(\zeta^2e)$ for $H=\operatorname{diag}(\zeta,1)$.
These maps respect both divisor frames and $H^3=1$, so they
linearize K. Divisor twists at O have their natural linearization.

For any degree-zero line L, the orbit sum of a representative
divisor is the pullback of its pushforward to $\mathbf P^1$.
Hence $L\otimes\gamma^*L\otimes\gamma^{2*}L\simeq O_X$.
A nonzero section of $\operatorname{Sym}^mK\otimes L$ therefore has
a nonzero orbit product in $H^0(\operatorname{Sym}^{3m}K)$.
The generic symmetric algebra $k(X)[u,v]$ is an integral domain;
no factorial or representation semisimplicity enters this argument.

## The quadratic calculation has only one character

A nonzero section of $\operatorname{Sym}^2K(O)$ is a symmetric
map $K^\vee\to K(O)$. It cannot have generic rank one: its image
would be a line quotient of $K^\vee$, of degree at least four,
whose saturation in $K(O)$ has degree at most minus three.
Thus its determinant is nonzero.

The determinant lies in $H^0((\det K)^2(2O))=H^0(O_X(4O))$.
The affine determinant frame has character $\zeta^2$, and
$H^0(O_X(4O))=\langle1,x\rangle$ has invariant coefficients.
A section of character $\zeta^j$ has determinant character
$\zeta^{2j}$; consequently $2j=2$ modulo three. Since C3 has
order prime to five, every section splits into eigensections.
Every nonzero eigensection has a nonzero determinant, so only
$j=1$ can occur.

Write an affine section as $(f_0,f_1,f_2)$. Its infinity
coordinates and bounds are
\[
g_0=f_0-ef_1+e^2f_2,\quad g_1=f_1-2ef_2,\quad g_2=f_2,\qquad
\operatorname{ord}_O(g_i)\ge(9,-2,-13)_i.
\]
Character one and the last bound force $f_2=yh$, $\deg h\le1$;
the polynomial $p(x)$ part of the older calculation is absent.
The middle bound gives $f_1=b+2(PEh)_+$, $b\in k$.
The first bound cancels the polynomial part of
$y^2V$, where $V=bE+2E(PEh)_+-PE^2h$, leaving $g_0=-y^2V_-$.
The coefficients of $-V$ at $x^{-1},x^{-2},x^{-3}$ must vanish.
On $(b,h_0,h_1)$ they are
\[
\begin{pmatrix}[3]&[24]&0\\[14]&[14]&[8]\\[14]&[9]&1\end{pmatrix},
\qquad \det=[18]\ne0.
\]
This is a three-coefficient identity in the displayed P and E,
not an exhaustive matrix construction. It forces $b=h=0$,
and then the first bound forces $f_0=0$.

## The higher symmetric powers needed for all twists

For power n, polynomial affine coordinates satisfy
\[
g_i=\sum_{j=i}^n\binom ji(-e)^{j-i}f_j,\qquad
\operatorname{ord}_O(g_i)\ge5n-11i.
\]
Set $d_i=-5n+11i$ and
$R_i=\sum_{j>i}\binom ji(-e)^{j-i}f_j$.
Descending in i, write $f_i=h_i-(R_i)_+$; the free monomials
of $h_i$ are $x^my^r$ with $m\ge0$, $0\le r\le2$,
$3m+10r\le d_i$. The remaining equations are the coefficients
of $R_i$ with $m<0$ and $3m+10r>d_i$. Distinct pairs $(r,m)$
have distinct valuations, so this reconstructs EVERY section.
The characters $r-i\bmod3$ split each exact system.

| n | Full matrix | Character blocks | Full-column determinant codes |
| --- | --- | --- | --- |
| 6 | 89 by54 | 27 by19;30 by18;32 by17 | [5],[21],[24] |
| 9 | 158 by123 | 51 by43;55 by43;52 by37 | [2],[10],[13] |
| 12 | 248 by222 | 81 by76;82 by73;85 by73 | [12],[5],[21] |

The [sixth-power source](../../scripts/arithmetic/pro_quadratic_twist_vanishing.py),
[ninth-power source](../../scripts/arithmetic/k_cubic_twist_vanishing.py)
and [twelfth-power source](../../scripts/arithmetic/k_quartic_twist_vanishing.py)
construct the entries, labels and selected rows. Restricted-scalar
elimination independently gives total F5 ranks108,246,444;
the twelfth-power block ranks are152,146,146.
Their required certificates remain in
[the external evidence](../../../litt3-computation-data/overnight_three_replies_20260926/).
Thus all three section spaces vanish after EVERY field extension.
The orbit product proves all geometric degree-zero-twist vanishing
for $\operatorname{Sym}^mK$, $m=2,3,4$.

## The shifted cubic is a restriction of the later required space

Retain also the useful assertion $H^0(\operatorname{Sym}^3K(3O))=0$.
The later sharp-line proof already requires the COMPLETE ten-section
basis of $H^0(\operatorname{Sym}^3K(9O))$, with seven character-zero
sections $s_0,\ldots,s_6$ and three character-one sections
$t_0,t_1,t_2$. It is stored in
[k_original_shift3_cubic_sections.json](../../../litt3-computation-data/overnight_three_replies_20260926/k_original_shift3_cubic_sections.json)
and reconstructed by
[the section source](../../scripts/arithmetic/k_symmetric_section_space.py).
Its established full-space rank is reused.

The smaller space is the kernel of restriction to 6O. In the SAME
rational frames its bounds are
$\operatorname{ord}_O(g_i)\ge(12,1,-10,-21)_i$.
For character zero, the $x^8,x^9$ coefficients of $g_3$ first
kill $s_5,s_6$. On $s_0,\ldots,s_4$, the forbidden coefficients
$(g_0,x^{-2}),(g_0,x^{-3}),(g_1,yx^{-2}),
(g_1,yx^{-3}),(g_2,y^2x^{-2})$ have matrix
\[
\begin{pmatrix}
[17]&[7]&[5]&[14]&[2]\\
[18]&[11]&[16]&[23]&[13]\\
[12]&[6]&[10]&[11]&[22]\\
[13]&[22]&[21]&[23]&[20]\\
[20]&[6]&[12]&[8]&[19]
\end{pmatrix},\qquad\det=[10]\ne0.
\]
For character one, the forbidden coefficients
$(g_2,x^5),(g_2,x^4),(g_3,yx^5)$ on $(t_0,t_1,t_2)$ give
\[
\begin{pmatrix}0&0&1\\0&1&0\\[20]&[12]&[23]\end{pmatrix},
\qquad\det=[5]\ne0.
\]
Their valuations violate the smaller bounds individually, and
distinct monomials cannot cancel. Hence restriction is injective,
proving the shifted cubic claim without its old32-by18 reconstruction.
The weaker K(O) twist consequence already follows directly from
the sharp K(3O) theorem.

## One semi-invariant argument covers all rank-three cases

Let a finite rank-three coefficient R surject onto K and let
$T\to\operatorname{Sym}^mR$ be a nonzero finite character line.
On a connected finite Galois étale cover $h:D\to X$ trivializing
R and T, it is a fixed nonzero homogeneous plane polynomial Q.
If its image vanished, every projective line
$\mathbf P((h^*K)^\vee_t)$ would lie in V(Q).
A nonzero plane polynomial has finitely many line components.
Connectedness therefore makes this Grassmannian morphism constant,
which would make the actual subbundle $(h^*K)^\vee\subset O_D^3$
trivial. Its degree is $-\deg h$, a contradiction.
Thus the semi-invariant has nonzero image in
$\operatorname{Sym}^mK\otimes T^{-1}$.

This works for every positive m, even for nonreduced Q and
five-divisible finite monodromy. For irreducible R every nonzero
map is surjective by [finite-coefficient generation](finite_coefficient_generation.md).
The twist vanishings exclude m=1,2,3,4. A projectively orthogonal
pairing supplies the degree-two semi-invariant, and three permuted
lines supply the degree-three monomial. A self-dual odd-rank form
is symmetric by Schur's lemma. These are applications of the SAME
restriction argument, so their separate dimension proofs are unnecessary.

Finally, if an irreducible rank-four coefficient permutes four
lines, a nonzero map to K is surjective and no line has identically
zero image: equivariance would kill its transitive orbit.
Their product is a nonzero degree-four finite semi-invariant,
contrary to quartic twist vanishing. Two permuted rank-two blocks
are not covered, and no original common-cover decision follows.
