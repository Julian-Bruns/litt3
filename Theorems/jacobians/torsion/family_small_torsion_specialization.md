# Small torsion from a two-variable jet test

Let C_t:v^2=u(u-1)(u-2)(u-3)(u-t) over bar(F5), t^5-t!=0, with
O=infinity, and put N=870. There are at most N geometric
parameters t for which some non-Weierstrass P has 8[P-O]=0 in J(C_t).
These exceptional parameters are Frobenius-stable. Thus if the degree
of t over F5 exceeds N, then

    C_t embedded in J(C_t) meets J[8] only in its six Weierstrass classes.

The [singleton-root theorem](family_singleton_root_exclusion.md)
excludes double-zero Cartier eigenforms for EVERY smooth parameter,
independently of its degree. Together with that earlier input:

For the fixed genus-nine X and such a high-degree t, any
ACTUAL coreless bi-etale span X<-Z->C_t having a clump has image size
at least four on C_t. This excludes BOTH zero and nonzero Cartier cases,
without any bound on either cover degree or the primitive tensor weight.
No clump is asserted to exist; larger images remain possible.

The high-prime-degree partners in bounded_atlas_partner_finiteness already
satisfy this bound: with B=336000 its K>B^2>N, and degree r>K over F25
implies degree over F5 at least r. Thus the SAME chosen pair has neither
a cored common cover nor a coreless common cover with singleton image.
The remaining coreless cases are not excluded.

The calculation uses the [general polynomial jet criterion](superelliptic_single_point_torsion_test.md),
valid for squarefree superelliptic curves in every characteristic
prime to their covering exponent, including torsion orders divisible
by the characteristic.

A general incidence principle is retained: in a smooth proper pointed
family over a connected smooth base curve, remove an open-and-closed
collection of allowed prime-to-characteristic torsion components.
If the relative Abel curve misses the remaining torsion in one fiber,
its intersection is supported over finitely many base points.

Version4,3 October2026. Later backup torsion excludes both branches
of the two-minor test, replacing the old Euclidean computation.
[Proof](../../../Proofs/jacobians/torsion/family_small_torsion_specialization.md).
