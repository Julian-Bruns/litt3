# Five distinct actual X-fields have independent norm maps

Version1,2026-09-22. Let X be the fixed genus-nine curve, A=J(X),
K=End^0(A), and E=Q(zeta_3) contained in K. Let
h_i:T->X be actual finite etale maps from the SAME smooth proper
connected curve, all of degree d=(g(T)-1)/8. Put
\[
u_i=(h_i)_*,\qquad v_i=h_i^*=u_i^\dagger,\qquad
H_{ij}=\operatorname{Tr}_{K/E}(u_iv_j).
\]
If the embedded fields h_i^*k(X) are pairwise distinct, then
\[
H_{ii}=9d,\qquad H_{ji}=\overline{H_{ij}},\qquad
|H_{ij}|\le2d\quad(i\ne j).
\tag{1}
\]
Either complex embedding of E gives the same modulus. Consequently,
for any family of at most FIVE distinct fields,
\[
\boxed{u_1,\ldots,u_r\text{ are linearly independent over }E.}
\tag{2}
\]
Equal fields are grouped by the actual cubic automorphisms of X.
In a relation supported on at most five distinct fields, every
field's grouped E-coefficient must therefore vanish separately.

In particular a relation among THREE maps with nonzero coefficients
in K whose ratios belong to E forces all three fields to coincide.
For nonzero integer coefficients, the only possibilities are:
all three maps are identical and the coefficients sum to zero;
or the maps are the three cubic conjugates of one map and the
coefficients are equal. Thus a literal identity
\[
(h_1)_*+(h_2)_*+(h_3)_*=0
\]
holds exactly for a cubic orbit, after permuting the maps.

If N pairwise distinct fields occur and m is the geometric
multiplicity of A in J(T), their Gram matrix satisfies
\[
\frac{81N}{4N+77}\le\operatorname{rank}_E H\le9m.
\tag{3}
\]
In particular N>154 implies m>=3. This does NOT improve the
existing m>=5 bound on the first Y-leg Galois closure.

No Galois hypothesis or cover-degree restriction is imposed.
Arbitrary K-coefficients outside the stated ratios, individual
one-form relations, and finite closure of the actual field orbit
are not settled. Neither original common-cover problem is solved.

[Proof](../../../Proofs/jacobians/isogeny_sieves/fixed_x_short_map_relations.md).
