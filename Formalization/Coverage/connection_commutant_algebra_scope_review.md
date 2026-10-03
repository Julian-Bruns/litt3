# Actual connection commutant as a literal quotient algebra

Six new solution modules build and pass the two-root [focused audit533](../../../litt3-computation-data/formalization-20261003/verification/20261003T111831Z/report.json). The roots are `OneVariableConnectionCentralizerAlgebra` and `RestrictedConnectionCentralizerReducedness`. All 533 transitive Litt3 theorem declarations use only `Classical.choice`, `Quot.sound`, `propext`; forbidden dependencies and captured source changes are both zero. All current captured hashes, including the six new files, have been compared with the report and match. Independent mathematical acceptance remains distinct. No canonical source theorem is promoted by this widening.

Throughout the actual connection conclusions, Kp means the literal subfield `{x ∈ K | ∃y ∈ K, y^p=x}`, with its genuine inclusion into K. The **whole commutant here is the Kp-linear commutant in End_Kp(K)**. It is not a claim about all commuting operators over an arbitrary smaller original derivation base, where the field need not have finite dimension. K itself need not be perfect. All primes, including two, are retained.

## Generic polynomial-value quotient

`PolynomialValueAlgebras.actualPolynomialValueAlgebraEquiv` works over any field B and any B-algebra A that is a ring, including noncommutative or zero targets. For every actual x∈A it gives the genuine algebra equivalence
AdjoinRoot(minpoly_B(x)) ≃_B range(aeval_x).
The minimal-polynomial kernel equality and the actual quotient-to-range equivalence construct this map; integrality, nontriviality and a polynomial presentation are not assumptions. The companion theorem identifies the image of **every original polynomial class** as its literal value P(x). If x is nonintegral, minpoly=0 and the equivalence retains the injective full polynomial algebra. In a zero target the quotient is the genuine zero quotient. These boundary cases are not suppressed by an unnecessary nontriviality premise.

## Entire actual connection algebra and basis

`RestrictedConnectionCentralizerAlgebra` assumes an actual full one-parameter p-basis b of K over Kp and an actual Kp-derivation D with D(b.parameter)=1. For every f∈K the literal original connection is L=D−f, and the actual scalar curvature is c=D^(p−1)(f)+f^p. The previously proved theorem derives c∈Kp; scalar membership and the full restricted identity are not extra premises.

The module constructs
AdjoinRoot(X^p+C(c)) ≃_Kp centralizer({L})
in the actual endomorphism algebra. It composes the already proved **full** minimal-polynomial equality, the generic polynomial-value equivalence, and the earlier whole-centralizer equality derived from an actual constructed cyclic vector. Its map sends the literal adjoined root to the **same** L and every polynomial class to the same P(L). The quotient is not merely a noncanonical algebra of the same dimension. The actual whole-commutant dimension p is derived from this quotient.

`RestrictedConnectionCentralizerBasis` transports the genuine monic-quotient power basis, including the explicit finite-index reindexing. It yields a full basis of the entire commutant with values exactly 1,L,…,L^(p−1). It also proves that any two actual Kp-linear operators commuting with L commute with each other: both are actual polynomial values, and the polynomial source is commutative. No matrix normal form, supplied cyclicity, supplied commutativity, sample rank computation or preselected family of commuting operators is used.

`OneVariableConnectionCentralizerAlgebra` removes the p-basis input for a genuine field K finitely generated of transcendence degree one over perfect characteristic-p constants k. An original derivation D over an arbitrary commutative ring R, normalized at an actual t with D(t)=1, is canonically rebased to Kp **without changing its function or the connection function**. Actual FG/trdeg-one results derive the full p-basis. The conclusion constructs c∈Kp with its literal original curvature formula, the entire commutant quotient equivalence, and the full power basis. R and k need no supplied scalar-tower relation and there is no finiteness-over-R assumption. Its centralizer remains explicitly Kp-linear.

## Correct pure-power branch criterion

`PrimePowerQuotientNilpotency` first proves, over **any field and any prime degree**, that X^p+C(c) is irreducible exactly when −c has no pth root in that field. This theorem does not require characteristic p. The monic-quotient degree argument also proves every power below p of the literal root difference root−a is nonzero, for arbitrary a, without a characteristic premise.

In characteristic p, if a^p=−c, the same difference has pth power zero. Characteristic p of the actual quotient is **derived** by injectivity of the coefficient inclusion, using the positive degree p; it is not assumed or obtained from a potentially zero quotient. The module consequently proves that the actual quotient is reduced iff there is no original scalar root. In the root branch it constructs an explicit nonzero nilpotent of exact exponent p; in the other branch actual irreducibility gives the domain.

`RestrictedConnectionCentralizerReducedness` transports this exact criterion through the literal connection algebra equivalence. Both `IsReduced` and `IsDomain` of the **entire actual commutant** are equivalent to
∀a∈Kp, a^p≠−c.
When this holds, every nonzero commutant element is a unit of the commutant itself, with inverse coming from the genuine irreducible quotient. When an original Kp root a exists, the module constructs a commutant element whose underlying actual operator is exactly L−a·id, proves its pth power is zero, and proves every smaller power is nonzero. In particular **c≠0 is not asserted to make the commutant a field**: nonzero curvature and absence of a Kp scalar root are different conditions.

## Exact six-file pins and boundary

The current hashes in audit533 are:

| Solution module | SHA256 |
| --- | --- |
| PolynomialValueAlgebras | a6d44afa6f0b33f895cf450bef1a1de59a7557140a377859c689079300579547 |
| RestrictedConnectionCentralizerAlgebra | bc550b0a34943d9631ba2e4f232b1d04b3d460563b448dfd1a1209966680cb7a |
| RestrictedConnectionCentralizerBasis | d39f59a65640d005a3759960e5a341fb131cde5b3d6288a7a9690109f17f33cb |
| OneVariableConnectionCentralizerAlgebra | b68fae32589b2025b76d9815a6e0b117d609533844f43f97d4f262e9bd448020 |
| PrimePowerQuotientNilpotency | 9c0abc1b81d24f5a7d0852a101fa5c8f578b0eca5133247e9ecc853d2be6fd5a |
| RestrictedConnectionCentralizerReducedness | 6d6c9046c41079645db3cd76356681bb03a7cc005b63af3c8a85062281799983 |

These are original field/operator foundations, with symbolic proofs uniform in p and no computation certificate. No global H0 commutant, Cartier-height bound, Picard/cohomology identification or common-cover conclusion is inferred. The two newer original scalar-root multiplication-gauge modules are outside this six-file snapshot and require their own build/evidence.
