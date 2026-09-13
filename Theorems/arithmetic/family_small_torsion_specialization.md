# Small torsion from a two-variable jet test

Let C_t:v^2=u(u-1)(u-2)(u-3)(u-t) over bar(F5), t^5-t!=0, with
O=infinity, and put N=870. There are at most N geometric
parameters t for which some non-Weierstrass P has 8[P-O]=0 in J(C_t).
These exceptional parameters are Frobenius-stable. Thus if the degree
of t over F5 exceeds N, then

    C_t embedded in J(C_t) meets J[8] only in its six Weierstrass classes.

For EVERY t^5-t!=0, independently of its degree, no regular one-form
with a double zero is a Cartier eigenform (eigenvalue zero included).

Consequently, for the fixed genus-nine X and such a high-degree t, any
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

Version3,2026-09-13. The Hasse test and resultant bound have a
[bounded audit](../../Research/audits/HASSE_TORSION_BOUND_AUDIT_2026_09_13.md).
The inherited Cartier/clump arguments remain author prose.
[Proof](../../Solutions/arithmetic/family_small_torsion_specialization.md).
