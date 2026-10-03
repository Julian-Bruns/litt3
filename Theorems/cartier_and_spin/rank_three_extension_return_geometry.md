# Rank-three extension geometry and a family of false Frobenius-return tests

Version 8, 3 October 2026. Let K be the fixed actual extension
0->O_X(-5O)->K->O_X(6O)->0 on the genus-nine X. For every
T in Pic^0(X), put N=T(-O) and W_T=Ext^1(K,N), of dimension19.
The following statements concern actual bundles and extension classes.

1. Every nonzero class in P(W_T) gives a semistable rank-three
   degree-zero bundle R_xi. Its unique maximal line is N, of
   degree-1, and its quotient map to K is unique up to scalar.
   Every other line subbundle has degree at most-4, by the
   [sharp line-degree theorem](small_shift_line_twist_vanishing.md).
   The strictly semistable locus is a smooth embedded ruled
   surface Sigma_T=P_X(K) of degree35 in P18. Its defining rank-two
   linear system \(A_T=K(17O)\otimes T^{-1}\) has surjective
   restriction \(H^0(A_T)\to H^0(A_T|_D)\), of rank2deg D,
   for every effective base divisor D of degree at most five,
   including repeated points.
2. Any stable rank-three degree-zero E with Hom(E,K)!=0 surjects
   onto K and has one-dimensional Hom(E,K). For every M in Pic^0,
   Hom(E^vee tensor M,K)=0.
3. A strict return F_abs^{r*}R_xi=R_xi requires T^{5^r}=T and
   a one-dimensional kernel in the ACTUAL connecting map
   H^0(F_abs^{r*}K tensor T^-1(O))->H^1(O((1-5^r)O)).
   The first PROJECTIVE return is now impossible for every T and every
   twisting line, by the stronger
   [shifted all-twist vanishing](shifted_first_frobenius_vanishing.md).
   In fact that exclusion applies to any rank-three degree-zero bundle
   surjecting onto K, without stability or a prescribed extension class.
   The second-return section space has dimension11 and its cup
   matrix is sum xi_t^25 B_t, with an exact32x11x19 tensor B.

There is a stable extension R_* with rational transition
\[
T_* =\begin{pmatrix}1&0&-v_*\\0&1&-e\\0&0&1\end{pmatrix},
\quad v_*=y^2(x^{-6}+[18]x^{-4}),
\quad e=y^2\sum_{m=1}^{10}[c_m]x^{-m}.
\]
Its second-return cup matrix has rank10, and the unique lift is
a nowhere-zero section of F_abs^{2*}R_*(O). Nevertheless
\[
\operatorname{Hom}(F_{\rm abs}^{2*}R_*,K)=0.
\]
Thus its actual degree-one quotient is NOT K, and it has no strict
second return. These three passing preliminary tests and the
failure occur on a nonempty four-dimensional locally closed family
inside a reduced septic in the pure-v P5. This is not merely a
single numerical false positive. No assertion about higher periods
or nonperiodicity of that family is made.

The symmetric-invariant strategy has a proved boundary: chi(Sym^mK
tensor L)=(m+1)(m-16)/2, so all-twist vanishing is impossible for
m>=17. Natural primitive nonorthogonal SL3(F_q) modules, q=5^s>=25,
have no symmetric character line in any degree1<=m<q. These are
abstract representation types, not constructed coefficients on X.

The actual quotient test now has the complete form
\[
\operatorname{Hom}(F_{\rm abs}^{2*}R_\xi,K)
=\ker\!\left(\sum_{i=0}^{18}\xi_i^{25}T_i\right),
\quad T_i\in\operatorname{Mat}_{80\times35}(\mathbf F_{25}).
\]
It is reconstructed from the full extension, with
Hom(F_abs^{2*}K,K)=0. Every geometric point of the projective
pencil u=0, v=s y^2x^-6+t y^2x^-4 has zero Hom and hence no
strict second return. Polynomial Bezout identities cover the
whole pencil, including infinity.

The GLOBAL quotient rank-drop incidence is NONEMPTY. In the ordered
extension coordinates, let xi have entries 0..12 zero and entries
13..18 equal to (24,2,10,11,1,0). Then
\[
\operatorname{rank}\left(\sum\xi_i^{25}T_i\right)=33.
\]
Both maps in its two-dimensional Hom space have generic rank one
and factor through a common quotient F_abs^{2*}R_xi -> O(-5O).
An actual first-pullback quotient F_abs^*R_xi -> O(-O) is already
surjective. Therefore this example has NO strict Frobenius period
of any positive length, using semistability of R_xi.

More generally the entire incidence fiber over the section input
(f,alpha)=(0,1) is the projective line spanned by the two vectors
with final six coordinates (24,2,10,11,1,0) and (14,5,13,12,0,1).
Every member of this line has a nonzero map F_abs^*R -> O(-O),
hence a negative-degree line quotient and no strict positive period.
The latter all-geometric-parameter conclusion follows from two
checked identities and semilinearity, not a field-point search.
This line is disjoint from the previously excluded pencil. Neither
nonemptiness of the quotient incidence nor its dimension supplies
a rank-two quotient or a return.

The entire fixed-target negative-line locus
\[
\mathcal N_-=\{[\xi]:\operatorname{Hom}(F^*R_\xi,\mathcal O_X(-O))\ne0\}
\]
is a smooth quartic scroll in the pure-v P5. It is the image of
P1 times P1 by O(1,2), with coordinates
\[
(\xi_{13},\ldots,\xi_{18})^t
=M(\lambda s^2,\lambda st,\lambda t^2,\mu s^2,\mu st,\mu t^2)^t,
\]
where the coded matrix is
\[
M=\begin{pmatrix}
17&8&18&15&24&10\\17&12&7&22&17&1\\
17&12&19&21&19&8\\12&5&5&20&9&11\\
2&1&1&19&5&0\\7&24&0&15&4&1
\end{pmatrix}.
\]
Every point of this scroll is stable and has NO strict positive
Frobenius period. The earlier nonperiodic fiber pencil is one ruling.
This is a complete fixed-line locus, not a classification of all
Frobenius instability.

The fixed-target locus
\(\mathcal N_0=\{[\xi]:\operatorname{Hom}(F^*R_\xi,\mathcal O_X)\ne0\}\)
is also determined as a geometric reduced set: the scroll, one P3,
and eight P2s. The added linear spaces are pairwise disjoint and meet
the scroll in distinct rulings. They arise at parameter zero and at
the eight nonzero roots of
\[
r^2(r-[24])g_3(r)g_4(r),\qquad
g_3=(19,22,12,1),\quad g_4=(19,0,6,6,1).
\]
The cubic and quartic are irreducible and separable over F25.
Every STABLE member of this larger locus has no positive period.
No such claim is made for its strictly semistable members.

The stable strict second-return locus in P18 remains finite and reduced
in its natural fixed-locus structure, with unknown cardinality. Its
full sufficient system is now reduced exactly from 402 morphism
coefficients and 474 linear equations to 51 coefficients and 123
linear equations:
\[
M_\xi=
\begin{pmatrix}
\sum_j\xi_j^{25}T_j&0\\
\sum_{i,j}\xi_i\xi_j^{25}C_{ij}&\sum_j\xi_j^{25}Q_j
\end{pmatrix},\qquad
M_\xi(c,s)^t=0,
\]
where \(c\) has length35, \(s\) length16, and the two row blocks
have lengths80 and43. All full morphism coefficients are uniquely
recovered. Nine retained evaluation forms give the determinant of
the full 3-by-3 morphism, a cubic in (c,s). Its nonvanishing and the
complement of the stability surface MUST still be imposed. All361
mixed tensors and both recovery maps have been rebuilt and checked.
These equations have not been solved.

At each of the two previously supplied pencil basis points the full
Hom space from F^2R to R has dimension four; every map has rank at
most one and factors through O(-5O). These are complete global
morphism spaces, not just quotient maps.

The subsequent [geometric pure-v theorem](pure_v_geometric_rank_window.md)
excludes ALL stable strict second returns in the six-coordinate P5 over
the algebraic closure. Its quotient rank-drop locus is precisely the
quartic scroll plus45 isolated points, each nonperiodic at every positive
period. This closes that subfamily, not the full P18 system above.

No primitive finite rank-three source, strict second return, or
unrestricted nonexistence theorem is supplied. Rank two, higher ranks
and both original common-cover problems remain open.

[Proof and exact retained matrices](../../Proofs/cartier_and_spin/rank_three_extension_return_geometry.md).
[Fixed-line classification and full reduction](../../Proofs/cartier_and_spin/rank_three_reduced_returns.md).
