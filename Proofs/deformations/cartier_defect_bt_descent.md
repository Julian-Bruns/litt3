# Proof: trace correction preserves the prescribed upstairs object

[Statement](../../Theorems/deformations/cartier_defect_bt_descent.md).
This is local continuation of the returned realization theorem,
using its all-level extension. No independent audit is claimed.

## Trace on the actual Cartier spaces

At a supersingular point the cover is etale. Taking the trace of
a function with at most simple poles produces at most a simple pole
on the base. Elsewhere it preserves regularity. Cartier commutes
with separable trace on differentials, and the logarithmic form on
$D$ is the pullback of that on $C$, after the common character cover.
Consequently
\[
C\bigl(\operatorname{Tr}_q(h)\Omega_C\bigr)
=\operatorname{Tr}_q\bigl(C(h\,q^*\Omega_C)\bigr)=0
\tag{6}
\]
for $h\in K_D$. One can verify this identity after a separable normal
closure by summing the distinct field embeddings; no division by
its degree is needed. Since $\operatorname{Tr}_q q^*=d$, formula(1)
follows. In this formula $d^{-1}$ is in $\mathbf F_5^*$.

By [prime-to-five existence descent](prime_to_five_bt_extension_descent.md),
the given $B$ supplies some next extension $A$ downstairs, retaining
the complete BT$_N$ marking after determinant normalization. Set
$h=\Delta_N(q^*A,B)$. Changing $A$ by $a\in K_C$ changes $h$
by $-q^*a$, so (3) is independent of the choice.

If (3) vanishes, set $a=d^{-1}\operatorname{Tr}_q h$.
[Exact realization](versal_bt_cartier_realization.md) gives an actual
next extension $A'$ with $\Delta_N(A,A')=a$. Then
\[
\Delta_N(q^*A',B)=h-q^*a=0.
\tag{7}
\]
The actual marked normalized groups are isomorphic, by the all-level
comparison theorem. Conversely a descended extension provides a
choice with $h=0$. Uniqueness of a descended object with its marked
upstairs comparison follows either by finite flat descent or by
injectivity of pullback of the difference function.

## Descending a full tower without changing its upper terms

If $\dim K_D=\dim K_C$, injective pullback and (1) give
$K_{D/C}=0$. Start with the specified $H$ and comparison
$q^*H\simeq G_D[5]$. Suppose $A_N$ and
$q^*A_N\simeq G_D[5^N]$ have been constructed. Regard
$G_D[5^{N+1}]$ as a next extension via this exact comparison.
Equations(3)--(7) descend it to $A_{N+1}$, preserving the previous
whole marked level. The resulting inclusions and multiplication maps
form a full Barsotti--Tate group. Its pullback is the SPECIFIED $G_D$.
This induction would be invalid with existence descent alone; the
realized Cartier correction (7) is what retains the upper object.

## The two actual covering maps

For a supplied common admissible active oper, use
[common BT1 realization](common_admissible_bt1.md). On the original
$Z$ it gives
\[
f^*H_X\simeq g^*H_Y\otimes\Lambda,
\tag{8}
\]
where $\Lambda$ has order dividing four, and $H_Y=G_Y[5]$ for an
actual normalized full group on $Y$. Lift $\Lambda$ by its finite
Teichmuller character and put
\[
G_Z=g^*G_Y\otimes[\Lambda].
\tag{9}
\]
This is a full group on the original source with first level $f^*H_X$.
The finite character twist changes neither the projective oper nor
its logarithmic character: the constituent character is multiplied
by $\Lambda$ and the determinant by $\Lambda^2$, which cancel in
the logarithmic character $\chi^2\delta^{-1}$. Thus the spaces in
(4) are exactly those for (9) and $H_X$.

Apply full prescribed descent to $f$ to obtain $G_X$ with
$f^*G_X\simeq G_Z$. A connected source refinement of degree1,2 or4
trivializes $\Lambda$ and hence its finite Teichmuller lift. On this
refined source the full groups from the two ORIGINAL endpoints agree.
[Compatible full-group lifting](compatible_bt_lifting.md) gives a
simultaneous mixed-characteristic lift and removes the source
refinement. No simultaneous Galois closure was used. This proves(4)
and its contrapositive(5).

## Principal parts and the arbitrary-degree descent test

On a proper connected curve, a function in $K_H$ with no poles is
constant. Cartier gives $C(a\Omega)=a^{1/5}\Omega$, so that constant
must be zero. Thus its principal parts at $S$ detect the whole function.

For any finite etale $q$ and a given marked normalized next extension
$B/D$, take its two pullbacks to $R=D\times_C D$ with their induced
common lower-level marking. On every connected component, their
difference belongs to the Cartier kernel of that proper curve.
It is zero exactly when its simple-pole parts vanish. If they vanish,
the unique marked normalized isomorphism exists on $R$; uniqueness
forces its cocycle on the triple product. Faithfully flat descent
of the finite locally free Hopf algebras gives the specified object
on $C$. Conversely descent makes that difference zero.

In a common completed supersingular coordinate, realize the two
objects relative to the same local reference by parameters $j_1,j_2$
from the exact window family. Their polar difference is
\[
2\bigl(j_2(0)-j_1(0)\bigr)t^{-1}.
\tag{10}
\]
The vanishing of this principal part is coordinate-independent.
Thus the criterion is a finite matching condition on these local
last-digit values. It is not an automatic matching theorem.
