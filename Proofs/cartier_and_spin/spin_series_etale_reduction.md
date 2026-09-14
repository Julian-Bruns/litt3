# Proof: separability, decreasing differents, and spin descent

[Statement](../../Theorems/cartier_and_spin/spin_series_etale_reduction.md).
Author /root2026-09-08. Keep the specified embedded endpoint fields and
both etale maps at every stage. Put m=p+2; the common section h_n^2 is
a weight-m canonical tensor with divisor2D_n, where D_Y has degree m.
By canonical_intersection the resulting coreless span has only one
nonempty clump, namely the support of this tensor. In particular it
cannot also have a singleton clump on Y.

## 1. Complete series and separability from stage2

The preceding growth theorem gives globally generated L_n and r_n>=n
for n>=2. Let E_n=H0(Z_n,L_n). The normalized image construction gives
phi_n^*M_n=L_n and H0(S_n,M_n)=E_n. Indeed every coordinate section
descends, whereas every additional section on the normalization would
pull back to an additional section of L_n, contradicting completeness.

The [complete-section separability lemma](complete_section_quotients.md#2-global-generation-and-separability)
applies to Z_2→Y because deg L_Y=1. A separating ratio at stage2 remains
separating after every finite etale extension of its function field;
the larger ratio fields for n>=2 therefore also give separable phi_n.

The nested spaces E_n give nested ratio fields and finite maps
gamma_n:S_(n+1)->S_n. Since k(Z_(n+1))/k(S_n) is separable, gamma_n
is separable. Projection onto the old coordinates has no base point:
the old E_n still generates L_(n+1). Consequently

    gamma_n^*M_n=M_(n+1).                             (1)

The ratio fields and their different divisors are invariant under the
deck group of whichever endpoint is normal at that stage.

## 2. Low-genus images cannot persist

At a stage n even, Z_n->Y is Galois of degree N. Its invariant different
divisor R_n for phi_n descends to an effective INTEGRAL divisor on Y.
If S_n is rational, put a=deg M_n=r_n-1. Then deg phi_n=N/a and

    deg(R_n)/N=2+2/a.

This number is an integer, so a divides2 and r_n<=3. In particular S_4
cannot be rational, because r_4>=4.

Two consecutive S_n,S_(n+1), n>=2, cannot both be elliptic. Their
separable connecting map pulls back their one-dimensional regular
differential spaces isomorphically. The resulting common line k beta
inside the rational differentials on the tower is stable under BOTH
endpoint Galois groups: at each normal stage the map phi_n is equivariant.
Thus the rational-function line

    k * (beta^m / h_n^2)

is stable under both groups. The finite-dimensional descent lemma in
alternating_spin_growth makes this line constant. But equality of divisors
m div(beta)=2D_n is impossible, since D_n is reduced and m>=5. This is
a contradiction. Genus is nondecreasing under the separable gamma_n, so
g(S_4)>=1 and g(S_5)>=2.

The genera must then be unbounded. Otherwise Riemann--Hurwitz bounds the
degrees of all composites S_j->S_5, since g(S_5)>=2. Their integer degrees
form a divisibility chain, which eventually stabilizes. All later gamma_n
would be isomorphisms. Equation (1) would then make h0(M_n)=r_n constant,
contradicting strict growth. Nondecreasing unbounded genera tend to infinity.

## 3. The different vanishes by stage8

Composition of different divisors and the etaleness of Z_(n+1)->Z_n give

    pullback(R_n) = R_(n+1) + phi_(n+1)^*Diff(gamma_n). (2)

In particular R_(n+1)<=pullback(R_n). At an even stage with g(S_n)>=2,
write a=deg M_n and h=g(S_n). Riemann--Hurwitz gives

    deg(R_n)/deg(Z_n/Y)=2-2(h-1)/a.

It is a nonnegative integer strictly smaller than2. Therefore the
descended different on Y has degree either0 or1.

Both stages6 and8 are in this range. If R_6=0, (2) proves the desired
conclusion immediately. Otherwise R_6 is the pullback of one point P
of Y. Suppose R_8 were also nonzero. The same descent and (2) make it
the pullback of that same P. At stage7 the different is pulled back from
an effective divisor B_X on X. The two inequalities in (2), normalized
by the etale degrees and using deg(Z_n/Y)=(g(X)-1)deg(Z_n/X), force

    deg B_X=g(X)-1.

Both inequalities are therefore equalities of effective divisors. On Z_7
we have f_7^*B_X=g_7^*P, a common nonempty divisor with singleton image
on Y. Its support is a clump. This is distinct from the clump whose Y
image is D_Y of degree m>=5, contradicting uniqueness. Hence R_8=0,
and (2) gives R_n=0 for all n>=8. The finite separable phi_n are etale.

## 4. The image line really is a spin line

For n≥8, φ_n is étale and H0(S_n,M_n)=H0(Z_n,L_n). The
[complete-section descent lemma](complete_section_quotients.md#3-descent-determined-by-complete-sections)
therefore makes M_n a spin compatibly with L_n.

Under the additional endpoint hypotheses in
[effective spin probes](spin_probe_common_cover_reduction.md), both endpoint
fields and the original h descend after a bounded refinement.
