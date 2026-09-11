# Heisenberg Frobenius transport and two additional ranks

Auditor: `/root/audit_actual_heisenberg_defect`.
Date: 2026-09-11.
Verdict: PASS for the scope below. No mathematical correction.

Scope: the actual coefficient-125-Frobenius action on all 155 geometric
Heisenberg covers of each of bad-double cases 0 and 2, including the
central character; the 51 and 42 orbit counts; the zero reference Lang
primitives and degree-12 coefficient field; and the complete Hodge ranks
for case 0 / plane 1 / central 0 and case 2 / plane 0 / central 0.
The two cases have rank 721 and defect 29.

This audit does not certify a completed 155-cover rank census for either
double. It uses the actual-cover construction, geometric 155-class
classification, complete Čech model, and free six-generator argument
already checked in
[the preceding audit](ACTUAL_HEISENBERG_DEFECT_AUDIT_2026_09_11.md).
No producer code, research state, or canonical library was changed.

## 1. Parity supplies a zero reference primitive

The involution `ell -> -ell`, fixing kappa and u, negates every member
of the exact H1(O_D) basis `v/u,v/u^2,ell/u`. Its quotient is the
genus-zero curve `kappa^2=R`; it is the hyperelliptic involution of D,
not the involution of the original étale double D->B.

Every chosen AS representative chi is odd under this involution.
The affine and infinity parts of `chi^5-chi` remain odd because the
exact splitting preserves the four character components. Consequently

    C = -chi1^5*f2,U + f1,O*chi2

is even. Its H1(O_D) projection is zero, since that entire cohomology
space is odd. Thus the reference central Lang equation has right side
zero and admits exactly the zero primitive used by the program. This
holds for every plane; the independent replay checks all 62 reference
primitives in the two requested cases.

Only the reference primitive, for central label zero, vanishes. For
central label j the actual primitive is `j*chi3`. All three AS classes
are already defined over F_(5^12), and every remaining operation is an
exact split, product, or fifth power in that field. All 155 covers of
each case therefore have the stated models over F_(5^12); no degree-60
extension is needed to repair a reference Lang equation here.

## 2. The full UT3 automorphism and central comparison

For `M=[[a,b],[c,d]]` over F5, put

    q(x,y)=(ac/2)x^2+(bd/2)y^2+bc*x*y.

The map

    (x,y,z) -> (ax+by,cx+dy,det(M)z+q(x,y))

is an automorphism of the actual UT3 group scheme. Expanding its group
law gives the required cross term `(ax+by)(cX+dY)`; the independent
script verifies this as a symbolic polynomial identity, with arbitrary
a,b,c,d and both arbitrary input triples. It commutes with fifth power
because its coefficients lie in F5.

The overlap element is `(-chi1,-chi2,kappa)`. Its transformed central
coordinate is therefore `det(M)*kappa+q(chi1,chi2)`; the quadratic
term has the displayed positive signs. After matching the two quotient
characters exactly, the difference between the Frobenius-conjugate
overlap and this transformed overlap is the scalar cochain

    delta = sigma(kappa_old)-det(M)*kappa_target-q(chi1,chi2).

This comparison concerns both local cover equations, not just their
classes in H1(O). In every one of the 310 transport witnesses the
independent replay verifies

    delta^5-delta = difference_of_infinity_rhs
                   - difference_of_affine_rhs,

where the right sides use the full UT3 automorphism, including its
quadratic term on the local Lang data. Thus the difference is an actual
central AS torsor. Its H1(O) class identifies its geometric AS character:
the kernel of this identification consists of constants modulo AS,
which vanishes over the algebraic closure.

The target-plane component of that character is removed by a central
UT3 automorphism with a linear term in x and y. After that repair, the
remaining scalar overlap has zero H1(O) class and splits into actual
affine/infinity coboundaries. A possible remaining common constant is
again AS-surjective over the geometric field. This proves the claimed
geometric D-isomorphism class, including its central label.

The quadratic q is even on the odd chi representatives, so its H1(O)
class is zero. With the zero reference primitives this leaves a linear
central action, without an uncomputed affine translation. If `P` is the
old plane and the target basis is used to express sigma(P), write A for
the 2-by-2 quotient-basis matrix and nu for the induced scalar on the
one-dimensional quotient of AS space by P. The new central coordinate
is exactly `nu*j/det(A)`. The independent implementation obtains both
factors from a full 3-by-3 frame, rather than copying the producer's
normal-vector formula. All 310 target labels, basis changes, central
differences, and plane repairs agree with the saved witnesses.

## 3. Independent orbit counts

The independently reconstructed coefficient-Frobenius matrices on the
AS space are

    case 0: [[1,0,0],[4,3,0],[0,0,2]],
    case 2: [[1,0,0],[4,3,0],[0,0,4]].

Both have order four. On a plane invariant under a power L of sigma,
the central action is `nu/det(L|P)=nu^2/det(L)`. This gives a separate
Burnside count, beyond cycling through the stored permutation.

For case 0, sigma has eigenvalues 1,3,2. Of its three invariant planes,
one fixes all five central labels and two fix only zero, giving seven
fixed covers. Its square has seven invariant planes and fixes all five
labels above each, giving 35. For case 2, the eigenvalues are 1,3,4;
only zero is fixed over each of its three invariant planes. Its square
has seven invariant planes but negates their central coordinates, giving
seven fixed covers.

| Case | Fixed covers for powers 0,1,2,3 | Orbits of lengths 1,2,4 | Total |
| --- | --- | --- | --- |
| 0, branch A3 | 155,7,35,7 | 7,14,30 | 51 |
| 2, mixed A1 | 155,3,7,3 | 3,2,37 | 42 |

The independent permutations agree with every saved orbit and have
fourth power identity on all 155 labels. The underlying double and
actual multiplier A are fixed by coefficient-125-Frobenius. This
coefficient conjugacy commutes with the actual fifth-power Hodge map,
and the subsequent comparison is a geometric cover isomorphism.
Therefore Hodge rank is constant on each of these verified orbits.

## 4. Field transport and the two complete ranks

The independent field comparison finds the twelve roots of the actual
degree-12 modulus inside the saved degree-60 field, filters by alpha,
and identifies an embedding from the complete cover equations. It does
not reuse the producer's field-extension embedding command. Under that
embedding all 1,187 coefficients in the Hodge/cover receipt and all
10,471 coefficients in the deck/cover receipt for case 0 / plane 1
agree, including all six Hodge columns and all 750 deck columns.

For each requested additional cover, the independent replay reconstructs
the actual R and active A from the original branch or mixed datum,
checks all local cover data against the degree-12 receipt, recomputes
all six top Hodge columns 744--749 using nested quadratic Laurent
algebras, and compares every resulting coefficient. It also reconstructs
deck columns 738--749 and checks the group relations on all 750 basis
vectors. Both sets of comparisons pass.

Using the six images and actual group elements `g^a h^b c^d`, followed
by PARI dense finite-field rank, gives rank 721 in both cases. This is
independent of the producer's augmentation-orbit order and sparse rank
elimination. The already audited free-generator argument makes each a
complete Hodge rank, hence defect `750-721=29`.

## 5. Evidence and exact scope

Independent script: `scripts/audit_heisenberg_frobenius.py`.
It imports the preceding auditor's `IndependentBase` and
`IndependentTorsor`, and no producer module. Total execution was
104.62 seconds on one CPU. Its receipt records every input hash:
`Research/computations/heisenberg_frobenius_independent_audit_20260911.json`.

| Evidence | SHA-256 |
| --- | --- |
| Independent script | `d8cff1eb9ed5da0f3ceaa9cd1b53382cf1ac6a1ae5ede26486c7187187037535` |
| Independent receipt | `dcc57c4ac106219cdf3c935f63e6589335626f030bbf243c1581b5e2394bcafb` |
| Producer orbit script | `b988c7c539ef93d92436d0b7dea7ab75f2ff47aec6b1b83796c668ab828e2199` |
| Case 0 orbit receipt | `d92e030c6a86eb8a707333a7107da6e5ed1ef3915550fe776a17681d818fea54` |
| Case 2 orbit receipt | `fd17f7fe87437e78378454a68b8bd0f9805006505c814f84c60a3d9651547006` |

The branch rank inputs are the `*_case0_plane1_k12.json` receipts in
`Research/computations/`. The mixed rank inputs are
`case2/plane00_central0_{hodge,deck}.json` under
`/Users/julian/Documents/litt3-computation-data/heisenberg125-census-20260911/`.
Only these two complete ranks, together with the Frobenius transport,
are new numerical conclusions of this audit. It does not assign ranks
to every orbit while the censuses are running, and gives no common-cover
exclusion or higher-Witt conclusion.

Minor wording correction sent to the author: the quadratic automorphism
formula is in the ordinary UT3 coordinate w3. In logarithmic coordinate
`z=w3-w1*w2/2` the action is simply `z -> det(M)z`. The polynomial used
by the code is correct.
