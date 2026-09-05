# Tame over-orbifolds lift and factor by descent

This file closes the **specialization part** of the tame over-orbifold
route, conditional on one explicitly isolated complex-analytic input.  It
does not classify wild over-orbifolds and it does not construct a finite
envelope for an arbitrary self-correspondence.

Throughout,

\[
 k=\overline{\mathbf F}_5,\qquad
 S=\mathbf P^1_k(31,31,31),\qquad
 S_0=\mathbf P^1_k(2,3,62),
\]

and

\[
 \pi _0:S\longrightarrow S_0
\]

is the already constructed symmetric quotient of degree \(6\).

## The category being used

For a field or a DVR \(B\), a **tame orbifold curve over \(B\)** in this
file means a smooth proper Deligne--Mumford stack \(\mathcal X/B\), of
relative dimension one, with finite diagonal, geometrically connected
fibers, trivial generic stabilizer, and stabilizer orders invertible on
\(B\).  All morphisms called finite étale are representable unless the
opposite is explicitly stated.

Over an algebraically closed field, every such orbifold is an iterated
root stack

\[
 \sqrt[n_1]{(X,x_1)}\mathbin{\times_X}\cdots
 \mathbin{\times_X}\sqrt[n_r]{(X,x_r)}
\]

of its smooth coarse curve at distinct points.  Indeed, an inertia group
acts faithfully on the one-dimensional tangent space, so it is cyclic,
and the usual map to the corresponding root stack is an isomorphism
étale-locally at each stacky point and away from the stacky locus.

For a complete DVR \(R\), we use the same root-stack description with
distinct sections \(x_i:\operatorname {Spec}R\to X\).  Thus no generic
gerbe and no non-effective stabilizer action is allowed.  This is the
precise category in which the theorem below is asserted.

## The sole external complex input

Put

\[
 \Gamma=\Delta(31,31,31),\qquad
 \Gamma _0=\Delta(2,3,62),
\]

where \(\Delta(a,b,c)\subset\mathrm {PSL}_2(\mathbf R)\) is the
orientation-preserving Fuchsian triangle group for the complex orbifold
\(\mathbf P^1_{\mathbf C}(a,b,c)\).  Fix the index-six inclusion
\(\Gamma\subset\Gamma _0\) corresponding to the quotient \(\pi _0\).

### HYP-COMPLEX-COMMENSURATOR

**Status: external input; the cited theorem chain still needs a final
convention check.**

\[
 \operatorname {Comm}^{+}_{\mathrm {PSL}_2(\mathbf R)}(\Gamma)
       =\Gamma _0.                                                \tag{15.1}
\]

Here \(\operatorname {Comm}^{+}\) denotes the orientation-preserving
commensurator.  Equivalently, every finite-covolume Fuchsian group
\(\Lambda\) satisfying \(\Gamma\subseteq\Lambda\) is contained in
\(\Gamma _0\).

The following is a precise reference route to (15.1).

1. D. Singerman, *Finitely maximal Fuchsian groups*, J. London Math.
   Soc. (2) **6** (1972), 29--38,
   DOI 10.1112/jlms/s2-6.1.29, Theorems 1 and 2, classifies the normal
   and non-normal finite-index inclusions of orientation-preserving
   triangle groups.  For \(n>3\), its lists contain the standard chain
   giving
   \[
      \Delta(n,n,n)<\Delta(2,3,2n)
   \]
   with total index \(6\).  They also imply that
   \(\Delta(2,3,62)\) is finitely maximal.
2. K. Takeuchi, *Arithmetic triangle groups*, J. Math. Soc. Japan
   **29** (1977), 91--106, Theorem 3, is the complete list of
   arithmetic triangle signatures.  The signature \((2,3,62)\) is not
   in that list.
3. D. Singerman and R. I. Syddall, *The Riemann surface of a uniform
   dessin*, Beiträge Algebra Geom. **44** (2003), 413--430, Theorem
   9.1, states the needed Fuchsian form of Margulis's theorem: a
   finite-covolume Fuchsian group has finite index in its commensurator
   exactly in the non-arithmetic case.  The paragraph immediately after
   that theorem records, using Singerman's list, the resulting
   orientation-preserving commensurators of non-arithmetic triangle
   groups \(\Delta(2,m,n)\).

Indeed, commensurators are unchanged after passage to a finite-index
subgroup.  Item 2 and Theorem 9.1 make
\(\operatorname {Comm}^{+}(\Gamma _0)\) a discrete finite-index
Fuchsian overgroup of \(\Gamma _0\); finite maximality in item 1 then
makes it equal to \(\Gamma _0\).  Since \(\Gamma\) has finite index in
\(\Gamma _0\), equation (15.1) follows.

The remaining convention check is narrow but should not be hidden: one
must compare Singerman's orientation-preserving group convention and his
standard inclusion with the particular \(S_3\)-quotient used to define
\(\pi _0\).  Every algebraic step below is independent of this check.

## LEM-TAME-ROOT-LIFT -- one stack cover lifts effectively

**Status: proved text, using Wewers's tame-cover lifting theorem.**

Let \(\mathcal O/k\) be a tame orbifold curve and let

\[
 f:S\longrightarrow\mathcal O
\]

be representable finite étale.  There are

- a complete mixed-characteristic DVR \(R\) with residue field \(k\);
- a smooth proper tame root-stack orbifold \(\mathcal O_R/R\) with
  special fiber \(\mathcal O\); and
- a representable finite étale map
  \[
       f_R:\mathcal S'_R\longrightarrow\mathcal O_R               \tag{15.2}
  \]
  together with an identification of its special fiber with \(f\).

The source \(\mathcal S'_R\) is connected.  Its stacky locus consists of
three disjoint sections, each with inertia \(\mu _{31}\), lifting the
three stacky points of \(S\).

### Proof

Let \(O\) be the coarse curve of \(\mathcal O\).  The coarse map induced
by \(f\) is a nonconstant generically separable map
\(\mathbf P^1_k\to O\): separability follows because \(f\) is étale at
the generic points.  Riemann--Hurwitz therefore gives \(O\simeq
\mathbf P^1_k\).

Write the stacky points of \(\mathcal O\) as
\(q_1,\ldots,q_r\), with respective orders \(n_1,\ldots,n_r\), all
prime to \(5\).  Start with \(R=W(k)\), choose pairwise disjoint lifts
\(q_{i,R}\) on \(\mathbf P^1_R\), and set

\[
 \mathcal O_R=
 \sqrt[n_1]{(\mathbf P^1_R,q_{1,R})}\mathbin{\times_{\mathbf P^1_R}}
 \cdots\mathbin{\times_{\mathbf P^1_R}}
 \sqrt[n_r]{(\mathbf P^1_R,q_{r,R})}.
\]

On coarse curves, \(f\) is a cover tamely ramified only above the
\(q_i\).  If \(x\) lies over \(q_i\), representable étaleness of the
root-stack map is equivalent to

\[
              e_x\,|I_x|=n_i,                                    \tag{15.3}
\]

where \(e_x\) is the coarse ramification index and \(I_x\) is source
inertia.  In particular every \(e_x\) is prime to \(5\).

Now apply S. Wewers, *Deformation of tame admissible covers of curves*,
in *Aspects of Galois Theory*, London Math. Soc. Lecture Note Ser. 256,
Cambridge Univ. Press (1999), Corollary 3.1.3.  In Wewers's notation,
for a smooth projective marked curve over a complete noetherian local
ring, reduction from tamely ramified covers to covers of the special
fiber is an **equivalence of categories**.  This gives both uniqueness
and effectivity here.  More explicitly, §3.2.3 of that paper constructs
the compatible lifts over \(R/\mathfrak m^{j+1}\) and then applies
Grothendieck's Existence Theorem to algebraize the formal cover.  Thus
nilpotent invariance is not being used without a formal-GAGA
effectivity step.

Let \(C_R\to\mathbf P^1_R\) be the resulting marked tame cover.  The
marked source points are disjoint sections; \(R\) is strictly henselian,
so the finite étale marked divisors split into sections.  At the section
lifting \(x\), put a root of order

\[
                 |I_x|=\frac{n_i}{e_x}.
\]

Writing \(m=|I_x|=n_i/e_x\), the local root-stack chart is the
standard map

\[
 [\operatorname {Spec}R[[z]]/\mu _m]
 \longrightarrow
 [\operatorname {Spec}R[[u]]/\mu _{n_i}],
 \qquad u\longmapsto z,
\]

with the standard inertia inclusion.  On coarse coordinates it sends
\(u^{n_i}\) to \(z^{n_i}=(z^m)^{e_x}\).  Equation (15.3) says exactly
that this stack map is representable and étale.

Here is the global gluing in the language of the root-stack universal
property.  On the source put a root of order \(m_x=n_i/e_x\) at every
marked section \(x\) over \(q_i\), and let \(L_x\) be its tautological
root line bundle.  Then

\[
 M_i=\bigotimes_{x\mid q_i}L_x
 \quad\hbox{satisfies}\quad
 M_i^{\otimes n_i}
 \simeq
 \mathcal O\!\left(\sum_{x\mid q_i}e_xx\right)
 \simeq f_{\mathrm{coarse}}^*\mathcal O(q_i),
\]

with the corresponding tensor product of tautological sections.  The
universal property therefore gives a map to the \(n_i\)-th root along
\(q_i\), simultaneously for every \(i\), and hence a global map to their
fiber product \(\mathcal O_R\).  Its local charts are precisely those in
the preceding display, so it is representable and étale.  This is (15.2).

Connectedness is also retained.  Under Wewers's equivalence, a
decomposition of the lifted cover into open-and-closed pieces would
reduce to such a decomposition of \(S\); equivalently, idempotents lift
uniquely over the complete local base.  Finally, the only nontrivial
source inertia groups on the special fiber are the three copies of
\(\mu _{31}\).  The supports of nontrivial inertia in the coarse source
form a finite étale marked divisor over \(R\), hence are exactly three
disjoint sections; along each section the stabilizer is
\(\mu _{31}\).  \(\square\)

## LEM-RIGID-SOURCE -- the source lift is the chosen marked lift

**Status: proved text.**

Let

\[
 \mathcal S_R=
 \sqrt[31]{(\mathbf P^1_R,0)}
 \mathbin{\times_{\mathbf P^1_R}}
 \sqrt[31]{(\mathbf P^1_R,1)}
 \mathbin{\times_{\mathbf P^1_R}}
 \sqrt[31]{(\mathbf P^1_R,\infty)}.
\]

In the situation of LEM-TAME-ROOT-LIFT, the special-fiber
identification labels the three stack sections of \(\mathcal S'_R\).
There is an isomorphism in the marked root-stack 2-category

\[
       \iota:\mathcal S_R\xrightarrow{\sim}\mathcal S'_R,          \tag{15.4}
\]

compatible, up to a unique 2-isomorphism, with that special-fiber
identification.  We may consequently regard (15.2) as
\(f_R:\mathcal S_R\to\mathcal O_R\).

### Proof

The coarse curve \(C_R\) of \(\mathcal S'_R\) is smooth proper of
relative genus zero and carries three pairwise disjoint labelled
sections.  A genus-zero curve over a local base with a section is
\(\mathbf P(E)\) for a rank-two projective \(R\)-module \(E\); since
\(R\) is local, \(E\) is free.  There is a unique element of
\(\mathrm {PGL}_2(R)\) sending the three labelled sections to
\(0,1,\infty\).  Its reduction is the coordinate fixed on the special
fiber.

Equivalently, the deformation and infinitesimal-automorphism groups of
the labelled coarse source are

\[
 H^1\!\left(\mathbf P^1,T_{\mathbf P^1}(-0-1-\infty)\right)
 =H^1(\mathbf P^1,\mathcal O(-1))=0,
\]

\[
 H^0\!\left(\mathbf P^1,T_{\mathbf P^1}(-0-1-\infty)\right)
 =H^0(\mathbf P^1,\mathcal O(-1))=0.
\]

The coordinate therefore identifies the coarse marked curves uniquely.
Taking the three \(31\)-st roots gives (15.4).  Any two root-stack lifts
of the same marked coarse isomorphism are uniquely 2-isomorphic; the
compatibility 2-isomorphism on the special fiber lifts because
\(\mu _{31}\) is finite étale over the strictly henselian base.

This is the exact sense in which the lifted source is canonical.  The
target \(\mathcal O_R\) need not have a unique lift, and maps obtained
from two different target lifts need not be comparable.  What is true,
and all that is used below, is that **for every** marked target lift the
induced source is the same marked root stack \(\mathcal S_R\).  For a
fixed target lift, Wewers's equivalence also says that the lifted cover,
with its special-fiber identification, is unique up to unique
isomorphism.  Thus neither choice changes the source on which
\((\pi _0)_R\) is defined.  \(\square\)

The permutation action on the three marked sections, and hence on their
root stack, is defined over \(R\).  The integral symmetric-quotient
construction used for \(\pi _0\) gives a representable finite étale
map

\[
 (\pi _0)_R:\mathcal S_R\longrightarrow
 (\mathcal S_0)_R\simeq\mathbf P^1_R(2,3,62),                     \tag{15.4a}
\]

of degree \(6\), whose special fiber is \(\pi _0\).  Equivalently,
\((\mathcal S_0)_R=[\mathcal S_R/S_3]\), with the displayed
identification of its three effective cyclic inertia orders.  This is
the chosen mixed-characteristic lift of the quotient in what follows.

## LEM-EXTEND-GENERIC-2-ISOM -- extension over a normal model

**Status: proved text.**

Let \(R\) be a DVR, let \(\mathcal X/R\) be a normal
Deligne--Mumford stack every irreducible component of which dominates
\(\operatorname {Spec}R\), and let \(\mathcal T/R\) be a
Deligne--Mumford stack with finite diagonal.  If two maps

\[
 a,b:\mathcal X\longrightarrow\mathcal T
\]

are 2-isomorphic on the generic fiber, that specified 2-isomorphism
extends uniquely over \(\mathcal X\).

### Proof

The sheaf

\[
 \operatorname {Isom}_{\mathcal X}(a,b)\longrightarrow\mathcal X
\]

is the pullback of the finite diagonal of \(\mathcal T\), hence is
finite and separated.  Take a normal étale atlas \(U\to\mathcal X\)
and work on one integral component of \(U\).  Inside the finite
\(U\)-space \(\operatorname {Isom}_U(a,b)\), take the **reduced
irreducible closure** \(Z\) of the generic section.  Then \(Z\to U\)
is finite and birational.  On affine charts its coordinate ring is a
finite integral \(A\)-subalgebra of \(\operatorname {Frac}(A)\);
normality of \(A\) forces that algebra to be \(A\).  Hence
\(Z\to U\) is an isomorphism and the generic section extends.

The two pullbacks of this extension to
\(U\times_{\mathcal X}U\) agree on the generic fiber.  They agree
everywhere because that overlap is reduced and the Isom space is
separated.  The extension therefore descends to \(\mathcal X\).
The same argument shows that two extensions agreeing generically are
equal, which proves uniqueness.  \(\square\)

## THM-TAME-OVER-ORBIFOLD-FACTORIZATION

**Status: conditional proof, conditional only on
HYP-COMPLEX-COMMENSURATOR.**

Let \(\mathcal O/k\) be a tame orbifold curve and let

\[
             f:S\longrightarrow\mathcal O
\]

be representable finite étale.  Assuming (15.1), there is a
representable finite étale map

\[
             h:\mathcal O\longrightarrow S_0
\]

and a 2-isomorphism

\[
             h f\simeq\pi _0.                                    \tag{15.5}
\]

### Proof

The two preceding lifting lemmas give

\[
 f_R:\mathcal S_R\longrightarrow\mathcal O_R.
\]

Let \(K\) be the fraction field of \(R\).  The generic-fiber diagram is
of finite presentation, so it has a model over a finitely generated
subfield \(K_0\subset K\) of characteristic zero.  Choose an embedding
\(K_0\hookrightarrow\mathbf C\).  Analytic uniformization turns the
resulting \(f_{\mathbf C}\) into an inclusion

\[
              \Gamma\subseteq\Lambda
\]

of finite-covolume Fuchsian groups.  Every element of \(\Lambda\)
commensurates \(\Gamma\), since \(\Gamma\) and each of its
\(\Lambda\)-conjugates have finite index in \(\Lambda\).  Hypothesis
(15.1) gives

\[
              \Gamma\subseteq\Lambda\subseteq\Gamma _0.
\]

Taking quotients of the upper half-plane produces a representable
finite étale map over \(\mathbf C\),

\[
 h_{\mathbf C}:\mathcal O_{\mathbf C}
       \longrightarrow(\mathcal S_0)_{\mathbf C},
 \qquad
 h_{\mathbf C}f_{\mathbf C}\simeq(\pi _0)_{\mathbf C}.             \tag{15.6}
\]

This factorization descends to a finite extension of \(K\).  Here is a
precise finite-type argument.  Parameterize maps of the fixed degree by
the graph Hilbert scheme (or the Hom-stack for proper tame
Deligne--Mumford curves), include in the parameter problem the
2-isomorphism in (15.6), and restrict to the open locus on which \(h\) is
representable and finite étale.  The resulting factorization stack is
algebraic and of finite type over \(K_0\).  Its base change to
\(\mathbf C\) contains the Fuchsian factorization just constructed, so it
is nonempty.  It has a point over an algebraic closure
\(\overline {K_0}\), and that point is defined over some finite extension
\(K_1/K_0\).  Choose a \(K_0\)-embedding \(K_1\hookrightarrow
\overline K\).  The compositum \(K'=KK_1\) is finite over \(K\), and
base change gives (15.6) over \(K'\).  Normalize and complete \(R\) in
\(K'\).  The residue field remains \(k\), and all the lifted objects
base change to the new \(R\).  We retain the same notation.

It remains to extend the generic factorization.  We do this by descent,
not by claiming that a rational map out of \(\mathcal O_R\) extends.
Put

\[
 \mathcal R=\mathcal S_R\mathbin{\times_{\mathcal O_R}}\mathcal S_R
\]

and denote its projections by \(p_1,p_2\).  The generic
factorization and the canonical 2-isomorphism
\(f_Rp_1\simeq f_Rp_2\) give

\[
 ((\pi _0)_Rp_1)_K\simeq((\pi _0)_Rp_2)_K.                        \tag{15.7}
\]

The stack \(\mathcal R\) is finite étale over \(\mathcal S_R\), hence
smooth and normal over \(R\), and every one of its components dominates
the base.  The diagonal of \((\mathcal S_0)_R\) is finite.
LEM-EXTEND-GENERIC-2-ISOM therefore extends (15.7) uniquely over
\(\mathcal R\).

On the triple fiber product, the two sides of the descent cocycle agree
on the generic fiber and hence everywhere by the same uniqueness.  The
unit condition is identical.  Thus \((\pi _0)_R\) has an effective
descent datum along the representable finite étale surjection \(f_R\).
Morphisms into an algebraic stack satisfy fpqc descent, so this datum
gives

\[
 h_R:\mathcal O_R\longrightarrow(\mathcal S_0)_R,\qquad
 h_Rf_R\simeq(\pi _0)_R.                                         \tag{15.8}
\]

We next verify representability before using scheme-like finiteness
criteria.  On the generic fiber, \(h_R\) is representable by its
Fuchsian-group construction.  Every nontrivial inertia group of
\(\mathcal O_R\) occurs along one of its horizontal root sections.
The generic point of such a section maps to a horizontal root section
of \((\mathcal S_0)_R\), and therefore the whole section does.  Along
it, the inertia homomorphism is a homomorphism between finite étale
cyclic group schemes of orders prime to \(5\).  Its kernel is finite
étale of constant rank.  Since that kernel is trivial generically, it
is trivial everywhere.  At all other points source inertia is trivial.
The relative inertia of \(h_R\) is therefore trivial, which is the
representability criterion for a morphism of Deligne--Mumford stacks.

Now \(h_R\) is quasi-finite.  Indeed, for every geometric point \(t\) of
\((\mathcal S_0)_R\), the fiber of \(f_R\) over
\((\mathcal O_R)_t\) is a finite surjective cover and is contained,
using (15.8), in the finite fiber \(((\pi _0)_R)^{-1}(t)\).  Thus
\((\mathcal O_R)_t\) is zero-dimensional.  The map \(h_R\) is proper:
its graph is closed because \((\mathcal S_0)_R\) is separated over
\(R\), and projection from
\(\mathcal O_R\times_R(\mathcal S_0)_R\) to
\((\mathcal S_0)_R\) is proper.  A representable proper quasi-finite
map is finite.

Finally, the cotangent triangle for

\[
 \mathcal S_R\xrightarrow{f_R}\mathcal O_R
       \xrightarrow{h_R}(\mathcal S_0)_R
\]

and the étaleness of \(f_R\) and \((\pi _0)_R\) give

\[
 f_R^*L_{\mathcal O_R/(\mathcal S_0)_R}=0.
\]

Faithfully flat descent along \(f_R\) gives
\(L_{\mathcal O_R/(\mathcal S_0)_R}=0\).  Since \(h_R\) is a
finite-presentation representable morphism, it is étale.

Taking the special fiber of (15.8) proves (15.5).  \(\square\)

## Audit of lift choices and scope

The proof does **not** assert that two arbitrary finite étale maps with a
common source lift simultaneously.  For a fixed target deformation, one
map lifts uniquely, but two different legs can induce different
deformations of their source.  That is the genuine obstruction for a
general self-correspondence \(C\rightrightarrows S\).

The present situation avoids that obstruction for one specific reason:
the source is the three-pointed genus-zero root stack \(S\), whose marked
deformation space and marked automorphism group are both trivial.
Changing the lift of \(\mathcal O\) can change \(f_R\), but it cannot
change its marked source.  Forgetting the labels would introduce an
\(S_3\)-ambiguity; the fixed special-fiber identification supplies the
labels, so no such ambiguity enters the descent.

Consequently the theorem supplies the characteristic-\(5\) tame
specialization/overgroup implication formerly isolated as
OPEN-TAME-SPECIALIZATION, subject only to (15.1).  It does not produce
an over-orbifold from an arbitrary correspondence, exclude wild
over-orbifolds, or prove visibility by itself.
