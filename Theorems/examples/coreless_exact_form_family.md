# Coreless etale spans sharing an exact differential with uniform zeros

Let k=Fbar_5, n>=1 odd with5 not dividing n, and a=3n. In

    S=k(z,w), w^2=z^8+3,
    x=(z^5+zw)/2, y=(zw-z^5)/2,

choose u,r,s in a separable closure satisfying

    u^5-u=2x^2, v=xy-u,
    r^a=ux^2, s^a=vy^2.

Put K_X=k(x,u,r), K_Y=k(y,v,s), L=S(u,r,s)=K_XK_Y.
The smooth projective models give finite etale surjections X<-Z->Y,
with K_X intersect K_Y=k inside L and both leg degrees dividing5a.
Moreover

    g(X)=g(Y)=4a-3=12n-3,
    div_X(dx)=(a-1)D_X, div_Y(dy)=(a-1)D_Y,
    deg D_X=deg D_Y=8,

where D_X,D_Y are reduced and the nonzero regular exact differentials
dx,dy have equal pullbacks.

Thus a=3 gives genus-nine endpoints with double zeros, showing that the
[shared simple-root criterion](../shared_tensors/shared_tensor_core.md)
is sharp. These endpoints have gonality4. The case a=9 gives genus33
with zero order8. The former has no common regular projective connection;
the latter has a common dormant one.

More generally choose arbitrary connected etale covers X'->X,Y'->Y
of degrees m_X,m_Y each coprime to5a. Every connected component of
their common pullback gives a coreless etale span X'<-Z'->Y'. On X'
(and respectively Y') the shared exact differential has

    genus=1+4m_X(a-1),     number of zeros=8m_X,
    zero order=a-1.

Connected cyclic covers exist for every such degree. Taking a=9 and
m_X=m_Y=7 gives genus225 endpoints with56 zeros of order8.

Version2. The construction for every a=3n was independently audited
PASS2026-09-08. The arbitrary coprime-degree refinement was checked in
a bounded medium review on2026-09-14, as was the gonality-four conclusion.
The connection corollaries follow from the cited spectrum theorem.
[Proof](../../Proofs/examples/coreless_exact_form_family.md) ·
[Original construction audit](../../Research/audits/ORDER_EIGHT_GLOBAL_COUNTEREXAMPLE_AUDIT_2026_09_08.md).
