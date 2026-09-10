# Focused audit: actual p-covers and the Witt obstruction

Auditor: /root/audit_p_cover_witt_repair. Date: 2026-09-10.
Verdict: PASS. No mathematical blockers within the stated scope.
This is a bounded prose/computational audit, not Lean verification.

Scope: Sections 1--2 of `Research/CYCLIC_P_OBSTRUCTION_PLAYGROUND.md`,
`scripts/cyclic5_witt_obstruction.sage`, and its precision160 JSON receipt.
The canonical statement and dependencies of
`explicit_genus_two_witt_obstruction` were read through the workspace CLI.
Its audited higher inverse-Cartier recipe, first-lift identification,
nonzero rho, and etale naturality are inherited inputs, not re-audited.

## Group-module argument

Cartan--Leray for the actual torsor and the negative tangent bundle has
only coherent-cohomology row 1. Thus pullback identifies V_C with V_T^P
and gives H^i(P,V_T)=0 for i>0. Since the sole simple k[P]-module is k,
Ext^1(k,V_T)=0 implies injectivity by induction on finite composition
series; the group algebra is self-injective, so V_T is free. The same
holds for its relative Frobenius twist. No averaging by the cover degree
is used.

Norm identifies the coinvariants and invariants of these free modules,
and the downstairs map is their reduction modulo the augmentation radical.
Consequently D_T/JD_T is the downstairs cokernel and actual pullback is
induced by d mod JD_T -> Nd. This is valid with the Frobenius twist:
Frobenius fixes each group element and commutes with the norm.

For left modules, r -> rd has a left-ideal kernel. Every nonzero left
ideal of k[P] contains its unique simple socle kN. Hence Nd != 0
forces this map to embed the free module R, which splits by injectivity
of R. Iteration proves that dim ND_T is precisely the number of free
summands. This argument also verifies the side conventions for a
noncommutative p-group; matrix notation can equivalently use right
modules and the opposite ring. Nakayama gives the asserted minimum
number d_C of generators. When d_C=1, a cyclic quotient R/I has
nonzero norm exactly when I=0, equivalently dim D_T=|P|. The cyclic
Smith formula is consistent with this general argument.

## Geometric Psi dictionary

The multiplier is verified before taking cohomology, rather than inferred
from agreement of a base rank or a Serre functional. In the inherited
matrices, an infinitesimal variation contributes

    delta G = 5 z^-5 chi^5 E12.

Since rho=z Gamma12/5, IO^-1=SO MO^-1 and IU=MU SU^-1, the relevant
entries modulo5 are

    (IO^-1)11=aO=z^4 a,  (IU)22=a/mu.

Therefore delta rho=z*z^-5*z^4*a^2*chi^5/mu=a^2*chi^5/mu.
Here a^2=(u-t)(u-h)^2 and mu=4+4t. The sign can be reversed by the
chosen deformation-parameter convention; its image and the cokernel
are unchanged. The two anti-invariant factors multiply to a function
on C. Etale naturality now gives this identical operator upstairs,
acting on the actual AS algebra. The script also checks the full base
matrix from the audited variation and its Serre annihilator.

## Covers, cohomology, and completeness

The ordinary genus-two input gives exactly two dimensions of geometric
AS classes over F5, hence six lines. The fourfold semilinear Frobenius
product has order10, so F_(5^40) contains all fixed vectors; the
80-dimensional F5 calculation obtains two independent ones. Its six
projective representatives therefore cover all geometric connected
cyclic5 covers, not merely covers rational over F625.

Reduction of c^5-c gives an affine function fU and a remainder regular
at infinity. The equations wU^5-wU=fU and wO^5-wO=-rem glue by
wO=wU-c. Both are etale monic AS algebras. The formal local description
at infinity patches the finite algebra on the affine curve to the
actual proper etale cover (equivalently, normalization of the affine
function-field cover is unramified there). The nonzero geometric
AS class ensures connectedness.

The affine tangent frame D=eta^-1 is nonvanishing on U; its lattice at
infinity is z^2 k[[z]]D. The local AS power basis has transition
binomial(j,i)(-c)^(j-i), exactly as used in descending reduction.
Removing affine nongaps and then the local tail yields the fifteen
stated representatives. The five-step AS filtration has trivial
successive quotients; after tensoring T_C all H0 vanish. Thus each
step adds the full three-dimensional H1(T_C), establishing both
independence and completeness of that basis.

All coefficient extractions susceptible to the identified exact-constant
PARI issue use the protected helper, whose regression tests include
the initial cohomology representatives. Finite-precision extraction
retains precision checks. The assertion precision>3j+2 at a descending
step ensures that multiplication by subsequent powers of c, of pole
order at most3, cannot contaminate any retained coefficient through
degree1. This supplies a precision certificate, not just comparison of
two numerical ranks. The preimage verification uses fifth powers of
the actual semilinear preimage coordinates, as labeled in the JSON.

## Scope of the conclusion

Independent bounded replay:

    sage scripts/cyclic5_witt_obstruction.sage --precision 160

Exit0, all six rank13/defect2/obstruction-killed checks passed, together
with the explicit preimages, full base-matrix comparison, coefficient
regressions, and semilinear deck equivariance. Reported arithmetic time
was62.4063s. The existing exported JSON independently inspected here
records the same six verdicts at precision160 (62.6830s author run).

All six covers have defect2 and kill epsilon. Vanishing gives a marked
source W3 lift with the specified Hodge-line lift, by the inherited
definition. Such a repair cannot retain the C-leg: any compatible
target C3 still has nonzero rho, since its cokernel class is nonzero,
and negative-H1 pullback along an actual etale cover is injective.
Its pullback therefore remains a nonzero obstruction on that
cover-compatible source lift. The new available source deformations
are essential to the repair.

This constructs no second leg and no common cover of the fixed main
endpoints. The unmarked common-cover problem remains unsolved.
