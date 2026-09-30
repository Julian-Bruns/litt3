# Proof: retain a prime-to-p grade when the total rank vanishes

[Statement](../../Theorems/cartier_and_spin/common_atiyah_jet_obstruction.md).
All connections, maps, splittings and extension classes are common
for the actual two-map diagram. No-clump implies that every common
image is saturated. Thus these bundles form an abelian category;
evaluation at a source point is exact. In particular, maps between
distinct simple objects vanish. Common Hom spaces are finite-dimensional
over the algebraically closed field, so a simple object's endomorphism
ring is $k$.

## Scalar extensions survive every pullback

On a specified twist let
\[
0\longrightarrow\omega\longrightarrow
\mathcal A=J^1\omega\otimes\omega^{-1}
\longrightarrow\mathcal O\longrightarrow0
\tag{6}
\]
represent $\varepsilon$. Its restriction to the genus-$g(Y)$ endpoint
is nonzero: a connection on a line requires its degree to vanish in
$k$, whereas $\deg\omega_Y=2(g(Y)-1)\not\equiv0\pmod p$.
The degree assertion follows directly by summing the residues of a
connection form in a rational trivialization.

For $q=p^s$, the pulled-back extension has kernel $\omega^q$.
If it has a common splitting, the splitting's failure to respect
the canonical one-step Cartier connections is a common section of
$\omega^{q+1}$. There are no such nonzero sections: the zero divisor
of a nonzero common positive pluriform would give a clump. Thus this
splitting is horizontal. Full faithfulness of Cartier descent gives
a common splitting one twist later. Repeating gives a splitting of
(6), a contradiction. Consequently
\[
\beta_s=F^{[s]*}\varepsilon\ne0\quad(s\ge0).
\tag{7}
\]
For $s>0$, each endpoint group $H^1(\omega^{p^s})$ is zero. The
nonzero class can therefore be represented explicitly by the difference
of endpoint splittings on the original source, modulo differences
of endpoint sections. It belongs to
\[
\frac{H^0(Z^{(1)},\omega_{Z^{(1)}}^{p^s})}
{f^{(1)*}H^0(X^{(1)},\omega_{X^{(1)}}^{p^s})+
 g^{(1)*}H^0(Y^{(1)},\omega_{Y^{(1)}}^{p^s})}.
\tag{8}
\]
Here the starting Atiyah extension is on the $(s+1)$st twist.
Choosing other splittings changes only its representative in (8).

## Tensoring with an arbitrary-height direct image does not kill it

Write $U=F^{[s]*}H_s$ on the first twist. The diagonal-ideal
description of iterated Frobenius gives its common filtration with
grades
\[
B,B\omega,\ldots,B\omega^{q-1},\qquad q=p^s.
\tag{9}
\]
Indeed étale-locally the corresponding algebra is
$\mathcal O[\epsilon]/(\epsilon^q)$; the diagonal ideal is
$(\epsilon)$ and its $i$th grade is $\omega^i$. This also proves
the description for $q>p$, without using first derivatives to
claim transversality beyond height one.

Let $W=B\omega^{q-1}$ be the TOP grade, an actual subbundle of
rank $p-1$. Suppose the extension with class
$\gamma_s=\operatorname{id}_{H_s}\otimes\varepsilon$ splits.
Pulling its splitting back gives $s:U\to U\otimes\mathcal T$,
where $\mathcal T=F^{[s]*}\mathcal A$ is the scalar extension
with class $\beta_s$. Its composite with projection is the identity.

The bundle $(U/W)\otimes\mathcal T$ has grades $B\omega^i$ with
\[
i\in\{0,\ldots,q-2\}\cup\{q,\ldots,2q-2\}.
\tag{10}
\]
None equals $q-1$. The first-height
[Cartier theorem](common_cartier_subbundles.md) makes $B$ common-simple.
Different canonical twists are nonisomorphic by their degrees.
Hence every common map from $W$ to (10) is zero, by induction on
the target filtration. It follows that $s$ restricts to a splitting
$W\to W\otimes\mathcal T$. Taking its trace in the $W$ factor and
dividing by $p-1$ splits $\mathcal T$, contrary to (7).
For $s=0$, this is simply the usual trace on $B$ itself. We have proved
\[
\gamma_s\ne0\quad\text{for every }s\ge0.
\tag{11}
\]
No division by $\operatorname{rk}H_s=(p-1)p^s$ occurs.

Exactly the same argument applies to $F_*^{[s]}L$ for an arbitrary
common line $L$. Its pulled-back grades are $L\omega^i$; different
twists are nonisomorphic simple common lines, and the top grade now
has rank one. Thus its scalar class is nonzero as well. Tensoring
an object with a common line transports its scalar class isomorphically,
so these detectors survive subsequent line twists.

## Self-duality and the Atiyah identity

The local Cartier pairing on $B$ is
$\langle[a],[b]\rangle=\operatorname{Car}(a\,db)$.
It is alternating, since $2\operatorname{Car}(a\,da)=0$, and
perfect: in the basis $[x],\ldots,[x^{p-1}]$ its anti-diagonal
entries are nonzero. Finite Frobenius duality, using the dualizing
Cartier trace on differentials, transports it to a perfect common
alternating $\omega$-valued pairing on every $H_s$.

For any self-dual $E\simeq E^\vee\otimes\omega$, the tensor and
dual rules for Atiyah extensions give
\[
a(E)=-a(E)^\dagger+\operatorname{id}_E\otimes a(\omega).
\tag{12}
\]
These rules can be checked on the transition cocycle $G^{-1}dG$,
including the transition on the specified source identification.
They are identities of common extensions. For $E=H_s$, (11),(12)
already rule out a common connection on $H_s$ at every height.

## The block sum for any consecutive filtered system

Assume $E$ is common-simple and satisfies (12), with $\gamma_E\ne0$.
Let $V=V_0\supset V_1\supset\cdots\supset V_\ell=0$ have
$V_i/V_{i+1}=E\omega^i$. Suppose $V$ has a common connection.

For $i\ge1$, its second fundamental form for the indicated two
steps is a common map
$V_i\to(V/V_{i-1})\otimes\omega$. The source grades have
weights $i,\ldots,\ell-1$, and the target has weights
$1,\ldots,i-1$. There is no common simple factor in both.
This map is zero. Thus the connection is Griffiths transverse:
\[
\nabla V_i\subset V_{i-1}\otimes\omega.
\tag{13}
\]
On the adjacent grades its second fundamental forms are scalar
maps $E\omega^i\to E\omega^i$, since $\operatorname{End}(E)=k$.

Choose local frames of $E$, local generators of $\omega$, and
local splittings of the filtration. Order the grades by decreasing
weight. Every transition or source-comparison matrix has the form
$T=DU$, with $U$ upper unipotent in blocks and
\[
D=\operatorname{diag}(h^{\ell-1}G,\ldots,hG,G),
\tag{14}
\]
where $G$ is the transition of $E$ and $\eta_j=h\eta_i$.
By (13), a connection matrix $\Omega$ has no block below its
first subdiagonal. Each subdiagonal block is a scalar multiple
of the identity (times the local differential).

Let $\Sigma=\sum_i\Omega_{ii}$, a matrix in the $E$ factor;
this is a sum of blocks, NOT the scalar trace of $E$.
Conjugation by $D$ and the term $D^{-1}dD$ transform it into
\[
G^{-1}\Sigma G+\ell G^{-1}dG+
\frac{\ell(\ell-1)}2(d\log h)I.
\tag{15}
\]
The subsequent unipotent transformation does not change the block
sum. Explicitly, for an upper unipotent $U$ and a matrix $\Omega$
with this lower bandwidth,
\[
(U^{-1}\Omega U)_{ii}
=\Omega_{ii}+\Omega_{i,i-1}U_{i-1,i}
-U_{i,i+1}\Omega_{i+1,i}.
\tag{16}
\]
The extra terms cancel on summing, because every subdiagonal block
is scalar. Also $U^{-1}dU$ is strictly upper triangular. Formula
(16) does not require the other blocks to commute.

Thus the actual local matrices $\Sigma$ give a common coboundary
for $\ell a(E)+\ell(\ell-1)\gamma_E/2$. Taking its adjoint,
adding, and applying (12), gives
\[
0=\ell\bigl(a(E)+a(E)^\dagger\bigr)
+\ell(\ell-1)\gamma_E=\ell^2\gamma_E.
\tag{17}
\]
Since the extension group is a $k$-vector space and $\gamma_E\ne0$,
this forces $p\mid\ell$. Arbitrary extension matrices were retained
throughout; no splitting of $V$ was assumed.

For self-duality valued in $\omega^w$, (12) instead reads
$a(E)+a(E)^\dagger=w\gamma_E$. The same block sum is unchanged,
so its sum with its adjoint gives
$\ell(w+\ell-1)\gamma_E=0$. The distinction matters when $w=0$:
then length one is NOT excluded by this argument.

## The converse for actual jets

On a smooth curve, $J^{n}E$ is the pushforward of $E$ from the
second factor of the $(n+1)$st infinitesimal diagonal. If $n+1=pm$,
its diagonal equation in étale coordinates is
\[
(x-y)^{pm}=(x^p-y^p)^m.
\tag{18}
\]
Flat base change through relative Frobenius gives
$J^{pm-1}E\simeq F^*J^{m-1}(F_*E)$. This is coordinate independent
and commutes with the two original étale maps. Its canonical Cartier
connection is therefore common and dormant. Together with (17),
this proves the asserted exact jet-length criterion whenever $E$
is common-simple. The all-height theorem establishes that condition
for every $H_s$ by induction, without any circular use here.

The returned Pro proof establishes the scalar detector and the
two-block instance. The higher-height detector and (13)--(18) are
author extensions. A focused review checks the gap in the weight
sets (10), the noncommuting block cancellation (16), and actual
relative-Frobenius base change (18). Standard canonical-filtration
and direct-image facts are as in
[Sun](https://arxiv.org/abs/math/0611360); the common obstruction
and its survival are the additional assertions proved here.
