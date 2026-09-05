# Prime-avoiding etale global generation

**Status: collaborative author proof, 2026-09-05; not independently audited.**

Authors: /root and /root/gluing_cohomology_rigidity.

Every positive-degree line bundle on a curve over an algebraic closure of
a finite field becomes globally generated on a finite etale abelian cover.
The cover degree can avoid any prescribed finite set of primes. Thus this
positivity condition alone cannot obstruct the fixed-source construction,
even when a connected cyclic cover must remain connected.

## 1. Statement

Let k be an algebraic closure of F_p, let X/k be a smooth projective
connected curve, and let S be a finite set of primes containing p.

### Theorem 109.1

For any finite collection of positive-degree line bundles L_1,...,L_h
on X, there is a connected finite etale abelian Galois cover

\[
                         q:X'\longrightarrow X
\]

whose degree is prime to every prime in S and for which every q^*L_i is
globally generated.

There is no restriction on the divisibility of g(X) by p or by primes
in S. The statement includes degree-one line bundles.

We prove the theorem using a connected Lang-isogeny pullback and then
kill only torsion classes whose orders avoid S. The Lang pullback is an
auxiliary device for finding divisors; its degree is not the degree of
the final cover in the theorem.

## 2. Connectedness of Abel--Jacobi isogeny pullbacks

Assume g(X)>=1, choose P_0 in X(k), and let iota:X->J=Jac(X) be the
Abel--Jacobi map based at P_0.

### Lemma 109.2

For every connected finite etale isogeny phi:B->J, the pullback
X x_J B is connected. The same holds if iota is translated by any
point of J(k). This includes isogenies of degree divisible by p.

#### Proof

Over k, the isogeny is a torsor under the finite abelian group
K=ker(phi)(k). If its pullback were disconnected, its monodromy image
would be a proper subgroup H of K. A connected component, quotiented
by H, would give a lift of iota through the nontrivial intermediate
isogeny

\[
                         \bar\phi:B/H\longrightarrow J.
\]

Translate the lift so that it sends P_0 to zero. The universal property
of the Jacobian extends it to a homomorphism u:J->B/H satisfying
bar(phi) u = id_J. Both abelian varieties have dimension g(X), so u
is an isogeny and multiplicativity of degrees forces deg(bar(phi))=1.
This contradicts H being proper.

For a translated Abel map, choose a preimage of the translation point
under phi and translate B. This identifies the two pullbacks over k.
The argument uses no prime-to-p restriction. QED.

## 3. Keeping the excluded primary parts fixed

### Lemma 109.3

Let J be an abelian variety over a finite field F_q. Write F for its
q-power Frobenius. Suppose that all geometric J[ell]-points are rational
over F_q for every ell in S. For every positive integer m prime to all
primes in S,

\[
 J(\mathbf F_{q^m})[S^\infty]
                     =J(\mathbf F_q)[S^\infty].        \tag{109.1}
\]

Here the notation means the subgroup of elements whose orders have prime
factors only in S. Consequently, for every z in J(F_{q^m}), the point
F(z)-z has order prime to every prime in S.

#### Proof

Fix ell in S. On the ell-adic Tate module of geometric torsion points,
F is congruent to the identity modulo ell. For ell=p, use the etale
p-adic Tate module; it records all geometric p-primary torsion points.
The connected part of the p-power torsion group schemes contributes
no additional geometric points.

Factor

\[
              F^m-1=(F-1)(1+F+\cdots+F^{m-1}).
\]

The second factor is congruent to m times the identity modulo ell, so
it is an automorphism of the ell-primary torsion group and commutes with
F. Hence the kernels of F^m-1 and F-1 on that group are equal. This
proves (109.1), prime by prime.

The S-primary component of z therefore belongs to J(F_q), on which
F-1 vanishes. Thus F(z)-z has zero S-primary component. QED.

All the rationality hypotheses in this lemma can be achieved by enlarging
a finite field of definition: only finitely many geometric torsion points
are involved.

## 4. Divisors differing by torsion of allowed order

### Lemma 109.4

For every degree-one line bundle L on X with g(X)>=1, there are infinitely
many points x in X(k) for which

\[
                       \mathcal O_X(x)\otimes L^{-1}
                                                        \tag{109.2}
\]

has order prime to every prime in S.

#### Proof

Choose a finite field F_q over which X, P_0, and L are defined, and put
lambda=[L tensor O_X(-P_0)] in J(F_q). Enlarge F_q to satisfy Lemma 109.3.
The Lang isogeny

\[
                 F-1:J\longrightarrow J
\]

is finite etale: its differential is minus the identity, and its kernel
is the finite group J(F_q). Its degree is D=|J(F_q)|.

Pull it back along iota-lambda. The resulting curve

\[
 Z_\lambda=\{(x,z):F(z)-z=\iota(x)-\lambda\}
                                                        \tag{109.3}
\]

is smooth and projective over F_q, and geometrically connected by
Lemma 109.2. For arbitrarily large m prime to all primes in S, the Weil
bound gives

\[
 |Z_\lambda(\mathbf F_{q^m})|
       \ge q^m+1-2g(Z_\lambda)q^{m/2}.
\]

This tends to infinity. Every geometric fiber of Z_lambda->X has D
points, so the number of distinct projected points x also tends to
infinity. For such a rational point (x,z), Lemma 109.3 shows that

\[
 [\mathcal O_X(x)\otimes L^{-1}]
                       =\iota(x)-\lambda=F(z)-z
\]

has order prime to S. These yield infinitely many distinct x. QED.

## 5. Global generation and simultaneous refinement

#### Proof of Theorem 109.1

First suppose that L has degree one. Choose two distinct points x_1,x_2
from Lemma 109.4 and put

\[
                   T_i=\mathcal O_X(x_i)\otimes L^{-1}.
\]

Each T_i has finite order N_i prime to every prime in S, in particular
prime to p. Choose the associated mu_{N_i}-torsors and a connected
component of their fiber product. This is a connected finite etale
abelian Galois cover q whose degree is prime to S and which trivializes
both T_i. Thus q^*L is isomorphic to both O_{X'}(q^*x_1) and
O_{X'}(q^*x_2). Their canonical sections have disjoint zero divisors,
so they generate q^*L everywhere.

Now let deg L=d>1. Choose distinct points P_1,P_2 on X and apply the
degree-one result to

\[
                 L(-(d-1)P_1),\qquad L(-(d-1)P_2).
\]

On a connected common refinement, both pullbacks are globally generated.
Multiply their sections by the canonical sections of
O((d-1)q^*P_1) and O((d-1)q^*P_2), respectively. These give two systems
of sections of q^*L whose base loci are contained in the two disjoint
fibers q^{-1}(P_1) and q^{-1}(P_2). Together they generate q^*L.

Finally take a connected component of the fiber product of the covers
constructed for the finitely many L_i. A connected component of a fiber
product of finite etale abelian Galois covers is again an abelian Galois
cover, with group a subgroup of the product of their groups. Its degree
therefore remains prime to S. Each projection is surjective, and global
generation is preserved by pullback. This proves the simultaneous claim.

If g(X)=0, then X is P^1 and every positive-degree line bundle is already
globally generated, so the identity cover suffices. QED.

## 6. Consequence for the cyclic construction and its limits

Let V->C be a connected finite etale cyclic cover of prime degree r,
and include r in S. Every connected base change C_1->C of degree prime
to r preserves its connectedness: the cyclic function-field extension
and the extension of degree prime to r are linearly disjoint. The pulled
back cover V_1->C_1 is still a connected cyclic degree-r torsor.

In particular one can apply Theorem 109.1 directly on C. Alternatively,
pull a resulting abelian cover X'->X back along the original etale map
C->X and take a connected component C_1. Its degree over C divides
the degree of X'->X, so it is prime to r. The original maps to both
fixed targets remain present after etale base change and composition.

For the current p=5, r=3, g(X)=9 case, take S={3,5}. Thus the
degree-one canonical root L_X used after file 107 can become globally
generated after a further cover of degree prime to three. The fact that
three divides g(X) presents no obstruction.

This does not trivialize an existing r-primary discrepancy such as the
r-primary part of O_C(D_infinity) tensor (c^*L_X)^{-1}. If a line bundle
T of r-power order becomes trivial under a cover of degree e prime to r,
the norm gives T^e=O, and hence T=O already. Positivity and a nontrivial
r-primary discrepancy can therefore persist simultaneously.

No uniform bound on the required cover degree is proved here. Nor does
the theorem construct sections satisfying prescribed quadratic relations,
the particular norm-polynomial evaluations, or their cyclic/sign labels.
It eliminates an obstruction based only on eventual global generation
of positive line bundles, while retaining those additional requirements
as separate constraints.
