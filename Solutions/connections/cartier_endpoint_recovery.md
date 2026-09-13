# Proof: Cartier closure, canonical ratios, and one differential

[Statement](../../Theorems/connections/cartier_endpoint_recovery.md).
Author /root,2026-09-08. We use the usual p^(-1)-semilinear Cartier
operator on rational differentials over the perfect constant field;
this notation does not identify Frobenius-twisted curves by a k-map.

Cartier commutes with separable pullback. This follows directly from
the separating-variable formula: write a differential as
(sum a_i^p x^i)dx, 0<=i<p, and retain a_(p-1)dx. A separating variable
in the smaller field remains separating in a finite separable extension,
so the same decomposition computes both operators. Cartier preserves
regularity. Thus all the assumed Cartier iterates also descend to S,
and their span gives

    q^*H0(C,omega_C) contained in phi^*H0(S,omega_S).    (1)

If C is nonhyperelliptic, ratios of its canonical sections generate
k(C); (1) therefore gives k(C) contained in k(S) inside k(T).
Here one uses the standard very-ampleness of the canonical system on
a nonhyperelliptic smooth curve. If C is hyperelliptic, choose a model
y^2=F(x); p is odd. Its canonical basis is

    dx/y, x dx/y, ..., x^(g(C)-1) dx/y.

The first two forms in (1) give x in k(S). The form dx/y itself descends
to a rational differential beta on S. Since phi is separable, dx is
nonzero on S and pullback on rational differentials is injective.
Consequently the rational function dx/beta on S pulls back to y.
This also puts y, hence the entire k(C), in k(S). Canonical ratios
alone would have recovered only k(x); the last differential is essential.

The resulting field inclusion extends to a finite map S->C between
the smooth projective models, and its composite with phi is q. If q
and phi are etale, multiplicativity of ramification indices in the
tower makes S->C etale. This proves the general assertion.

For the spin application, let e be a nonzero section of the effective
degree-one spin L_C. Its square eta=e^2 is a regular differential with
one double zero, at a Weierstrass point. A descending section of M
squares to a regular differential on S whose pullback equals q^*eta;
this uses the stated COMPATIBILITY of the spin isomorphisms.

Section4 of family_small_torsion_specialization proves, by six explicit
polynomial identities, that eta and Cartier(eta) are independent for
EVERY t^5-t!=0. They span the two-dimensional canonical space. The
general assertion applies. In the alternating tower, the audited
eight-step theorem supplies an etale spin-compatible phi_n and the
surjectivity on all spin sections, so the same argument works at every
n>=8, whether that stage is Galois over C or not.

The only explicit family input is the absence of a double-zero Cartier
eigenform. Any other genus-two curve with this property has the same
effective-spin recovery conclusion. Ordinarity by itself is not used.

Background references: the separating-variable Cartier formula is
recorded in [Counting points on smooth plane quartics, Section2](https://link.springer.com/article/10.1007/s40993-022-00397-8).
The canonical-map dichotomy is recalled in
[Voight--Zureick-Brown, Chapter2](https://jvoight.github.io/articles/stacky-canonical-rings-final-fixederrata.pdf).
The proof above, including hyperelliptic field recovery, is independent
of any claim that two arbitrary separable maps have a common core.
