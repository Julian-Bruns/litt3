# Dormant-oper ordinarity does not supply the missing two-leg matching

**Status:** bounded primary-source boundary check, 2026-09-05.  This note
does not assert that a matching pair never exists.  It identifies the exact
extra datum required by the available lifting theorems and shows that neither
the generic five-element count nor uniqueness in rank four provides it.

Let

\[
                 Z\xrightarrow{f}X,\qquad Z\xrightarrow{g}Y
\]

be finite etale maps of smooth proper curves in characteristic five.  Write
`DOp_2(C)` for the set of isomorphism classes of dormant rank-two projective
opers on a curve `C`.

## 1. The functorial theorem is a theorem about a specified oper

Pullback gives

\[
 f^*:DOp_2(X)\longrightarrow DOp_2(Z),\qquad
 g^*:DOp_2(Y)\longrightarrow DOp_2(Z).                 \tag{1}
\]

Wakabayashi's Definition 2.1.2 calls a finite etale map of *dormant curves*
an underlying finite etale map together with the equality of the specified
upstairs oper and the pullback of the specified downstairs oper.  His
Theorem B says:

1. if the pullback of a specified dormant oper is ordinary, then that oper
   is ordinary downstairs; and
2. in the converse direction, pullback ordinarity is proved only for a
   general base dormant curve and a cyclic prime-to-`p` cover.

Neither assertion says that an oper on the covering curve descends, and
neither compares the two maps in (1).

Mochizuki's corresponding canonical-lifting statement has exactly the same
one-leg form.  Chapter III, Theorem 2.10 and Corollary 3.5 apply to a
specified indigenous bundle and its pullback, assuming that the pullback is
ordinary.  Applied to the two legs separately they canonically lift the two
pairs

\[
                 (Z,f^*P_X),\qquad (Z,g^*P_Y).          \tag{2}
\]

The uniqueness theorem identifies these lifts only if

\[
                         f^*P_X\simeq g^*P_Y.            \tag{3}
\]

Thus the exact usable hypothesis is that the two images in (1) meet in an
ordinary oper (with the pullbacks ordinary in the lifting sense).  Equivalently,
one may assume an ordinary oper on `Z` which descends through both legs.
Separate existence or separate ordinarity is not this hypothesis.

[Wakabayashi, Definitions 2.1.2--2.1.3 and Theorems A--B](https://arxiv.org/abs/1602.07061).
[Mochizuki, Chapter III](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf).
See also Theorem 33.6 and Corollary 33.7 of file 33 for the precise
scheme-etale lifting consequence.

## 2. Finiteness does not force the intersection

For a general genus-two curve in characteristic five, `DOp_2(C)` has five
elements:

\[
                    \frac{5^3-5}{24}=5.                 \tag{4}
\]

Even if all five opers on each of `X` and `Y` are ordinary and even if all
their pullbacks remain ordinary, (1) merely produces two subsets, each of
cardinality at most five, in `DOp_2(Z)`.  No theorem cited above gives
surjectivity, equality, or nonempty intersection of those subsets.  The
generic dormant-oper count on the usually much higher-genus curve `Z` is
not five, so there is no pigeonhole argument either.

A finite-set hypothesis which would make this automatic is a genuine
uniqueness statement upstairs--for example, that `Z` has a unique ordinary
dormant rank-two oper and that both chosen pullbacks are ordinary.  No such
statement follows from genus-two ordinarity of either target.

[Wakabayashi, Theorem 3.3 and Corollary 5.4](https://ems.press/content/serial-article-files/41233).

## 3. The unique rank-four oper loses precisely the needed information

Hoshi proves that on every curve in characteristic `p`, the dormant oper of
rank `p-1` is unique up to the stated equivalence (Theorem 2.1).  In
characteristic five this is the unique rank-four projective oper.  The
symmetric cube of any dormant rank-two oper is a dormant rank-four oper, so
uniqueness identifies all of these symmetric cubes with that one rank-four
object.

Consequently the composite

\[
              DOp_2(C)\xrightarrow{\operatorname{Sym}^3}DOp_4(C)
\]

is constant.  On a general genus-two curve its five distinct ordinary
rank-two inputs already map to the same unique rank-four output.  Hence rank
four cannot canonically select one of the five reductions.  After pullback to
`Z`, equality of the two rank-four symmetric cubes is automatic and is
strictly weaker than (3).

This also explains why functoriality of symmetric powers does not repair the
argument: it proves

\[
 \operatorname{Sym}^3(f^*P_X)\simeq
 \operatorname{Sym}^3(g^*P_Y),
\]

but the symmetric-cube map is visibly noninjective in the very case under
consideration.  Wakabayashi's canonical diagonal lifting similarly lifts
each selected ordinary dormant oper on a preselected lift of the curve; it
does not turn the unique rank-four object into a unique rank-two reduction
or identify the two curve liftings in (2).

[Hoshi, Proposition 1.4, Remark 1.4.2, and Theorem 2.1](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1822revised.pdf).
[Wakabayashi, canonical diagonal liftings](https://arxiv.org/abs/2209.08528).

## 4. Classical ordinary genus two does not currently supply dormant-ordinary

The two notions of ordinarity must not be conflated.  Wakabayashi defines an
oper to be ordinary by the etaleness of the dormant-oper moduli over curve
moduli at that oper.  He explicitly distinguishes this from maximal
`p`-rank of the Jacobian and states that for hyperbolic curves their relation
is not well understood.  The equivalence with classical ordinarity proved in
that paper is for elliptic curves, not genus two.

Every such curve does have at least one *dormant* rank-two oper (this is the
existence input used in Hoshi's Remark 1.4.2), but the assertion that at
least one of them is *ordinary* is the additional hyperbolic-ordinarity
condition.  It is not a consequence of the bare existence theorem.

For genus two in characteristic five the finite flat dormant-oper fiber has
scheme length five.  All five are ordinary exactly on the etale locus of
this finite map; a general curve lies there.  Wakabayashi's proof of his
generic formula explicitly chooses a curve which is both classically
ordinary and outside the image of the nonordinary dormant locus.  These are
two separate open conditions in the proof.

There is a useful equivalent boundary in Lange--Pauly.  For every
classically ordinary genus-two curve in odd characteristic, the
Frobenius-destabilized base locus is a zero-dimensional local complete
intersection of length

\[
                   \frac23p(p^2-1),
\]

which is `80` for `p=5`; its sixteen theta-characteristic blocks have length
five.  They state reducedness only for a general curve, not for every
ordinary curve.  Thus this theorem supplies the correct length but not the
assertion that all five dormant opers are ordinary on every ordinary
genus-two curve.

The bounded search found neither a primary theorem proving

\[
 \text{ordinary Jacobian of a genus-two curve in characteristic five}
 \Longrightarrow \text{all five dormant rank-two opers ordinary}
\]

nor a published explicit ordinary genus-two counterexample.  The exact
known statement is the branch-locus formulation above.  Even a future proof
of the displayed implication would not supply (3), so it would still not
give a joint lift of a coreless correspondence by itself.

[Wakabayashi, introduction, Definition 2.1.3, and Remark 2.1.5](https://arxiv.org/abs/1602.07061).
[Lange--Pauly, Theorem 2 and Section 8](https://arxiv.org/abs/math/0309456).

## Conclusion

The dormant-oper route has one sharp missing condition: a **common
rank-two reduction upstairs**, not merely ordinary opers on both targets.
The five-element generic count does not force such a reduction, and the
canonical rank-four oper deliberately forgets it.  Therefore no checked
Mochizuki--Hoshi--Wakabayashi theorem turns ordinary genus two alone into a
simultaneous lift of a coreless bi-etale correspondence.
