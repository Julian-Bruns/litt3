# Exact local matching and sharpness of the contact bound

Let k be algebraically closed of characteristic p>0, d>=1 with p not
dividing d, and e>=0. For a formal parameter x let

    s=x^e a(x)(dx)^d, a in k[[x]]^*.

Choose 1<=r<=p-1 with rd=1 mod p, and use the formal generalized
Cartier operator on s^r. Its vanishing is equivalent to BOTH p not
dividing n=e+d and the existence of a formal parameter t with

    s=t^e(dt)^d.

Under these equivalent conditions, put m in {1,...,p-1} for the
integer satisfying n+dm=0 mod p. ALL formal automorphisms preserving
t^e(dt)^d are exactly

    h(t)=lambda*t*(1+t^m B(t)^p)^(d/n),
    lambda^n=1, B in k[[t]].

The rational exponent means the unique n-th root with constant term1
of (1+t^m B^p)^d; it is not a characteristic-zero binomial convention.
Two distinct such branches with the same slope have contact order
1+m+p*j for some j>=0. For any number N of branches, the least possible
sum of pairwise contacts is exactly

    binom(N,2)+m*min(sum_(i=1)^n binom(N_i,2)),
    N_i>=0, sum N_i=N.

The minimum is attained by balanced N_i and constant choices of B.
These attaining branches are algebraic power series. Thus imposing ALL
formal tensor and Cartier equations cannot improve this contact bound
at one point. In particular, the local input to contact_degree_bound is
sharp, even without truncating its differential equations.

This is LOCAL. It supplies no smooth projective common source and no
everywhere-etale maps. Global realization may impose further restrictions.
At e=0 it also says all nonvanishing Cartier-zero tensor germs of the
same weight are formally equivalent. No endpoint-only finite-jet test
of these germs distinguishes curves.

Version1,2026-09-08. Author prose, not independently audited.
[Proof](../Solutions/Sol_cartier_zero_formal_matching.md).
