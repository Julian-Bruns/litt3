# The canonical Cartier extension is the sole common trace obstruction

Version3,21September2026. Let $k=\overline{\mathbf F}_5$ and let
$X\xleftarrow f Z\xrightarrow gY$ be an ACTUAL coreless finite
etale span of smooth proper connected curves, with $g(Y)=2$ and
no clump. All bundles, maps, extensions, and traces retain the
specified common identifications and the relative Frobenius twists.

On the $r$th twists, $r\ge1$, put
\[
A_r=F_*^{[r]}\mathcal O,\qquad B_r=A_r/\mathcal O.
\]
In the category of common bundles, the boundary map is an isomorphism
\[
k=\operatorname{End}_{\rm common}(B_r)
\xrightarrow{\ \sim\ }
\operatorname{Ext}^1_{\rm common}(B_r,\mathcal O).
\tag{1}
\]
It sends $1$ to the ACTUAL nonsplit sequence
\[
0\longrightarrow\mathcal O\longrightarrow A_r
\longrightarrow B_r\longrightarrow0.
\tag{2}
\]
Consequently the two endpoint images have exactly a common line:
\[
f^{(r)*}H^1(X^{(r)},B_{r,X}^{\vee})
\cap g^{(r)*}H^1(Y^{(r)},B_{r,Y}^{\vee})
=k\,e_{r,Z}
\subset H^1(Z^{(r)},B_{r,Z}^{\vee}).
\tag{3}
\]
Here $e_{r,C}$ denotes the class of (2), and both endpoint pullback
maps in (3) are injective. No covering degree is inverted.

Equivalently, let $\lambda_{r,C}$ be Serre pairing with $e_{r,C}$.
The joint trace has image EXACTLY the following hyperplane:
\[
\begin{split}
\operatorname{im}\bigl(\operatorname{Tr}_f,\operatorname{Tr}_g\bigr)
&=\{(s_X,s_Y):\lambda_{r,X}(s_X)=\lambda_{r,Y}(s_Y)\},\\
H^0(Z^{(r)},B_{r,Z}\omega_Z)&\longrightarrow
H^0(X^{(r)},B_{r,X}\omega_X)\oplus
H^0(Y^{(r)},B_{r,Y}\omega_Y).
\end{split}
\tag{4}
\]
Thus the joint trace has cokernel dimension one at EVERY height.
For the fixed genus-nine $X$, its target dimension is
$18(5^r-1)$, and its rank is $18(5^r-1)-1$.

There is also an ARBITRARY-RANK vanishing: for every common strongly
semistable bundle $E$ with positive degree on $Y$,
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)=0.
\tag{5}
\]
Consequently the joint trace on $E\omega$ is surjective onto the
two endpoint section spaces. This assertion does not require absence
of a common oper. Its proof uses a finite common projective monodromy
orbit of line directions, the actual induced rank-two extensions,
and pushforward of their effective divisors. It does NOT assume
that no-clump persists after arbitrary endpoint refinements.

If there is additionally no common regular projective connection,
this completely describes the answer for positive semistable common
coefficients of rank at most four:
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)=
\begin{cases}
k\,e_1,&E\simeq B_1\text{ as an ACTUAL common bundle},\\
0,&\text{otherwise}.
\end{cases}
\tag{6}
\]
Thus the first Cartier bundle is the sole exception in these ranks.
This last classification uses the exact rank-four Frobenius theorem;
it is not asserted for arbitrary higher-rank semistable coefficients.

More generally, suppose $E$ is common and AMPLE on the endpoints,
of arbitrary rank $d$. Fix its target twist, using the inverse
relative twists as sources in the definition of $B_s$, and put
$h=\lfloor\log_5(d+1)\rfloor$, with $B_0=0$. Then the canonical
boundary map gives
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\simeq\operatorname{Hom}_{\rm common}(E,B_h).
\tag{7}
\]
Every nonzero class is the pullback of a canonical Cartier extension
along an ACTUAL common surjection $E\twoheadrightarrow B_j$, for
some $1\le j\le h$. In particular every such class is killed by
at most $h$ Frobenius pullbacks, independently of the covering
degrees. For a common-simple ample $E$ in any rank, the extension
group is nonzero exactly when $E\simeq B_1$, and is then a line.
No no-oper hypothesis is needed for these ample-bundle assertions.

In particular, for every common ample rank-$d$ coefficient,
\[
\dim\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\le m_{B_1}(E)\le\lfloor d/4\rfloor,
\tag{8}
\]
where $m_{B_1}(E)$ is its common Jordan--Holder multiplicity.
This is exactly the cokernel dimension of the ACTUAL joint trace
on $E\omega$. The rank bound is sharp for every $d$, attained
by $B_1^{\oplus\lfloor d/4\rfloor}$ together with canonical-line
summands for the remaining rank. When $4\mid d$, equality holds
precisely for $E\simeq B_1^{\oplus d/4}$ as an actual common bundle.
For the fixed genera nine and two, that joint trace has rank at
least $9(\deg E_Y+d)-\lfloor d/4\rfloor$.

For every $m\ge2$, every actual common quotient $E$ of
$B_1^{\otimes m}$ has
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)=0.
\tag{9}
\]
This includes symmetric powers, exterior powers in their nonzero
ranks, and Schur constructions presented as such quotients. Thus
their actual joint trace is surjective. These tensor constructions
cannot generate another canonical-extension obstruction.

These statements concern global extensions and both original
trace maps. They do not construct a common bundle from the three
exact forms on $X$, nor exclude the surviving full-coordinate
monodromy branch. Both original common-cover candidates remain open.
[Proof](../../Proofs/cartier_and_spin/common_cartier_extension_trace.md).
