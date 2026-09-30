# Proof: the rank-four boundary is exactly the Cartier bundle

[Statement](../../Theorems/cartier_and_spin/rank_four_common_frobenius_classification.md).
We retain both actual maps and all their Frobenius twists. No-clump
implies that every common morphism has saturated image; in particular
a nonzero common line map is an isomorphism. HN filtrations commute
with the two finite etale pullbacks and hence are common.

## 1. A two-block oper gives a scalar projective connection

Let $(H,\nabla)$ be a common connection of rank $2m$, with a
common rank-$m$ subbundle $A$ whose second fundamental form is an
isomorphism $A\simeq(H/A)\omega$. Assume $2m$ is invertible in $k$.
Then this datum has a canonical common projective connection.

Here is a direct calculation, including its independence of the
choices. Put $B=H/A$. In a coordinate $t$, choose a frame of $B$
and a lift of that frame to $H$. Choose the frame of $A$ using
the second fundamental isomorphism. The connection matrix is
\[
d+\begin{pmatrix}P&R\\I&S\end{pmatrix}dt.
\]
Eliminating the $A$-coordinate of a horizontal section gives the
operator on its $B$-coordinate
\[
D_t=\partial_t^2+U\partial_t+V,
\qquad U=P+S,\quad V=S'+PS-R.
\tag{3}
\]
This is intrinsic to the cyclic projection $H\to B$, and so does
not depend on its chosen splitting. Set
\[
K_t=V-\tfrac12U'-\tfrac14U^2,
\qquad r_t=-\frac1m\operatorname{tr}(K_t).
\tag{4}
\]
Changing the $B$-frame conjugates $K_t$: this follows either by
direct substitution or by writing
$D_t=(\partial_t+U/2)^2+K_t$. Thus $r_t$ is independent of that
frame. For a coordinate change $t=h(s)$, put $v=h'$ and $c=v'/v$.
The scalar chain rule gives
\[
U_s=vU-cI,\qquad V_s=v^2V,
\]
and therefore
\[
K_s=v^2K_t+\tfrac12\{h,s\}I,
\qquad
r_s=v^2r_t-\tfrac12\{h,s\}.
\tag{5}
\]
This is precisely the projective-connection transformation law
for the potential in $z''=rz$; in characteristic five its
Schwarzian coefficient is $2$. Everything in (3)--(5) is functorial
for the given etale maps. There is no common spin choice or
connection on $B$ being assumed. In the no-clump setting every
such common regular projective connection is dormant, by the
[connection-spectrum theorem](../projective_connections/coreless_connection_spectrum.md).
We will apply this with $m=2$.

## 2. Excluding the two-by-two HN case

Put $H=F^*E$ with its canonical Cartier connection. Suppose its
HN filtration has two semistable rank-two grades
\[
0\longrightarrow A\longrightarrow H\longrightarrow B\longrightarrow0.
\]
The second fundamental map $s:A\to B\omega$ is nonzero. Otherwise
$A$ would descend to a destabilizing subbundle of the semistable
$E$. If $s$ has rank two, common saturation makes it an isomorphism.
Section1 supplies the forbidden common projective connection.

Suppose instead that $s$ has rank one. Write $K=\ker s$ and
$\operatorname{im}s=M\omega$, with $M\subset B$ a common line.
Since $\nabla K\subset A\omega$, its further second fundamental
form is a common line map
\[
K\longrightarrow(A/K)\omega.
\]
It must vanish. Indeed, semistability of $A$ gives
$\deg K\le\mu(A)\le\deg(A/K)$ on each endpoint, whereas an
isomorphism with $(A/K)\omega$ would strictly reverse this
inequality. Consequently $K$ is horizontal.

Apply the same argument to the dual HN sequence. The kernel of
the dual second fundamental map is the line $(B/M)^*\subset B^*$,
and it too is horizontal. Its annihilator $V\subset H$ is a
horizontal rank-three subbundle containing $A$, with $V/A=M$.
Thus the actual Cartier-flat quotient $V/K$ has the oper line
$A/K$, with second fundamental isomorphism
\[
A/K\xrightarrow{\sim}M\omega.
\]
It is a common dormant rank-two oper, again a contradiction.
This excludes the entire two-by-two case, including a rank-one
second fundamental form; no block has been replaced by its
semisimplification.

## 3. A destabilizing line generates the full four-step oper

In every remaining HN rank pattern, either $H$ or its dual has
a maximal HN piece of rank one. Replace $E$ by its dual if needed,
and call this line $L$. It is not horizontal, by semistability of
$E$. Generate successive subbundles $V_i$ under the connection,
starting with $V_1=L$. Once $V_{i-1}$ is constructed, the second
fundamental map for $V_i$ factors through $V_i/V_{i-1}$.
As long as this map is nonzero, its saturated image is a line
and gives
\[
V_i/V_{i-1}\xrightarrow{\sim}
(V_{i+1}/V_i)\omega.
\tag{6}
\]
Thus the ranks increase one at a time, with actual isomorphisms
on the whole curves.

If this process stopped at rank two, it would give a horizontal
rank-two subbundle with a dormant oper line. If it stopped at
rank three, it would give a full horizontal dormant rank-three
oper. Its complementary rank-two oper is constructed in
[Section3 of the small-rank proof](low_rank_common_frobenius_instability.md):
adjunction of the lowest line quotient embeds its Cartier antecedent
in $F_*N$, and the last two canonical grades give the rank-two
quotient oper. That construction uses only the full oper flag,
not semistability of its antecedent. Both stops therefore contradict
the no-oper hypothesis. The process reaches rank four.

We obtain a full dormant four-step oper on $F^*E$. Write $N$ for
its lowest line quotient. Its four grades, from lowest to highest,
are
\[
N,\quad N\omega,\quad N\omega^2,\quad N\omega^3.
\tag{7}
\]

## 4. The complementary line identifies the actual bundle

Adjunction of $F^*E\twoheadrightarrow N$ gives $E\to F_*N$.
This is generically injective: its pulled-back generic kernel would
be horizontal and contained in the penultimate oper piece. The
successive isomorphisms (6) force any such subspace down the whole
flag and hence to zero. Common saturation makes it a subbundle
injection, with common line quotient $Q$:
\[
0\longrightarrow E\longrightarrow F_*N\longrightarrow Q
\longrightarrow0.
\tag{8}
\]
Equivalently, the first four jets identify $F^*E$ with the first
four canonical grades of $F^*F_*N$; the jet factors $1,2,3$ are
units. The remaining line is $N\omega^4\simeq F^*Q$.

Finite Frobenius duality applied to the nonzero quotient in (8)
gives a common nonzero line map
\[
N\longrightarrow F^!Q=F^*Q\otimes\omega^{-4}.
\]
It is an isomorphism. Under this identification the quotient in
(8) is the dualizing counit, up to a common invertible scalar.
The projection formula and duality identify its kernel as
\[
E\simeq Q\otimes B^*\simeq B\otimes Q\omega_{C^{(1)}}^{-1}.
\tag{9}
\]
For the last equality use the actual alternating Cartier pairing
$B\otimes B\to\omega_{C^{(1)}}$. If we replaced $E$ by its dual,
the same pairing changes (9) into another line twist of $B$.
Thus (1) holds with its original common comparison retained.

The endpoint identification is consistent with Hoshi's
[uniqueness theorem for dormant opers of rank $p-1$, Theorem2.1](https://www.cambridge.org/core/journals/nagoya-mathematical-journal/article/note-on-dormant-opers-of-rank-p1-in-characteristic-p/ED7385C2B49B351FF43AD260FFD7D454).
Here the adjunction calculation also constructs the common line
and the isomorphism on the specified source, so endpoint uniqueness
alone is not being used as a substitute for compatibility.

Conversely, $B$ is common-simple in the no-clump case; its common
HN filtration then forces endpoint semistability. Hence $B\otimes L$
is semistable and common-simple. On the genus-two endpoint, putting
$\ell=\deg L$, the top canonical line of $F^*(B\otimes L)$ has
degree $8+5\ell$, while the whole bundle has slope $5+5\ell$.
It is therefore unstable. This proves the converse in (1).

## 5. Degrees and strong semistability

The degree of $B_Y$ is four. Therefore every bundle in (1) has
degree $4+4\deg L_Y$. There is also NO delayed first instability.
Indeed no $B\otimes L$ can have a common connection in the
no-oper branch. To see this without a common theta characteristic,
write its common Atiyah class as
\[
a(B\otimes L)=a(B)+\operatorname{id}_B\otimes a(L).
\]
The Cartier alternating pairing supplies the adjoint involution
and the identity
\[
a(B)+a(B)^\dagger=\operatorname{id}_B\otimes a(\omega).
\]
If the preceding connection class vanished, substituting the
scalar expression for $a(B)$ into this identity would give
\[
\kappa_B:=a(B)-\tfrac12\operatorname{id}_B\otimes a(\omega)=0.
\]
The [intrinsic skew-class detection](common_projective_atiyah_detection.md)
then supplies a common dormant projective oper, a contradiction.
There is no division by the rank of $B$ or unproved injectivity of
a scalar extension-class map in this argument.

At the first unstable step of any common semistable rank-four
bundle, Section4 identifies its semistable antecedent as a twist
of $B$. If that antecedent were already a positive Frobenius
pullback, it would carry its common canonical Cartier connection,
which the preceding paragraph excludes. Therefore the very first
pullback was unstable. This proves the strengthened equivalence
(1), the divisibility by four, and the one-step strong-semistability
test. Ranks two and three use the previous small-rank theorem.

If the original degree is zero, the common line at that last
antecedent has degree minus one. Coefficient twisting transfers
its existence to the original span, giving a degree-one common
line by duality. Conversely any degree-minus-one common line $L$
makes $B\otimes L$ a semistable degree-zero example with unstable
first pullback. This proves (2). The common degree group has
generator $e\mid2$, so its alternatives are precisely $e=1,2$.

## 6. The exact minimum rank in all four branches

Now allow the common oper to exist, while retaining no-clump. A
rank-one bundle is always strongly semistable. If a degree-zero
semistable common rank-two bundle fails strong semistability, its
last semistable antecedent has the oper line constructed in the
small-rank proof. Its genus-two degree is one, from
$2\deg L=5\deg E+2=2$. Thus necessarily $e=1$ as well as a
common oper. Conversely, if these two conditions hold, take the
actual common canonical-determinant Bol bundle $Q$ and a common
line $L$ of degree minus one. Then $Q\otimes L$ is semistable of
degree zero and its first Frobenius pullback is unstable.

When an oper exists but $e=2$, the preceding paragraph excludes
rank two. The common-simple adjoint $\operatorname{End}^0(Q)$
is the rank-three example already constructed in the small-rank
theorem. If no oper exists, ranks two and three are excluded by
that theorem, and Section5 decides rank four exactly by $e=1$.

It remains to supply rank five when there is no oper and $e=2$.
In fact the same example works in every no-clump branch. Put
$T=F_*\omega^{-2}$ on the first twisted endpoints. Its genus-two
degree is zero. If $U\subset T$ is a nonzero common saturated
subbundle of rank $s$, intersect $F^*U$ with the canonical
filtration of $F^*T$. Its line grades are $\omega^{i-2}$ for
$0\le i\le4$. By common saturation each induced grade is zero
or the full line. Cartier transversality, whose indices $1,2,3,4$
are units, forces the nonzero grades to be the first $s$ grades.
Consequently
\[
5\deg U_Y=2\sum_{i=0}^{s-1}(i-2)=s(s-5).
\tag{10}
\]
Integrality forces $5\mid s$, so $s=5$. Thus $T$ is common-simple
and endpoint semistable, since its HN filtration is common. Its
Frobenius pullback contains the positive line $\omega^2$ and is
unstable. Coefficient twisting transfers the example to the original
span. This completes all four entries of the table.

The proof is intrinsic to the actual Frobenius connection, common
saturation, and the matrix calculation (3)--(5). It has no numerical
certificate and no independent audit at this stage. Neither common
degree alternative has been excluded for an arbitrary original span.
