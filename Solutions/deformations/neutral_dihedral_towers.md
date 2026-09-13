# Proof: actual cyclic specialization and semilinear parity

[Statement](../../Theorems/deformations/neutral_dihedral_towers.md).
Author /root,2026-09-11. Bounded independent audit PASS by
/root/audit_actual_heisenberg_defect, with reflection identification
and normalization at each Witt level made explicit below.

## 1. Actual connected covers

The ordinary elliptic curve E has compatible iterated Verschiebung
isogenies E_a→E with cyclic etale geometric kernel C_(5^a). The
ramified degree-two extension D/E is linearly disjoint from each
odd-degree cyclic extension. Thus W_a=D x_E E_a is connected, smooth
and projective, and W_a→D is finite etale cyclic of degree q=5^a.
This is the same geometric construction as in the proof of
ordinary_dihedral_spin_growth, using the selected resolvent's E.

The original free double involution of D acts by [-1] on E. Its
product with [-1] on E_a gives tau on W_a. It remains free, since
its image on D is free, and it inverts cyclic translations. The
resulting2q automorphisms are the full degree over C, proving the
dihedral Galois assertion. Quotienting by tau gives the actual T_a.
Choose compatible isogenies; then all adjacent W and T maps are
actual finite etale maps. Reflection subgroups are nonnormal when
a>=1. Etale Hurwitz gives the stated genera.

The unique anti-invariant geometric Artin--Schreier direction identifies
the first stage with the already audited W_1. All reflection lifts
differ by a cyclic translation and are conjugate, since2 is invertible
modulo5. The first-stage identification can therefore be made
tau-equivariant, identifying the ORIGINAL T_1 and its marking.

## 2. The actual Hodge map specializes to the first cyclic level

Put R_q=k[e]/e^q, e=sigma-1, with compatible cyclic generators.
Actual tangent cohomology V_a=H1(W_a,T_(W_a)) is free rank6 over R_q
by etale_p_witt_obstruction. Both the linearized source and target
of the actual Psi_a are free of this rank. Coefficient Frobenius
fixes the abstract group basis.

For K=<sigma5>, the kernel of C_q→C5,

    sigma5-1=e5,       N_K=e^(q-5).

The norm identifies the quotient modulo e5 with the K-invariants
of each free module. The same identification is used on source
and target. It commutes with coefficient Frobenius and with tau,
since inversion preserves N_K. Etale naturality on invariants
therefore identifies the quotient map with the ACTUAL Psi_(W_1).

Modulo e, the map is Psi_D and has rank5. Eliminate five unit
pivots over the local ring R_q, leaving one scalar f_q. Its reduction
modulo e5 has exact order2, by the audited first-stage Smith result.
Thus f_q=e² times a unit in R_q. This proves

    coker(Psi_a)≅R_q/(e²),       d(W_a)=2.

The argument does not infer a high-level operator from a numerical
defect: the norm specialization identifies the actual cohomology maps.

## 3. Fitting types, including coefficient Frobenius

Let v=sigma-sigma^(-1)=2e+O(e²). It is a uniformizer of R_q and
tau(v)=-v. Coefficient Frobenius fixes v. The eventual kernel and
image of Psi_a are R_q-submodules, since its coefficient transport
is an automorphism of R_q. The finite-dimensional semilinear Fitting
decomposition is therefore an R_q-linear direct sum. Its summands
are free, as direct summands over a local ring.

Reduction modulo v of its bijective part is bijective, and of its
nilpotent part is nilpotent. Uniqueness of the actual lower Fitting
decomposition gives R_q-ranks4 and2 respectively. The nilpotent
part on D is the two-dimensional pullback from C, hence tau-positive.
Average lifts of a basis under tau, dividing only by2. Nakayama
makes these tau-fixed lifts a free R_q-basis upstairs.

In this basis Psi_nil=M(v)Phi, with EVEN matrix entries in v. The
constant coefficient obeys M_0 M_0^[5]=0, the actual semilinear
two-step nilpotence, not necessarily M_0²=0. Consequently

    M(v)M(v)^[5]=v²U(v).

The Smith factors of M are1,v²: it has mod-v rank1 and cokernel
length2. Therefore det(M) has nonzero v² coefficient, and the
product determinant has nonzero v4 coefficient. That coefficient
survives for EVERY q>=5, including q=5. Hence det(U) is a unit.
This is a coefficient calculation, not cancellation of a zero divisor.
U can be chosen even.

Even iterates are v^(2j) times invertible semilinear maps. Odd
iterates acquire the two Smith lengths from M. Thus

    rank Psi_nil^(2j)=2 max(q-2j,0),
    rank Psi_nil^(2j+1)=max(q-2j,0)+max(q-2j-2,0).

These are exactly the ranks of two nilpotent blocks q-1,q+1.
No successive coefficient operators were commuted.

On tau-positive vectors put w=v². The nilpotent part is free rank2
over k[w]/w^((q+1)/2); the induced matrix has Smith factors1,w,
and its square is w times an invertible semilinear map. The ranks
decrease by1 at each iterate, giving one block q+1. The negative
part similarly gives one block q-1. Taking order-two invariants
is exact and identifies the positive map with Psi_(T_a). Therefore
d(T_a)=1 and, since dimH1(T_a,T_(T_a))=3q, its bijective dimension
is2q-1. The closure's bijective dimension is4q.

This uses the actual base Fitting type, involution, freeness and
first-stage Smith result together. Smith length alone would not
determine the semilinear block lengths.

## 4. Increasingly long finite repairs on DIFFERENT sources

At a=0 the specified C2 is compatible. Suppose T_(a-1) has a
compatible W_(a+1) lift. Lift the ORIGINAL adjacent degree-five
map from T_a over it, with the prescribed full tuple. Choose any
smooth next lower curve extension, and lift that etale cover.
Naturality makes its next upper obstruction class a pullback of
the lower one. Both special-fiber defects equal1, so the actual
neutral-degree-five theorem makes that pullback zero. Vary the
upper curve digit by a preimage under Psi to kill its representative.
The original Hodge line then lifts uniquely, with the specified
grading and flat periodicity line. This constructs a compatible
T_a through W_(a+2).

The newest correction may abandon the adjacent map at that digit.
Earlier truncations retain that adjacent map, not an asserted
composite map to C above W2. The original W2 marking is preserved.
This induction changes source as a grows and supplies no full
inverse system on any fixed T_a.

If a compatible third truncation also extended T_a→C over some
C3, naturality before taking obstruction cokernels would give

    0=rho_(T_a)=h_a^*rho_C.

Injectivity of individual etale pullback on negative tangent H1
would force rho_C=0, contradicting the audited epsilon_C!=0.
Thus the finite repairs do not repair that original map to C.

## 5. Full-tower existence remains a first-stage question

A full compatible T_1 tower pulls back along the original finite
etale map T_a→T_1, giving a full tower on T_a.

Conversely, pull a GIVEN full T_a tower along its original etale
double W_a→T_a. It has its actual deck involution tau. The cyclic
map W_a→W_1 is neutral because both defects are2. The audited
neutral-Galois full-tower theorem descends this GIVEN tower along
the original map, retaining its cyclic deck action.

The descended involution requires an actual normalization argument.
At every Witt length and for each lifted cyclic deck element g,
the automorphisms tau*g*tau^(-1) and g^(-1) have the same special
fiber. Lifts of a specified automorphism of a hyperbolic curve are
unique through nilpotent thickenings, since H0(T)=0. They therefore
agree at every length. The actual cyclic action is normalized by
tau, which descends to W_1. Its order-two relation and freeness
persist. Quotienting gives the ORIGINAL marked T_1 tower.

The tuple also descends: the original upper tuple is tau-equivariant
because it came from T_a; faithful etale descent and the prescribed
unique Hodge/graded identifications retain that equivariance on W_1.
The actual flat twist is included. No involution was presumed on an
arbitrary lower lift, and no unrelated Galois refinement was used.

## Independent checks

Audit: NEUTRAL_DIHEDRAL_TOWERS_AUDIT_2026_09_11.md, PASS with the
two explicit clarifications incorporated above. The independent
scripts/deformations/cyclic/audit_neutral_dihedral_towers.py uses no producer module.
Fourteen nontrivial-coefficient even matrices at q5,25,125 give618
independent ranks matching all formulas, including cases where
M0*M0^[5]=0 but M0²!=0. Separate six-column norm tests check both
source and target specializations and inversion equivariance.
Runtime11.93s on one CPU; receipt
Research/computations/neutral_dihedral_towers_independent_audit_20260911.json.
These matrices test the algebraic proof; they are not substituted
for the actual geometric Hodge maps or higher Witt calculations.
