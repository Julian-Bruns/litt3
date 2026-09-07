# Proof: contact bounds for reduced unions

[Statement and audit evidence](../Theorems/Thm_contact_degree_bound.md).
The exposition below proves the reduced-union form directly; no
Jacobian-orthogonality, tame-inertia or branch-count hypothesis is added.

## 1. Global intersection budget

Use the statement's tensors of weight d and reduced zero divisors
eD_X,eD_Y, with p not dividing d(e+d). Put n=e+d and let m>=2
be least with e+dm=0 mod p. Thus2<=m<=p.

Let C be ANY finite reduced union of distinct preserving joint images.
Write Z_i for its smooth normalizations, a_i,b_i for their actual
etale degrees, and

    A=sum a_i, B=sum b_i,
    T=sum(g(Z_i)-1)=A(g(X)-1)=B(g(Y)-1).

Every formal branch is a smooth graph over both endpoint coordinates.
For the two fiber classes F_X,F_Y, the class C-B F_X-A F_Y is
orthogonal to the ample class F_X+F_Y. Hodge index gives C^2<=2AB.
If there are c normalized components, adjunction gives

    delta(C)=p_a(C)-sum_i g(Z_i)+c-1=C^2/2+T<=AB+T.    (1)

All branches are smooth, so each local delta is the sum of pairwise
branch contacts, INCLUDING contacts between distinct image components.

On the disjoint normalization the common reduced zero set S satisfies

    S=f^(-1)(D_X)=g^(-1)(D_Y),
    u=deg D_X=2d(g(X)-1)/e, v=deg D_Y=2d(g(Y)-1)/e,
    |S|=Au=Bv=2dT/e, |S|^2/(uv)=AB.                  (2)

## 2. Local slopes and contacts

At P in D_X,Q in D_Y choose parameters with

    s_X=x^e U(x)(dx)^d, s_Y=y^e V(y)(dy)^d,
    U(0)V(0)!=0.

A branch y=h(x) preserving the tensors has slope lambda!=0 satisfying

    h^e V(h)(h')^d=x^e U(x),
    lambda^(e+d)=U(0)/V(0).

Thus there are at most n slope classes. Different slopes have contact1.
For distinct same-slope branches of contact q>=2, compose one with the
inverse of the other. The resulting automorphism

    h(x)=x+c x^q+O(x^(q+1)), c!=0,

preserves a tensor x^e A(x)(dx)^d. At relative degree q-1 its pullback
changes by(e+dq)c: the unit ratio A(h)/A starts only in degree q.
Hence e+dq=0 mod p, so q>=m. Composition preserves contact order.

If r_PQ branches meet over(P,Q), with class sizes r_PQ,lambda, their
local contribution is at least

    binom(r_PQ,2)+(m-1)sum_lambda binom(r_PQ,lambda,2)
      >= ((1+(m-1)/n)r_PQ^2-m r_PQ)/2.

This is Cauchy--Schwarz on at most n slope classes and also holds for
zero or one branch. Sum over the uv grid points and apply it again:

    delta(C)>=(1+(m-1)/n)|S|^2/(2uv)-m|S|/2.

Combining with(1)--(2) gives the complete reduced-union inequality

    (m-1-n)AB/(2n)<=(1+md/e)T.

When m>n+1, division by T gives both stated degree bounds.
A single jointly minimal image is the special case c=1. For e=d=1
and p>=5, n=2,m=p-1, so B<=c_p(g(X)-1) and A<=c_p(g(Y)-1),
where c_p=4p/(p-4). No Cartier condition on the one-form was used.

## 3. Orbifold atlases use the same reduced union

Let q:C->S be a representable finite etale atlas of degree N, with S
smooth proper effective, and let a rational one-form on its coarse
curve B pull back to a regular simple-zero form on C. The normalization
of(C x_B C)_red is C x_S C: the latter is finite, normal, etale over
both C factors, and generically identical because S has trivial generic
inertia. Both total projection degrees are N and every component
preserves the pulled-back form. The preceding inequality gives

    N<=c_p(g(C)-1).

This includes wild stabilizers and characteristic-divisible atlas degrees.

## Limitation

In characteristic5, positivity requires m>e+d+1 while m<=5. The only
positive possibility is e=d=1: for(e,d)=(1,2),(2,1), m=2,3 respectively.
The general inequality remains valid but need not bound the degrees.
Taking tensor powers does not improve this local budget; the separate
etale-root theorem uses additional geometry, not an assumed larger contact.
