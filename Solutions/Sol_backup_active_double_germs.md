# Complete active-double defect germs at the backup

Author calculation, 2026-09-11. Fresh mathematical and independent
arithmetic audit PASS by /root/audit_backup_all_bad_double_germs.
[Statement](../Theorems/Thm_backup_active_double_germs.md). This is a
one-leg result, not an unmarked common-cover exclusion or a higher-Witt
calculation. No coefficient correction was found.

## Result

Let B:v^2=F=u(u-1)(u-2)(u-3)(u-alpha), alpha^3+alpha+1=0.
All 85 admissible active connections are ordinary on B. For 79 of them
all 15 nontrivial etale doubles remain indigenous-ordinary. Six
connections have exactly two bad twists each, all with defect one.

Ten of these twelve bad pairs are the universal branch-support cases
in `genus_two_active_twists`. Their actual genus-three maximal abelian
pro-5 defect germs have formal type UV+W^4. The two new mixed-support
pairs have type UV+W^2. Thus their actual maximal balanced (Z/q)^3
covers, q=5^n, have defects respectively

    (7q^2-3)/4       and       (3q^2-1)/2.

Every further actual etale cover dominating one of them has at least
this defect. The small parameter does have an additional bad datum,
but its abelian defect singularity is an ordinary double point rather
than the more singular A3 point. No unsupported transfer of the
high-degree table to alpha is being made.

## The complete table and the actual extra datum

Index the fifteen two-classes by the five singletons {0},{1},{2},{3},
{alpha}, followed by lexicographically ordered pairs of these indices.
A singleton means its pair with O. If R0 is a source pair polynomial,
put S0=F/R0. A branch datum has A=[u^4](S0 R0^2)S0. A mixed datum has

    J=R0' S0+2R0 S0',  K=Hasse_derivative_6(R0 S0^2),
    A=K(h)R0(u-h)^2,  J(h)=0.

The connection is r=3a''/a+(a'/a)^2, where a=A/F^2, and derivatives
are in u. The extra backup datum is R0=u-alpha, h=3alpha. Its two
bad cover polynomials are R=u(u-2) and R=(u-1)(u-3).

`scripts/check_genus_two_active_twists.sage --backup` checks the actual
quartic Cartier identity, endpoint ordinarity, and all 1275 twist
blocks. It also includes every root in the mixed degree-four algebras
and every pair among the five geometric dormant roots. Its complete
receipt is `Research/computations/backup_active_twist_table.json`.

## Why these jets concern actual covers

For each bad pair form the genuine etale double D->B with

    kappa^2=R, ell^2=S=F/R, v=kappa ell.

The genus is three. The fifteen underlying doubles are all
Jacobian-ordinary by the already audited complementary-elliptic test.
The actual tangent operator in the eta^(-1) frame sends a cochain b'
to A b^5. The coefficient A is the normalized active quartic itself;
no factor has been replaced by a convenient unrelated polynomial.

The affine coefficient algebra has components 1,kappa,ell,v over
k[u]. At either infinity the degrees of R are 1 or 2 and those of S
are 4 or 3. In both cases the regular tangent cutoffs are

    1: j<=-1, kappa: j<=-2, ell: j<=-3, v: j<=-4.

This gives the same six exact Laurent-cohomology representatives

    v/u, v/u^2, v/u^3, ell/u, kappa/u, ell/u^2.

The H1(O) basis is v/u,v/u^2,ell/u. The full four-component group of
involutions has order prime to five, so regularity at both infinity
points splits into these individual character components; cancellations
between different components cannot produce a missing regular section.

Use the formal line cocycle exp(Xv'/u'+Yv'/u'^2+Zell'/u') through
degree four, and its Frobenius pullback with X,Y,Z fixed. The exact
target quotient recursively replaces an infinity part c by
-(exp(D)-1)c. This is exactly the geometric Picard presentation already
audited for `bad_double_abelian_a3_family`, now with the actual A,R,S
of each case. The same negative-source-bundle argument makes the six
unchanged source cochains a basis of the twisted source H1.

All computations use Laurent polynomials, not a precision cutoff.
The script chooses independent constant row and column pivots, then
performs the full two-sided Schur elimination. It does not assume a
self-adjoint presentation or keep only the exceptional matrix entry.
Every constant matrix has rank five and its second semilinear iterate
also has rank five. The H1(O) Frobenius matrices are separately invertible.

Because the curve is ordinary, the actual completed abelian-cover
parameter ring has the same tangent coordinates as the formal Picard
ring. The normal-basis/Artin-Schreier transition proof of the canonical
family theorem identifies their four-jets, with coefficient Frobenius
retained. Both singularity types below are finitely determined by
these jets; this is enough to determine the actual full formal type.

## Exact finite outputs

The full six-by-six four-jets and their scalar Schur complements are
in `Research/computations/backup_bad_double_jet_0.json` through `_11.json`.
The generator is `scripts/backup_bad_double_jets.py --case-id i --output PATH`.
Each case takes about 0.17 seconds after startup. Coefficient tuples
use the basis (1,alpha,alpha^2).

| Case | Kind | Source R0 index | Bad R index | Hessian rank | Radical quartic |
|---|---|---:|---:|---:|---|
|0|branch|4|7|2|(3,1,3)|
|1|branch|4|9|2|(2,4,2)|
|2|mixed|4|6|3|not applicable|
|3|mixed|4|10|3|not applicable|
|4|branch|8|2|2|(3,4,3)|
|5|branch|8|10|2|(2,1,2)|
|6|branch|11|0|2|(3,2,2)|
|7|branch|11|12|2|(3,2,2)|
|8|branch|13|3|2|(0,0,3)|
|9|branch|13|5|2|(0,0,3)|
|10|branch|14|1|2|(2,0,0)|
|11|branch|14|6|2|(3,0,0)|

Both mixed determinants are nonzero: (0,0,3) and (3,4,2).
In every case all linear and cubic coefficients vanish. This is also
forced by the hyperelliptic involution ell->-ell, kappa->kappa, which
negates all three Picard cocycles. The constant exceptional source and
target characters agree, so its scalar Schur relation is even.

For rank two, choose the displayed nonzero radical vector. Because
the cubic part vanishes, transverse critical repairs start in degree
three, and do not change the nonzero radical quartic. Formal splitting
then gives UV+W^4, using only inverses of 2 and 4. For rank three,
the characteristic-not-two formal Morse lemma gives UV+W^2 directly.

## Balanced lengths and limitations

The ideal generated by q-th powers of a regular parameter system is
the intrinsic Frobenius-power ideal m^[q], so it is preserved by any
formal coordinate change. Hence the actual balanced defect is the
length of k[[U,V,W]]/(UV+W^r,U^q,V^q,W^q), with r=4 or 2.

For r=4, the canonical A3 theorem gives (7q^2-3)/4. For r=2, use the
semigroup k[[xi^2,zeta^2,xi zeta]]: retained monomials correspond to
0<=a,b<2q, a=b mod2, with a<q or b<q. If q=2m+1, their number is
2q^2-((m+1)^2+m^2)=(3q^2-1)/2. The first values are 37,937,23437,
compared with 43,1093,27343 for A3.

These are actual one-leg defect calculations. Neither the main nor
backup common-source problem is solved. In particular, no arbitrary
source is asserted to dominate these abelian towers, and no full
Witt obstruction has been computed by these Picard four-jets.

## Independent audit

The fresh audit checks the geometric applications, including the
degree-one R valuations, actual Frobenius twists, source cohomology
bases, Schur and transverse repairs, and the all-level formulas.
Its independent script `scripts/audit_backup_bad_double_jets.py`
uses nested quadratic Laurent algebras and the ratio det(M)/det(B),
and imports neither jet producer. It verifies 106 full-matrix
directional four-jets, all twelve constant and ordinary-Frobenius
matrices, all Hessians, all ten radical quartics, and character parity.
Runtime was 3.053 seconds. Independent quotient-ideal dimensions at
q=5,25,125 are A1:37,937,23437 and A3:43,1093,27343.

The receipt `Research/computations/backup_all_bad_double_jet_audit.json`
has SHA256 d78dd02c43487f95a857a7e63ac000ebf29a9a7bd0090538b06902922497896a.
The complete 1,275-twist replay also matches and is saved separately.
[Audit scope](../Research/audits/BACKUP_ALL_BAD_DOUBLE_GERMS_AUDIT_2026_09_11.md).
This does not newly audit every upstream classification theorem.
