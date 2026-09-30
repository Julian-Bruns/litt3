# Descent and display rigidity for versal truncated BT groups

Version1,20 September2026. Let $k$ be algebraically closed of odd
characteristic $p$, and let $C/k$ be a smooth proper hyperbolic curve.
Let $H/C$ be an everywhere-versal height-two, dimension-one BT1,
generically ordinary. Fix two BT$_N$ extensions $A,B$ of this SAME
marked $H$, where $N\ge2$. An extension means an actual truncated
Barsotti--Tate group, not just a Dieudonne bundle.

Their determinant characters can be normalized to the Teichmuller
lift of the determinant character of $H$, by rank-one etale twists
trivial modulo $p$. After this normalization:

1. Over every finite separable extension $L/k(C)$,
   $\operatorname{End}(A_L)=\mathbf Z/p^N$. A marked,
   determinant-preserving isomorphism is therefore unique.
2. A marked isomorphism after ANY finite separable cover of $C$
   descends to $C$, after its scalar determinant correction.
3. More generally let the maximal separable part of a finite cover
   have degree $d$ and different divisor $R$. An isomorphism after
   that cover descends if
\[
\deg R<(p-1)d\deg\omega_C.
\]
This includes every purely inseparable cover. The bound is independent
of the truncation level and the inseparable degree.

The actual truncated-display functor is fully faithful on ISOMORPHISMS
between everywhere-versal height-two, dimension-one BT$_N$ groups
over $C$, for every $N\ge1$. Thus an isomorphism of their complete
level-$N$ displays has a unique group-scheme lift. If its reduction
is the display of a prescribed BT1 marking, that marking is retained.
No assertion about arbitrary noninvertible display morphisms is made.

For the actual finite etale span $X\xleftarrow fZ\xrightarrow gY$
with compatible such BT1 groups and $g(Y)=2$, put $m=\deg g$.
At $p=5$ the different bound is $\deg R<8dm$ over $Z$.
If the separable cover is tame and ramified only over the common
reduced four-point supersingular divisor, then
\[
\deg R\le4dm<8dm,
\]
so the bound holds automatically. At EVERY level, neither an etale
source refinement nor the infinitesimal display-to-group gerbe
repairs missing compatibility of determinant-normalized endpoint
extensions. A compatible DISPLAY is sufficient; its existence is
not proved.

The level-two statements are the returned Pro result. The extension
to every level is a local continuation using the same obstruction,
the truncation factorization of endomorphisms and the all-level Lau
gerbe theorem. No compatible endpoint extensions are constructed.
[Proof](../../Proofs/deformations/versal_bt_display_descent.md).
