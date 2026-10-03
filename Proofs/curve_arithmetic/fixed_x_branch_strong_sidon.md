# Proof: a five-coordinate additive certificate and its symmetry consequence

Version1,3 October2026. Independently accepted in the [whole genus-two audit](../../Research/audits/Q0_FOUR_GENUS_TWO_WHOLE_AUDIT_2026_10_03.md). The following finite verification was first inspected by hand and then checked once by a fresh addition-only source.

The accepted [fixed-X branch-stabilizer receipt](../../../litt3-computation-data/abelian_rigidity_20260922/branch_stabilizer.json) provides the ten roots in an F5-basis of F5⁸. Their first FIVE coordinates are the following, in the receipt's order:

|i|coordinates|
|---|---|
|0|(0,1,0,1,2)|
|1|(0,1,0,4,0)|
|2|(0,1,3,0,4)|
|3|(0,2,0,0,2)|
|4|(0,2,1,1,2)|
|5|(2,1,3,3,1)|
|6|(2,2,4,4,2)|
|7|(4,0,1,2,1)|
|8|(4,0,1,4,4)|
|9|(4,1,0,4,3)|

The55 unordered sums allowing repetitions have distinct first-five-coordinate vectors. This can be checked without field multiplication or finding roots. Group them by their first coordinate: the groups have sizes15,6,10,6,18 for first-coordinate values0,1,2,3,4. In the first FOUR coordinates the only collision is the pair(0,7) versus(1,8), both giving(4,1,1,3). Their fifth coordinates are THREE and FOUR. Every diagonal pair is included in this count. Thus equality in the field implies equality of unordered pairs. The [fresh source](../../scripts/genus_two/oct03_fixed_x_branch_sidon_gate.py) checked these exact assertions using only stored inputs in0.000045 CPU seconds. Its [external receipt](../../../litt3-computation-data/oct03_fixed_x_branch_sidon_gate/sidon.json) records the input SHA256, projected roots,55 distinct sums and the first-four collision. No earlier root or automorphism calculation was repeated.

An affine change sends a sum equality to the same equality after multiplying by its nonzero slope and adding twice its translation. Therefore the property holds in the centered quadratic coordinate as well.

For the stated degree-FOUR map, every ramified fiber has exactly ONE index-THREE point: two such points would exceed its degree. Hurwitz gives g(B)+THREE branch values, one of which is infinity. Hence there are exactly g(B)+TWO finite branch values, respectively THREE or FOUR. The identity f∘j=2C−f makes this finite set invariant under the reflection v↦2C−v. A FOUR-element invariant set has TWO distinct exchanged pairs with equal sum2C, forbidden by Sidon. A THREE-element invariant set contains the unique fixed value C and one exchanged pair, yielding r+s=2C with THREE distinct roots, also forbidden. Thus such a map-level symmetry is impossible.
