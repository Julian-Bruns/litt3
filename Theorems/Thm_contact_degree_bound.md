# A parameterized contact bound retaining both etale maps

Let k be algebraically closed of characteristic p>0. Let
X <-f- Z -g-> Y be a jointly minimal finite etale span of smooth
projective connected curves of genus at least two. Put a=deg f,
b=deg g, sX=g(X)-1, sY=g(Y)-1, t=a sX=b sY.

Assume nonzero regular weight-d tensors have equal actual differential
pullbacks and divisors eD_X,eD_Y, with both D reduced, e,d>0, and
p not dividing d(e+d). Put n=e+d and let m>=2 be least with e+dm=0
modulo p. Then

    ((m-1-n)/(2n))ab <= (1+md/e)t.

If m>n+1, then

    b <= 2sX n(e+md)/(e(m-1-n)),
    a <= 2sY n(e+md)/(e(m-1-n)).

The same inequality holds for a finite REDUCED union of distinct
preserving joint images, using total degrees A,B,T=sum(g(Z_i)-1).
It includes contacts between different components.

In particular, for p>=5 a shared one-form with simple zeros gives
b<=4p sX/(p-4) and a<=4p sY/(p-4). More generally, if an effective
orbifold atlas C -> S of degree N pulls back a rational one-form on
the coarse curve to a regular form with simple zeros, then
N<=4p(g(C)-1)/(p-4). No Jacobian or tame-inertia hypothesis is needed.

Evidence: contact and root-extension audits PASS, 2026-09-06; the
general atlas argument was extracted from the checked genus-nine note.
[Proof](../Solutions/Sol_contact_degree_bound.md).
