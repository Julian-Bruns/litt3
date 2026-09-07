# Rosati saturation detects actual etale factorization

Version 1, 2026-09-07. Author prose; not independently audited.
ID: `etale_rosati_factorization`.

Let k be algebraically closed and let f:C->X, g:C->Y be ACTUAL finite
etale maps from the SAME smooth projective connected curve, with
g(X),g(Y)>=2 and degrees a,b. Let D be the normalization of their
reduced joint image in X x Y, c=deg(C/D), and

    u=g_*f^*:J(X)->J(Y).

Use the canonical principal polarizations for the Rosati adjoint.
For any ell different from char(k), put

    T=Tr(u^dagger u | H^1(J(X),Q_ell)).

This trace is an integer independent of ell. Both induced maps from D
and the map C->D are finite etale, c divides gcd(a,b), and

    T <= 2ab+2c(g(C)-1).                              (1)

Equality in (1) holds exactly when the reduced joint image is smooth.

The following conditions are equivalent:

- u^dagger u=ab id on J(X);
- T=2ab g(X);
- f=h g for an ACTUAL finite etale map h:Y->X, necessarily of degree a/b.

When these hold, D=Y via its second projection and c=b. In particular
the assertion concerns the original curve maps, not merely isogenous
Jacobians or an unrelated correspondence.

If b>1 and ell_b is its smallest prime divisor, then failure of that
factorization forces the strict alternative

    T <= 2ab(1+(g(X)-1)/ell_b).                       (2)

For X=Y of genus h and a=b=M, saturation is equivalent to g=alpha f
for an automorphism alpha of X. If no such automorphism exists and M>1,

    T <= 2M^2(1+(h-1)/ell_M) <= (h+1)M^2.

If M=1 both maps are isomorphisms. No claim is made for a ramified leg,
a formal pair of Jacobian homomorphisms, or g(X)=1.

[Proof](../Solutions/Sol_etale_rosati_factorization.md).
