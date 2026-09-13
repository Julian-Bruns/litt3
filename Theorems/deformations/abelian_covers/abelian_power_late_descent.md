# Finite-abelian late descent

Version2, 2026-09-13. The former nodal, elementary and finite-abelian
results are consolidated here. Independent mathematical
[audit](../../../Research/audits/LATE_DESCENT_CONSOLIDATION_AUDIT_2026_09_13.md):
PASS. Audited prose, not Lean verification.

Over k=bar(F5), let h:T->C be an actual connected finite etale G-cover
of smooth projective curves,
g(C)>=2, G=product_(i=1)^r C_(5^b_i), with integers r>=1, b_i>=1
and A=sum_i b_i>=2. Fix on C a
regular rank-two projective oper with nowhere-zero nilpotent p-curvature,
its specified active-admissible maximal-Higgs periodic filtered tuple,
projective grading and actual flat square-trivial twist. Compatibility
at W_j extends this full tuple through W_(j-1). The original upper
tuple is its pullback along h, including the grading and flat twist.

Put O=W_(A+1)(k), R=k[G], J=augmentation, N=sum G and
S=sum_i(5^b_i-1). On genuine descended references assume the tangent
and normal H1 lattices are free O[G]-modules, pullback identifies the
lower lattices with invariants, and pulled-back negative two-affine
Cech complexes have integral deck-linear cohomology sections and
boundary primitives. Retain the maximal-Higgs tangent/normal
identification, negative tangent H0, H1(C,omega_C^2)=0, auxiliary
global-oper extension and uniqueness of the marked maps, Hodge lines
and prescribed tuple.

In separate source/target bases assume the primary operator is
diag(I_(3g(C)-4),f) Phi, f in J^2, with nonzero quadratic symbol Q
satisfying Q(v)!=0 for every nonzero ORIGINAL v in F5^r. The invariant
lower block is diag(I,0) Phi and its kernel pulls back to kN.
Coefficient Frobenius Phi fixes abstract deck generators.

Write F_d=Ann(J^(d+1))=J^(S-d), with J^j=R for j<=0. If F4 subset(f),
then for n>=A+1 a given compatible C_n and original h_n:T_n->C_n have
the following property: every GIVEN compatible T_(n+A+1) extending T_n
forces its GIVEN T_(n+1) to descend compatibly along h, over a compatible
C_(n+1) extending C_n and h_n, with the full supplied tuple. Without
F4 subset(f), the range n>=A+2 still holds. For G=C5^2 the range is
n>=3 without any discriminant or extra image condition.

Balanced exponents b_i=b>=2 satisfy F4 subset(f) for every
multiplicity-two f. For r=3,b=1 it suffices that the formal scalar
germ, up to a unit, is uv+w^s for some 2<=s<=4; this includes
the cubic case s=3. No arbitrary formal coordinate change is applied to
an unequal-power ideal.

## Integral content

For any additive deck-equivariant L:O[G]->O[G] reducing to f Phi,
with arbitrary higher corrections, the whole combined repair satisfies

    Lx=Neta mod5^A     => xbar inF2 and Tr(x) in5^A O;
    Lx=Neta mod5^(A+1) => xbar in kN and etabar=0.

For G=C5^2, Lx=Neta mod25 with etabar=0 further forces xbar inF1.
Every binary multiplicity-two f has F2=J6 subset(f); a nonsingular
binary quadratic has the stronger F3=J5 subset(f). Pointwise torsor
products satisfy F_i F_j subset F_(i+j); these are not group-algebra
products.

The proof establishes the sharp general image bound

    J^(d+(r-1)(q-1)) subset(f)
    in k[x1,...,xr]/(x1^q,...,xr^q),

for an infinite field of characteristic p, a p-power q, and f of
multiplicity 1<=d<q. It gives both the binary and balanced image claims.

## Actual applications and boundary

For each of the ten main branch bad doubles and twelve backup bad
doubles in the [flag theorem](abelian_defect_flags.md):

- all31 elementary rank25 planes, including defect10, satisfy
  given T6 => its given T4 over given C3;
- the maximal elementary rank125 cover satisfies
  given T_(n+4) => its given T_(n+1) over given C_n for n>=4,
  in particular T8 => given T5 over C4;
- balanced (C_(5^b))^r covers, r=1,2,3 and b>=2, satisfy the general
  late conclusion from n>=rb+1.

Actual cyclic quotient defect2 verifies the ORIGINAL rational-direction
condition. Formal scalar coordinates check only the image condition.
A full given upper tower descends by iteration once its specified
initial lower stage has descended. The longest supplied upper lift is
not asserted to descend. No initial descended stage, common compatible
tower or factorization of an arbitrary common source is supplied.
The unmarked common-cover problem remains unsolved.

[Proof and retained evidence](../../../Proofs/deformations/abelian_covers/abelian_power_late_descent.md).
