# A parameterized coreless etale family with small uniform exact zeros

Let k=Fbar_5, let n be a positive odd integer with 5 not dividing n,
and put a=3n. In the genus-three field

    S=k(z,w), w^2=z^8+3,
    x=(z^5+zw)/2, y=(zw-z^5)/2,

choose u,r,s in a separable closure satisfying

    u^5-u=2x^2, v=xy-u,
    r^a=ux^2, s^a=vy^2.

Put K_X=k(x,u,r), K_Y=k(y,v,s), L=S(u,r,s)=K_XK_Y.
The smooth projective models give ACTUAL finite etale surjections
X<-Z->Y, with K_X intersect K_Y=k inside L. Furthermore

    g(X)=g(Y)=4a-3=12n-3,
    div_X(dx)=(a-1)D_X, div_Y(dy)=(a-1)D_Y,
    deg D_X=deg D_Y=8,

where D_X,D_Y are reduced, and the nonzero regular exact differentials
dx,dy have equal pullbacks. Both leg degrees divide 5a. No claim that
either leg is Galois, or that this solves Litt3, is made.

In particular a=3 gives genus-nine examples with uniform zero order TWO;
a=9 gives the user's genus-33 counterexample with zero order EIGHT.
Thus exactness, a small fixed zero order, and actual projective etaleness
do not themselves force a core. The genus-nine endpoints here are NOT
the fixed trigonal X: they admit a degree-four map and no degree-three map.

For any prime ell not dividing 5a, taking arbitrary connected cyclic
etale degree-ell covers of BOTH endpoints, and a component of their
common pullback, again gives an actual coreless bi-etale span. The new
genus is 1+4ell(a-1), with 8ell zeros of the SAME order a-1.
For a=9,ell=7, both endpoints have genus225 and56 zeros of order8.
This last refinement does not supply the genus29 endpoint or the
ramified cyclic-seventh-root structure of the active application.

Version1,2026-09-08. User's a=9 proof and the entire a=3n extension:
medium independent prose audit PASS by /root/audit_order8_global_counterexample.
The final etale-refinement and gonality corollaries are elementary author
arguments, not separately audited. Exact symbolic checks are supplementary,
not substitutes for the global proof. This is not Lean verification.
[Audit metadata](../../Research/audits/ORDER_EIGHT_GLOBAL_COUNTEREXAMPLE_AUDIT_2026_09_08.md)
is reference-only. [Proof](../../Proofs/examples/coreless_exact_form_family.md).
