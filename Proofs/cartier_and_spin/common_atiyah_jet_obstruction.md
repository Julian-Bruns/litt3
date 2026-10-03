# Proof: a prime-to-p seed controls every Frobenius direct image

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

Write $U=F^{[s]*}H_s$ on the seed's twist. The diagonal-ideal
description of iterated Frobenius gives its common filtration with
grades
\[
E,E\omega,\ldots,E\omega^{q-1},\qquad q=p^s.
\tag{9}
\]
Indeed étale-locally the corresponding algebra is
$\mathcal O[\epsilon]/(\epsilon^q)$; the diagonal ideal is
$(\epsilon)$ and its $i$th grade is $\omega^i$. This also proves
the description for $q>p$, without using first derivatives to
claim transversality beyond height one.

Let $W=E\omega^{q-1}$ be the TOP grade, an actual subbundle
of rank r prime to p. Suppose the extension with class
$\gamma_s=\operatorname{id}_{H_s}\otimes\varepsilon$ splits.
Pulling its splitting back gives $s:U\to U\otimes\mathcal T$,
where $\mathcal T=F^{[s]*}\mathcal A$ is the scalar extension
with class $\beta_s$. Its composite with projection is the identity.

The bundle $(U/W)\otimes\mathcal T$ has grades $E\omega^i$ with
\[
i\in\{0,\ldots,q-2\}\cup\{q,\ldots,2q-2\}.
\tag{10}
\]
None equals $q-1$. The seed E is common-simple.
Different canonical twists are nonisomorphic by their degrees.
Hence every common map from $W$ to (10) is zero, by induction on
the target filtration. It follows that $s$ restricts to a splitting
$W\to W\otimes\mathcal T$. Taking its trace in the $W$ factor and
dividing by r splits $\mathcal T$, contrary to (7).
For $s=0$, this is the usual trace on E itself. We have proved
\[
\gamma_s\ne0\quad\text{for every }s\ge0.
\tag{11}
\]
No division by $\operatorname{rk}H_s=rp^s$ occurs.

Exactly the same argument applies to $F_*^{[s]}L$ for an arbitrary
common line $L$. Its pulled-back grades are $L\omega^i$; different
twists are nonisomorphic simple common lines, and the top grade now
has rank one. Thus its scalar class is nonzero as well. Tensoring
an object with a common line transports its scalar class isomorphically,
so these detectors survive subsequent line twists.

## Self-duality and the Atiyah identity

Finite Frobenius duality transports the perfect omega-valued
pairing on E to a perfect common omega-valued pairing on every
H_s. It preserves its symmetric or alternating type. For the
specialization E=B, use its established canonical Cartier pairing
from the [first-height theorem](common_cartier_subbundles.md).

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

## Initial jets and the weighted one-stage classification

For ANY common-simple $E_0$, let $0\ne V\subset F_*E_0$ be a
common saturated subbundle. Intersect $F^*V$ with the diagonal-ideal
filtration of $F^*F_*E_0$. Its induced graded images in
$E_0\omega^i$ are zero or the whole simple factor. All common
images are saturated by no-clump. The canonical Cartier connection
restricts to $F^*V$; its adjacent graded maps have nonzero
coefficients $i=1,\ldots,p-1$. Thus the nonzero images are exactly
the indices $0,\ldots,\ell-1$, for some $1\le\ell\le p$.

Projection onto those first $\ell$ grades identifies
$F^*V$ with the ACTUAL jet bundle $J^{\ell-1}E_0$: its kernel
has all graded terms zero, and each retained graded map is an
isomorphism. This common identification transfers the Cartier
connection and gives $\operatorname{rk}V=r\ell$.

Now suppose $E_0$ has prime-to-$p$ rank $r$ and a perfect common
$\omega^w$-valued pairing. Self-duality gives
$\deg E_{0,Y}=rw(g(Y)-1)$. The actual jet identification gives
\[
p\deg V_Y=r\ell(w+\ell-1)(g(Y)-1).
\tag{19}
\]
For a proper nonzero $V$, $1\le\ell<p$. Reducing (19) modulo
$p$, the stated degree and rank hypotheses force
$\ell\equiv1-w\pmod p$. Thus $w\equiv1$ rules out every proper
subobject.

Otherwise every proper nonzero subobject has the same rank
$r\ell$. Two distinct such subobjects have zero intersection:
a nonzero common intersection is saturated and has the same
allowed rank, so must equal both. Their common sum therefore has
rank $2r\ell$. It cannot be proper, which would require rank
$r\ell$, or whole, which would require $2\ell=p$. The latter
is impossible for odd $p$; exceeding the ambient rank is also
impossible. This proves uniqueness. A proper subobject of $V$,
or the inverse image of a proper subobject of the quotient,
would contradict it. Hence both factors are common-simple.
A common splitting would give a second proper subobject.
For $p=5$, the seeds $\omega^{-2}$ and $\omega^{-1}$ have
weights $-4$ and $-2$, respectively; this yields the stated
simplicity and rank3 conclusions without asserting existence.

## One induction for every omega-valued seed and every height

The seed $H_0=E$ is common-simple. Suppose $H_s$ is common-simple
and let $0\ne V\subset F_*H_s$ be a common saturated subbundle.
The initial-jet identification just proved transfers its Cartier
connection to $J^{\ell-1}H_s$, with $1\le\ell\le p$.
Apply the block-sum identity to $H_s$, using its already proved
nonzero $\gamma_s$ and actual omega-valued self-duality.
It gives $\ell^2\gamma_s=0$, so $p\mid\ell$. Hence $\ell=p$,
and the saturated inclusion $V\subset F_*H_s$ has full rank
and is equality. This proves common simplicity of $H_{s+1}$.

After induction the same block sum applies to every jet length,
giving necessity in (2). The converse follows below. The scalar
detector used only simplicity and the prime-to-p rank of the
ORIGINAL seed; it did not assume simplicity of a later H_s.

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
this proves the exact jet-length criterion for every H_s.
The preceding joint induction establishes its common simplicity.

The returned Pro proof establishes the scalar detector and the
two-block instance. The general seed detector, block sum and joint induction are
extensions. A focused review checks the gap in the weight
sets (10), the noncommuting block cancellation (16), and actual
relative-Frobenius base change (18). Standard canonical-filtration
and direct-image facts are as in
[Sun](https://arxiv.org/abs/math/0611360); the common obstruction
and its survival are the additional assertions proved here.
