# Proof: a unique growing Cartier direction in a cyclic five-cover

[Statement](../../Theorems/cartier_and_spin/cyclic_cartier_orbit_bound.md).
All curves are smooth, proper and geometrically connected over the
algebraically closed field $k$ of characteristic five. Absolute
Cartier is inverse-Frobenius semilinear; all scalar powers below
retain this convention.

## 1. The differential module of an actual cyclic etale cover

First let $q:T\to C$ be any connected finite etale cyclic cover of
degree $Q=5^r$, with group $G=\langle\gamma\rangle$ and
$t=\gamma-1$. Coherent Cartan--Leray descent gives the five-term
sequence beginning
\[
0\longrightarrow H^1(G,k)\longrightarrow H^1(C,\mathcal O_C)
\xrightarrow{q^*}H^1(T,\mathcal O_T)^G.
\]
Here $H^0(T,\mathcal O_T)=k$ and $H^1(G,k)=\operatorname{Hom}(G,k)$
is one-dimensional. Its image is $k\eta$, where $\eta$ is the
class of the first degree-five quotient, normalized by sending
$\gamma$ to $1$. This is an Artin--Schreier class, so $F\eta=\eta$.
In particular it is nonzero; one does not presume injectivity of
coherent pullback in characteristic-divisible degree.

By Serre duality, the trace on regular differentials has image
\[
\operatorname{im}\operatorname{Tr}_q
=\operatorname{Ann}(\eta)\subset H^0(C,\omega_C),
\qquad\dim\operatorname{Ann}(\eta)=g(C)-1.
\tag{1}
\]
Etale descent identifies $H^0(T,\omega_T)^G$ with
$q^*H^0(C,\omega_C)$, of dimension $g(C)$. The norm is
\[
N=1+\gamma+\cdots+\gamma^{Q-1}=t^{Q-1}
=q^*\operatorname{Tr}_q.
\]
Decompose $H^0(T,\omega_T)$ into nilpotent $t$-blocks. Its
invariant dimension counts all blocks, hence there are $g(C)$.
The rank of $t^{Q-1}$ counts blocks of length $Q$, hence exactly
$g(C)-1$ have that length. Riemann--Hurwitz gives total dimension
$g(T)=Q(g(C)-1)+1$. The remaining block therefore has length one:
\[
H^0(T,\omega_T)\simeq k\oplus k[G]^{g(C)-1}.
\tag{2}
\]
On the right, the intersection of the image of $t$ with the
invariants consists of the bottoms of the full-length blocks.
Using (1), this proves the concrete equality
\[
tH^0(T,\omega_T)\cap H^0(T,\omega_T)^G
=q^*\operatorname{Ann}(\eta).
\tag{3}
\]
No division by $Q$ occurs.

## 2. Every nonzero Artin--Schreier class detects the double pairing

For the fixed $X$, put
\[
W=\langle dx/y,x\,dx/y,x^2dx/y\rangle.
\]
The certified [double-Cartier calculation](two_form_map_descent.md)
identifies $\tau_X:\bigwedge^2V\to W$ as a semilinear isomorphism.
The [Cartier calculation](cartier_petri_excess_one.md) gives
$\ker C_X^2=\ker C_X=V$, with $\dim V=3$, and places $V$ in the
six-dimensional $dx/y^2$ sector. Cartier maps $W$ injectively into
that sector. If $C_Xw\in V$ for $w\in W$, then $C_X^2w=0$, hence
$w\in V\cap W=0$. Thus
\[
H^0(X,\omega_X)=V\oplus W\oplus C_XW.
\tag{4}
\]

Let $0\ne\eta\in H^1(X,\mathcal O_X)$ satisfy $F\eta=\eta$.
Frobenius--Cartier duality reads
\[
\langle F\eta,\omega\rangle
=\langle\eta,C_X\omega\rangle^5.
\tag{5}
\]
It shows that $\eta$ annihilates $V$. If it also annihilated $W$,
then (5) would make it annihilate $C_XW$, and (4) would contradict
the perfectness of Serre duality. Therefore its restriction to $W$
is nonzero.

Consequently
\[
b_\eta(u,v)=\langle\eta,\tau_X(u,v)\rangle
\]
is a nonzero alternating inverse-$25$-semilinear form on the
three-dimensional space $V$. Taking its $25$th power makes it an
ordinary nonzero alternating bilinear form with the same radical.
Its rank is two and its radical $R_\eta$ is a line.

For the finite projective geometry, put
$H=H^1_{\rm et}(X,\mathbf F_5)=H^1(X,\mathcal O_X)^{F=1}$.
The cubic automorphism $\gamma$ has no invariants because its
quotient is the projective line. Thus $\mathbf F_5[\gamma]\simeq
\mathbf F_{25}$ and $H$ has dimension three over this field.
Restriction $H\to W^\vee$ is injective by the argument above.
It intertwines $\gamma$ with a primitive cube-root scalar,
hence is F25-linear with the corresponding embedding into k.

The Frobenius-fixed vectors span the entire bijective part
$H^1(X,\mathcal O_X)_{\rm bij}=\operatorname{Ann}(V)$ over k:
$\ker C_X^2=\ker C_X$ gives
$\operatorname{im}F^2=\operatorname{im}F=\operatorname{Ann}(V)$,
so this image is already the bijective part
([Artin--Schreier descent](https://stacks.math.columbia.edu/tag/0A3J),
Lemma59.63.2). Its restriction to $W^\vee$ is surjective by (4).
Consequently the image of H is an F25 form of $W^\vee$:
its three F25 basis vectors are also k-linearly independent.
The semilinear isomorphism $\tau_X$ followed by the alternating
radical identification sends this form to an F25 form of V;
the scalar exponent25 fixes F25. Therefore the radical lines
are exactly its651 projective points. The six F5 lines in each
F25 line are the six unmarked degree-five covers with that
radical. The unique F25 line itself defines the corresponding
cubic-stable degree25 cover.


## 3. Only one Jordan block of the exact forms can be nontrivial

Return to $q:T\to X$ and $E=\ker C_T$. Etale descent and Cartier
naturality give $E^G=q^*V$. Take $u\in tE\cap E^G$. Write
$u=tv=q^*u_0$ with $v\in E$ and $u_0\in V$. For every $w\in V$,
additivity and naturality of the actual double-Cartier operation give
\[
t\,\tau_T(v,q^*w)=q^*\tau_X(u_0,w).
\tag{6}
\]
The right side is invariant, and the left side is in the image of
$t$ on regular differentials. Equation (3) therefore implies
\[
\langle\eta,\tau_X(u_0,w)\rangle=0.
\]
Since this holds for every $w$, one has $u_0\in R_\eta$. Thus
\[
\dim(tE\cap E^G)\le1.
\tag{7}
\]

There are exactly three $t$-blocks in $E$, since $\dim E^G=3$.
Each block of length at least two contributes exactly one dimension
to $tE\cap E^G$, while a length-one block contributes none. At most
one block is therefore nontrivial. Every block has length at most
$Q$ because $t^Q=0$.

On the first relative twist, $E=H^0(T^{(1)},q^{(1)*}B_X)$, and
$B_X$ has its canonical perfect alternating omega-valued pairing.
The audited [cyclic symplectic block theorem](../deformations/section_growth/cyclic_symplectic_blocks.md)
therefore says that every odd block length strictly below $Q$
has even multiplicity. If $L=1$, the trivial block has multiplicity
three, a contradiction. If $1<L<Q$ is odd, that length has
multiplicity one, again a contradiction. Thus
$L\in\{2,4,\ldots,Q-1,Q\}$. In particular a nontrivial block always
occurs, and its invariant bottom is exactly $q^*R_\eta$.

Finally the later
[deck-module theorem](../jacobians/etale_frobenius_degree_gap.md)
identifies the actual Frobenius-nilpotent part with $R^3$.
Serre duality identifies $E$ with the contragredient dual of
$\operatorname{coker}F_T$, with its scalar twist. Duality and
inversion of the deck generator preserve cyclic block lengths.
Thus its invariant factors are $t,t,t^L$, including a zero
factor when $L=Q$. This is Smith form of the linearized map,
not a common basis conjugating all its semilinear powers.


The general estimate $a(T)\le3Q$ follows just from three invariant
blocks; the improvement uses the specific nondegenerate double
pairing and the actual Artin--Schreier class. We have not assumed
that an arbitrary alternating common-cover tower is cyclic over X.

## 4. An actual elementary abelian boundary

Work on $C=X^{(1)}$ with its Cartier bundle $B_X$, and write
$V_B=H^0(C,B_X)$. Under the usual scalar-twisted identification it
is the space $V$ used above. Its perfect alternating omega-valued
pairing gives the cup-product identity
\[
\langle\eta\cup u,v\rangle=\langle\eta,\mu(u,v)\rangle,
\qquad H^1(C,B_X)\simeq V_B^\vee.
\tag{8}
\]
This is the actual pairing and cup product, as established in the
[Cartier--Petri proof](cartier_petri_excess_one.md).

Let $\gamma$ be the cubic automorphism of $C$. It acts by a
nontrivial cube-root scalar $\chi$ on $V_B$, and therefore by
$\chi^2$ on the three-dimensional image of $\mu$. The quotient
$C/\langle\gamma\rangle$ is the projective line. Since three is
invertible in characteristic five, finite-map descent gives
\[
H^1_{\mathrm{et}}(C,\mathbf F_5)^{\langle\gamma\rangle}=0.
\]
Choose any nonzero class $\eta_1$ in this six-dimensional
$\mathbf F_5$-space, and put $\eta_2=\gamma\eta_1$. They are
linearly independent over $\mathbf F_5$: the only cube root of
unity in $\mathbf F_5$ is one, and there are no invariants. They
define an actual connected etale $A=(\mathbf Z/5)^2$-cover of C,
the relative twist of a cover $q_A:T_A\to X$.

Also denote their coherent images by $\eta_i$. They are
Frobenius-fixed and nonzero. By (5), applied on the appropriate
twist, nonvanishing of their pairing with the double-Cartier image
is equivalent to nonvanishing with the image of $\mu$. Thus
\[
D_i:V_B\longrightarrow V_B^\vee,
\qquad D_i(u)(v)=\langle\eta_i,\mu(u,v)\rangle
\]
has rank two. Equivariance of Serre duality and the single cubic
character of the image of $\mu$ give
\[
D_2=\lambda D_1,\qquad
\lambda\in\mu_3\setminus\{1\}\subset k.
\tag{9}
\]
The choice of pullback versus inverse action only exchanges the
two primitive cube roots and does not affect the argument.

Inside the regular permutation sheaf $(q_A^{(1)})_*\mathcal O$
take the rank-three subbundle $\mathcal U$ of affine linear
functions on the deck group A. Translations preserve it, and
there is an exact sequence
\[
0\longrightarrow\mathcal O_C\longrightarrow\mathcal U
\longrightarrow\mathcal O_C^2\longrightarrow0
\tag{10}
\]
whose two extension classes are $\eta_1,\eta_2$, with simultaneous
signs depending on the coordinate convention. Tensoring with $B_X$
and using (8)--(9), the connecting map on sections is
\[
V_B^2\longrightarrow V_B^\vee,
\qquad(u_1,u_2)\longmapsto D_1(u_1+\lambda u_2).
\]
Its rank is two. The inclusion of $\mathcal U$ into the actual pushforward embeds
its global sections into $E_A$, retaining the scalar twist.

For every $v\in V_B$, the pair $(-\lambda v,v)$ belongs to the
kernel of the connecting map, so it has a global lift.
Subtracting its translate by the second standard deck generator
gives $v$ in the invariant copy of $V_B$. Thus $V_B\subset JE_A$.
Etale descent gives $E_A^A=q_A^*V_B$, so
$JE_A\cap E_A^A=E_A^A$. This proves the actual geometric boundary.
It explains why testing only the cyclic quotient characters cannot
carry the one-line argument over to an arbitrary five-group.

For the stronger numerical statement, apply the later augmentation
bound to the ACTUAL A-cover. The radical-layer dimensions of k[A]
are the coefficients of $(1+x+\cdots+x^4)^2$, whose maximum is5.
The base nilpotent Frobenius part has dimension3 and is killed by F;
hence $a(T_A)\ge3\cdot5=15$. This applies to every actual degree25
elementary abelian cover, independently of the cubic-stable
construction used to make all invariant directions augmentation
images. The651 count is already proved by the F25 geometry above.
