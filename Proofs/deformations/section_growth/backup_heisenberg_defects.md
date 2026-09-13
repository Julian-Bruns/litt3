# Proof: the complete actual Heisenberg census on two bad pairs

[Statement](../../../Theorems/deformations/section_growth/backup_heisenberg_defects.md).
Independent completion audit PASS, /root/audit_actual_heisenberg_defect,
2026-09-11. Audits are reference-only:
ACTUAL_HEISENBERG_DEFECT_AUDIT_2026_09_11.md,
HEISENBERG_FROBENIUS_AND_ADDITIONAL_RANKS_AUDIT_2026_09_11.md,
HEISENBERG_CENSUS_COMPLETION_AUDIT_2026_09_11.md.
All are in Research/audits. The initial audit rebuilt full finite
Laurent cohomology for actual pilot columns. The completion audit
checked every rank, orbit label, cover equation and artifact link.

## Actual covers and complete classification

Use the ordinary genus-three curve D and its three-dimensional
Artin--Schreier space from backup_active_double_germs. A two-plane
with basis chi1,chi2 gives the connected elementary-five-square cover.
Take representatives on the pulled-back two-affine cover and split
chi_i^5-chi_i=f_i,U-f_i,O exactly. In the UT3 Lang coordinates,

    w1^5-w1=f1,U, w2^5-w2=f2,U,
    w3^5-w3=f1,U*w2+f3,U.

The overlap is

    w1,O=w1,U-chi1, w2,O=w2,U-chi2,
    w3,O=w3,U-chi1*w2,U+kappa0.

The remaining compatibility identity is

    f3,O=f3,U+wp(kappa0)-chi1^5*f2,U+f1,O*chi2.

It is checked as an exact Laurent-polynomial identity. The cross
cohomology class vanishes by the hyperelliptic parity, allowing the
canonical primitive kappa0=0. The five distinct central choices are
kappa0+j*chi3,j in F5, with chi3 complementary to the plane. The
corresponding f3,U and f3,O are retained separately for every cover.
The triangular affine equations have Jacobian diagonal -1 and the
transition is invertible, so these are actual finite etale covers.

A subgroup of H surjecting onto H/Z contains a nonzero commutator,
hence all of Z, so these covers are connected with full monodromy H.
Every lift of a fixed elementary-five-square quotient differs by an
Artin--Schreier character. The automorphisms of H fixing H/Z absorb
exactly the two-plane of quotient characters. Thus the five choices
exhaust its geometric lifts. Changing the basis of the plane is
accounted for by the actual UT3 automorphisms. There are31*5=155covers.

## Actual cohomology and the six-column acceleration

The exact Laurent coefficient ring has components1,kappa,ell,v. In
the eta-inverse tangent frame, its cohomology gaps are

    v/u,v/u²,v/u³,ell/u,kappa/u,ell/u².

The125monomials w1^i w2^j w3^l, with exponents0..4, are ordered by
i+j+2l. Their gluing is triangular in this order. The graded normal
lines have no H0, so the750products with the six gap classes form the
actual H1(T,T_T). Descending reduction is finite Laurent-polynomial
arithmetic, with no series precision cutoff.

The actual Hodge map is A*f^5 before this reduction. Its coefficient
Frobenius is retained. The full deck action of
h:(w1,w2,w3)→(w1,w2+1,w3+w1) is computed by the same quotient.
The other generators g:w1→w1+1 and c:w3→w3+1 are constant binomial
matrices. The full relations gh=c*hg and h^5=1 hold on all750classes.

Put omega=w1^4*w2^4*w3^4. Its deck norm is -1. Hence the six classes
b_i*omega have norms -b_i and generate the free rank-six k[H]
cohomology lattice by Nakayama. Their six Hodge images and all their
deck translates determine the entire map. This cuts the expensive
geometric computation from750Hodge columns to six, without changing
the exact rank problem.

The independent pilot audit used a different finite Laurent reducer
and additional non-seed columns. The completion audit independently
reconstructed all750image columns and checked their full dense ranks
for each of the93orbit representatives.

## Exact coefficient conjugacy and exhaustive ranks

The two pairs are defined over F125. Coefficient125-Frobenius therefore
permutes the155covers without changing their defects. The transport
retains the central character, not only the underlying plane. For
M=[[a,b],[c,d]], the change of ordinary central coordinate is

    w3new=det(M)*w3+(ac/2)w1²+(bd/2)w2²+bc*w1*w2.

The logarithmic central coordinate w3-w1*w2/2 instead transforms by
det(M). Both affine equations and the Artin--Schreier classes were
checked under all310central transports. The coefficient field can
be reduced from F_(5^60) to F_(5^12);1187Hodge and10471deck coefficients
from the earlier pilot files were independently transported exactly.

There are51orbits for the branch pair and42for the mixed pair. Every
label(plane,central) occurs once. The three high-defect branch orbit
representatives account for exactly the five central choices on the
original base plane. Their full ranks are713. Every other rank is721.
Subtracting from750 gives37and29. Independent identification of the
high plane uses its actual character pullback from B.

The two producer runs took3593.36s and3031.82s, with no failed jobs.
Independent sequential one-core completion replays took270.30s and
215.52s. All279Hodge/deck/rank artifacts and their hashes/links passed.
The result uses only actual coefficient-conjugacy classes, not an
assumption that unexamined covers resemble the pilots.

## Replay and scope

Main scripts:

    scripts/deformations/backup_heisenberg_defect.py
    scripts/deformations/rank_heisenberg_free_columns.py
    scripts/deformations/heisenberg_frobenius_orbits.py
    scripts/deformations/verify_heisenberg_field_transport.py
    scripts/deformations/run_heisenberg_census.py

Orbit tables are Research/computations/heisenberg125_frobenius_case0.json
and heisenberg125_frobenius_case2.json. Complete datasets are
/Users/julian/Documents/litt3-computation-data/heisenberg125-census-20260911/
case0 andcase2, with summary.json and every actual equation/column/rank.
The independent completion verifier and its receipts are referenced by
the completion audit. No production rerun is needed to use this theorem.

Further actual etale pullback injects the defect-bundle sections, so
the displayed domination lower bounds follow. The proof does not
substitute an abstract group-algebra element for an actual operator.
Indeed, independent algebraic stress tests show that a fixed abelian
germ and adjoint symmetry alone do not determine Heisenberg colength;
higher central terms can change it. A generalization of the census
therefore still requires additional geometric information.
