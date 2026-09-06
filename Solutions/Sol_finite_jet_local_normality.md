# Controlled determinacy and finite local Galois tests

Author: /root, 2026-09-06. Major audit PASS as part of the Hermitian
package, /root/hermitian_fixed_base_major_audit, 2026-09-06.
[Audit record](../Research/audits/HERMITIAN_FIXED_BASE_MAJOR_AUDIT_2026_09_06.md).
[Statement](../Theorems/Thm_finite_jet_local_normality.md).

## 1. A controlled formal inverse calculation

Write v for z-adic order and f^[j] for Hasse derivatives. Since v(f)=e,

    v(f^[j]) >= max(0,e-j).

If v(x)=1, v(u)=r>=2, the nonlinear Taylor remainder therefore satisfies

    v(f(x+u)-f(x)-f'(x)u) >= e-2+2r.              (1)

For 2<=j<=e the term has order at least e-j+jr>=e-2+2r.
For j>e it has order at least jr>=e-2+2r. When e=1 the latter estimate
still applies. Zero Hasse derivatives cause no problem in any characteristic.

Start x_0=z and suppose v(g-f(x_i))=n_i>=N. Unless the error is zero,
put u_i=(g-f(x_i))/f'(x_i), x_(i+1)=x_i+u_i. Substitution by a
uniformizer preserves order, so v(f'(x_i))=delta at every stage. We have
r_i=v(u_i)=n_i-delta>=q>=2. By (1),

    n_(i+1) >= e-2+2(n_i-delta) >= n_i+1.

The last inequality is precisely n_i>=2delta-e+3. Hence x_i converges
to phi=z+O(z^q), with linear coefficient one and f(phi)=g.

For uniqueness, two such solutions have difference u of order r>=q,
unless identical. The linear Taylor term has order delta+r, strictly
less than every nonlinear term because r>=q>delta-e+2. Their difference
cannot be zero. This also proves that an exact f-preserving automorphism
congruent to the identity modulo z^q is the identity.

This is formal convergence inside characteristic p, not a lift to
characteristic zero. It works over any coefficient field without extracting
roots; algebraic closedness is used for the later geometric counting language.

## 2. Approximate symmetries recover exactly the actual automorphisms

Lift any psi in A_N(f)(k) to its polynomial representative, an actual formal
automorphism. Apply Part 1 to the series F=f composed with psi, and g=f.
Their order and derivative order are e,delta; the latter follows either
from the chain rule or from their congruence modulo z^N. There is an eta
congruent to the identity modulo z^q with F composed with eta=f. Therefore
rho=psi composed with eta is an EXACT automorphism over k((f)), and has
the same q-1 jet as psi.

Conversely every exact automorphism supplies a point of A_N. Two exact
automorphisms with the same q-1 jet differ by one congruent to the identity
modulo z^q, hence are equal by Part 1. Truncation respects composition.
It consequently identifies Aut(k((z))/k((f))) with the indicated image of
A_N, not with all of A_N.

The extension k((z))/k((f)) is finite separable of degree e: k[[z]] is a
finite free k[[f]]-module of rank e, and separability is equivalent to
f' nonzero. A finite separable degree-e extension has at most e base-field
automorphisms, with equality exactly when it is Galois. This proves the
certificate. It refers to distinct k-points, not scheme length in a
possibly nonreduced jet scheme.

For two series f,g, a genuine fixed-base isomorphism sends z to a source
uniformizer psi, giving f(psi)=g. Conversely an approximate equality modulo
z^N is corrected by Part 1 applied to f composed with psi. Only coefficients
below N occur in the approximate equations. The condition a_1 nonzero may
be encoded by an extra variable b and equation b a_1=1. Elimination followed
by reduced zero-dimensional point counting can therefore test Galoisness;
existence of the mixed equations tests fixed-base isomorphism. This is an
exact finite-algebraic prescription, not a claim of practical small runtime.

## 3. Target-coordinate tails and literature boundary

If h(t)=t+O(t^2), then v(h(f)-f)>=2e. Part 1 applies whenever 2e>=N.
Because delta>=e-1, the inequality 3e>2delta+2 implies both terms of
N are at most 2e. The quoted numerical cutoffs follow by substitution.
A target scaling h(t)=a t with a!=1 is NOT absorbed by this argument.
It remains genuine data when comparing multiple local extensions over
one fixed target. This caveat is essential for the atlas criterion.

The bound 2delta-e+2 for right determinacy appears as the Boubakri–Greuel–
Markwig bound recalled in Nguyen, Remark 2.6(c), printed p.240, in
[The right classification of univariate power series in positive characteristic](https://www.journalofsing.org/volume10/nguyen.pdf).
Here a d-jet means coefficients through degree d, explaining N=d+1.
Nguyen's Definition 2.1 and Proposition 2.8 give a sharper support-dependent
bound; the upper-bound proof, Step 1 on p.241, successively kills higher
coefficients by source changes. We retain the elementary controlled proof
above because the correction order and uniqueness directly provide the
finite Galois test. Neither cited theorem says arbitrary maps with matching
different exponents are locally normal.
