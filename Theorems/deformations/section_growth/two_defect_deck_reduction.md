# Two-section Galois covers and their exact finite images

Version2,2026-10-03. Let \(k\) be algebraically closed of characteristic
\(p\ge5\), \(q:Z\to Y\) a connected finite étale Galois cover of smooth
projective connected curves, and \(E\) a bundle with a perfect alternating
pairing \(E\otimes E\to\omega_Y\). No genus, stability or ordinariness
hypothesis is needed. Assume
\[
H^0(Y,E)=0,\qquad U=H^0(Z,q^*E),\qquad\dim_kU=2.
\]
Put \(G=\operatorname{Gal}(Z/Y)\), \(\rho:G\to GL(U)\) and
\(\Gamma=\rho(G)\). Every Sylow \(p\)-subgroup \(P\) of the ACTUAL
group \(G\) is cyclic. There is a normal prime-to-\(p\) subgroup
\(K\subset\ker\rho\) with the following descriptions.

## Nontrivial p-action

If \(p\mid|\Gamma|\), put \(|P|=p^a\), \(a\ge1\). Then
\[
\Gamma\in\{C_{2p},D_{2p},C_2\times D_{2p}\},\qquad
G/K\in\{C_{2p^a},D_{2p^a},C_2\times D_{2p^a}\},
\]
in corresponding order. Throughout, \(D_m\) means dihedral of ORDER \(m\).

The actual intermediate \(T_a=Z/K\) has two sections.
Its quotient \(Y'=T_a/(PK/K)\) has one section and is an elementary
abelian two-cover of \(Y\) of degree \(d=2\) or4. There is a distinguished
double \(C\to Y\) with one section; \(Y'\to C\) has degree1 or2
and adds none. For \(h=g(Y)\), all these actual étale quotients have
\[
g(C)=2h-1,\qquad g(Y')=d(h-1)+1,\qquad
g(T_a)=dp^a(h-1)+1.
\]
In particular \(h=2\) gives \(g(C)=3\), \(g(Y')=3\) or5 and
\(g(T_a)=2p^a+1\) or \(4p^a+1\).
The faithful image has order at most \(4p\); the exponent \(a\) is
unbounded. For EVERY \(a\), the cyclic \(C_{2p^a}\) case is the
fiber product of \(C\to Y\) with an actual cyclic-\(p^a\) cover of \(Y\).
The dihedral cases need not be such products.

## Trivial p-action: the residual groups are explicit

If \(p\nmid|\Gamma|\), put \(|P|=p^a\), allowing \(a=0\).
Take \(K\) to be the normal prime-to-\(p\) complement in \(\ker\rho\).
Then
\[
G/K=C_{p^a}\rtimes\Gamma,
\]
with the action given by \(\det\rho\): \(+1\) is trivial and \(-1\)
is inversion. The faithful residual representation is semisimple,
self-dual and has no invariant vectors. Its possible groups are:

| Faithful image \(\Gamma\) | Order | Determinant |
| --- | --- | --- |
| Cyclic \(C_n\), \(n\ge2\) | \(n\) | \(1\) |
| Orthogonal dihedral \(D_{2n}\), \(n\ge2\) | \(2n\) | Reflection sign |
| Binary dihedral \(\widetilde D_{2n}\), \(n\ge2\) | \(4n\) | \(1\) |
| Binary tetrahedral \(\widetilde A_4\) | \(24\) | \(1\) |
| Binary octahedral \(\widetilde S_4\) | \(48\) | \(1\) |
| Binary icosahedral \(\widetilde A_5\) | \(120\) | \(1\) |

The order must be prime to \(p\); in particular \(\widetilde A_5\)
is absent when \(p=5\). A binary group denotes the FULL inverse image
of its indicated projective subgroup under \(SL_2(k)\to PGL_2(k)\).
Thus only the orthogonal dihedral case can invert the cyclic \(p\)-part;
all other cases give \(G/K=C_{p^a}\times\Gamma\).
These are necessary representation types, without asserted geometric
realizations. The cyclic and dihedral orders and \(a\) remain unbounded.

## Characteristic-five indigenous application

For the actual tangent bundle \(E_r\) on \(Y^{(1)}\) of an admissible
active connection, apply the theorem to \(q^{(1)}\): sections are
indigenous defects. The prime-to-five map \(Z\to Z/K\)
preserves both defect directions. The
[descent theorem](../defect_preserving_etale_descent.md) descends every
EXISTING compatible Witt tower along this ORIGINAL map.

Over the selected ordinary genus-two family, \(C\) in the nontrivial
case is one of its ten known bad doubles. For a common span
\(X\leftarrow Z\to Y\) with ordinary \(r_X\), its canonical X-source
descends to \(Z/K\); the further map \(Z/K\to Y\) is not thereby lifted.
The [two-defect exclusion](two_defect_nontrivial_five_exclusion.md)
excludes the nontrivial-action branch for the selected main pair,
including a nonordinary X-connection. The trivial-action branch and
arbitrary non-Galois legs are not excluded. A second endpoint map stays
on the original \(Z\); it descends to \(Z/K\) only if \(K\) fixes
its embedded endpoint field.

[Proof](../../../Proofs/deformations/section_growth/two_defect_deck_reduction.md).
