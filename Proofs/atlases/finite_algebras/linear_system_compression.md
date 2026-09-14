# Source and proof: one inverse chart for a finite linear system

[Statement](../../../Theorems/atlases/finite_algebras/linear_system_compression.md).

The rank-preserving matrix T_u is due to Gabizon–Raz,
[*Deterministic Extractors for Affine Sources over Large Fields*,
Lemma6.1](https://eccc.weizmann.ac.il/report/2005/108/download)
(author version, pp.17–18; Combinatorica **28** (2008), 415–440,
[DOI](https://doi.org/10.1007/s00493-008-2259-3)).
Its polynomial proof works over any field: put a full-rank n-by-k
matrix B in column echelon form with distinct increasing terminal
indices. In det(T_u B), the identity permutation has the unique
highest degree, at most n(1+...+k). Thus this determinant is nonzero.
The field-size hypothesis of the finite-field specialization lemma
is unnecessary for an indeterminate u.

Let R=O(Z). Its reduced quotient is a product of finite extensions
L_a/K. After adjoining u, these factors are L_a(u), and the cited
nonvanishing makes d a unit in each. The kernel of

    R tensor_K K(u) -> product_a L_a(u)

is nilpotent, so d is a unit in R tensor_K K(u) as well. This is
where finiteness is used; reducedness is unnecessary.

On d invertible, the compressed system Ap=T_u f has the unique
solution p=v/d. Substitution into every original row and the
homogeneous normalization gives exactly Hv=df and ell(v,b)=d.
These substitutions are inverse homomorphisms of coordinate rings,
so retain nilpotents as well as points.

For the atlas application, the
[intrinsic incidence theorem](../intrinsic_atlas_incidence.md)
gives finiteness and identifies the kernel of the projection of H(b)
to Ext1(V,T) with the line k p at an actual solution. If H(b)q=0,
then q=c p, whereas H(b)p=I b is nonzero by normalization and the
injectivity of I. Hence c=0, proving the full-column-rank hypothesis
also for nonacyclic V.

Here deg_b(d)=5k and deg_b(v)<=5k-4, so the residual rows have degree
at most5k+1. For n=96,k=32 the parameter-degree bound is50,688.
The parameter remains independent: specializing u requires
nonvanishing of d at every atlas point, and taking fifth powers
of formulas over K(u) also sends u to u^5.

[The exact checker](../../../scripts/atlases/algebra/verify_linear_system_compression.sage)
reconstructs all33 genus-two atlas points, rejects their33 invalid
normalizations, and checks an explicit full-rank matrix lost at u=1.
Its retained output is
[the compression certificate](../../../../litt3-computation-data/atlas-generic-compression/genus_two_check.json).
Bounded audit: PASS, /root/audit_finite_rank_condensation,2026-09-14;
arbitrary-field nonvanishing, finite nonreduced algebra and inverse maps.
