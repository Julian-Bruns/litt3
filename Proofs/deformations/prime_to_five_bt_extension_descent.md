# Proof: corestrict the extension and normalize its boundary

[Statement](../../Theorems/deformations/prime_to_five_bt_extension_descent.md).
All Ext groups here are in abelian fppf sheaves. We retain the
specified BT$_N$ group $A$ and its subgroup $H=A[5]$.

## The boundary which detects the next truncation

For an extension
\[
e:\quad0\longrightarrow H\xrightarrow{i}B\xrightarrow{\pi}A
\longrightarrow0,
\tag{1}
\]
and a local section $a\in A[5]$, choose an fppf-local lift $b$ in
$B$. The section $5b$ lies in $H$ and is independent of the lift,
since $5H=0$. This defines an additive natural boundary
\[
\partial(e):A[5]=H\longrightarrow H.
\tag{2}
\]
It is additive in the extension class. For an actual marked
BT$_{N+1}$ extension, written with quotient map $[5]:B\to A$,
it is the identity under the given marking.

Conversely, suppose $\partial(e)=\operatorname{id}_H$. The middle
sheaf is representable and finite locally free: it is an $H$-torsor
over the finite locally free scheme $A$. If $5b=0$, then
$a=\pi(b)\in A[5]$ and (2) gives $a=0$. Hence
\[
B[5]=i(H).
\tag{3}
\]
Multiplication by five factors through an injective map
$\beta:A\to B$, with $\pi\beta=[5]_A$ and
$\beta|_{A[5]}=i$. Its image is $5B$. Using
$A[5^{N-1}]=5A$ shows that $5B=B[5^N]$. Indeed, a section killed
by $5^N$ maps to $5A$; lift its preimage under $[5]_A$, then use
$i(H)\subset5B$ to remove the remaining difference. Iterating gives
\[
B[5^j]=5^{N+1-j}B\quad(1\le j\le N+1).
\tag{4}
\]
These subgroup sheaves are finite locally free, identified with
the specified lower truncations of $A$; $B[5]$ is the BT1 $H$.
The truncated Barsotti--Tate criterion therefore makes $B$ a BT$_{N+1}$.
The map $\beta$ gives its marked identification $B[5^N]=A$.
For the criterion in terms of finite locally free truncations see
[Illusie, Definition1.1](https://www.imo.universite-paris-saclay.fr/~luc.illusie/Illusie-Chicago-2023-1.pdf).
At $N=1$ this is exactly the boundary calculation in the
[BT2 extension quotient](versal_bt2_extension_quotient.md).

## Corestriction

Let $e_D$ be the extension class of the supplied BT$_{N+1}$ on $D$.
For a finite etale map, direct image of abelian sheaves is exact:
etale locally on $C$ it is a finite product. The diagonal and sum
maps are
\[
A\xrightarrow{u}q_*q^*A,
\qquad q_*q^*H\xrightarrow{t}H.
\]
Push (1) on $D$ forward, pull its quotient back along $u$, and
push its kernel out along $t$. This constructs an actual extension
class $\operatorname{cor}_q(e_D)$ on $C$. Additivity and naturality
of (2), or the calculation on a splitting etale cover, give
\[
\partial\operatorname{cor}_q(e_D)=d\operatorname{id}_H.
\tag{5}
\]
Choose an integer $a$ with $ad\equiv1\pmod5$ and take the Baer
multiple $a\operatorname{cor}_q(e_D)$. Its boundary is the identity.
The first part realizes it as a marked BT$_{N+1}$ on $C$.
No scalar $1/d$ is used in characteristic five unless $d$ is
invertible; this is precisely the stated restriction on the cover.

In height two, a discrepancy in the next determinant character lies
in $1+5^N\mathbf F_5$. Squaring is invertible on this group, so a
rank-one etale character twist trivial at the preceding level
normalizes the determinant without changing $A$.

## The common-oper application and the remaining wild case

The actual comparison in
[common BT1 realization](common_admissible_bt1.md) identifies
$f^*H_X$ with $g^*H_Y$ tensored by an order-four etale character.
That character has a Teichmuller $\mathbf Z_5$-lift, so $f^*H_X$
has a full group extension. Apply (5) with $q=f$ and $N=1$.
The corestriction is not claimed to retain the specified pullback
extension; thus it does not settle the source compatibility class.

For the general reduction, replace a single finite etale cover by
its connected Galois closure $W\to C$, with group $\Gamma$. Let
$P$ be a Sylow five-subgroup. The tower $W\to W/P$ can be factored
into connected cyclic degree-five covers by a subgroup series of
the finite five-group. If next-level existence descends across
every such step, it descends to $W/P$. The remaining degree
$[\Gamma:P]$ is prime to five, so (5) descends it to $C$.
This uses no simultaneous Galois source for a two-leg span.
