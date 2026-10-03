# Proof: the ordered isotropic directions yield a forbidden one-branch double cover

Version1,3 October2026. Independent whole review [PASS](../../Research/audits/TWO_ORBIT_QUADRATIC_COMPLEMENT_OBSTRUCTION_AUDIT_2026_10_03.md); see the [statement](../../Theorems/quotient_geometry/two_orbit_quadratic_complement_obstruction.md).

## The complement has the same simple discriminant

Perfection of F and saturation of I give a surjective bundle map F→I*⊗S, with kernel K=I^⊥ of rank TWO. Both restricted forms are generically nondegenerate. Over a DVR trivialize S and write the Gram matrix of I. The exact sequence identifies F/(I+K) with the cokernel of I→I*. Its length equals the valuation d of detGram(I). The generically full-rank inclusion I⊕K→F therefore has determinant valuation d. Taking determinants of the compatible forms gives
\[
v(\det\operatorname{Gram}(I))+v(\det\operatorname{Gram}(K))
=2v(\det(I\oplus K\to F))=2d.
\]
Hence the Gram determinant of K has valuation d. It has precisely a simple zero at every point of D and no other zero. In particular K's quadratic form has rank ONE there, and is perfect elsewhere.

## Construct the actual connected quadratic cover

In the projective line bundle P(K), take the generic two isotropic directions, and normalize C in their quadratic splitting field. Call the resulting cover C′→C. Locally, a binary symmetric form with determinant a unit is étale-split over the strictly henselian completed base. At a simple determinant zero its matrix can be diagonalized as a unit plus a uniformizer times a unit, so its two directions are obtained by adjoining a square root of that uniformizer times a unit. Thus C′→C is finite of degree TWO, ramified exactly at D, with index TWO and different ONE there. The odd valuations of the discriminant ensure the quadratic field is not split, so C′ is connected.

The compatible projective G-action preserves the two-direction locus. Scalar multipliers act trivially on projective directions, so they create no new cocycle in this cover. Each g therefore gives an actual lift to C′ satisfying the group law. This actual G-action is faithful since it is faithful on C.

## The tame orbit creates no second branch downstairs

At a point of H the form is nondegenerate. In an eigenbasis with eigenvalues λ and−λ, covariance with the value-line scalar−λ² forces the diagonal entries of its Gram matrix to vanish. Its cross entry is nonzero. Its two isotropic directions are therefore exactly the two eigenlines. The order-two stabilizer fixes EACH direction. Both points of C′ over such a point consequently have the same order-two stabilizer as the original point of C.

At a point of D there is a UNIQUE ramified point of C′ above it. Its G-stabilizer equals the original odd-order stabilizer: any element fixing it fixes its image, and every element stabilizing its image fixes the unique preimage. At ordinary points the G-stabilizer is trivial.

## The coarse quotient has exactly one branch point

Set V=C′/G. The inclusion of invariant fields gives an actual separable degree-TWO map V→C/G=P¹: the degrees in the two actual Galois quotient towers are both |G|, while [k(C′):k(C)]=TWO.

Ramification indices multiply in these towers. Over the D branch value, C′→C→P¹ has index twice the original odd stabilizer order, whereas C′→V has that original order. Thus V→P¹ has index TWO. Over H both towers have the same order-two stabilizer, so V→P¹ is unramified. It is unramified elsewhere as well. Since D is ONE G-orbit, there is precisely ONE branch point downstairs. The degree-TWO extension is tame because p≠2, so Hurwitz gives
\[
2g(V)-2=2(-2)+1=-3,
\]
an impossibility. This proves the statement.

No eigendirection on C is asserted to be rational: the connected ramified cover C′ is used, then its actual quotient. Nor is a ramified C′ substituted for either original étale endpoint leg.
