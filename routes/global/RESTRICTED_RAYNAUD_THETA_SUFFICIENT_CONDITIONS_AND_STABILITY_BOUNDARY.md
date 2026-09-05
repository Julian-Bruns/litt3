# Restricted Raynaud theta: sufficient conditions and the stability boundary

Date: 2026-09-05. Author: Codex, canonical-trace comparison agent.
Status: elementary deductions from standard results; author proof, not
independently audited. No novelty claim.

Throughout, k is algebraically closed of characteristic p>2, and all
curves are smooth, proper, connected, and of genus at least 2. Write
F_C:C -> C^(1) for relative Frobenius and

\[
 B_C=\operatorname{coker}(\mathcal O_{C^{(1)}}\longrightarrow
                         F_{C*}\mathcal O_C).
\]

The Raynaud divisor Theta_C on J(C^(1)) has support

\[
 \{L:H^0(C^{(1)},B_C\otimes L)\ne0\}.
\]

Its existence as a proper effective divisor is Raynaud's theorem;
see [Raynaud, Theorem 4.1.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf).
The following arguments never identify failure of ordinarity at L=0
with failure of properness of a restricted theta locus.

## 1. A precise monodromy class giving proper axis theta

Let f:Z -> X be an actual finite etale cover. Let W -> X be its connected
Galois closure, with group G and Z=W/H. Thus H is core-free in G.
Suppose G has a normal p-subgroup P such that G/P is abelian. Then

\[
       f^{(1)*}J(X^{(1)})\not\subset\Theta_Z.
\]

This includes non-Galois f, arbitrary p-divisibility of its degree, and
nonordinary X. It requires neither a second leg nor minimality.

### Proof and exact divisor formula

Every simple kG-module is one-dimensional. Indeed, a nonzero module for
a finite p-group has nonzero fixed vectors; for a simple G-module S,
normality of P makes S^P a nonzero G-submodule. Hence P acts trivially,
and the abelian quotient has only one-dimensional simple modules over k.

The bundle E=f^(1)_*O_(Z^(1)) is associated to the permutation module
k[G/H] on the etale G-torsor W^(1) -> X^(1). A composition series gives
a filtration of E by vector subbundles with quotient line bundles L_chi.
These line bundles have finite order prime to p, since the finite image
of any character chi:G -> k^* has order prime to p. Repetitions occur
with multiplicities [k[G/H]:chi].

Etale Frobenius base change and projection formula give

\[
 H^i(Z^{(1)},B_Z\otimes f^{(1)*}L)
   =H^i(X^{(1)},B_X\otimes L\otimes E).
\]

Choose L outside the finite union of the translates

\[
 \Theta_{X,\chi}:=
 \{L:H^0(X^{(1)},B_X\otimes L\otimes L_\chi)\ne0\}.
\]

Each quotient is acyclic: its Euler characteristic is zero, and its
degree-zero cohomology vanishes. The filtration therefore makes the
whole tensor product acyclic. This proves properness.

In fact additivity of determinant of cohomology gives the equality of
effective divisors on J(X^(1))

\[
 (f^{(1)*})^*\Theta_Z
     =\sum_\chi [k[G/H]:\chi]\,\Theta_{X,\chi}.
\]

Here Theta_(X,chi) is the inverse translate of Theta_X by L_chi, as
specified by its displayed support; the notation fixes translation signs.
The preceding properness argument justifies pulling back the divisor.
Even set-theoretically the support is exactly the displayed union:
if a graded piece has nonzero H^0, take the first such piece. All previous
pieces are acyclic, so this section lifts to that filtration stage and
then injects into H^0 of the whole bundle.

Consequently, for any further actual finite etale g:Z -> Y, the locus

\[
 D=\{(L,M):H^0(Z^{(1)},B_Z\otimes f^{(1)*}L
                              \otimes g^{(1)*}M)\ne0\}
\]

is proper: its restriction to the M=O axis is already proper.

### Exact group-theoretic boundary of this proof

For a finite group G the following conditions are equivalent:

1. G has a normal p-subgroup with abelian quotient.
2. The commutator subgroup G' is a p-group.
3. G has a normal Sylow p-subgroup with abelian prime-to-p quotient.
4. Every simple kG-module is one-dimensional.

Conditions 1--3 are equivalent by absorbing the p-primary subgroup of an
abelian quotient into the normal p-subgroup. Condition 1 implies 4 by
the preceding fixed-vector argument. Conversely, under 4 the regular
representation is upper triangular in a composition-series basis.
Its commutator subgroup is upper unitriangular, hence a p-group; the
regular representation is faithful.

For the actual core-free permutation representation k[G/H], these are
also equivalent to saying that all its composition factors are lines:
if they are, this faithful representation is upper triangular and again
forces G' to be a p-group. Thus the group-class boundary is exact for the
line-filtration argument, even for a non-Galois leg. Outside this class,
the argument does not apply; this is NOT a claim that restricted theta
must fail to be proper.

## 2. An ordinary-complement sufficient condition

Let A be an abelian subvariety of J(C), and suppose Q=J(C)/A is ordinary.
Then

\[
                        A^{(1)}\not\subset\Theta_C.
\]

### Proof

Use Verschiebung V_J:J(C)^(1) -> J(C), and let K be the connected local
component at the identity of ker(V_J). The image of K in Q^(1) lies in
ker(V_Q). Since Q is ordinary, ker(V_Q) is etale. A connected local scheme
maps to its identity component, which is the identity point. Consequently
K is contained scheme-theoretically in A^(1).

The Dirac property says that a local equation of Theta_C restricts
nontrivially to O_(ker(V_J),0), where it generates the socle. Thus it
cannot vanish identically on A^(1). This is precisely the implication
needed here from [Tong, Definition 1.2.7.1 and Theorem 1.2.7.7](https://arxiv.org/pdf/0712.2046).

This argument does not require that C map birationally into a dual
abelian variety. For a mixed image A^(1)=im(f^(1)*+g^(1)*), it supplies a
sufficient condition when the complementary quotient is ordinary; it
does not assert that this quotient is ordinary.

## 3. Minimality does give generic stability of the special family

Let X <-f- Z -g-> Y be actual finite etale maps, and assume minimality:
k(Z)=k(X)k(Y) inside k(Z). Then

\[
                     E_M=f_*g^*M
\]

is a stable degree-zero bundle on X for M in a nonempty open subset of
J(Y). No assumption on Hom(J_X,J_Y) or on p-divisibility of monodromy is
needed. The same statement holds on the Frobenius twists.

### Proof

Take the Galois closure pi:W -> X of f, and write r_i:W -> Z for the
sheets indexed by G/H. The maps h_i=g r_i:W -> Y are pairwise distinct:
equality of h_i and h_j, together with f r_i=f r_j, would contradict
minimality unless r_i=r_j.

The homomorphisms h_i^*:J(Y) -> J(W) are also pairwise distinct. If two
were equal, duality would make the maps AJ_Y h_i and AJ_Y h_j differ by
a constant translation in J(Y). That translation preserves AJ_Y(Y), so
it induces an automorphism of Y acting trivially on H^0(Y,omega_Y).
Such an automorphism is the identity in characteristic different from 2:
the canonical map is an embedding unless Y is hyperelliptic; in the
hyperelliptic case its only possible additional kernel is the
hyperelliptic involution, which acts as -1 on canonical forms. The
translation and the two maps must therefore be equal, a contradiction.

The equalities h_i^*M=h_j^*M consequently define finitely many proper
closed kernels in J(Y). Choose M outside them. Etale base change gives

\[
                       \pi^*E_M=\bigoplus_i h_i^*M,
\]

a sum of pairwise nonisomorphic degree-zero line bundles. It is
semistable, so E_M is semistable. If E_M had a proper nonzero subbundle
of slope zero, its pullback would be a degree-zero subbundle of this
polystable sum. Such a subbundle is a direct sum of a subset of its
pairwise nonisomorphic stable factors: equivalently, use the abelian
category of semistable bundles of slope zero, in which a sum of simple
objects is semisimple. The pullback subbundle is G-invariant, while G
acts transitively on the summands. The subset is therefore empty or
full, a contradiction. No averaging by |G| is used.

## Boundary for the unresolved two-leg question

Projection formula expresses the mixed theta locus as

\[
 D(L,M)=H^0(X^{(1)},B_X\otimes L\otimes f^{(1)}_*g^{(1)*}M).
\]

Section 3 proves stability of the special pushforward family for generic
M, but proves NO theta divisor for its tensor product with B_X. Mere
stability is not a general criterion for existence of a generalized
theta divisor. Sections 1 and 2 are sufficient properness conditions,
not consequences of generic stability.

The separate [relative Gauss-map note](MINIMAL_BIETALE_CORRESPONDENCE_HAS_BIRATIONAL_RELATIVE_GAUSS_MAP.md)
proves birationality when either target is nonhyperelliptic. The bounded
primary-source search found no theorem or actual counterexample settling
restricted Raynaud properness under that birational Gauss hypothesis.
Raynaud's full-Jacobian argument uses all g(C) regular parameters;
restricting to a smaller abelian subvariety does not retain that proof.
Pareschi's [Theorem 1.5](https://arxiv.org/pdf/1401.7442) concerns ordinary
generic vanishing for embedded normal Cohen-Macaulay subvarieties, not
one-step Frobenius injectivity. These are precise limits of the checked
arguments, not a claim that no further theorem exists.
