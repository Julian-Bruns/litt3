# Generic two-leg theta failure forces simultaneous trace orthogonality

Date: 2026-09-05. Author: `/root`.
Status: focused check by `/root/generic_trace_reduction_check`,
2026-09-05: correct under the intended algebraically closed-base
hypothesis. [Verdict and clarification](audits/GENERIC_TWO_LEG_TRACE_REDUCTION_AUDIT.md).
The omitted explicit base hypothesis is supplied below; without it
the standalone minimum-over-k-points lemma can fail over a finite field.
The Cartier--Petri input is classical; no priority claim.
This does not prove (R). It applies in arbitrary degrees and
does not require Galoisness or a bound on a-number.

## 1. The parameterized rank-drop lemma

Let k be algebraically closed. Let C/k be a smooth projective connected curve, P a smooth irreducible
k-variety, E a vector bundle on C with Euler characteristic zero, and
N a family of degree-zero line bundles on C parametrized by P. For
t in P(k), put d_t=h^0(C,E tensor N_t)=h^1(C,E tensor N_t).
The first-order class of the family in a tangent direction v at t is

\[
                 \kappa_t(v)\in H^1(C,\mathcal O_C).
\]

### Lemma 1.1

If the cup-product map

\[
 \kappa_t(v)\cup-:H^0(C,E\otimes N_t)
                    \longrightarrow H^1(C,E\otimes N_t)       \tag{1}
\]

has rank r, then

\[
                 \min_{u\in P(k)}d_u\le d_t-r.               \tag{2}
\]

In particular, at every point of the open locus where d_t has its
generic minimum, (1) is ZERO for every tangent direction v. This is
stronger than saying that every matrix in the tangent family is singular.

### Proof

Locally on P, the perfect complex R pr_*(E tensor N) has a two-term
presentation K^0 -> K^1 by vector bundles of equal rank. Its kernel
and cokernel at t are the two cohomology spaces in (1). Split off an
invertible block of the matrix at t. After row and column operations,
the remaining block is a d_t by d_t matrix vanishing at t.

Because P is smooth, v is the tangent of a formal arc through t.
Along that arc the remaining matrix is

\[
                            zM+O(z^2),
\]

where M represents (1). The equality with cup product is the usual
obstruction to lifting a section across a first-order deformation
of its line bundle: in Cech representatives the obstruction is the
product of the line-bundle cocycle and the original section.

A nonzero r by r minor of M gives a nonzero minor over k((z)). Thus
the generic corank along the arc is at most d_t-r. A corresponding
minor of the original family is not identically zero on P, proving
(2) on a nonempty open of P. Such an open has a k-point since k is
algebraically closed. At a point where d_t is already minimal, (2)
forces r=0. QED.

This is a formal local proof; it does not rely on interpreting a
nonzero tangent vector as a nonzero arithmetic Frobenius direction.

## 2. Apply the lemma to the actual two maps

Assume char(k)=p>2 and fix actual finite etale maps

\[
                         X\xleftarrow f Z\xrightarrow g Y.
\]

Write C_1=C^(1) for scalar Frobenius twists and f_1,g_1 for the
twisted maps. Let F_Z:Z -> Z_1 be relative Frobenius.
Set B_Z=F_{Z*}O_Z/O_{Z_1} and

\[
 P=J(X_1)\times J(Y_1),\qquad
 N_{L,M}=f_1^*L\otimes g_1^*M,
 \qquad d(L,M)=h^0(Z_1,B_Z\otimes N_{L,M}).                \tag{3}
\]

Let delta be the generic minimum of d. The desired (R) is delta=0.
No minimality or Hom-zero assumption is needed for the following
necessary condition on delta>0.

The canonical alternating nondegenerate pairing of locally exact
differentials is

\[
 b_Z:B_Z\otimes B_Z\longrightarrow\omega_{Z_1}.
\]

Locally it is induced by (da,db) -> Cartier(a db). It identifies B_Z
with its Serre dual and gives the Cartier--Petri multiplication

\[
 \mu_N:H^0(B_Z\otimes N)\otimes H^0(B_Z\otimes N^{-1})
                         \longrightarrow H^0(\omega_{Z_1}).   \tag{4}
\]

See [Tong, Proposition 1.2.1.1 and Proposition 2.2.1](https://arxiv.org/pdf/0712.2046).
The spaces on the left have the same dimension d(L,M) by Serre
duality and Euler characteristic zero.

### Theorem 2.1: generic simultaneous trace annihilation

There is a nonempty open P_0 in P on which d=delta and, for every
(L,M) in P_0(k), N=N_(L,M), and all s,t in the respective spaces
in (4),

\[
                \operatorname{Tr}_{f_1}\mu_N(s,t)=0,
 \qquad        \operatorname{Tr}_{g_1}\mu_N(s,t)=0.          \tag{5}
\]

If (R) fails, delta>0, so (5) concerns nonzero section spaces on a
whole open family. Both traces use the SAME actual Z and N. This is
not a construction from unrelated Jacobian factors.

### Proof

For tangent directions xi in H^1(X_1,O) and eta in H^1(Y_1,O),
the deformation class in Lemma 1.1 is

\[
                           f_1^*\xi+g_1^*\eta.
\]

At a minimum point the cup-product map is zero. Serre duality pairs
its value on s with t as

\[
 \langle\xi,\operatorname{Tr}_{f_1}\mu_N(s,t)\rangle_X
 +\langle\eta,\operatorname{Tr}_{g_1}\mu_N(s,t)\rangle_Y.   \tag{6}
\]

This is functoriality of Serre duality: the dual of pullback on H^1(O)
is trace on regular differentials. Since xi and eta range independently,
nondegeneracy of duality on X_1 and Y_1 proves both equations (5).
QED.

Equivalently, all generic Cartier--Petri images lie in

\[
 \ker\big(H^0(\omega_{Z_1})
     \xrightarrow{(\operatorname{Tr}_{f_1},\operatorname{Tr}_{g_1})}
       H^0(\omega_{X_1})\oplus H^0(\omega_{Y_1})\big).       \tag{7}
\]

## 3. Positive tests and their exact limitation

At ANY parameter (L,M), use (6) to form a scalar bilinear pairing
Q_(xi,eta) on the two section spaces. If its rank is r>0, Lemma 1.1
reduces the generic upper bound to

\[
                             \delta\le d(L,M)-r.            \tag{8}
\]

If r=d(L,M), this proves (R). More generally, if every point with
d(L,M)>0 admits some nonzero trace pairing (6), the generic minimum
cannot be positive and (R) follows. One needs only a rank drop at
each possible positive minimum, not a nondegenerate pairing at every
bad point or a small bound on d(L,M).

No result here proves the needed nonzero pairing. Minimality and the
known birational translated tangent map concern ratios of pulled-back
canonical forms. They do not imply that a Cartier--Petri product has
nonzero trace to either target. In particular a nonzero regular form
on Z can have BOTH traces zero. The kernel in (7) can be large.
This file isolates that issue rather than replacing it with a claim
that all matrix pencils must contain an invertible member.

## 4. Intrinsic parameters and inseparable tangent blindness

Let H be the reduced connected image of

\[
              \phi:P\longrightarrow J(Z_1),\quad
                       (L,M)\longmapsto f_1^*L+g_1^*M.
\]

It is an abelian subvariety. The same lemma can be applied directly
to H and the restricted Poincare family. At its generic minimum all
Cartier--Petri products annihilate the FULL intrinsic tangent space
T_0H. This is the stronger necessary statement.

The image of d phi need not equal T_0H when phi is inseparable.
Consequently the two trace conditions (5) can miss intrinsic directions.
Etaleness of f and g does NOT imply separability of their Picard
pullback homomorphisms in p-divisible degree. The rank-drop test using
(6) is still sufficient whenever it succeeds, but its failure need
not reflect an actual theta obstruction. It may be first-order blindness
of the chosen parameterization. No converse is asserted.

There is a useful clean case. If Hom(JX,JY)=0 and both cover degrees
are prime to p, phi has finite kernel of order prime to p and is a
separable isogeny onto H. Indeed applying the two norms to an element
of ker(phi) gives

\[
                  [\deg f]L=0,\qquad[\deg g]M=0,
\]

because the cross homomorphisms vanish. Thus ker(phi) is a subgroup
of two prime-to-p torsion groups, hence finite etale. In this case
the trace formulation detects all intrinsic first-order directions.
Outside this case one should retain H itself or develop higher-order
deformations; one must not silently divide by the cover degrees.

## 5. The unresolved restricted claim (R)

The earlier question was: over k=Fbar5, take actual finite etale maps
X <-f- Z -g-> Y with 5 not dividing either degree, Y ordinary of genus2,
X nonhyperelliptic of genus at least3, and Hom(JX,JY)=0. Assume joint
minimality, namely k(Z)=k(X)k(Y) inside the SAME function field k(Z).
Must the generic value in (3) be zero? This restricted claim remains OPEN.
The cofinal-refinement counterexamples do not settle it: a nontrivial
refinement of Z destroys this joint minimality. No former prompt is proof.

## 6. Remaining implication

For an actual minimal bi-etale correspondence with ordinary genus-two
Y and the chosen nonhyperelliptic X, either prove that the positive
generic-minimum situation (5) is impossible, or identify additional
geometric data it forces that survives in the correspondence tower.
Theorem 2.1 is valid in all degrees, but that further implication is
open here. The unrestricted one-leg version is known to fail by
Raynaud's examples, so the second trace and the common source cannot
be dropped from a proposed proof of this task.
