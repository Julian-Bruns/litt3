# Proof: first instability in ranks two and three

[Statement](../../Theorems/cartier_and_spin/low_rank_common_frobenius_instability.md).
We use the actual common category, whose morphism images are
saturated when no clump exists. In particular, any nonzero common
map of line bundles is an isomorphism. Harder--Narasimhan
filtrations commute with finite etale pullback; hence the relevant
filtrations and their second fundamental forms are common.

Take the FIRST unstable Frobenius pullback and rename its
semistable antecedent $E$. Write $D=\deg E_Y$ at this step and
$H=F^*E$, with its actual canonical Cartier connection. Thus
$\deg H_Y=5D$. Work on the appropriate twisted span throughout.
Existence of a common projective oper transfers back to the
original span by inverse coefficient twist, not by identifying
relative Frobenius twists as $k$-curves.

## 1. Rank two

The destabilizing line $L\subset H$ is common. Put
$a=\deg L_Y>5D/2$. It cannot be horizontal, since Cartier descent
would contradict semistability of $E$. Its nonzero second
fundamental map is therefore an isomorphism
\[
L\xrightarrow{\sim}(H/L)\otimes\omega.
\]
On $Y$, where $\deg\omega=2$, this says
\[
2a=5D+2.
\tag{1}
\]
In particular $D$ is even. The canonical connection, this line
and the displayed isomorphism are an actual dormant rank-two
oper, and hence a projective oper. No determinant trivialization
or common square root was used.

## 2. Rank three: generating the next line

After replacing $E$ by its dual if necessary, the maximal
Harder--Narasimhan piece of $H$ has rank one. Indeed, the only
case without such a first piece is a two-step filtration of ranks
two and one; duality reverses those ranks. Denote that common
line by $L$ and write $a=\deg L_Y>5D/3$.

Again $L$ is not horizontal. Its second fundamental map into
$(H/L)\omega$ has saturated image $M\omega$, with $M$ a common
line in $H/L$, and gives an isomorphism
\[
L\simeq M\omega.
\]
Let $V\subset H$ be the inverse image of $M$ and let $N=H/V$.
On $Y$ their degrees are
\[
\deg M=a-2,\qquad \deg V=2a-2,\qquad
\deg N=5D-2a+2.
\tag{2}
\]
The second fundamental form of $V$ vanishes on $L$, and is thus
a common line map
\[
M\longrightarrow N\omega.
\tag{3}
\]

If (3) vanishes, $V$ is Cartier-horizontal. It descends to a
common rank-two subbundle $V_0\subset E$. Semistability gives
\[
\frac{2a-2}{10}\le\frac D3,
\qquad 3a>5D,
\qquad 5\mid(2a-2).
\]
Write $a=5m+1$. The first two inequalities give
$0\le D-3m<3/5$. Since $D-3m$ is integral, $D=3m$.
Consequently $V_0$ has degree $2m$ and the same slope as $E$,
so it is semistable. Its Frobenius pullback contains $L$ of
degree $5m+1$, which destabilizes it. Section1 constructs the
required common rank-two oper.

If (3) is nonzero, it is an isomorphism. Equating the two line
degrees yields
\[
3a=5D+6.
\tag{4}
\]
Thus $D=3m$, $a=5m+2$, and the degrees of $L,M,N$ are
$5m+2,5m,5m-2$. Both adjacent second fundamental forms are
isomorphisms. The filtration $0\subset L\subset V\subset H$
is a full dormant rank-three oper. The next section constructs
the complementary rank-two oper directly.

## 3. The actual complementary Frobenius quotient

Adjunction of the quotient $F^*E\twoheadrightarrow N$ gives a
common map
\[
\iota:E\longrightarrow F_*N.
\tag{5}
\]
This is injective generically. Otherwise its pulled-back generic
kernel would be a nonzero horizontal subspace of $H$ inside $V$.
The isomorphism (3) forces such a subspace into $L$, and the
preceding second fundamental isomorphism then forces it to be
zero. Since the actual common image of (5) is saturated, (5)
is a subbundle injection. Let $Q$ be its rank-two quotient.

Use the canonical filtration
\[
0=\mathcal H_5\subset\mathcal H_4\subset\cdots
\subset\mathcal H_0=F^*F_*N,\qquad
\mathcal H_i/\mathcal H_{i+1}=N\omega^i.
\]
The first three jet maps of the cyclic projection $H\to N$
identify $H$ with $\mathcal H_0/\mathcal H_3$.
Explicitly, its induced grades are $N,M,L$, and the two
second fundamental isomorphisms identify them with
$N,N\omega,N\omega^2$; the factors $1$ and $2$ in the jet
maps are units in characteristic five. This is an isomorphism
everywhere, not just at the generic point. Thus
\[
\mathcal H_3\xrightarrow{\sim}F^*Q.
\]
Under this identification the line $\mathcal H_4$ gives
\[
0\longrightarrow N\omega^4\longrightarrow F^*Q
\longrightarrow N\omega^3\longrightarrow0.
\tag{6}
\]
The canonical connection on $F^*Q$ has zero p-curvature. Its
second fundamental map for (6) is an isomorphism: it is the
ambient canonical-filtration map of index four, whose coefficient
$4$ is a unit. Hence (6) is the required dormant projective oper.
This proves the rank-three implication without assuming an
abstract oper-duality theorem.

At the first unstable step, $D$ differs from the original degree
$d$ by a power of five and possibly a sign. Equations (1) and
(4), including the horizontal case of Section2, therefore imply
$r\mid d$. Rank-one bundles are automatically strongly semistable.
The asserted no-oper and nondivisible-degree consequences follow.

## 4. Converse in rank three

The [proper-subbundle theorem](cartier_witt_oper_subbundle.md)
constructs from the common dormant oper its common-simple adjoint
bundle $K=\operatorname{End}^0(Q)$, of rank three and degree zero.
Its Harder--Narasimhan filtration is common, so common simplicity
forces semistability on the endpoints. If
$L\subset F^*Q$ is the oper line, then
\[
\operatorname{Hom}(F^*Q/L,L)\simeq\omega
\]
is a line subbundle of $F^*K$ of positive degree. Thus $K$ is
not strongly semistable. This construction needs no common spin
lift and retains the original source comparison.

## 5. The conditional rank-four boundary

On the first twists, choose endpoint theta characteristics
$\vartheta_C^2\simeq\omega_C$. Their pulled-back ratio on the
original source is a two-torsion line, with the indicated square
trivialization supplied by the actual canonical comparison.
Its torsor trivializes it on a finite etale source cover of degree
at most two; use a connected component if the torsor is trivial.
Thus the same endpoint lines form an actual common theta
characteristic on this refined span. No endpoint curve is changed.

A clump on the refinement would map to a clump on the original
source, by full-fiber saturation. Likewise equality of pulled-back
endpoint projective connections descends through the faithfully
flat source cover. Thus the no-clump and no-oper assumptions persist.

The [common Cartier bundle](common_cartier_subbundles.md) is
common-simple in this situation. Its common HN filtration therefore
forces endpoint semistability. Hence $B\vartheta^{-1}$ is a common
semistable rank-four degree-zero bundle. In the canonical filtration
of its Frobenius pullback the top line is
$\omega^4\otimes F^*\vartheta^{-1}$. Its degree on the genus-two
endpoint is $8-5=3>0$, so it destabilizes that pullback. This proves
the stated conditional sharpness; it constructs no original span.

This is a direct author proof. Its checks are the two degree
identities, Cartier descent of the actual horizontal subbundle,
and the complementary canonical filtration. No numerical test or
independent proof audit is claimed. The theorem does not supply
the small common coefficient from a hypothetical bare span.
