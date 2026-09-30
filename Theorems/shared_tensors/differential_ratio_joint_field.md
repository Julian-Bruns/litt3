# Coprime Cartier degrees make the differential ratio generate the joint field

Let k be algebraically closed of odd characteristic p≡2 mod3. Let F be
squarefree and monic of degree d≥4, with 3∤d, and put

    X: y³=F(x),       theta=dx/y²,
    ell(x)=sum_i ([x^(pi+p−1)] F^((p−2)/3))^(1/p) x^i,
    Q=ell' F+(ell/3)F',       a=3deg(ell)+d.

Assume ell≠0, Q nonconstant, a odd, and gcd(a,3deg Q)=1.
Let Y:v²=P(u) be smooth of genus two, deg P=5, with eta=du/v and

    Cartier(eta)=(c0+c1u)eta,       c1≠0.

Embed both function fields in a common function field K, finite
separable over each, and form their actual compositum M. Then

    delta=eta/theta ∈ M,       M=k(x,delta)=k(u,delta).

Indeed q=Cartier(theta)/theta and dq/theta have coprime function
degrees a and 3deg Q. Hence theta recovers k(X) in every separable
intermediate field to which it descends as a rational differential;
eta likewise recovers k(Y). No ordinarity assumption is needed.

## Actual étale quotients and spin probes

If K=k(Z) comes from two finite étale maps, the joint normalization C
is finite étale over both endpoints. Put n=deg(C→X), let D_X,D_Y be
the reduced pullbacks of their points at infinity, and c=|D_X∩D_Y|.
Then

    g(X)=d−1,   g(C)=(d−2)n+1,   deg(C→Y)=(d−2)n,
    div(delta)=2D_Y−(2d−4)D_X,   deg(delta)=(2d−4)n−2c.

If p∤(d−2)(d−3), delta is separating.

Suppose a spin line on Z has regular sections e0,e1,e2,b with
e0²=theta, e1=x e0, e2=x² e0 and b²=eta. Their ratio image has
normalization with field M(w), w=b/e0 and w²=delta. This extension
of M has degree at most two and is an actual intermediate étale common
quotient. The spin line descends to O((d−2)f*O_X), with its specified
square and these sections. No descent of additional sections is asserted.

## The characteristic-five family

All the hypotheses above, including separation, hold when p=5,
d=5r, r≥2, 3∤r, r≢1 mod5, and the coefficient of x^(5r−1) in F
is nonzero. Here deg ell=r−1, deg Q=6r−2 and

    (deg q, deg(dq/theta))=(8r−3,18r−6).

The selected genus-nine curve has r=2, giving degrees13 and30.
For the selected genus-two family, c1^5=3(t+1)≠0.

Version2,2026-09-14. The coprime-degree generalization and both cyclic
exclusions passed a bounded medium audit by audit_extension_fiber_scope.
The original r=2 argument came from the user's September8 Pro response.
[Proof](../../Proofs/shared_tensors/differential_ratio_joint_field.md).
