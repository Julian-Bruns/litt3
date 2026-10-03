# Proof: an odd block degree forces a forbidden uniform double fiber

Version1, 3 October 2026. [Independent whole audit PASS](../../Research/audits/OCT03_PRIMITIVE_RANGE_AND_THREE_TEN_BLOCKS_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_three_ten_blocks_disjoint_infinity_exclusion.md).

Let F=k(t), E=k(B′), A=k(Γ), and L/F the single normal closure of E/F. Let M act on its thirty sheets and H=Gal(LA/A). The actual ten-sheet component T/A gives an H-orbit Δ with S10 action. Suppose M has three blocks of size ten.

## The cubic block field is actual and unique

Intersections of any such block system with Δ form an H-invariant partition of the primitive ten-point action. Since there are only three blocks, the partition cannot consist of ten singleton sets. Hence Δ itself is one full block. Every M-block system containing Δ is its set of M-translates; therefore the system is unique.

Take the distinguished E-sheet in Δ. Its block stabilizer contains both its point stabilizer and H. The corresponding field R is consequently contained in E∩A, with [R:F]=3 and [E:R]=10. The same argument shows uniqueness among all cubic F-subfields of E: such subfields correspond exactly to block systems of size ten in the transitive sheet action. Since [T:A]=[E:R]=10 and AE=T, the actual full tensor product E⊗R A is the field T.

The free involution sigma of E/C0 sends t to−t and preserves F. Thus sigma(R) is another cubic F-subfield and equals R. Its restriction sigma_R is nontrivial. Put Q=R^{sigma_R}. Then Q⊂C0. Because t∈R but t∉C0, C0R=E and R∩C0=Q. Degree comparison gives
\[
[Q:k(z)]=3,\qquad[C_0:Q]=10,\qquad[R:Q]=2.
\]
All these are actual separable fields; no X-map on R or Q is asserted.

## The quotient has genus below nine

The actual Γ→R has degree m. Hurwitz gives g(R)≤13 because g(Γ)=12m+1. Every zero and pole of t on B′ is simple, so R/F is unramified over t0 and t∞. Each of those fibers on R consists of three distinct points. The involution sigma_R maps each fiber to itself and has at least one fixed point in each odd-cardinality fiber. Its fixed points occur only in these fibers, because any fixed point maps to a fixed point of t↦−t. Its ramification count r_sigma is therefore2,4 or6. Tame Hurwitz gives
\[
g(R)=2g(Q)-1+r_\sigma/2,
\qquad g(Q)\le6.
\]

## A fixed point gives an unramified z-point of Q

Choose a sigma_R-fixed R-point above t0 and let A0 be its image on Q. The R/F index there is one and the F/k(z) index is two. The R/Q index is also two, since it is a tame fixed point. Therefore the Q/k(z) index at A0 is one. On the other hand every point of C0 above z0 lies in D1 and has index two over k(z). It follows that the actual map pi:C0→Q has at A0 a uniform double fiber
\[
\pi^*A_0=2E_0,\qquad\deg E_0=5,
\]
with E0 supported in D1.

## The opposite actual X-leg gives the contradiction

The fixed J(X) is absolutely simple of dimension nine, while g(Q)≤6. Thus both Hom(J(Q),J(X)) and Hom(J(X),J(Q)) vanish. In particular the correspondence (h2)_* pi*:J(Q)→J(X), defined using the actual C0 projections, is zero. Hence for any Q-points A,B the degree-ten norm divisors (h2)_*pi*A and (h2)_*pi*B are linearly equivalent.

Choose any Q-point A∞ above z∞. Its entire pi-fiber is supported on D2, the h2-infinity divisor, so (h2)_*pi*A∞=10O. By disjointness D1∩D2 is empty, (h2)_*E0 is an effective finite divisor E_X of degree five. Consequently
\[
2E_X\sim10O.
\]
The degree-zero line L=O_X(E_X−5O) is two-torsion and has a nonzero section after twisting by5O, hence also after twisting by7O. The established [fixed-X norm theorem](../../Theorems/jacobians/isogeny_sieves/trigonal_constant_norm_obstruction.md) says every nontrivial geometric two-torsion L has h0(L(7O))=0. Thus L is trivial and E_X∼5O.

But E_X is finite, so a function with divisor E_X−5O would have exact pole order five at O, contrary to the semigroup <3,10>. Equivalently L(5O)=span{1,x}, whose nonconstant elements have pole order three and retain multiplicity two at O in their degree-five zero divisors. This contradiction excludes the three-ten-block configuration.
