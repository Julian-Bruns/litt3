# Fixed-line exclusions and the full strict-return reduction

Integrated 24 September 2026. This supplies the additions in version4 of
[the return-geometry theorem](../../Theorems/cartier_and_spin/rank_three_extension_return_geometry.md).
It uses the already proved extension geometry and its exact stability
surface; it does not replace them with numerical stability tests.
The unchanged full returned proof is retained in
[the original report](../../../litt3-computation-data/degree_six_actual_return_20260924/originals/return/actual_strict_second_return_partial/REPORT.md).

## Exact fixed-line equations

Use the original extension coordinates and rational transition
\[
G=\begin{pmatrix}1&-u&-v\\0&1&-e\\0&0&1\end{pmatrix},
\qquad (d_1,d_2,d_3)=(-1,-5,6).
\]
For \(q=5\) or25 set \(U=u^q,V=v^q,E=e^q\), including coefficient
Frobenius. A map \(F^{\log_5q*}R_\xi\to\mathcal O(dO)\) has affine
row \((n,a,b)\) and infinity row
\[
(n,\ a+Un,\ b+E(a+Un)+Vn).
\]
In the cases below all maps have the unique form
\[
\begin{aligned}
n&\in L_{d+q},&t&\in L_{d+5q},\\
a&=t-(Un)_+,&
b&=-(E(t+(Un)_-)+Vn)_+,
\end{aligned}
\]
with residual equation \([E(t+(Un)_-)+Vn]_{d-6q}=0\).
Here \(L_a=H^0(\mathcal O(aO))\), and positive and negative parts use
the reduced basis \(x^iy^j,\ 0\le j\le2\), of pole weight \(3i+10j\).
The infinity conditions on the first two entries give exactly the
listed spaces. The third has no free global term in these cases.

The constant coefficient map in \(t\) has the following exact sizes
and full column ranks:

| q,d | dim n | dim t | residual rows | eliminated residual rows |
| --- | ---: | ---: | ---: | ---: |
| 5,-1 | 2 | 16 | 39 | 23 |
| 5,0 | 2 | 17 | 38 | 21 |
| 25,-1 | 16 | 116 | 159 | 43 |

Thus \(t\) is recovered by a left inverse. The remaining first-pullback
system, with \(n=s+tx\) and \(\eta_i=\xi_i^5\), is a polynomial pencil
\((sN_0+tN_1)\eta=0\). It splits into coordinate blocks
\((0,6,7)\), \((1,\ldots,5,8,\ldots,12)\), and \((13,\ldots,18)\).

For target \(\mathcal O(-O)\), these blocks have sizes8-by-3,
11-by-10 and4-by-6 and constant maximal ranks on all of P1.
Polynomial minors and Bezout combinations check the affine chart;
infinity is checked separately. The last block has a basis of two
quadratic syzygies. Their six coefficient vectors are independent.
Inverse coefficient Frobenius gives exactly the matrix M in the
statement and the O(1,2) scroll parametrization. A stacked pencil has
rank19, so each nonzero parameter point determines a unique \([s:t]\)
and a one-dimensional fixed-target Hom space.

## Stability and all-period exclusion

The previously proved surface \(\Sigma\) is reconstructed through its
actual dual evaluation sections. Its intersection with the pure-v P5
consists of the ten finite cubic branch evaluations. The infinity
line of \(\Sigma\) is disjoint from that P5. After the invertible M
coordinate change, the scroll is cut out by the six minors of
\[
\begin{pmatrix}z_0&z_1&z_3&z_4\\z_1&z_2&z_4&z_5\end{pmatrix}.
\]
Substituting a branch evaluation into one of these equations gives a
polynomial coprime to P. The explicit Bezout identity checks all ten
geometric branch points at once. Hence the entire scroll is stable.

A nonzero first-pullback map to \(\mathcal O(-O)\) has image of negative
degree. If \(F^{r*}R=R\) for any \(r>0\), pull that map to a multiple
of r to obtain a negative quotient of the semistable R, impossible.
The same argument with target \(\mathcal O\) contradicts stability
for every stable member of the zero-line locus. It does not give this
conclusion for a strictly semistable member of that locus.

For target \(\mathcal O\), the first coordinate block drops rank only
at zero. The middle block determinant is
\(r^2(r-[24])g_3(r)g_4(r)\), with \(g_3,g_4\) as in the statement.
Two size-nine minors have a Bezout combination equal to one, so its
rank never falls below nine. It has rank ten at infinity. The factors
are irreducible, separable, and coprime. At zero the full pencil kernel
has dimension four; at each of the eight nonzero roots it has dimension
three; elsewhere it is the two-dimensional quadratic kernel already
used for the scroll. Inverse Frobenius gives the P3 and eight P2s.
The rank19 stacked pencil proves their disjointness and uniqueness
of the parameter. These are geometric reduced-set statements; no
unproved scheme multiplicity assertion is needed.

## Full return elimination

The previous sufficient full-morphism system is retained, not replaced
by the quotient test. Write \(c=(f,\alpha)\) for its35 initial
coefficients, \(y=(g_0,q_0)\) for235, \(s=s_0\) for16, and \(t=t_0\)
for116. The lower constant coefficient matrix A has size315-by-235
and rank235. Let \(S_A\) be its checked left inverse and \(L_A\) its
80-row left annihilator. Then
\[
y=\sum_j\eta_jD_jc,\qquad
\sum_j\eta_jT_jc=0,\qquad \eta_j=\xi_j^{25},
\]
with \(D_j=-S_AB_j\) and \(T_j=L_AB_j\).

The upper constant matrix has size159-by-116 and rank116, with
checked left inverse \(S_N\) and43-row annihilator \(L_N\).
After the lower recovery the upper residual is
\[
\sum_{i,j}\xi_i\eta_j C_{ij}c+\sum_j\eta_jQ_js=0.
\]
All mixed coefficients are constructed from the original Laurent
transition, so target variables remain \(\xi_i\) while source variables
are \(\eta_j\). Setting both equal without Frobenius would be wrong.
The upper left inverse then recovers t uniquely. These two reversible
eliminations prove equality of the kernel of the displayed123-by-51
matrix with the full global Hom space. They are valid also where
the remaining matrix drops rank.

The original nine entries of the full morphism at a fixed regular
point are retained as linear forms in (c,s), with polynomial parameter
coefficients. Their determinant is the global determinant: both source
and target determinants are trivial on the proper curve. A nonzero
determinant gives an isomorphism everywhere. Conversely any return
occurs in this system, and its determinant may be normalized to one
over the algebraically closed field. Stability is imposed by removing
the specified whole surface \(\Sigma\), not by removing a finite
set of sampled points.

At the two supplied regression points, the reduced kernels have
dimension four. The recovered rational matrices satisfy the actual
transition and all nine infinity bounds. Their four-dimensional spans
factor globally through \(\mathcal O(-5O)\), followed by the four
sections of \(R(5O)\). Hence every map is singular there, despite
nonzero quotient morphisms.

## Executed verification and remaining decision

The local rebuild independently regenerated the quotient tensors, all
361 mixed blocks, both recovery arrays, every evaluation array, dual
stability sections, fixed-line pencils and polynomial rank witnesses.
It reconstructed the full global morphisms at both regression points.
All checks passed; the complete output is in
[the focused audit](../../Research/audits/DEGREE_SIX_ACTUAL_RETURN_FOCUSED_2026_09_24.md).
Unchanged source is retained in
[the return source directory](../../scripts/arithmetic/pro_degree6_actual_return_20260924/return).

The resulting determinant-one equations on the stable complement
have not been solved. In particular, classifying these fixed-target
line loci does not classify every possible Frobenius destabilization.
The stable strict second-return set is still undecided. Neither a
finite coefficient nor a common cover is constructed by the reduction.
