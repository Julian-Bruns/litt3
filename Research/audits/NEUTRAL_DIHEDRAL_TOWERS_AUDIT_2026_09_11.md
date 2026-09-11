# Neutral dihedral towers: bounded independent audit

Verdict: **PASS**, with the scope and two clarifications below.
Auditor: /root/audit_actual_heisenberg_defect. Date: 2026-09-11.
This is a mathematical prose audit with independent finite-algebra checks,
not Lean verification or a computation of higher Witt obstructions.

Audited source: [candidate](../NEUTRAL_DIHEDRAL_TOWERS_CANDIDATE.md), SHA256
`94c16633be7c5c88b5cf298658e9a4c188645bf0c55981b7b7106479235e9a22`.
No candidate, producer, canonical-library or research-state file was edited.

## Verdict and exact scope

All four proposed conclusions follow from the stated canonical inputs.
For each of the fourteen noncanonical quadratic resolvents of the ONE
specified obstructed F625 genus-two pair, the compatible elliptic
Verschiebung construction gives an actual tower at every q=5^a. For a>=1,

    d(W_a)=2,                  d(T_a)=1,
    W_a: bijective 4q,         nilpotent blocks q-1 and q+1,
    T_a: bijective 2q-1,       nilpotent block q+1.

There is some compatible extension of the original marked T_(a,2)
through the Witt ring W_(a+2)(k), for every a>=0. The source varies with a.
For a>=1, none extends the original map to C even through the third
compatible truncation. Full compatible marked-tower existence on T_a is
equivalent to existence on the T_1 of the SAME selected resolvent tower.

No full tower on T_1 or any other fixed source has been constructed or
excluded. The result does not equate the fourteen different T_1 cases,
assert all-q statements for the excluded canonical double, classify other
non-Galois covers, or construct a common cover of the main/backup pair.

The inherited statements were checked through the canonical records and
the relevant solution sections for explicit_non_galois_neutral_five,
etale_p_witt_obstruction, neutral_degree_five_obstruction_structure,
neutral_galois_witt_descent and ordinary_dihedral_spin_growth. Their
already audited geometric/Hodge inputs were not replaced by arbitrary
equivariant matrices.

## 1. Actual covers and identification of the first stage

The ordinary elliptic curve has compatible etale Verschiebung maps with
cyclic geometric kernels C_(5^a). The quadratic function-field extension
D/E and each odd-degree cyclic extension are linearly disjoint. Thus the
fiber product W_a is connected as well as smooth and proper, and its map
to D is etale of degree q. The original double D/C is also etale.

Choosing an origin at a branch point makes ell -> -ell equal to [-1] on
E. The product of the original involution on D and [-1] on E_a gives an
actual involution on W_a. It is free since its image on D is free. It
inverts cyclic translations, so the displayed automorphisms give the full
degree-2q dihedral Galois group over C. Quotients by the reflection give
the actual T_a. The compatible quotient maps are etale: they are maps
between intermediate quotients of an actual etale Galois cover, not a
normality assumption concerning some unrelated cover. Etale Hurwitz gives
the claimed genera. The reflection subgroup is nonnormal when a>=1,
proving non-Galoisness of T_a/C.

The unique anti-invariant geometric Artin--Schreier direction identifies
the q=5 cyclic cover with the audited first stage. To also identify the
reflection quotient, note explicitly that all reflection lifts differ by
a cyclic translation and are conjugate by a cyclic translation because
2 is invertible modulo 5. Thus the first-stage identification can be
chosen tau-equivariantly. This is a clarification, not a missing input.

## 2. Actual subgroup specialization and closure defect

Let sigma generate C_q and K=<sigma^5>. On a free R_q=k[e]/e^q module,

    sigma^5-1=e^5,
    N_K=sum_(g in K)g=e^(q-5).

Multiplication by N_K identifies the quotient modulo e^5 with the
K-invariants. The same identification is used on BOTH the linearized
source and target. Coefficient Frobenius fixes N_K and the abstract group
basis, so these identifications commute with the semilinear map. Actual
etale naturality on invariant cohomology identifies the induced map with
Psi_(W_1). Inversion preserves N_K, so the identification also respects
tau. This proves the required specialization, not just its dimension.

Modulo e the lower operator on D has rank 5. Five unit pivots can therefore
be eliminated over R_q, leaving one scalar relation. Its reduction modulo
e^5 has order exactly 2 by the audited first-stage Smith result; hence the
scalar itself is e^2 times a unit. This proves d(W_a)=2 for every a>=1.
The row/column elimination is used only for this cokernel assertion.

## 3. Semilinear Fitting argument

The eventual kernel and image of Psi are R_q-submodules: coefficient
Frobenius is an automorphism of R_q fixing v, so both kernels and images
are stable under multiplication by R_q. Their Fitting direct sum is thus
R_q-linear, and both summands are free over this Artin local ring.
Reduction of the bijective summand is bijective and reduction of the
nilpotent summand is nilpotent. Uniqueness of the lower Fitting
decomposition therefore gives free ranks 4 and 2 respectively.

The lower nilpotent part is tau-positive: it is the pullback of the
two-dimensional nilpotent part on C, and no additional nilpotent part
exists on D. Averaging lifts of a lower basis gives tau-fixed basis
vectors upstairs; Nakayama makes them an R_q-basis. In this basis tau
acts on coefficients by v -> -v, where v=sigma-sigma^(-1) is a
uniformizer. Commutation with the actual Psi makes all entries of its
nilpotent matrix M even in v.

The constant matrix satisfies M_0 M_0^[5]=0, not necessarily M_0^2=0.
Evenness consequently gives

    M M^[5] = v^2 U.

The nilpotent summand has Smith factors 1,v^2. Hence det(M) has nonzero
v^2 coefficient, and det(M M^[5]) has nonzero v^4 coefficient. That
coefficient survives for every q>=5, including q=5, forcing det(U) to be
a unit. This is a valid coefficient argument in the truncated ring; it
does not cancel v^4 as if it were a non-zero-divisor. U can be chosen even.

Even iterates are v^(2j) times an invertible semilinear map. Odd iterates
have the two Smith lengths obtained by adjoining M, giving exactly the
rank formulas in the candidate and hence blocks q-1,q+1. No commutation
of the successive invertible factors is required. On tau-positive
vectors the coefficient ring is k[w]/w^((q+1)/2), w=v^2; the corresponding
Smith factors are 1,w and the square is w times an invertible map. The
ranks decrease by one at every iterate, giving one block q+1. The
negative block is q-1. Exact order-two invariants identify the positive
operator with the ACTUAL operator on T_a. The remaining bijective
dimension follows from dim H1(T_a,T_(T_a))=3q.

Thus the Fitting conclusion uses freeness, the actual base Fitting type,
the actual involution, and the first-stage Smith result together. Smith
length alone is not being treated as a semilinear block length.

## 4. Finite induction and descended involution

In the induction, a compatible lift of T_(a-1) through W_(a+1)(k) is
pulled along the original adjacent etale map. A smooth next lower curve
extension exists; the inherited primary comparison is applicable to the
specified previous tuple, even when this chosen next reference is not
compatible. Its upper obstruction class is a pullback. Actual neutral
degree-five cokernel pullback is zero, so varying the new upper curve
digit kills the representative. The inherited uniqueness statement
retains the prescribed Hodge line, grading and flat periodicity twist.

The newest correction may destroy the just-lifted ADJACENT map at that
digit. Earlier truncations retain that adjacent map, not a composite map
to C above W2. The original W2 marking is retained throughout. This is
the exact induction needed; it supplies no inverse system on a fixed
T_a. Negative H1 injectivity and the nonzero epsilon_C then rule out any
compatible third truncation retaining the original map to C.

For the full-tower implication, pull a given T_a tower along its original
etale double to get W_a with tau. The cyclic map W_a/W_1 is neutral
(both defects are 2), so the inherited neutral-Galois theorem descends
this GIVEN tower along the original map, with its cyclic deck action.
There is a direct rigorous way to make the candidate's uniqueness step
explicit. For every lifted cyclic deck element g and every Witt length,
tau g tau^(-1) and g^(-1) have the same special-fiber automorphism. A
hyperbolic curve has H0(T)=0, so lifts of a specified automorphism to a
nilpotent thickening are unique. Therefore these two automorphisms agree
at every length. The actual cyclic action is normalized by tau, which
therefore descends to its W_1 quotient. Its order-two relation and
compatibility follow, and its action is free because the special-fiber
action is free. Its quotient is the ORIGINAL marked T_1.

The tuple descends too: the specified upper tuple is tau-equivariant
because it came from T_a, while the neutral-Galois descent retains its
specified graded/Hodge identifications and original flat twist. Faithful
etale descent, with these unique identifications, makes the descended
tuple tau-equivariant. Quotienting gives the compatible marked T_1 tower.
The reverse implication is ordinary lifting of the original etale
T_a/T_1 map. No general existence of a prime-to-five involution on an
arbitrary lower lift was presumed.

## 5. Independent bounded checks

[Checker](../../scripts/audit_neutral_dihedral_towers.py) imports no
producer module. It uses k=F5[z]/(z^2+2), coefficient Frobenius and actual
truncated polynomial arithmetic, with one CPU and no child agents.

Fourteen random even 2-by-2 matrices were tested: eight at q=5, five at
q=25 and one at q=125. Their constant matrix is semilinearly conjugated
by [[1,0],[z,1]], giving M_0=[[z,1],[3,z]]. It has
M_0 M_0^[5]=0 but M_0^2!=0, so replacing semilinear iteration by ordinary
powers would fail these tests. Full coefficient matrices of the
semilinear iterates and their positive/negative restrictions were built
independently. PARI computed 618 ranks: every iterate through q+1 at
q=5,25, and fifteen selected iterates through q+1 at q=125. All agree
with blocks q-1,q+1 and their claimed signs. The square-unit and nonzero
determinant-coefficient assertions were also checked directly.

At q=5,25,125, separate six-column random group-algebra tests checked the
explicit norm identity, coefficient-Frobenius specialization on both
source and target, and inversion equivariance. The script finished PASS
in 11.929651 seconds. These checks support the general algebra proof;
they are not assertions that the random matrices are geometric Hodge
operators, nor numerical computations of W4 or any higher Witt lift.

Ranks use PARI with the explicit modulus. The local Sage small-field
dense backend gave an incorrect rank for the simple rank-one matrix
[[z,1],[3,z]] with this nonprimitive defining generator, so that backend
was not used. The explicit F625 input generator was separately checked
to have order 624 and did not exhibit this issue; no producer artifact
or inherited rank was changed.

Receipt: [neutral_dihedral_towers_independent_audit_20260911.json](../computations/neutral_dihedral_towers_independent_audit_20260911.json).

    checker SHA256: f6f564bde5d84071a2c1d0e399f896d08a51720c1a210c14e9c6cd9d6747c4ff
    receipt SHA256: 7c13275f72424e189259f7e6fbcb0baeadb74c7f219660b3e2d0a73e6fd36431

Reproduction:

    env OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 \
      sage -python scripts/audit_neutral_dihedral_towers.py \
      --output Research/computations/neutral_dihedral_towers_independent_audit_20260911.json

No mathematical blocker or additional unproved hypothesis was found.
The reflection identification and levelwise normalization argument above
are the recommended explicit clarifications when integrating the proof.
