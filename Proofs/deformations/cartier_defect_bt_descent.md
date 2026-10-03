# Proof: the absolute class supplies existence, trace supplies prescribed descent

[Statement](../../Theorems/deformations/cartier_defect_bt_descent.md).
Use the later absolute torsor and exact Cartier classification;
both preserve actual groups and the full lower-level marking.

## The absolute class and its relative difference space

The [absolute extension torsor](versal_bt_extension_torsor.md)
commutes with actual etale pullback. Its Cartier bundle admits
coherent trace, with $\operatorname{Tr}_q q^*=d$ on cohomology.
The supplied next extension $B$ gives $q^*e_N(A_N)=0$.
Since $d$ is invertible, $e_N(A_N)=0$: an actual normalized
marked next extension $A$ exists on the original curve.

Cartier commutes with the same pullback and trace. Thus
$\operatorname{Tr}_q:K_D\to K_C$ and
$\operatorname{Tr}_q q^*=d$ give the stated direct sum.
Set $h=\Delta_N(q^*A,B)$. Changing $A$ by $a\in K_C$
changes $h$ by $-q^*a$, leaving
$h-d^{-1}q^*\operatorname{Tr}_q h$ unchanged.
The actual upstairs fiber is a $K_D$-torsor. Therefore this
projection is onto $K_{D/C}$ and gives its exact dimension.

If $r_q(B)=0$, set $a=d^{-1}\operatorname{Tr}_q h$.
[Exact realization](versal_bt_cartier_realization.md) gives an actual
next extension $A'$ with $\Delta_N(A,A')=a$. Then
\[
\Delta_N(q^*A',B)=h-q^*a=0.
\tag{1}
\]
The actual marked normalized groups are isomorphic, by the all-level
comparison theorem. Conversely a descended extension provides a
choice with $h=0$. Uniqueness of a descended object with its marked
upstairs comparison follows either by finite flat descent or by
injectivity of pullback of the difference function.

## Descending a full tower without changing its upper terms

If $\dim K_D=\dim K_C$, injective pullback and the trace decomposition give
$K_{D/C}=0$. Start with the specified $H$ and comparison
$q^*H\simeq G_D[5]$. Suppose $A_N$ and
$q^*A_N\simeq G_D[5^N]$ have been constructed. Regard
$G_D[5^{N+1}]$ as a next extension via this exact comparison.
The trace correction descends it to $A_{N+1}$, preserving the previous
whole marked level. The resulting inclusions and multiplication maps
form a full Barsotti--Tate group. Its pullback is the SPECIFIED $G_D$.
This induction would be invalid with existence descent alone; the
realized Cartier correction (1) is what retains the upper object.

For arbitrary degree with $K_D=0$, injective pullback on functions
gives $K_C=0$. The ordinary absolute torsor constructs the unique
next extension of every supplied normalized $A_N$ on $C$.
Its pullback and the specified upper extension agree because their
difference lies in $K_D=0$. Induction preserves the given full tower.
This uses neither a normalized trace nor a Galois closure.

## The two actual covering maps

For a supplied common admissible active oper, use
[common BT1 realization](common_admissible_bt1.md). On the original
$Z$ it gives
\[
f^*H_X\simeq g^*H_Y\otimes\Lambda,
\tag{2}
\]
where $\Lambda$ has order dividing four, and $H_Y=G_Y[5]$ for an
actual normalized full group on $Y$. Lift $\Lambda$ by its finite
Teichmuller character and put
\[
G_Z=g^*G_Y\otimes[\Lambda].
\tag{3}
\]
This is a full group on the original source with first level $f^*H_X$.
The finite character twist changes neither the projective oper nor
its logarithmic character: the constituent character is multiplied
by $\Lambda$ and the determinant by $\Lambda^2$, which cancel in
the logarithmic character $\chi^2\delta^{-1}$. Thus the indigenous Cartier spaces are unchanged.

Apply either the prime-to-five equal-defect criterion or the
arbitrary-degree zero-source-kernel criterion to $f$. Both give
$G_X$ with
$f^*G_X\simeq G_Z$. A connected source refinement of degree1,2 or4
trivializes $\Lambda$ and hence its finite Teichmuller lift. On this
refined source the full groups from the two ORIGINAL endpoints agree.
[Compatible full-group lifting](compatible_bt_lifting.md) gives a
simultaneous mixed-characteristic lift and removes the source
refinement. No simultaneous Galois closure was used. This proves the lift
criterion and its stated necessary conditions for nonliftability.

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
\tag{4}
\]
The vanishing of this principal part is coordinate-independent.
Thus the criterion is a finite matching condition on these local
last-digit values. It is not an automatic matching theorem.
