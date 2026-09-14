# Kummer common covers with absolutely simple, Hom-zero endpoints

Let k be algebraically closed and n>=3 an odd integer invertible in k.
For A,B in k(t)^*, put

    S_A={P in P1 : ord_P(A) is nonzero modulo n},

and define S_B similarly, including infinity. Assume both supports are
nonempty and disjoint, and every nonzero valuation modulo n is coprime
to n. In the field L=k(t)(u,v), u^n=A, v^n=B, the smooth projective
models give two actual finite etale Galois maps of degree n

    C_plus <- T -> C_minus,
    k(C_plus)=k(t,uv),       k(C_minus)=k(t,u/v).

Their common core is k(t). If r=#(S_A union S_B), then

    g(C_plus)=g(C_minus)=(n-1)(r-2)/2,
    g(T)=1+n(g(C_plus)-1).

In characteristic five this construction has the following explicit
examples over F25=F5[a]/(a^2+2), both with n=3.

| Endpoint genus | A(t) | B(t) | p-ranks of J(C_plus),J(C_minus) |
|---|---|---|---|
|3|t|(t-1)(t-a)(t-a-2)|2,2|
|4|t^3+4a*t^2+t+2a+4|t^3+(4a+3)t^2+(a+4)t+4a+1|2,4|

In both rows the geometric Jacobians are absolutely simple and their
geometric Hom groups vanish in both directions. The common sources
have genera7 and10 respectively. The genus-three endpoints are Picard
curves; the genus-four minus endpoint is ordinary.

Thus absolute simplicity, geometric Hom-zero and an ordinary endpoint
can coexist with two prime-to-five Galois etale legs. These examples
have a core.

Version1. The two cubic specializations retain their original independent
audits. A bounded independent review on2026-09-14 also checked the odd-n
construction, including composite n, infinity and the genus formulas.
[Proof and arithmetic verifier](../../Proofs/examples/kummer_common_covers.md).
