# Rosati saturation detects factorization through an etale map

Version 2, 2026-09-22. Author prose; focused extension check recorded.
ID: `etale_rosati_factorization`.

Let k be algebraically closed and let f:C->X be ACTUAL finite separable
and g:C->Y ACTUAL finite etale, from the SAME smooth projective curve, with
g(X),g(Y)>=2 and degrees a,b. Let D be the normalization of their
reduced joint image in X x Y, c=deg(C/D), and
\[
u=g_*f^*:J(X)\to J(Y).
\]
Use the canonical principal polarizations for the Rosati adjoint.
For any ell different from char(k), put
\[
T=\operatorname{Tr}(u^\dagger u\mid H^1(J(X),\mathbf Q_\ell)).
\]
This trace is an integer independent of ell. The maps C->D and D->Y
are finite etale, D->X is finite separable, c divides gcd(a,b), and
\[
T\le2ab+2ac(g(X)-1).\tag{1}
\]

If f is also etale, the last term is the original 2c(g(C)-1).

Equality in (1) holds exactly when the reduced joint image is smooth.

The following conditions are equivalent:

- u^dagger u=ab id on J(X);
- T=2ab g(X);
- f=h g for an ACTUAL finite separable map h:Y->X, of degree a/b.

When these hold, D=Y via its second projection and c=b. If f was etale,
so is h. In particular
the assertion concerns the original curve maps, not merely isogenous
Jacobians or an unrelated correspondence.

If b>1 and ell_b is its smallest prime divisor, then failure of that
factorization forces the strict alternative
\[
T\le2ab\bigl(1+(g(X)-1)/\ell_b\bigr).\tag{2}
\]
For X=Y of genus h and a=b=M, saturation is equivalent to g=alpha f
for an automorphism alpha of X. If no such automorphism exists and M>1,
\[
T\le2M^2\bigl(1+(h-1)/\ell_M\bigr)\le(h+1)M^2.
\]
If M=1 both maps are isomorphisms. The extension allows ramification
of f, but NOT of the projection g through which descent is asserted.
It makes no claim for formal Jacobian homomorphisms or g(X)=1.

In particular, if f^*J(X) is contained in g^*J(Y) as actual abelian
subvarieties of J(C), then f factors through g. Indeed the rational
Rosati projector b^{-1}g^*g_* is the identity on that image and gives
u^dagger u=ab id. No equality of integral Hom lattices is needed.

[Proof](../../../Proofs/jacobians/isogeny_sieves/etale_rosati_factorization.md).
