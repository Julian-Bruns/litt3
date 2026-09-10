# Focused audit: the abelian p-cover defect node

Auditor: /root/audit_p_cover_witt_repair. Date: 2026-09-10.
Verdict: PASS. No mathematical blockers to the stated all-degree formula
or the separate p-group-Galois-closure vanishing corollary.
This is a bounded prose/computational audit, not Lean verification.

Scope: the proof now at `Solutions/Sol_abelian_p_defect_node.md`, the new code in
`scripts/cyclic25_witt_module.sage`, and its precision260 receipt.
The preceding focused cyclic-p audit is inherited, including the actual
Psi multiplier, six geometric AS covers, exact Laurent coefficient
guard, and group-module theorem. Those inputs were not audited again.

## Descent and cyclic stabilization

For normal H in P, multiplication by N_H identifies the H-coinvariants
of a free left k[P]-module with its H-invariants, equivariantly for P/H.
Normality ensures that the norm commutes with P. Cartan--Leray identifies
the invariants of V_T with V_(T/H); the same reasoning applies to the
relative Frobenius linearized source. Naturality gives a commuting
square for Psi on both modules. Thus the quotient operator is the base
change of Psi, and right exactness of tensor product gives the asserted
cokernel identity. No exactness of invariants on arbitrary defect
modules is being assumed.

For a cyclic group of order 5^a, the corank-one hypothesis makes the
defect module R/(e^l). Its quotient to the actual degree-five
intermediate cover has length min(l,5). The inherited result makes
this2, and hence l=2 for every a>=1. This applies to every such actual
cyclic cover, regardless of which of the six first quotients it has.

## The finite relation and its code

The two independent geometric AS classes define the maximal elementary
abelian quotient of rank2. Their compositum is connected, degree25,
and etale. The two-variable power filtration has trivial successive
quotients, and tensoring with T_C preserves the vanishing H0 needed to
obtain the 75-dimensional basis. Reverse lexicographic elimination in
the code respects the componentwise triangular order of local
transitions.

The deck differences act on powers of w1,w2 by their usual binomial
differences with F5 coefficients, without any extra Cech correction.
The matrix called `conversion` uses exactly the (i,j,e) ordering of
the reducer. Since Delta_i^4(w_i^4)=4, its two-factor norm is1 on
each of the three top generators. The three generators are therefore
an actual free R_1 basis, and equivariance reconstructs the operator
from their three computed images. Its Frobenius semilinearity causes
no change to these F5-valued deck-coordinate transformations.

The local transition coefficient for a lower component (i,j) has pole
order at most3(a+b-i-j). The strict absolute-precision bound
>3(a+b)+2 therefore protects every retained coefficient through degree1
under all later elimination. The inherited protected coefficient
helper is used for the new Laurent extractions.

The constant matrix equality with the inherited base Psi verifies the
norm convention as well. The Schur complement is computed using an
actual unit2x2 pivot. Its finite inverse is correct because the
augmentation ideal of R_1 has ninth power zero. Expanding the group-ring
matrix gives the correct 75-dimensional linearization; multiplication
by its Schur relation independently verifies its cokernel dimension.

The author receipt records precision260, defect9, quadratic order2,
six cyclic lengths2, and56.3224s for the new part. I independently
reconstructed its field and full relation in Sage and checked:

- Lowest degree exactly2 and nonzero quadratic discriminant.
- The stored discriminant and its polynomial
  X^4+4X^3+4X^2+4X+1.
- Nonvanishing on all six F5 tangent directions.
- Colength9 by a fresh25x25 multiplication matrix.

This lightweight replay exited0. The costly three-column Laurent
calculation was reviewed in code rather than rerun; the preceding
six-cover calculation already had an independent replay in the
inherited audit. The full relation, not merely its asserted rank,
was checked here.

## All abelian groups and coordinate changes

Any finite abelian5 quotient has at most two generators, since the
geometric H1_et(C,F5) has dimension2. A rank-two quotient modulo5 is
the entire elementary abelian quotient. Its group-coordinate changes
have invertible linear part in GL2(F5); the actual substitutions may
also have higher terms. These preserve quadratic nondegeneracy and
nonvanishing on F5 tangent lines. Multiplication by a unit likewise
preserves both properties.

After base change to this elementary quotient, a lifted unit pivot
gives D_T=R/(f). Isomorphic cyclic quotients have equal annihilator
ideals; nonzero generators of the same principal ideal in a local
ring are associates. This justifies the asserted unit ambiguity of
the relation, without imposing a preferred generator of D_T.
Every polynomial lift of f to the formal power-series ring has the
same quadratic part. Over the geometric field it is an ordinary
node. The formal Morse reduction in characteristic5 is valid: its
invertible linear gradient removes higher homogeneous errors by
successive coordinate changes, without division by their degrees.

When A=B=q is a power of5, the ideal generated by the q-th powers
of a regular parameter system is invariant under every formal
coordinate change. Thus the colength is2q-1.

When A>B=q, the line t=0 is an F5 direction in the chosen group
coordinates and is transverse to both node branches. Consequently
t has nonzero linear term on each branch. Reparametrizing the two
branches separately makes t=U+V in k[[U,V]]/(UV). Modulo t^q one has
U^q+V^q=0 and U^(q+1)=V^(q+1)=0. Since A>=5q, every element of the
maximal ideal has A-th power zero, so imposing s^A changes nothing.
The remaining colength is2q. These arguments prove the stated formula
for every actual abelian cover, not just the computed degree25 cover.

## General p-group-closure corollary and two-leg limit

Let an actual nontrivial connected cover T->C have Galois closure
L->C with finite5-group P, and put H=Gal(L/T). Then H is proper and
lies in a maximal subgroup M of P. Such M is normal of index5.
The factorization T=L/H -> L/M -> C therefore contains one of the
six actual cyclic5 covers as its first intermediate cover over C.
Its epsilon vanishes by the inherited theorem, and naturality forces
epsilon(T)=0. This corollary does not assert a defect formula for
nonabelian monodromy.

For all these covers, any source W3 Hodge repair still loses the
original C-leg: a compatible target C3 has nonzero rho, and its
negative-H1 pullback is injective. The full two-leg deformation functor
has not been repaired. No common cover is constructed or excluded,
and the unmarked common-cover problem remains unsolved.
