# How resolved common-cover variants handle non-Galois legs

**Status: primary-source literature and proof-mechanism note, 2026-09-04.**

This note is not a new theorem and does not settle the proper positive-
characteristic problem.  Its purpose is narrower: it records exactly how the
closest positive and negative results pass between arbitrary covers, Galois
covers, and correspondences with two etale legs.  The broad literature search
is in [the literature audit](LITERATURE_AUDIT_THROUGH_2026_09_04.md); the
present note reads the proofs of the closest results and extracts the parts
that can actually be reused.

## 1. Three operations that must not be confused

Let \(C\to X\) and \(C\to Y\) be finite etale maps of connected smooth
curves.

### 1.1 Closing one etale leg is harmless

Take the normal closure of \(k(C)/k(X)\), and let \(\widehat C_X\) be the
normalization of \(X\) in it.  Since the original extension is unramified at
every place, so are all its conjugates and their compositum.  Thus

\[
        \widehat C_X\longrightarrow X
\]

is finite etale and Galois.  The map \(\widehat C_X\to C\) is also finite
etale, so the composite \(\widehat C_X\to Y\) remains finite etale.  This
works in every characteristic.  Hence one may always make **one chosen
etale leg** Galois without losing a common cover.

### 1.2 Closing both legs is not a formal operation

Taking the normal closure over \(Y\) next makes that leg Galois but can destroy
normality over \(X\).  Repeating the operation gives the alternating core
tower of [file 21](21_SIMULTANEOUS_ENVELOPE_CORE_TOWER_CRITERION.md); there is
no formal reason for it to stop.  File 21, Proposition 21.5, gives a complex
same-target bi-etale correspondence for which no simultaneous Galois
refinement exists.

In subgroup language, a simultaneous refinement asks for one finite-index
subgroup that is normal in both ambient covering groups.  Separate normal
cores do not supply one.  This is a substantially stronger requirement than
the existence of the original finite-index intersection.

### 1.3 Closing a ramified leg is different again

Suppose only that \(C\to X\) is etale and \(C\to Y\) is a nonconstant map.
Galois-closing over \(X\) preserves the ramification indices of the composite
map to \(Y\): an etale refinement cannot remove ramification already present
on \(C\to Y\).  Galois-closing the ramified extension over \(Y\), on the other
hand, need not remain etale over \(X\).

This is the precise reason that one-sided virtual domination results cannot
be upgraded to common-etale-cover results by saying “take a Galois closure.”

## 2. Comparison of the proof mechanisms

| Result | Setting and conclusion | Treatment of non-Galois maps | Actual closing mechanism |
|---|---|---|---|
| Tamagawa | Any two smooth connected **affine** curves over \(\overline{\mathbf F}_p\) have a common finite etale cover | No Galois closure is needed | After separate etale refinements, both curves map finite etale to \(\mathbf A^1\); take a fiber product |
| Bogomolov--Tschinkel | For \(p\ge5\), an etale cover of any hyperelliptic curve dominates any projective curve | The target leg is allowed to be ramified | Abhyankar cancellation is arranged only on the source leg |
| Poonen | Many tame Galois covers of curves of genus at most two virtually dominate a hyperelliptic curve | Again one etale leg and one arbitrary dominant leg | Iterated composita and one-sided Abhyankar cancellation |
| Complex uniformization | A common etale cover is equivalent to commensurability of the two uniformizing Fuchsian lattices | The finite-index intersection itself is the common source | No normality is required |
| Mochizuki, nonarithmetic case | All curves in the commensurability class map etale to one hyperbolic core orbifold | He Galois-closes one leg only | The discrete commensurator is a finite ambient envelope |
| Mochizuki, arithmetic case | Finitely many isogenous curves of each fixed type | No closure argument | Arithmeticity is inherited and Takeuchi finiteness applies |
| Tamagawa--Mochizuki Isom theorem | Whole arithmetic fundamental groups reconstruct finite-field curves | Applied to open groups, it reconstructs the already-known common source | It has no open-subgroup-to-ambient extension conclusion |
| Minamide--Sawada--Tsujimura (2026) | Certain open/closed subgroup isomorphisms of almost surface groups are ambient-inner | Requires preservation of **every** procyclic family | This would close the gap only after proving a currently missing hypothesis |

The common pattern in the genuinely positive bi-etale results is not a clever
choice of two Galois closures.  It is the construction of one lower object to
which both curves map etale.  In the affine theorem that object is
\(\mathbf A^1\); in the nonarithmetic complex theorem it is the hyperbolic
core orbifold.

## 3. Tamagawa's affine theorem: a common lower target

Tamagawa's theorem states that any two affine, smooth, connected curves over
the algebraic closure of a finite field have a common finite etale cover.
This is the main theorem of
[*Correspondences on curves in positive characteristic*](https://doi.org/10.1090/conm/767/15400).

The proof architecture, visible in Tamagawa's earlier characteristic-two
[proof sketch](https://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/contents/pdf/1200-19.pdf)
and all-characteristic
[outline](https://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/contents/pdf/1324-1.pdf),
is this:

1. For an affine curve \(U\), pass to a finite etale cover \(U'\to U\).
2. Construct a finite etale map \(U'\to\mathbf A^1\).  In characteristic
   two the differential obstruction is a line bundle and is killed after an
   etale cover; adding a sufficiently high Frobenius power makes the function
   finite without changing its differential.  In general characteristic,
   Tamagawa packages the possible maps in a smooth parameter scheme and uses
   his finite-etale quasi-section theorem.
3. Given refinements \(X'\to X\) and \(Y'\to Y\) with finite etale maps to
   \(\mathbf A^1\), every connected component of

   \[
           X'\times_{\mathbf A^1}Y'
   \]

   is finite etale and surjective over both \(X'\) and \(Y'\), hence over
   both original curves.

The heavy input in step 2 is the unramified Skolem/arithmetic Bertini theorem;
see Tamagawa's
[*Unramified Skolem problems and unramified arithmetic Bertini theorems in
positive characteristic*](https://www2.math.ethz.ch/EMIS/journals/DMJDMV/vol-kato/tamagawa.dm.pdf).

This proof handles non-Galois covers by avoiding normality entirely.  Base
change preserves etaleness, and the fiber product performs the synchronization.

The affine hypothesis is structural, not a removable technicality.  A proper
connected curve has no nonconstant map to \(\mathbf A^1\), and a positive-
genus proper curve has no finite etale map to \(\mathbf P^1\).  On
compactifying Tamagawa's maps, the points at infinity are precisely where
ramification is allowed to appear.  Filling those punctures therefore destroys
the step on which the fiber-product proof depends.

**Transferable lesson.**  A proper analogue would need a common lower
**orbicurve** whose stacky indices absorb the boundary ramification.  Producing
such an orbicurve is already a finite-envelope problem; it is not obtained by
compactifying the affine theorem.

## 4. Bogomolov--Tschinkel and Poonen: cancellation on only one leg

Bogomolov--Tschinkel call a projective curve \(X\) universal when every
projective curve \(T\) is dominated by some finite etale cover of \(X\).
Their [Theorem 1.7](https://people.math.harvard.edu/~ctm/home/text/others/bogomolov/unramif/unramif.pdf)
says that every hyperelliptic curve over \(\overline{\mathbf F}_p\),
\(p\ge5\), is universal.  It does **not** say that the map to \(T\) is etale.

The main construction makes the asymmetry explicit.  Starting from a generic
simply ramified map \(T\to\mathbf P^1\), the proof pulls it back to an elliptic
curve \(E_0\).  Every \(\overline{\mathbf F}_p\)-point of \(E_0\) is torsion,
so a suitable etale isogeny of \(E_0\) sends all branch points to one point.
A fixed double cover \(C_0\to E_0\) has matching ramification there.  In the
fiber product, Abhyankar's lemma cancels ramification in the projection to
\(C_0\), while the projection to \(T\) is merely a surjective regular map.
Theorem 1.7 then passes from \(C_0\) to an arbitrary hyperelliptic source by
another etale double-cover construction.

Thus the proof deliberately spends its matching ramification to make one
specified projection etale.  It gives no simultaneous cancellation on the
target projection.  An etale refinement of the resulting source cannot remove
that target ramification.

Poonen's
[*Unramified covers of Galois covers of low genus curves*](https://math.mit.edu/~poonen/papers/etale.pdf),
Theorem 1.7, enlarges the class of curves known to virtually dominate a
hyperelliptic curve.  Its composita and Abhyankar-lemma arguments have the
same orientation: they manufacture an unramified cover over the curve on the
left of the relation \(X\Rightarrow Y\), while the map to the curve on the
right may remain ramified.  This is a construction theorem, not a passage
from Galois to non-Galois bi-etale correspondences.

### 4.1 The exact genus-nine curve in file 76 is universal

This boundary applies to the present explicit curve, not only to hypothetical
hyperelliptic alternatives.  The curve \(X\) of
[file 76](../../Theorems/Thm_fixed_pair_arithmetic.md) has a tame cyclic
degree-three map

\[
                  \pi:X\longrightarrow\mathbf P^1
\]

branched at the ten finite roots of the polynomial in (76.1) and at infinity.
It is therefore tamely superelliptic in the sense of Poonen.  Poonen's
Corollary 1.9 gives

\[
                         X\Rightarrow H
\]

for some hyperelliptic curve \(H\).  Since the characteristic is \(5\),
Bogomolov--Tschinkel's Theorem 1.7 makes \(H\) universal.  Transitivity of
\(\Rightarrow\) proves that this exact \(X\) virtually dominates every
projective curve, in particular the genus-25 curve \(Y\) of file 76.

The first step also has a transparent fiber-product witness.  Choose four
finite branch points \(a_1,a_2,a_3,a_4\) of \(\pi\), and let

\[
 H:\qquad
 z^3=\frac{(t-a_1)(t-a_2)}{(t-a_3)(t-a_4)}.                 \tag{97.1}
\]

This cyclic triple cover of \(\mathbf P^1_t\) is totally ramified at four
points, so Riemann--Hurwitz gives \(g(H)=2\); hence \(H\) is hyperelliptic.
The two Kummer classes defining \(X\) and \(H\) are independent modulo cubes:
the first is nontrivial at all eleven branch points of \(X\), whereas the
second is supported at only the chosen four.  Thus the normalization

\[
                    D=X\times_{\mathbf P^1}H
\]

is connected.  At the four common branch points the two order-three
ramification indices cancel in the normalized fiber product.  Away from
those points \(H\to\mathbf P^1\) is etale.  Consequently

\[
             D\longrightarrow X\quad\text{is finite etale of degree }3,
\]

while \(D\to H\) is a degree-three map ramified over the other seven branch
points of \(X\to\mathbf P^1\).  In particular,

\[
                         g(D)-1=3(g(X)-1)=24,
                         \qquad g(D)=25.                  \tag{97.2}
\]

This is an explicit \(X\Rightarrow H\) correspondence.  Pulling it back along
the etale source leg in a Bogomolov--Tschinkel witness \(H\Rightarrow Y\)
proves transitivity while preserving etaleness over \(X\).

There is an exact consequence for the internal exclusion program.  For the
fixed genus-25 curve \(Y\) in
[file 95](95_ABELIAN_ETALE_TOWERS_AND_ENDOMORPHISM_FIELDS.md), Corollary 95.6
shows that no finite **abelian Galois** etale cover of any curve \(X\) of
genus at most \(13\) can even admit a nonconstant map to \(Y\).  If such an
\(X\) is hyperelliptic, Bogomolov--Tschinkel nevertheless produces an etale
cover of \(X\) dominating \(Y\).  After Galois-closing its etale \(X\)-leg,
the deck group must therefore be nonabelian.

By Section 4.1 the same conclusion holds for the exact nonhyperelliptic
genus-nine \(X\) of file 76: take any Poonen--Bogomolov--Tschinkel witness
that an etale cover of this \(X\) dominates the fixed \(Y\), then Galois-close
over \(X\).  Corollary 95.6 forces the resulting Galois group to be
nonabelian.

This is not merely an abstract group-theoretic boundary.  It proves that
actual one-sided witnesses escape the abelian packet obstruction through
nonabelian monodromy.  Consequently one cannot hope to extend file 95 to
arbitrary deck groups while still allowing an arbitrary ramified map to
\(Y\).  Any negative proof of the common-cover problem must use the fact that
the second leg is **etale**, not just the existence of a map to \(Y\).

### 4.2 The normalized ramification efficiency is already in the literature

For a finite separable map \(h:U\to Y\), set

\[
 \rho(h)=\frac{\deg(h)(g(Y)-1)}{g(U)-1}
        =\frac{\deg(h)(2g(Y)-2)}{2g(U)-2}.                 \tag{97.3}
\]

Riemann--Hurwitz gives \(0<\rho(h)\le1\), with equality exactly when \(h\)
is etale.  Etale precomposition leaves \(\rho\) unchanged.

This exact normalization and its tower supremum were already introduced in
Chojecki's 24 May 2026 research note
[*Finite-etale tower profiles, ramification gradients, and cyclic Prym
\(p\)-ranks*](https://www.ulam.ai/research/litt-3.pdf).  Definition 3.1 calls

\[
 \sigma(X,Y)=
 \sup_{\substack{U\to X\ {\rm finite\ etale}\\
                 h:U\to Y\ {\rm finite\ separable}}}\rho(h)             \tag{97.4}
\]

the directed ramification gradient.  Proposition 3.2 proves invariance under
finite-etale replacement of **either** variable.  Proposition 3.3 proves the
composition inequality

\[
                    \sigma(X,Z)\ge\sigma(X,Y)\sigma(Y,Z),                \tag{97.5}
\]

using connected components of the relevant fiber products; at the level of
the two chosen correspondences, the scores multiply exactly.  Corollaries
3.4--3.5 record the sharp logical distinction:

- a common finite etale cover implies \(\sigma(X,Y)=1\);
- if the value \(1\) is **attained** by one pair \((U,h)\), then
  Riemann--Hurwitz makes \(h\) etale, so \(U\) is a common cover;
- the bare equality \(\sup\rho=1\), without an attainment theorem, does not
  by itself produce a common cover.

Section 4 of that note also explains why almost-unramified maps with
unrestricted source curves do not by themselves give a tower obstruction.
The missing input would be a uniform ramification gap inside the fixed etale
tower of \(X\).

A bounded check of Markovic's
[*Unramified correspondences and virtual properties of mapping class
groups*](https://people.maths.ox.ac.uk/~markovic/M-mod.pdf) finds the
qualitative relation “virtually dominates,” but no normalized
Euler-characteristic score, ramification gradient, or efficiency invariant.
No earlier exact match was located in the sources searched for this addendum.
Thus (97.3)--(97.5) should be cited to Chojecki rather than presented as a new
invariant.

## 5. Characteristic zero: commensurability without simultaneous closure

For a compact complex hyperbolic curve \(X\), write

\[
       X(\mathbf C)=\mathbf H/\Gamma_X
\]

for its uniformizing cocompact torsion-free Fuchsian lattice.  Curves \(X\)
and \(Y\) have a common finite etale cover exactly when, after conjugating one
lattice in \(\mathrm{PSL}_2(\mathbf R)\), the lattices
\(\Gamma_X,\Gamma_Y\) are commensurable.  Their finite-index intersection is
the common source.  No Galois assumption is needed.

This gives immediate negative examples: the invariant trace field

\[
       k_\Gamma=\mathbf Q\bigl(\operatorname{tr}\Gamma^{(2)}\bigr)
\]

is unchanged under commensurability.  Curves whose uniformizing lattices have
different invariant trace fields cannot have a common finite etale cover.
See Maclachlan--Reid,
[*Invariant trace-fields and quaternion algebras of polyhedral groups*](https://web.ma.utexas.edu/users/areid/invt.pdf),
Theorem 2.1, for the invariant.  This method excludes a correspondence
directly; it does not obtain one by closing either leg.

There is no known positive-characteristic replacement for the distinguished
embedding of a complex curve's fundamental group as a lattice in
\(\mathrm{PSL}_2(\mathbf R)\).  The abstract prime-to-\(p\) geometric
fundamental group therefore does not carry this trace-field obstruction.

### 5.1 Mochizuki's nonarithmetic hyperbolic core

Mochizuki's
[*Correspondences on Hyperbolic Curves*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Correspondences%20on%20Hyperbolic%20Curves.pdf)
uses the Margulis commensurator dichotomy at exactly the place where a common
ambient group is needed.  If \(X\) is nonarithmetic, then

\[
 \Gamma_X\subset\operatorname{Comm}(\Gamma_X)
\]

has finite index and the commensurator is discrete.  The quotient stack

\[
 \mathcal O_X=\mathbf H/\operatorname{Comm}(\Gamma_X)
\]

is the hyperbolic core, and \(X\to\mathcal O_X\) is finite etale.

For a correspondence \(C\to X,\ C\to Z\), Proposition 3.2 first says that
one may replace \(C\) by its Galois closure **over \(Z\)**.  This is precisely
the harmless one-leg operation of Section 1.1.  Normality of
\(\Gamma_C\) in \(\Gamma_Z\) then proves

\[
       \Gamma_Z\subset\operatorname{Comm}(\Gamma_X),
\]

so \(Z\to\mathcal O_X\) is finite etale.  The proof does not claim that the
replacement is simultaneously Galois over \(X\).  Instead, discreteness of
the commensurator supplies a finite ambient envelope.  Inside that one
discrete finite extension, an ordinary finite-index core can supply a
simultaneous Galois refinement if one is wanted.

This is the cleanest successful analogue of the desired ambient-extension
strategy.  Its decisive hypothesis is not merely that a commensurator exists,
but that it is **discrete and finite over the original lattice**.

### 5.2 Mochizuki's arithmetic case avoids envelopes

For an arithmetic lattice the commensurator is dense, so the quotient above
is not a finite algebraic orbifold.  Mochizuki does not repair this by a more
elaborate Galois closure.  Arithmeticity passes to every isogenous curve, and
Takeuchi's theorem gives only finitely many arithmetic curves of a fixed
signature.  This proves the arithmetic half of Mochizuki's finiteness theorem
by classification, not by constructing a minimal common orbifold.  The cited
input is Takeuchi,
[*Arithmetic Fuchsian groups with signature \((1;e)\)*](https://doi.org/10.2969/jmsj/03530381),
and the general finiteness result quoted as his Theorem 2.1.

The distinction matters here because dense commensurators can actually defeat
simultaneous Galois refinement; this is the mechanism used in file 21,
Proposition 21.5.  Thus even over \(\mathbf C\), existence of a common etale
cover does not imply existence of one Galois over both curves.

### 5.3 General complex curves

Mochizuki's Theorem 5.3 proves that a general hyperbolic curve with
\(2g-2+r\ge3\) equals its own hyperbolic core.  Every curve isogenous to it
then maps finite etale to it.  The proof bounds possible orbifold signatures
by Riemann--Hurwitz and removes their images by a moduli-dimension argument.
Again, the conclusion comes from a minimal orbifold, not from simultaneous
normal closures.

His descent Lemma 4.1 also marks a characteristic boundary: rigidity of one
leg uses a trace splitting on \(H^1\), and the proof explicitly uses that the
covering degree is invertible in characteristic zero.  It cannot simply be
ported to degrees divisible by \(5\).

## 6. Finite-field anabelian theorems: reconstruction is not extension

After descending a common-cover diagram to a finite field, the two maps give
an isomorphism between two open subgroups of the target's **arithmetic**
fundamental group.  The Tamagawa--Mochizuki Isom theorem reconstructs the
finite etale covers corresponding to those open groups and the isomorphism
between them.  In the common-cover application, that is precisely the source
curve and source isomorphism already present.

What is needed is stronger: the open-subgroup isomorphism must extend to an
automorphism of the ambient target group (and, in the root-stack formulation,
to one of the six geometric automorphisms).  The published Isom theorem has no
such virtual-to-global clause.  The exact arithmetic and Frobenius ambiguity
is proved in [file 25](25_EXACT_FROBENIUS_DESCENT_AND_ANABELIAN_LIMIT.md),
Sections 1--3.  Primary sources are Mochizuki,
[*Absolute anabelian cuspidalizations of proper hyperbolic curves*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Absolute%20Anabelian%20Cuspidalizations.pdf),
Theorem 3.12, and Saidi--Tamagawa's
[*prime-to-\(p\) version*](https://ems.press/content/serial-article-files/41067),
Theorem 1 and Corollary 3.10.

Passing to the prime-to-\(5\) quotient does not fix this logical gap.  It also
forgets precisely the positive-characteristic monodromy detected by many of
the alternating and linear groups in the current finite quotients.

Hoshi's
[*Tripod-degrees*](https://ems.press/content/serial-article-files/52257),
Theorem B, is another close but non-closing result.  Its numerical hypothesis
does hold for \(p=5,\ell=31\), but it classifies Frobenius-equivariant
automorphisms of the **entire** geometrically pro-\(31\) arithmetic tripod
group.  Our correspondence initially gives only an isomorphism between two
open subgroups of the full root-stack group.  Invoking Hoshi would therefore
presuppose the missing ambient extension and would discard the non-pro-\(31\)
monodromy.

## 7. The 2026 families-preserving theorem: the exact near match

Minamide--Sawada--Tsujimura,
[*Families preserving isomorphisms via techniques in anabelian geometry*](https://arxiv.org/pdf/2608.01417),
Theorem 3.11(iii), prove the following kind of statement for almost pro-
\(\mathcal C\) surface groups and related groups.  If closed subgroups contain
nontrivial ambient-normal subgroups, then a **families-preserving** isomorphism
between them is induced by an inner automorphism of the ambient group.

Here families-preserving means that **every procyclic subgroup** is sent to
an ambient conjugate of itself.  It does not mean merely that the three
geometric inertia groups, decomposition groups, or their Frobenius characters
are preserved.

Reading the proof shows that this hypothesis is essential to the available
argument.  Arbitrary primitive procyclic subgroups of auxiliary free pro-\(p\)
normal subgroups are used at every normal-open level.  The hypothesis makes a
nested family of compact conjugator sets nonempty; compactness produces one
compatible conjugator, and intersections of normalizers then force innerness.
Peripheral inertia supplies nowhere near this family.  Remark 2.4.1(iii) asks
whether the corresponding third hypothesis of Theorem 2.3 can be dropped and
states that the authors do not know.

Thus this theorem identifies a precise possible bridge but does not cross it:

1. find one common almost-surface quotient receiving both open subgroup
   embeddings; and
2. prove, after the allowed geometric normalization, preservation of the
   ambient conjugacy class of **every** procyclic subgroup.

On the unquotiented group, full families preservation already implies the
normality needed to stop the core tower, so using the theorem there would be
circular.  Its only plausible gain is on a genuinely smaller common quotient
where families preservation can be established independently.

## 8. Actionable conclusions for the present problem

1. **Use one-leg Galois closure freely, but never infer simultaneous
   normality.**  It is legitimate to Galois-close either etale leg for a
   monodromy or representation-theoretic calculation.  The other leg stays
   etale.  Alternating closures need not terminate.

2. **Do not target universal non-domination.**  Bogomolov--Tschinkel prove
   that etale towers of hyperelliptic curves dominate every projective curve
   over \(\overline{\mathbf F}_p\), \(p\ge5\), and Poonen's theorem makes the
   exact genus-nine \(X\) of file 76 universal as well.  File 95 shows
   concretely that the required Galois monodromy is then forced to be
   nonabelian.  A negative proof must use the second leg's etaleness:
   unramified Riemann--Hurwitz, differential, conductor, Prym, or local-inertia
   constraints that disappear for a merely dominant map.

3. **The common-lower-object method is real but expensive.**  Tamagawa and
   nonarithmetic Mochizuki succeed because they construct a shared lower
   scheme or orbifold.  For the present root stack, constructing a finite
   ambient orbifold is essentially the simultaneous-envelope/visibility
   statement of file 21, not a softer preliminary reduction.

4. **The best anabelian target is now exact.**  One would need a common
   almost-surface quotient plus normalized preservation of every procyclic
   family.  Frobenius equivariance and preservation of the three stacky
   inertia classes do not imply this in the published proof.

5. **Exploit nonabelian one-leg monodromy rather than trying to remove it.**
   The one-leg closure is always available, and the abelian case is already
   strongly constrained by files 95--98.  The literature says that
   nonabelian closure is not a pathology that can be normalized away; it is
   how actual Bogomolov--Tschinkel domination witnesses evade abelian
   obstructions.

6. **Characteristic-zero trace and rigidity arguments do not transport
   formally.**  They depend respectively on a distinguished Fuchsian-lattice
   embedding, a discrete commensurator, or division by covering degrees in a
   trace map.  None survives unchanged for full degree-divisible-by-\(5\)
   etale monodromy.

No primary source found in the accompanying search turns one-sided domination,
one-leg Galois closure, or an arithmetic open-subgroup isomorphism into the
missing proper bi-etale correspondence.  The sharp literature-supported next
step is therefore geometric: use etaleness of the second leg to constrain the
nonabelian Galois closure of the first.

## Primary references used

- F. Bogomolov and Y. Tschinkel,
  [*Unramified correspondences*](https://people.math.harvard.edu/~ctm/home/text/others/bogomolov/unramif/unramif.pdf),
  Contemp. Math. 300 (2002), Theorem 1.7 and Sections 2, 4.
- B. Poonen,
  [*Unramified covers of Galois covers of low genus curves*](https://math.mit.edu/~poonen/papers/etale.pdf),
  Math. Res. Lett. 12 (2005), Theorem 1.7 and Section 2.
- A. Tamagawa,
  [*Correspondences on curves in positive characteristic*](https://doi.org/10.1090/conm/767/15400),
  Contemp. Math. 767 (2021), main theorem.
- A. Tamagawa,
  [*Unramified Skolem problems and unramified arithmetic Bertini theorems in
  positive characteristic*](https://www2.math.ethz.ch/EMIS/journals/DMJDMV/vol-kato/tamagawa.dm.pdf),
  Doc. Math., Extra Volume Kato (2003), 789--831.
- S. Mochizuki,
  [*Correspondences on Hyperbolic Curves*](https://www.kurims.kyoto-u.ac.jp/~motizuki/Correspondences%20on%20Hyperbolic%20Curves.pdf),
  Theorems 2.5, 2.6, 3.3, 4.2, 5.3 and Proposition 3.2.
- A. Minamide, K. Sawada, and S. Tsujimura,
  [*Families preserving isomorphisms via techniques in anabelian geometry*](https://arxiv.org/pdf/2608.01417),
  arXiv:2608.01417v1 (2026), Theorem 3.11 and Remark 2.4.1(iii).
- P. Chojecki,
  [*Finite-etale tower profiles, ramification gradients, and cyclic Prym
  \(p\)-ranks over \(\overline{\mathbf F}_q\)*](https://www.ulam.ai/research/litt-3.pdf),
  research-note draft dated 24 May 2026, Definition 3.1 and Propositions
  3.2--3.3.
- V. Markovic,
  [*Unramified correspondences and virtual properties of mapping class
  groups*](https://people.maths.ox.ac.uk/~markovic/M-mod.pdf),
  Bull. Lond. Math. Soc. 54 (2022), 2324--2337.
