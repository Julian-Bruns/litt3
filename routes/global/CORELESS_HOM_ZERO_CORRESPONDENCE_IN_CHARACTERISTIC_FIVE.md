# A coreless Jacobian-orthogonal étale correspondence in characteristic five

**Status:** collaborative author proof; focused independent audit **PASS**,
2026-09-05, auditor `/root/canonical_trace_algebra`. No breaking objections.
The arithmetic, corelessness, and same-source good reduction were independently
checked; the auditor's own ordinary-factor computation was rerun as an author
self-check, not an independent computational audit. Nonbreaking suggestions
concern two supplementary Stacks citations, projective-group notation, and
explicit geometric/henselian conventions.
[Audit record](audits/CORELESS_HOM_ZERO_CORRESPONDENCE_IN_CHARACTERISTIC_FIVE_AUDIT.md).

Arithmetic/core arguments: /root and
/root/gluing_cohomology_rigidity. The ordinary-factor computation is the
separate input by /root/canonical_trace_algebra linked below.

This is an auxiliary boundary theorem. It is not a correspondence for
the fixed pair in file 76, a no-common-cover theorem, or a claim about
the dimension of any simultaneous deformation space.

## Theorem

Over \(k=\overline{\mathbf F}_5\), there are smooth projective connected
curves \(X,Y,Z\), with \(g(X)=5\), \(g(Y)=3\), and finite étale maps

\[
                         X\longleftarrow Z\longrightarrow Y
\]

such that

\[
 \operatorname{Hom}(J(X),J(Y))=0,\qquad
                 k(X)\cap k(Y)=k\quad\text{inside }k(Z).
\]

The joint map can be chosen primitive. The target \(Y\) is
\(y^2=t^7-1\); the target \(X\) is the explicit three-block quotient
described next. The existence proof chooses a sufficiently high power
of a quaternionic commensuration. No explicit exponent or source
equation is claimed.

## 1. Fixed targets, their lift, and the initial actual correspondence

Choose a primitive seventh root \(\zeta\), initially in characteristic
zero, and put

\[
 \begin{aligned}
 F_1&=(t-1)(t-\zeta),\\
 F_2&=(t-\zeta^2)(t-\zeta^3),\\
 F_3&=(t-\zeta^4)(t-\zeta^5)(t-\zeta^6).
 \end{aligned}
\]

Let \(W\) be the smooth normalization in
\(k(t)(u_1,u_2,u_3)\), where \(u_i^2=F_i\). Let \(H\cong C_2^2\)
be the even-sign subgroup and let \(\sigma\) change all three signs.
Then

\[
             Y=W/H:\ y^2=t^7-1,\qquad X=W/\langle\sigma\rangle.
\]

The actual maps \(W\to Y\) and \(W\to X\) are Galois étale of degrees
four and two. At a finite branch point inertia changes one sign, and
at infinity it changes only the third sign. Neither inertia group
meets either quotient subgroup. Thus \(g(W)=9\), \(g(X)=5\),
\(g(Y)=3\). This is the construction of
[110, §4](110_TWO_LEG_WITT_OBSTRUCTION_AND_NONZERO_CROSS_TRACE.md),
with infinity accounted for explicitly.

The characteristic-zero curves and maps have good reduction at five:
the eight branch sections, including infinity, remain disjoint, and
the multiquadratic covers are tame there. Equivalently, construct the
smooth tame covers of the relative marked projective line and take the
same free quotients. Denote the reductions again by \(X,Y,W\).

The character decomposition gives

\[
 J(X)\sim J(y^2=F_1F_2)\times J(y^2=F_1F_3)
                     \times J(y^2=F_2F_3).
\]

All three factors are ordinary, of genera \(1,2,2\), by the exact
[ordinary-factor certificate](SEVENTH_ROOT_BRANCH_PARTITIONS_ORDINARY_PAIR_FACTORS.md).
Hence \(X\) is ordinary.

For completeness, \(Y\) is supersingular. Set \(q=125\). The Hermitian
curve \(U^{q+1}+V^{q+1}+W^{q+1}=0\) over \(\mathbf F_{q^2}\) has
\(q^3+1\) points and genus \(q(q-1)/2\); counting norm fibers gives the
point count directly. It attains the upper Weil bound, so all its
Frobenius eigenvalues are \(-q\). The functions

\[
                 t=-(U/W)^{18},\qquad y=(V/W)^{63}
\]

give a nonconstant map to \(y^2=t^7-1\), since \(126=2\cdot63=7\cdot18\).
Thus \(J(Y)\) is a quotient of a supersingular Jacobian and is
supersingular. Its slopes \(1/2\) are disjoint from the ordinary slopes
of \(J(X)\), proving \(\operatorname{Hom}(J(X),J(Y))=0\).

It remains to replace the original cored correspondence by a coreless
one without replacing these two target curves.

## 2. Exact arithmetic input and the subgroup for \(Y\)

Use the orientation-preserving triangle-group convention. Write

\[
 \Phi=\Delta(2,3,7),\quad
 \Pi=\Delta(7,7,7),\quad
 \Delta=\Delta(2,7,14).
\]

The following specific arithmetic facts are recorded in
Girondo--Torres--Wolfart,
[Shimura curves with many uniform dessins, §4 and §6](https://www.researchgate.net/publication/225821698_Shimura_curves_with_many_uniform_dessins),
preprint pp. 11--12 and 20--21; published in Math. Z. 271 (2012),
757--779, [doi:10.1007/s00209-011-0889-4](https://doi.org/10.1007/s00209-011-0889-4):

- \(\Phi\) is the projective norm-one group of a maximal order in a
  quaternion algebra \(A\) over \(F=\mathbf Q(\cos(2\pi/7))\), split at
  one real place and every finite place.
- For the prime \(\mathfrak p_7\) above seven, \(\Pi\) is the inverse
  image of the upper-unipotent \(C_7\) under
  \(\Phi\to\mathrm{PSL}_2(\mathbf F_7)\).
- \(\Pi\) has index two in \(\Delta\). The prime two is inert in \(F\),
  with residue field \(\mathbf F_8\).

These facts specify a congruence subgroup \(\Pi\), not merely a
commensurability class. In particular, \(\Pi\) has the maximal-order
local condition away from \(\mathfrak p_7\).

The cyclic degree-fourteen map \(Y_{\mathbf C}\to\mathbf P^1\) given by
\(t^7\) has branch indices \(7,2,14\). Its uniformizing surface group is

\[
                \Gamma=\ker(\Delta\to C_{14})=[\Delta,\Delta].
\]

Indeed \(\Delta^{\mathrm{ab}}=C_{14}\), and the deck map has this full
quotient. The unique index-two subgroup of \(\Delta\) is \(\Pi\), so

\[
                           \Gamma\triangleleft\Pi,\qquad
                           [\Pi:\Gamma]=7.                 \tag{1}
\]

We do **not** assume that \(\Gamma\) is congruence.

## 3. A commensuration supported only at two

By [Voight, Quaternion Algebras, Main Theorem 28.5.3](https://link.springer.com/chapter/10.1007/978-3-030-56694-4_28),
\(A^1(F)\) is dense in the finite norm-one adeles: its split real place
checks the indefiniteness hypothesis. Choose \(g\in A^1(F)\) such that:

1. \(g\) is integral at every finite place other than two;
2. \(g\equiv1\pmod{\mathfrak p_7}\);
3. at two, \(g\) lies in a sufficiently small open neighborhood of
   \(\operatorname{diag}(2,2^{-1})\).

These are a nonempty open set of finite adeles. The third condition can
be chosen to impose negative valuation on the trace, and consequently
nonzero translation length on the Bruhat--Tits tree. Thus \(g\) is
two-adically loxodromic and no nonzero power belongs to a bounded
subgroup.

At the split real place \(g\) is an orientation-preserving
commensuration. For every integer \(n\), put

\[
                    \Pi_n=g^n\Pi g^{-n},\qquad
                    \Gamma_n=g^n\Gamma g^{-n}.
\]

Outside two, \(g\) preserves the local conditions defining \(\Pi\):
at \(\mathfrak p_7\) it belongs to the congruence kernel, and at all
other places it belongs to the maximal compact group. At two, for a
sufficiently large \(a=a(n)\), the principal \(2^a\)-congruence subgroup
is contained in both relevant maximal compact groups. It follows that
\(\Pi\cap\Pi_n\) contains a principal \(2^a\)-congruence subgroup of
\(\Pi\), normal in \(\Pi\). The analogous statement holds in \(\Pi_n\).
Both associated normal-core quotients have order dividing

\[
             |\mathrm{SL}_2(\mathcal O_{F,2}/2^a)|
                    =504\cdot 8^{3(a-1)},                 \tag{2}
\]

and hence have order prime to five.

## 4. Passing from the congruence group to \(\Gamma\)

Here is the needed finite-group lemma, which prevents an unjustified
congruence assumption about the curve itself.

**Lemma.** Suppose \(\Gamma\triangleleft\Pi\) and
\(\Gamma'\triangleleft\Pi'\) have index prime to \(p\). If
\(\Pi\cap\Pi'\) has normal core of prime-to-\(p\) index in each of
\(\Pi,\Pi'\), then \(\Gamma\cap\Gamma'\) has normal core of
prime-to-\(p\) index in each of \(\Gamma,\Gamma'\).

**Proof.** Put \(R=\operatorname{core}_{\Pi}(\Pi\cap\Pi')\),
\(R_0=R\cap\Gamma\), and \(S=R_0\cap\Gamma'\).
Then \(R_0\triangleleft\Gamma\) has prime-to-\(p\) index,
\(S\triangleleft R_0\), and \(R_0/S\) is a subgroup of
\(\Pi'/\Gamma'\). Intersect the conjugates of \(S\) under a finite
set of representatives for \(\Gamma/R_0\). Their intersection \(K\)
is normal in \(\Gamma\), is contained in \(\Gamma\cap\Gamma'\), and
\(R_0/K\) embeds in a product of prime-to-\(p\) groups. Thus
\([\Gamma:K]\) is prime to \(p\), proving the assertion on this side.
Interchange the two sides. \(\square\)

Apply the lemma to (1)--(2). Consequently the actual characteristic-zero
self-correspondence

\[
 Y\longleftarrow V_n=(\Gamma\cap\Gamma_n)\backslash\mathfrak H
                        \longrightarrow Y
\]

has prime-to-five Galois closures on **both** legs. The maps use the
identity and \(g^{-n}\) on \(\mathfrak H\), respectively.

## 5. High powers remove the core while retaining \(X\) and \(Y\)

Align the universal covers of the original \(X\leftarrow W\to Y\).
Let \(\Gamma_X,\Gamma_W,\Gamma\) be their uniformizing groups, with
\(\Gamma_W\) a finite-index subgroup of both endpoint groups.

We use the finite-discrete-overgroup argument already proved in
[21, Proposition 21.5](21_SIMULTANEOUS_ENVELOPE_CORE_TOWER_CRITERION.md).
A compact surface lattice has only finitely many discrete overgroups:
the universal orbifold area bound bounds their indices; their normal
cores then have bounded index in the surface lattice; and each such
core has a discrete normalizer of finite quotient.

The normalizer \(N(\Gamma)\) is a finite extension of \(\Gamma\).
It lies in the arithmetic commensurator and is two-adically bounded,
because \(\Gamma\) is bounded there and finitely many cosets remain
bounded. Hence \(\Gamma_n\) are pairwise distinct: an equality would
put a nonzero power of \(g\) in \(N(\Gamma)\).

Each discrete overgroup \(\Lambda\) of \(\Gamma_X\) has only finitely
many subgroups with the covolume of \(\Gamma\), since these have one
fixed finite index. Therefore, for all but finitely many \(n\),

\[
                      \langle\Gamma_X,\Gamma_n\rangle
                       \text{ is not discrete}.          \tag{3}
\]

This means that the corresponding two endpoint function fields have
constant intersection. A common nonconstant meromorphic function on
\(\mathfrak H\) would be invariant under both groups; a nondiscrete
group gives an accumulating orbit at a suitable regular point, forcing
that function to be constant by the identity theorem.

Now form the actual fiber product \(W\times_Y V_n\), using the first
leg of \(V_n\). Its components have uniformizing subgroups

\[
 \Gamma_W\cap\gamma_i\Gamma_n\gamma_i^{-1},
 \qquad \gamma_i\in\Gamma_W\backslash\Gamma,
\]

with a fixed finite set of representatives sufficient for all \(n\).
For each \(i\), the conjugates \(\gamma_i\Gamma_n\gamma_i^{-1}\) are
again pairwise distinct. The same finite-overgroup argument therefore
proves (3) for all these components once \(n\) avoids a finite set.
Every such component gives a coreless correspondence from the
**original \(X\)** to the **original \(Y\)**.

Passing from a component to the normalization of its joint image, if
desired, makes the correspondence primitive. This is a finite étale
intermediate cover on either leg. Refining or removing such a source
refinement does not change the intersection of the two endpoint
function fields.

This assertion concerns the correspondences attached to \(g^n\).
It does not assert that every component of an unrestricted iterated
Hecke fiber product is coreless; backtracking components may have cores.

## 6. Good reduction of the same two-leg diagram

Every component in §5 has prime-to-five Galois closure on both endpoint
legs. Indeed, over \(W\) it is a base change of a leg of \(V_n\), and
over \(V_n\) it is a base change of the Galois \(C_2^2\)-cover \(W\to Y\).
The remaining map \(W\to X\) is Galois of degree two. Galois closures
of such towers have prime-to-five order: one may take products of
conjugate Galois closures, and their Galois groups are subgroups of
successive wreath products of the given prime-to-five groups.

The characteristic-zero curves and maps descend to a number field.
For example, finite étale covers of the already algebraic \(X,Y\)
descend to \(\overline{\mathbf Q}\), and the additional map between
hyperbolic curves descends because the scheme of nonconstant maps
between these fixed curves is finite.

Use the good reduction models of \(X,Y\) at a place above five.
The prime-to-\(p\) specialization theorem
([Stacks, Theorem 58.30.3](https://stacks.math.columbia.edu/tag/0BUQ))
extends a cover with prime-to-five Galois closure to a finite étale
cover of each target model after a finite extension of the DVR.
Do this for both legs. The two resulting source models have the same
generic fiber and are smooth proper curves of genus at least two.
Uniqueness of the stable model identifies them by the specified
generic-fiber identity. Thus **both original maps extend on the same
smooth source model**. Its special fiber is geometrically connected.

Finally, [Krishnamoorthy, Correspondences without a core, Lemma 4.10,
pp. 1188--1189](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf)
states that a core in a special fiber of a finite étale correspondence
of smooth proper geometrically integral curves, with hyperbolic source,
would force a core in the generic fiber. All these hypotheses now hold.
The coreless characteristic-zero correspondence therefore remains
coreless after reduction to \(\overline{\mathbf F}_5\).

Its endpoints are precisely the ordinary \(X\) and supersingular \(Y\)
from §1. Their Jacobians have no nonzero homomorphisms between them.
If the special-fiber joint map is not primitive, replace its source
by the normalization of its joint image. This is again an intermediate
finite étale cover on both legs and has the same endpoint-field
intersection. No preservation of generic primitivity under reduction
is assumed.
This proves the theorem.

## Exact boundary

The construction establishes that “no core” and Jacobian Hom
vanishing can coexist on an actual proper bi-étale correspondence
in characteristic five. It does not address the fixed genus-nine and
genus-twenty-five pair, and it does not produce a nonzero simultaneous
deformation or an obstruction to lifting.

No generic-preservation assertion about absolute simplicity is used.
Good reduction at five is established for the **whole two-leg diagram**
through prime-to-five Galois closures, not inferred from good reduction
of the bare target curves. The ordinary-factor certificate is retained
as a separately identified computational input; this note does not
claim an independent audit of it or of the complete combined theorem.
