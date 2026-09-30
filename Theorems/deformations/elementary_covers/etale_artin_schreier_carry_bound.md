# An all-precision degree bound for étale Artin–Schreier charts

Version2,2026-09-15. This is a local integral chart theorem. It does
not require ordinariness, a Hodge structure, or a chosen curve.

Let p be prime and A a p-adically complete, separated
commutative ring. Put

    B=A[W1,...,Wr]/(W_i^p-a_i*W_i-b_i),  a_i,b_i in A.

Use the free A-basis W^e with 0<=e_i<p. Let F_d B be the span of
the basis monomials of total degree at most d, with F_d=0 for d<0,
and define the closed weighted modules

    G_d B=sum_(j>=0) p^j F_(d+(p-1)j) B.

These have the following properties.

1. G_d*G_e is contained in G_(d+e), and x in G_1 implies x^p in
   G_1. The latter assertion uses the displayed chart relations.

2. Let a in A^*, b in A. Any root of x^p-a*x-b modulo p whose
   residue has total degree at most one has a unique lift x in B.
   That lift belongs to G_1. Consequently an étale chart map whose
   residue sends every coordinate to an affine-linear expression
   preserves G_d for every d. More generally this holds for any
   homomorphism between such chart algebras whose image coordinates
   are these uniquely lifted roots with affine-linear residue.
   The ambient algebra B in which roots are lifted need not be etale:
   only the coefficient a in the root equation being solved must be a unit.
   The same holds for semilinear chart
   maps when the coefficient homomorphism sends base to base and
   p to p, and for compositions of these maps.

3. If every a_i is a unit, a derivation D of A extends uniquely to
   B and preserves G_d.
   In particular differentiation and any combination of the chart
   operations in part2 obey the same degree estimate.

Equivalently, substitution of a polynomial of degree at most d,
followed by any of these operations, can be written modulo p^m as

    sum_(j=0)^(m-1) p^j h_j,  deg h_j <= d+(p-1)j.

The coefficients h_j use the fixed normal monomial basis and
coefficient sections on A/p. Only existence of such an expansion
is asserted; with p-torsion its digits need not be unique.
This is a bound for actual integral
operations, before any eventual obstruction division.

No p-torsion-free hypothesis is needed. In particular the statement
applies directly to truncated Witt coefficient rings. Invertibility
of the a_i is unnecessary for the multiplicative and p-th-power
bounds in part1; it is needed where specified in parts2 and3.

For p=5 the first three carries have bounds d+4,d+8,d+12. In
particular the original two-carry estimate for the marked rank125
comparison extends to its third carry. This does not prove that
the extra terms vanish after normal projection. Nor does this
theorem apply to arbitrary inverses of positive-degree moving
functions, or impose an étale-cover structure on a moving source.

[Human-readable proof](../../../Proofs/deformations/elementary_covers/etale_artin_schreier_carry_bound.md).
