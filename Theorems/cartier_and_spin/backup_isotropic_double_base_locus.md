# A curve of isotropic double-base Cartier planes

Version1,23September2026. For the fixed ordinary genus-two backup Y,
let F:Y->C=Y^(1), B=F_*O_Y/O_C and eta=du/v. Consider saturated
degree-zero Lagrangians S in B with evaluation base 2P and raw
Wronskian divisor 4P+Q1+Q2, with P,Q1,Q2 pairwise distinct.

This locus is NONEMPTY. Every nonempty irreducible component has
dimension at least one. It has a geometrically irreducible curve
component defined over F125 that is smooth and etale over the
P-curve at the following point P=O. No uniqueness of component is
asserted.

Use codes [n0+5n1+25n2]=n0+n1*alpha+n2*alpha^2 and ascending rows.
Let f=A0(u)+vA1(u), where
\[
A0=(0,48,17,51,4),\qquad A1=(12,44,74,48,58,84).
\]
Write df=(H+vT)eta, with
\[
H=(30,19,22,59,31,21,110,42),\quad T=(48,9,28,1).
\]
Let D be the degree-two divisor with Mumford rows
d=(51,97,1), e=(44,24); its points are ([27],[13]),([31],[114]).
Let E=Q1+Q2 have rows q=(14,123,1), eQ=(63,76). Then
\[
H^2-\Phi T^2=[53]d^5q^2,\qquad
\operatorname{div}(df)=5D+2E-12O.
\]
The sheets, squarefreeness and all relevant coprimality conditions
are part of the exact certificate. The plane is
\[
S0=\operatorname{Sat}_B\langle[f],[f^2]\rangle_{k(C)},\qquad
\kappa0=O_C(F(D)-3O_C),\quad
L0=\det S0=O_C(3F(D)+F(E)-8O_C).
\]
Its determinant has reduced Mumford rows ((89,25,1),(28,29)) on C
and EXACT order1850. Its unordered residual divisor is F125-rational;
the individual residual points require F_(125^2).

There is also an exhaustive determinantal presentation of the entire
geometric locus. Write each canonical degree-minus-one line as
kappa=O_C(D1-3O_C), where D1 is effective of degree two, in its
unique canonical Mumford representative (use D1=2O_C for kappa=-O_C).
Let
\[
V=\langle u,u^2,u^3,u^4,u^6,u^7,
v,uv,u^2v,u^3v,u^4v,u^5v\rangle_k,
\quad Z=F^*D1+3P+2Q1+2Q2.
\]
The locus is precisely the vanishing of all12-by12 minors of
\[
V\longrightarrow H^0(Z,\omega_Y(15O)|_Z),\qquad f\longmapsto df|_Z,
\]
with the three-point distinctness conditions. Its nonzero kernel is
one-dimensional and reconstructs
\[
S=\operatorname{Sat}_B\langle[f],[f^2]\rangle,\qquad
\det S=O_C(3D1+P1+Q11+Q21-9O_C).
\]
All three Mumford strata of degrees0,1,2, infinity, ramification
and all Frobenius-root choices are retained. This is an exhaustive
presentation, not an irreducible-component census or an actual
etale-span construction.

[Proof](../../Proofs/cartier_and_spin/backup_isotropic_double_base_locus.md).
