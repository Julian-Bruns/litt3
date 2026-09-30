# Proof: recover each endpoint and rule out the two cyclic ambiguities

[Statement](../../Theorems/shared_tensors/differential_ratio_joint_field.md).
Use Cartier(a^p alpha)=a Cartier(alpha). Cartier commutes with separable
function-field inclusions: a separating parameter remains a p-basis,
so the same expansion computes rational Cartier in both fields.

## Coprime degrees recover the differential field

Since theta=y^(−p)F^((p−2)/3)dx, Cartier extraction gives

    Cartier(theta)=ell dx/y,
    q=Cartier(theta)/theta=ell y,
    dq/theta=Q=ell' F+(ell/3)F'.

The point at infinity has pole orders3 for x and d for y. Thus q,Q
have unique poles of orders a=3deg ell+d and 3deg Q. The extension
[k(X):k(q,Q)] divides both function degrees and is therefore one.
If theta descends to a separable intermediate field, so do q,Q.
For Y, eta recovers u=(Cartier(eta)/eta−c0)/c1 and v=du/eta.

## The differential ratio removes both remaining ambiguities

Put N=k(x,delta) and E=N(y). Since theta and eta=delta theta descend
to E, differential recovery gives E=M. If E≠N, the cubic Kummer
extension has an automorphism sigma(y)=zeta y fixing x,delta. It gives

    sigma(eta)=zeta eta,
    sigma(Cartier(eta)/eta)=zeta^(1/p−1) Cartier(eta)/eta
                         =zeta Cartier(eta)/eta.

Hence sigma(u)=zeta u+(zeta−1)c0/c1 and sigma(v)=v. Its restriction
to k(Y) is a nontrivial order-three automorphism fixing v. This is
impossible since [k(Y):k(v)]=5. Therefore M=k(x,delta).

Next put N=k(u,delta), E=N(v). Recovery from eta and theta=eta/delta
again gives E=M. A nontrivial quadratic involution would send
theta↦−theta, q↦q and Q↦−Q. Since Q≠0 and p is odd, it would
restrict to a nontrivial involution of k(X)=k(q,Q) fixing q, contrary
to the odd degree [k(X):k(q)]=a. Thus M=k(u,delta).
Both intermediate fields are separable under K because they contain
the separating parameter x or u, respectively.

## Actual quotients and spin sections

In a tower of finite maps of smooth curves, vanishing of the top
ramification and different forces vanishing at both intermediate
steps. The joint normalization consequently retains both étale maps.
Tame Hurwitz gives g(X)=d−1, and theta has divisor(2d−4)O_X.
Together with div(eta)=2O_Y, étale Hurwitz gives the stated genera,
degrees and divisor of delta. At points of the nonempty D_X its pole
orders are 2d−4 or 2d−6. The stated condition makes these prime to p,
so delta is not a pth power and is separating.

The four spin ratios generate k(x,w)=M(w), since w²=delta. Their
normalization is an intermediate field of K, so both maps remain étale.
The equality div(e0)=(d−2)f*O_X identifies the spin line with the
pullback of O((d−2)f_w*O_X), with the square supplied by theta.
The other three descended rational sections are regular because their
pullbacks to Z are regular. This also covers small d, where the existence
of the prescribed regular spin sections is an additional hypothesis.

## The original family satisfies the degree criterion

For p=5 and d=5r, the nonzero coefficient of x^(5r−1) gives
deg ell=r−1. As r≢1 mod5, ell' F has degree6r−2; ell F'/3 has
degree at most6r−3. Hence deg Q=6r−2. The two function degrees are
8r−3 and18r−6, whose gcd divides

    9(8r−3)−4(18r−6)=−3.

It is one because 3∤r, and the first degree is odd. Also
5∤(d−2)(d−3). At the selected r=2 curve this gives degrees13,30.
In the selected Y_t family, c1^5=3(t+1)≠0.
These endpoint recoveries do not exclude a common cover.
