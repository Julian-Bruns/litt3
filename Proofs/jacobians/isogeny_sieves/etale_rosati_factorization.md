# Proof: Rosati saturation and the actual joint image

Author proof, 2026-09-07. This isolates and generalizes the repeated
adjunction argument in the older quadratic-coarsening proof. It has
not been independently audited.

## 1. Normalize the same-source image

Write Gamma for the reduced integral image of (f,g):C->X x Y and
nu:D->Gamma for its normalization. The field k(D) is the compositum
of the two embedded endpoint fields INSIDE k(C); no common Galois
closure or intersection-degree formula is used. The maps

    C --v--> D --f_D--> X,     D --g_D--> Y

are finite separable. The tower formula for differents and the etaleness
of f and g show that v,f_D,g_D are all etale. Put

    c=deg(v),  a'=a/c,  b'=b/c,
    q=g(D)-1=a'(g(X)-1)=b'(g(Y)-1)=(g(C)-1)/c.

In particular c divides gcd(a,b). The divisor correspondence of Gamma
induces u_D=g_D* f_D^*, and norm-pullback for v gives u=c u_D.

For any reduced integral correspondence of bidegrees a',b' on X x Y,
the product-surface intersection formulas are

    Gamma^2=2a'b'-Tr(u_D^dagger u_D | H^1(J(X),Q_ell)),
    K_(X x Y) . Gamma=2a'(g(X)-1)+2b'(g(Y)-1)=4q.

The first is the intersection pairing on the Kunneth decomposition:
the two fiber classes contribute 2a'b', and the H^1(X) tensor H^1(Y)
part contributes minus the trace of the adjoint composition. It applies
to a singular integral image as well as to a smooth correspondence.
It also proves integrality and ell-independence of the trace.

Adjunction and normalization now give

    g(D) <= p_a(Gamma)
         =1+a'b'-(T/(2c^2))+2q.

Rearranging proves (1). More precisely,

    2ab+2c(g(C)-1)-T=2c^2(p_a(Gamma)-g(D)).          (3)

The genus difference is the length of nu_*O_D/O_Gamma. It vanishes
exactly when Gamma is normal, hence smooth over the perfect field k.
This proves the equality characterization in (1).

## 2. Saturation forces the second projection to have degree one

If T=2ab g(X), substitute g(C)-1=a(g(X)-1) in (1):

    ab(g(X)-1) <= ca(g(X)-1).

Since g(X)>1, this gives b<=c. But c divides b and b'=b/c>=1,
so c=b and g_D has degree one. Thus g_D is an isomorphism,
h=f_D g_D^(-1):Y->X is finite etale, and f=h g.

Conversely, if f=h g, then a=b deg(h), u=b h^*, and

    u^dagger u=b^2 h_*h^*=ab id.

This implies the displayed trace equality. Hence all three conditions
are equivalent; no separate operator-norm or positivity theorem is needed.

If factorization fails, the positive integer b/c is a nontrivial divisor
of b, so b/c>=ell_b. Substitution c<=b/ell_b into (1) proves (2).
For equal endpoints and degrees, h has degree one and is an automorphism;
write alpha=h^(-1). The uniform bound uses ell_M>=2.

## 3. Use in an involution calculation

Let f:C->X have degree M, let delta be an involution of C, and set
g=f delta. Then u=f_*delta^*f^* is Rosati self-adjoint. If a known
endomorphism decomposition makes all its scalar coordinates equal
to +M or -M, then u^2=M^2 id. The theorem supplies an ACTUAL
automorphism h of X relating f and f delta. If Aut(X)={1,iota_X}
with iota_X^*=-1, a mixed scalar-sign pattern is impossible.

This consequence replaces the two identical reduced-image/adjunction
computations in the genus-three quadratic-coarsening proof. That proof's
remaining arithmetic, branch-parity and Prym hypotheses are not removed.
