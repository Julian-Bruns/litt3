# Global spin primitives and the two-leg matching defect

Use the spin Cartier conventions, with p odd, ell=p+2, L^2=omega_C,
g(C)>=2, and K(C,L) as in spin_cartier_root_normal_form.

There is a natural exact sequence, using relative Frobenius,

    0 -> H0(C^(1),L_1) -> H0(C,L^p) --nabla--> K(C,L)
      --boundary--> H1(C^(1),L_1) -> 0.                 (1)

Here nabla is the canonical connection on F_C^*L_1=L^p. A section h
has a GLOBAL REGULAR spin primitive b iff boundary(h)=0. Its ambiguity
is precisely a horizontal section, or a p-th power after the usual
absolute-twist identification. The obstruction space has dimension
h0(C,L). In particular a non-effective spin line has a unique global
primitive for EVERY h in K(C,L).

On the root cover w^ell=h_l, a global primitive b gives the rational
primitive H=b_l/w^p of alpha, with poles supported on the reduced root
divisor and of order at most p. If c of its points are zeros of b, then

    deg(H)=p*(ell(g(C)-1)-c),
    ord_R(H)=ell+2 at those c points,
    ord_R(H)=-p at the remaining root points.

There is also a BASE-CURVE map

    R_b=b^(p+2)/h^p : C -> P1,

of the same degree p*((p+2)(g(C)-1)-c), branched only over0 and infinity.
Over0 its indices are p+2 at p(g(C)-1)-2c points and p+4 at c points.
Over infinity all indices are p, at (p+2)(g(C)-1)-c points, and each
different exponent is p+1. In characteristic5 and genus2 this gives
degrees25,30,or35. These are actual rational functions on the endpoint,
not a claim that their pullbacks agree across the span.

Now retain BOTH actual finite etale maps X<-f-Z-g->Y and their compatible
spin lines L_Z=f^*L_X=g^*L_Y. Suppose reduced sections h_X,h_Y in the
respective K-spaces have equal pullbacks. Their boundary classes have
the same pullback to H1(Z^(1),L_(Z,1)).

If BOTH endpoint boundary classes vanish, choose primitives b_X,b_Y.
There is a uniquely determined horizontal section t on Z^(1) such that

    f^*b_X-g^*b_Y=F_Z^*t.

Its class

    epsilon in H0(Z^(1),L_(Z,1)) /
      (f_1^*H0(X^(1),L_(X,1)) + g_1^*H0(Y^(1),L_(Y,1)))             (2)

does not depend on the primitive choices. If epsilon=0, the span has
a CORE. Therefore a coreless span with zero endpoint boundaries requires
a new spin section outside the sum of the two pulled-back spaces.
Indeed in that case

    h0(Z,L_Z) >= h0(X,L_X)+h0(Y,L_Y)+1.                (3)

In particular H0(Z,L_Z)=0 forces a core without any separate endpoint
boundary hypothesis. This is an unbounded-degree necessary condition
on the ACTUAL common source; source acyclicity is not assumed to hold
in the common-cover problem. Neither an effective source spin line nor
a nonzero epsilon constructs a correspondence. The converse to the
core implication is not asserted.

## Boundary-independent canonical primitives

Under the same coreless reduced-match hypotheses put s_i=h_i² and

    a=(p+1)/2,             b=(p+3)/2,             ell=p+2.

There ALWAYS exist regular Q_i in H0(C_i,omega_i^(p*b)) with
nabla Q_i=s_i^a; here nabla is the canonical Frobenius connection.
No vanishing of the original spin boundary is assumed. Their difference
on Z is F_Z^*R, with a well-defined NONZERO quotient class

    [R] in H0(Z^(1),omega^b) /
       (f_1^*H0(X^(1),omega_X^b)+g_1^*H0(Y^(1),omega_Y^b)).

It remains nonzero on any further common-source etale refinement, modulo
these SAME endpoint spaces. R is a SOURCE tensor, not a common endpoint
tensor. In characteristic five the derivative, primitive and ambiguity
weights are21,20,4 respectively.

Higher powers in this Cartier congruence do not create independent
constraints: for every j>=0, primitives for s_i^(a+p*j) may be chosen
as s_i^(p*j)Q_i. The corresponding mismatch class is exactly
s_(Z,1)^j[R], in ambiguity weight b+j*ell, modulo the endpoint spaces
in that weight. This equality includes independence of primitive choices.
It does not assert that every conceivable higher-weight construction is
of this form; it covers these repeated powers of the same shared s.

Version3,2026-09-08: adds boundary-independent canonical primitives for
all odd p and identifies the repeated-power mismatches. This generalizes
the latest Pro weight20/4 construction and records its exact limitation.
Author proof, not independently audited or formalized.
[Spin definitions](../Definitions/Def_spin_cartier_roots.md) ·
[Proof](../Solutions/Sol_spin_primitive_matching_defect.md).
