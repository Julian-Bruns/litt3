# P-group refinement invariance of restricted Raynaud theta

Date: 2026-09-05. Author: `/root/canonical_trace_algebra`.
Status: author proof, not independently audited. The proposed refinement
and normal-p-subgroup reduction are due to `/root`; no novelty claim.

This note supplements the
[socle criterion](SOCLE_CRITERION_FOR_RESTRICTED_RAYNAUD_THETA.md), rather
than reproving it. It gives exact invariance under source p-refinements
for arbitrary parameter families, and allows the socle criterion to be
tested after removing a normal p-subgroup of an actual Galois closure.
Removing that subgroup need not preserve a second target map.

Throughout, k is algebraically closed of characteristic p>0. Curves are
smooth, proper, and connected; the Raynaud applications have genus at
least two. Write F_C:C -> C^(1) for relative Frobenius and

\[
 B_C=\operatorname{coker}(\mathcal O_{C^{(1)}}\longrightarrow
                         F_{C*}\mathcal O_C).
\]

## 1. The elementary p-extension lemma

Let h:W' -> W be a connected finite etale Galois cover with p-group
P and degree d=|P|. For every vector bundle V on W,

\[
 H^0(W',h^*V)=0\quad\Longleftrightarrow\quad H^0(W,V)=0.       \tag{1.1}
\]

No Euler-characteristic hypothesis is needed for (1.1). More precisely,

\[
 h^0(W,V)\ \le\ h^0(W',h^*V)\ \le\ d\,h^0(W,V).             \tag{1.2}
\]

### Proof

The bundle h_*O_(W') is associated to the regular kP-module on the
etale P-torsor. Every simple kP-module is trivial. A composition series
of the regular module therefore descends to a filtration by vector
subbundles whose d successive quotients are O_W. Tensoring with V
gives successive quotients V. The upper bound in (1.2) follows from
the long exact cohomology sequences and projection formula. Pullback
of sections along the faithfully flat map h is injective, giving the
lower bound and hence (1.1).

If chi(V)=0, the same filtration gives chi(h^*V)=0. Consequently V is
acyclic if and only if h^*V is acyclic. No trace splitting or division
by d occurs. \(\square\)

The result also applies to a finite sequence of etale Galois p-group
refinements, by iteration. It is not a claim about arbitrary covers
whose degree happens to be a power of p.

## 2. Families and exact theta multiplicity

Let S be an integral parameter variety, and let V be a vector bundle
on W x S with chi(V_s)=0 on every fiber. Denote the two projections to S
by pi and pi', and set V'=(h x id_S)^*V. The filtration above pulls
back to W x S. Multiplicativity of determinant of cohomology gives

\[
 \det R\pi'_*V'\ \simeq\ (\det R\pi_*V)^{\otimes d}.        \tag{2.1}
\]

Use the inverse determinant line for the theta-section convention:
locally a complex [E^0 -> E^1] of equal-rank bundles gives the section
det(E^0 -> E^1) of det(E^1) tensor det(E^0)^(-1). Such presentations
can be obtained from a sufficiently positive auxiliary divisor on W.

If V is generically acyclic, its theta section and that of V' satisfy,
under (2.1),

\[
                       \theta_{V'}=\theta_V^{\otimes d}     \tag{2.2}
\]

up to the harmless unit coming from determinant identifications.
Indeed the determinant sections multiply along the filtration, whose
successive quotient families are all V. In particular, as effective
Cartier divisors,

\[
                              \Theta_{V'}=d\,\Theta_V.      \tag{2.3}
\]

Fiberwise (1.1) says that the bad-section loci have exactly the same
support, whether or not they are proper. If V is not generically
acyclic, both determinant sections are identically zero. In that case
one must not call their vanishing an effective Cartier divisor or use
an undefined pullback of a divisor containing all of S.

### Raynaud application, including two legs

For an etale map h the Frobenius square is Cartesian, and gives the
canonical identity

\[
                        h^{(1)*}B_W\simeq B_{W'}.           \tag{2.4}
\]

Let N be any family of degree-zero line bundles on W^(1), parametrized
by an abelian variety S; no injectivity or separability of its
parameter map to J(W^(1)) is required. Apply Sections 1--2 to
V=B_W tensor N and h^(1). Since deg(B_W)=(p-1)(g(W)-1), its fiber
Euler characteristic is zero. Thus the two loci

\[
 \{s:H^0(W^{(1)},B_W\otimes N_s)\ne0\},\qquad
 \{s:H^0(W'^{(1)},B_{W'}\otimes h^{(1)*}N_s)\ne0\}
                                                               \tag{2.5}
\]

are equal set-theoretically. They are proper simultaneously. When
proper, their determinant theta divisors differ by the factor d.

In particular, for any actual bi-etale W -> X,Y, take

\[
 N_{L,M}=f^{(1)*}L\otimes g^{(1)*}M,
 \qquad S=J(X^{(1)})\times J(Y^{(1)}).
\]

Replacing W by the actual p-refinement W', with its two composite
maps to X and Y, preserves both properness and failure of properness
of this two-leg restricted theta locus. Minimality is not needed for
this assertion. Numerical section dimensions need not remain equal;
only the support and the asserted divisor multiplicity are invariant.

## 3. Exact reduction by a normal p-subgroup

Let q:W -> C be an actual connected finite etale Galois cover with
finite group G. Let P be any normal p-subgroup, in particular O_p(G),
and write

\[
 h:W\longrightarrow\overline W=W/P,
 \qquad \overline q:\overline W\longrightarrow C,
 \qquad Q=G/P.
\]

On the Frobenius twists put

\[
 \begin{aligned}
 \mathcal D_W(L)&=H^0(W^{(1)},B_W\otimes q^{(1)*}L),\\
 \mathcal D_{\overline W}(L)
   &=H^0(\overline W^{(1)},B_{\overline W}
                                \otimes\overline q^{(1)*}L).
 \end{aligned}
\]

Descent of sections and (2.4) give a canonical Q-equivariant identity

\[
                  \mathcal D_W(L)^P
                    =\mathcal D_{\overline W}(L).          \tag{3.1}
\]

Here invariants are taken only on sections; their exactness on
arbitrary modular representations is not being asserted.

Every simple kG-module S is killed by P: its P-invariants are nonzero
because P is a p-group, and normality makes them a G-submodule.
Hence inflation identifies all simple kQ-modules with all simple
kG-modules. For each such S, (3.1) gives

\[
 \operatorname{Hom}_{kG}(\operatorname{Inf}S,\mathcal D_W(L))
   =\operatorname{Hom}_{kQ}(S,\mathcal D_{\overline W}(L)).  \tag{3.2}
\]

Equivalently, inside D_W(L),

\[
 \operatorname{soc}_{kG}\mathcal D_W(L)
     =\operatorname{Inf}\bigl(
          \operatorname{soc}_{kQ}\mathcal D_{\overline W}(L)\bigr).
                                                               \tag{3.3}
\]

Thus all origin, translated, and multipoint simple-submodule tests
from the socle note are exactly equivalent on the quotient. In
particular the first-axis theta loci for q and qbar have equal support;
when proper the upstairs divisor is |P| times the downstairs one.

Let m_p(Q) be the least dimension greater than one of a simple kQ-module,
or infinity if none exists. The previously proved socle criterion
applied to qbar gives the sufficient condition

\[
                         a(\overline W)<m_p(Q).             \tag{3.4}
\]

In particular a(W/P)<=1 suffices. More generally, it suffices that
the socle of H^0(Wbar^(1),B_Wbar) contain only character simples;
there is no need to bound its total dimension when those character
isotypes are the only ones present. Since all simples are inflated,
m_p(Q)=m_p(G). The improvement in (3.4) is using the smaller actual
quotient a-number instead of a(W).

For clarity the generic section dimensions obey only

\[
 \delta_{\overline q}\le\delta_q
                         \le |P|\delta_{\overline q},       \tag{3.5}
\]

not an asserted equality; their vanishing is equivalent. The same
inequalities hold for the a-numbers at L=O.

## 4. Actual intermediate curves and the second-leg boundary

If Z=W/H is an actual intermediate cover f:Z -> C, pullback embeds

\[
 H^0(Z^{(1)},B_Z\otimes f^{(1)*}L)
                          \hookrightarrow\mathcal D_W(L).
\]

Therefore any sufficient condition above proving properness on W/P
proves properness for W and then for this actual Z. If Z also maps
finite etale to Y, its two-leg locus is proper by restriction to the
M=O axis. Both original maps from Z are retained.

Conversely, the second map from W or Z need not descend to W/P.
The normal-p reduction is therefore not a replacement of the
bi-etale correspondence by a new common source, and it does not
identify arbitrary two-variable twists upstairs with twists on W/P.
It is used only for a descended parameter family, in particular the
first-axis family just proved sufficient. No conclusion for a
general non-Galois intermediate is obtained by simply replacing H
by HP; Sections 3--4 make no such assertion.

The line-filtration mechanism already appears, for a more restrictive
monodromy class, in the
[earlier restricted-theta comparison](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md).
The additions here are arbitrary-parameter source p-refinement
invariance, exact normal-p socle reduction, and their sufficient-test
interface with the unchanged actual second leg.
