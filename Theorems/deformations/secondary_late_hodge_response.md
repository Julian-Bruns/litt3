# Stability of the complete secondary late response

Version5, 2026-09-15. The result concerns genuine reached prefixes
and chosen whole repairs.

Use [integral oper calculus](integral_oper_calculus.md) with p>=5.
For r>=2 take source precision p^(r+4) and flat precision p^(r+3).
Vary X by -p^(r+1)N and insert its whole primary graphs p^r*q.
Suppose the complete next relative class R(N) is zero. Choose a
full primary preimage and whole regular repairs at source weight
p^(r+2) and graph weight p^(r+1). The remaining whole comparison
divided by p^(r+2) defines the secondary response modulo the delayed
relative image.

Compare indices r using the same original marking, coefficient
Frobenius, N and whole q through their required digits. Background
X agrees modulo p^4, current frames/connections modulo p³ and
genuine preceding potentials modulo p. Their actual variation is

    Delta P=p^r*(D³q/2-2*Pcur,0*Dq-q*D(Pcur,0)) mod p^(r+1),

with the actual patch signs. Here Pcur,0 is the residue CURRENT
potential. Any induced change of the next current connection is
retained through its actual p² coefficient. Higher preceding
coefficients are used in each absolute comparison.

For r>=3 the complete secondary response is independent of r.
At r=2 only the final-weight quadratic primary-increment sector
can differ. A fixed projection annihilating that sector gives the
same response for all r>=2. A sufficient condition is a multiplicative
residue filtration preserved by all residue operations, degree-zero
background factors and primary increments in F_d, with the normal
projection killing F_(2d). No degree bound on whole delayed repairs
is required.

For these assertions in the intrinsic quotient by im R, assume that
changes of whole regular primitives contribute only to im R. It
suffices that the normal sheaf have H0=0, so a full primary preimage
determines its primitive uniquely. Without this global condition,
the local comparison still holds for matched whole choices; it does
not identify an obstruction modulo all possible primitive choices.

The reference secondary comparison is r=2, the sixth comparison
when the new source is in the fourth slot. Matching only two flat
digits proves the earlier relative theorem and does not identify
this response. The third-slot fifth slope is a different input.

## A computation from the whole first variation

Let L:U->C be a homomorphism of abelian groups, with multiplication
by p injective on C. No torsion or completeness condition on U
is needed. In the application U,C record the complete admissible
directions and whole normal cochains, and L is their actual
first-variation operator. Its reduction must
represent the COMPLETE primary equation, including whole regular
graph variables. In the oper application L also includes the genuine
preceding-potential response and the induced current-connection reframe.
Put

    K0=ker(L mod p),  O0=coker(L mod p).

For k in K0 choose an integral lift u. The relative response is

    R(k)=[L(u)/p] in O0.

For k in ker R choose v such that L(u)+p*L(v) is p²-divisible.
Then the secondary response is

    S(k)=[(L(u)+p*L(v))/p²] in O0/im R.                 (*)

Both maps are independent of the displayed choices and additive
over Fp. Moreover S(k)=0 if and only if k has a lift t in U with
L(t)=0 modulo p³. All primary and delayed choices are allowed in
this equivalence. Formula(*) uses only L modulo p³; its numerator
must be combined before the second division.

For the actual oper first variation, L modulo p³ requires source
data modulo p^4, current frames/connections and whole directions
modulo p³, and the preceding potential and its normalized variation
only modulo p. The source exponential through j=3 and Taylor
recurrence through j=3 suffice. A central square-zero bookkeeping
variable fixed by coefficient Frobenius computes L. This is a
prime-adic first variation, not a derivative of residue Frobenius.
At r=2 the specified projection must still kill the quadratic
exception; the recipe computes its linear part. The full primary
and whole-primitive hypotheses above remain essential for identifying
(*) with the intrinsic geometric secondary obstruction.

The [marked-torsor theorem](marked_obstruction_torsors.md) gives the
separate global extension criterion. It needs actual surjectivity of
the resulting secondary map at each reached prefix; the maps need
not be constant. This local theorem is one way to establish those
surjectivity conditions from a fixed finite comparison.

[Human-readable proof](../../Proofs/deformations/secondary_late_hodge_response.md).
