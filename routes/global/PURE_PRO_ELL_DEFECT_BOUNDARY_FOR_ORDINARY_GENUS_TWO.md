# Pure pro-ell defect over an ordinary genus-two curve: the exact boundary

Date: 2026-09-05.
Author: `/root/x_elliptic_quotient_maps`.
Status: bounded source check plus the elementary reductions proved below.
No universal boundedness or counterexample is claimed.

Throughout, `k=Fbar_5`, `C/k` is an ordinary curve of genus two, and
`ell` is a prime.  Write

\[
 \Delta(T)=g(T)-f(T)
\]

for the 5-rank defect.  The Boxall argument in
[the maximal-abelian note](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md)
bounds `Delta` in the maximal abelian `ell`-power tower when `J(C)` is
geometrically simple.  This note records why the checked literature does
not currently extend that conclusion to the full pro-`ell` tower.

## 1. Raynaud's fixed-curve construction cannot stay canonically pure-ell

Let `U -> C` be any connected finite etale cover of degree `ell^a`.  It
need not be cyclic.  Riemann--Hurwitz gives

\[
                         g(U)=1+\ell^a.                 \tag{1.1}
\]

Raynaud's Corollary 18 uses the canonical principal polarization on
`J(U)`.  Its Heisenberg parameter `n` must divide `g(U)`.  If both the
cover and the Heisenberg group are to have `ell`-power order, then
`n=ell^b>1`; but

\[
                         1+\ell^a\equiv1\pmod\ell.      \tag{1.2}
\]

Thus the canonical-polarization construction cannot produce a pure
`ell`-group counterexample at any pure `ell`-power level over a genus-two
base.

This is exactly why Raynaud's proof of Theorem 2 becomes mixed-prime in
the present numerical case.  For `p=5` and `g(C)=2`, his choice is

\[
       m=2(p-1)=8,\qquad g(U)=1+8=9,\qquad n=9.         \tag{1.3}
\]

The first stage is a 2-cover and the Heisenberg stage is a 3-group.
Taking normal closure does not remove either prime.  Hence the known
fixed-support `{2,3}` tower is not a pure pro-2 or pure pro-3 tower.

The source is Michel Raynaud,
[*Revêtements des courbes en caractéristique p>0 et ordinarité*](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf),
Compositio Math. 123 (2000), Theorem 17, Corollary 18, and the proof of
Theorem 2 on pp. 84--85.

### 1.1. The genuine noncanonical-polarization loophole

Theorem 17 is stronger than Corollary 18.  If `theta_0` is any principal
polarization on `J(U)` and its degree on the Abel curve is `d`, Raynaud
only requires

\[
       n\mid d,\qquad {d\over n}\le {g(U)-1\over4}.     \tag{1.4}
\]

So (1.2) does **not** by itself rule out Raynaud's construction: an
additional principal polarization can have `ell | d` even though the
canonical one has degree `g(U)` prime to `ell`.  Raynaud explicitly
points to this phenomenon in Remark 20(3).

There is nevertheless a useful numerical filter.  If `lambda` is the
canonical polarization and `u=lambda^{-1}lambda_0`, then `u` is a
positive Rosati-symmetric automorphism.  The usual intersection/trace
formula and arithmetic--geometric mean give

\[
 d={\operatorname {Tr}_{H^1}(u)\over2}\ge g(U).         \tag{1.5}
\]

Combining (1.4) and (1.5) shows `n>4`.  In particular a pure-2 use of
Theorem 17 requires `n>=8`, and a pure-3 use requires `n>=9`.  No such
polarization on a pure-power level over an ordinary genus-two curve was
found in the checked sources.

### 1.2. A deck-algebra obstruction to the loophole

Here is a small general lemma which makes the remaining escape precise.

**Lemma 1.1.**  Let `U -> C` be a connected etale Galois cover with
group `G` and let `lambda` be the canonical polarization of `J(U)`.
Assume that the natural deck-action map identifies

\[
                         \operatorname {End}(J(U))=\mathbf Z[G]. \tag{1.6}
\]

Then the degree `d` on `U` of every principal polarization on `J(U)`
satisfies

\[
                              d\equiv1\pmod {|G|}.       \tag{1.7}
\]

In particular, if `G` is an `ell`-group, no such `d` is divisible by
`ell`, and Raynaud's Theorem 17 cannot be applied with an `ell`-power
parameter.

**Proof.**  Write a second principal polarization as `lambda u`, where
`u=sum_g a_g g` is a positive Rosati-symmetric unit of `Z[G]`.  On the
`G`-invariant copy of `J(C)`, `u` acts as its augmentation
`epsilon(u)`.  Since `u` and its inverse are integral, the augmentation
is `+1` or `-1`; positivity makes it `+1`.

For an unramified Galois cover, the etale Chevalley--Weil formula is

\[
 H^1_{\rm et}(U,\mathbf Q_q)
 \cong \mathbf Q_q^{\,2}\oplus
       \mathbf Q_q[G]^{\,2(g(C)-1)}                    \tag{1.8}
\]

for any auxiliary prime `q` away from `5|G|`.  Since `g(C)=2`, the trace
of `u` on (1.8) is

\[
                  2\epsilon(u)+2|G|a_1.
\]

The polarization intersection/trace formula identifies half of this
trace with `d`.  Hence `d=1+|G|a_1`, proving (1.7).  `square`

Thus a Raynaud counterexample inside a pure tower must occur at a level
with genuinely extra endomorphisms/polarizations, not one whose integral
endomorphism ring is only the deck algebra.  This does not rule out other
finite local systems without theta divisors.

## 2. A pure-2 failure already occurs at one level

It is false that every 2-power cover of an ordinary genus-two curve is
ordinary.  Ozman--Pries, Theorems 1.2 and 7.1, prove that in characteristic
`p>=3` the locus of etale double covers of a genus-`g`, 5-rank-`f` curve
whose Prym is almost ordinary is nonempty and has codimension one.  With

\[
                         p=5,\quad g=f=2,
\]

this gives an ordinary genus-two curve `C/Fbar_5` and an etale double
cover `U -> C` whose elliptic Prym is supersingular.  Thus

\[
                 g(U)=3,\qquad f(U)=2,\qquad\Delta(U)=1. \tag{2.1}
\]

See E. Ozman and R. Pries,
[*Ordinary and almost ordinary Prym varieties*](https://archive.intlpress.com/site/pub/files/_fulltext/journals/ajm/2019/0023/0003/AJM-2019-0023-0003-a005.pdf),
Asian J. Math. 23 (2019), Theorem 7.1 (especially its genus-two base
case), and Theorem 1.2.

This is an actual pure-2 counterexample to levelwise preservation of
ordinarity.  It is **not** an unbounded-defect pro-2 tower: one bad Prym
adds only one to `Delta`, and the paper supplies no compatible sequence
of bad double covers over one fixed base curve.

## 3. What is known for broad nonabelian classes

There are two exact positive statements, neither of which answers the
fixed pro-2 question.

1. If `ell=p=5`, every finite etale Galois 5-group cover of an ordinary
   curve is ordinary.  Indeed, Deuring--Shafarevich gives

   \[
    f(U)-1=|G|(f(C)-1),
   \]

   which agrees with unramified Riemann--Hurwitz when `f(C)=g(C)`.
   Thus every pure pro-5 tower has identically zero defect.

2. Raynaud's Theorem 14 says that, for the **geometric generic** curve
   of genus `g`, every etale Galois cover whose group is a central
   extension of two finite abelian groups and whose order is prime to
   `g!` is ordinary.  For `g=2`, this includes every odd `ell`-group of
   nilpotency class at most two.  It gives no information for `ell=2`.
   More importantly, it is a generic-moduli theorem, not a theorem for
   an arbitrary fixed `Fbar_5` point.  One cannot replace the generic
   point by a fixed closed curve by intersecting infinitely many open
   conditions over the countable field `Fbar_5`.

Ozman--Pries Theorem 4.5 similarly proves ordinary Pryms for cyclic
prime-to-5 covers of the generic curve in each positive 5-rank stratum;
Section 2 shows exactly why this cannot be upgraded to all fixed curves.

## 4. Why the abelian Boxall argument stops at nonabelian groups

The obstruction can be expressed without losing the actual cover.
Let `W -> C` be a finite etale Galois cover with `ell`-group `G`, where
`ell !=5`.  Put

\[
 B_T=F_{T/k*}\mathcal O_T/\mathcal O_{T^{(1)}}.
\]

Every irreducible representation of a finite `ell`-group in
characteristic 5 is monomial.  Thus it has the form

\[
             \rho=\operatorname {Ind}_H^G\chi          \tag{4.1}
\]

for a subgroup `H` and a one-dimensional character `chi`.  If
`V=W/H`, `q:V -> C`, and `L_chi` is the character line bundle on `V`,
then the associated local-system bundle is `q_*L_chi`.  Etale
functoriality of `B` and projection formula give the exact identity

\[
 H^0(C^{(1)},B_C\otimes E_\rho)
 \cong
 H^0(V^{(1)},B_V\otimes L_\chi).                        \tag{4.2}
\]

Consequently every nonabelian bad irreducible packet is still a bad
cyclic character, but on the **moving intermediate curve** `V`, not on
the fixed genus-two curve.  Boxall finiteness controls all high-order
characters on one fixed simple Jacobian.  It gives no uniform control as
the inducing subgroup `H`, the curve `V`, and its Raynaud divisor vary
up the pro-`ell` tower.  Formula (4.2) is the exact missing bridge.

## 5. Verdict for the pure pro-2 route

The bounded check gives neither a universal theorem nor a counterexample:

* no checked source proves bounded `Delta` in every pure pro-2 tower of
  a fixed ordinary genus-two curve;
* no checked source constructs a pure pro-2 tower over one such curve
  with unbounded `Delta`;
* Raynaud's actual fixed-curve tower cannot be converted to pure pro-2
  by deleting its 3-primary Heisenberg stage;
* a single nonordinary double cover is known and rules out the much
  stronger levelwise-ordinarity claim;
* Raynaud's remaining pure-power escape would require, at some pure
  level, an extra principal polarization of `ell`-divisible Abel degree
  (at least an 8-divisible parameter for `ell=2`), and Lemma 1.1 excludes
  that escape when the level has no endomorphisms beyond its deck
  algebra.

For the genus-nine/genus-two common-cover redesign, the degree ratio is
8, so the only single-prime tower that can contain both leg degrees is a
2-tower.  The correct next target is therefore a higher-rank statement
for finite 2-group local systems on the moving intermediate curves in
(4.2), or an actual construction exploiting extra endomorphisms.  The
canonical Raynaud divisibility calculation alone cannot decide it.
