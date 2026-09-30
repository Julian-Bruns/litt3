# Proof: negative Lie degree controls all inseparable descent

[Statement](../../Theorems/deformations/versal_bt_display_descent.md).
The level-two argument is supplied in the returned Pro reply of
20 September2026. We retain it and prove the all-level extension.
Throughout, relative Frobenius twists are retained. The generic
ordinariness is a condition on the group, not on the Jacobian of
the base curve.

## Determinant normalization and generic scalar endomorphisms

For height two and dimension one, the exterior square of a BT$_N$
exists and is height one and dimension one, compatibly with base
change. This is [Hedayatzadeh, Lemma8.3.3](https://arxiv.org/pdf/1009.2460),
including truncated groups. Write
\[
\bigwedge^2 A=\mu_{p^N}\otimes\delta_N(A),\qquad
\chi_A=\delta_N(A)[\delta_1(H)]^{-1}.
\]
Here $\chi_A$ takes values in $1+p\mathbf Z/p^N$. Choose the inverse
of two modulo $p^{N-1}$, and twist $A$ by $\chi_A^{-1/2}$.
Its determinant becomes $[\delta_1(H)]$, and its specified BT1 is
unchanged. At $p=5,N=2$ the exponent is two, exactly as in the reply.
The same operation applies independently on the original endpoints.
If a shorter normalized truncation is fixed, the correction is trivial
on that truncation too.

Set $K=k(C)$. After a finite separable extension, the two ordinary
constituents of $H_K$ are trivialized and its extension is described by
a Kummer class $e\in L^*/L^{*p}$:
\[
0\longrightarrow\mu_p\longrightarrow H_L
\longrightarrow\mathbf Z/p\longrightarrow0.
\]
Its class is nonzero. In the ordinary deformation coordinate the
Kodaira--Spencer map is $d\log e$; a zero Kummer class would give
zero generic Kodaira--Spencer map, contrary to versality. A separable
extension cannot turn a non-$p$th-power into a $p$th-power: any such
root would be purely inseparable over the original field. Thus this
nonsplitting persists over every finite separable extension.

An endomorphism acts on the constituents by $a,b\in\mathbf F_p$.
The relation $(a-b)e=0$ gives $a=b$. An endomorphism zero on both
constituents factors through $\operatorname{Hom}(\mathbf Z/p,\mu_p)$,
whose field-valued points are zero. Consequently
$\operatorname{End}_L(H_L)=\mathbf F_p$ for every finite separable
$L/K$, including before trivializing the constituents.

Now induct on $N$. An endomorphism of $A_L$ restricts to a scalar
on $H_L$. Subtract a scalar lift. The remaining map vanishes on
$A[p]$, so factors through
\[
A\xrightarrow{[p]}A[p^{N-1}].
\]
Its image is killed by $p^{N-1}$ and thus lies in $A[p^{N-1}]$.
By induction the resulting endomorphism of this shorter group is
a scalar. This proves $\operatorname{End}_L(A_L)=\mathbf Z/p^N$.
The factorization is also the one in
[Drinfeld, Section5.4](https://math.nyu.edu/~tschinke/books/MK60/submitted/Drinfeld.pdf).

In particular a marked automorphism is a scalar $u\equiv1\pmod p$,
with determinant $u^2$. Its determinant is one only when $u=1$.
For normalized $A,B$, their BT1 marking prescribes the determinant
comparison. The discrepancy of any marked isomorphism on a connected
cover is a constant in $1+p\mathbf Z/p^N$ and has a unique scalar
square-root correction.

## Separable descent

Let $D\to C$ be finite separable and carry this corrected isomorphism.
On the generic fiber of $D\times_C D$ the two pullbacks agree, by
the preceding uniqueness over each separable field factor. They agree
on the whole fiber product: the finite locally free Hopf coordinate
modules are torsion-free over the smooth base curve, so equality is
checked generically. The cocycle therefore holds, and faithfully flat
descent gives the original marked isomorphism over $C$. No simultaneous
Galois cover is used.

## Frobenius descent of the actual Hopf-algebra map

The infinitesimal automorphisms of a finite locally free commutative
group $M$ are naturally
\[
\operatorname{Lie}\underline{\operatorname{Aut}}(M)
=\operatorname{Lie}(M^\vee)\otimes\operatorname{Lie}(M).
\]
One can see this by writing an infinitesimal endomorphism as a map
from $M$ to the additive tangent space at its identity; additive
characters of $M$ identify with $\operatorname{Lie}(M^\vee)$.
For BT groups the Lie spaces are already determined on $p$-torsion.
The BT version, and its compatibility across levels, also follow
from Drinfeld, Lemma5.3.1 and Section5.4. Versality consequently gives
\[
\operatorname{Lie}\underline{\operatorname{Aut}}(A)=T_C.
\]

For an isomorphism $\alpha:F_D^*M\to F_D^*N$ on a smooth curve,
compare the canonical Cartier connections on the finite locally free
Hopf algebras. Composing their difference with $\alpha^{-1}$ gives a
Hopf derivation, hence the actual obstruction
\[
\operatorname{ob}_F(\alpha)\in
H^0\bigl(D,\omega_D\otimes
\operatorname{Lie}\underline{\operatorname{Aut}}(F_D^*M)\bigr).
\]
It vanishes exactly when the algebra map is horizontal. Cartier descent
then descends the algebra map and all of its Hopf identities. Thus
this is a criterion for descent of the group isomorphism itself.

Factor a finite cover through its maximal separable intermediate curve
$D_s\to C$, of degree $d$ and different degree $r$. Its purely
inseparable part is an iterate of relative Frobenius after the
appropriate coefficient twists. Put $c=\deg\omega_C$. At the step
with $j\ge1$ remaining Frobenius powers, the obstruction line has degree
\[
\deg\omega_{D_s}-p^jdc
=r-(p^j-1)dc.
\]
If $r<(p-1)dc$, this is negative at every step. Each obstruction
therefore vanishes, and the isomorphism descends to $D_s$. Separable
descent finishes the proof. This calculation does not depend on $N$.

On the original source $Z$, $c=2m$ in characteristic five. The
common supersingular divisor has degree $4m$. Tame ramification
supported there has different degree at most $4dm$, giving the
announced strict bound. A generic isomorphism alone is insufficient:
it must extend over the proper finite cover before this argument applies.

## Every truncated display isomorphism lifts uniquely

Lau's truncated display morphism is a gerbe banded by a finite flat
commutative group of order $p^{N d(h-d)}$, killed by the $N$th
relative Frobenius. Here $h=2,d=1$, so its order is $p^N$.
Use [Lau, TheoremB and Remark4.8](https://arxiv.org/abs/1006.2723),
or Drinfeld, Theorem1.1.1. This is an all-level statement.

For a specified display isomorphism $\beta:\phi_N(A)\simeq\phi_N(B)$,
its group-scheme lifts form a torsor under this infinitesimal band.
The torsor is finite flat radicial over $C$. Normalize its reduction;
the resulting smooth proper curve is finite purely inseparable over
$C$ and carries the tautological isomorphism. The preceding descent
argument has $d=1,r=0$, so descends that isomorphism to $C$.
It lies over $\beta$, as may be checked after the faithfully flat
cover. An infinitesimal group has no nonidentity section on a reduced
base, giving uniqueness. Applying the same fact at level one retains
any prescribed compatible marking.

This proves full faithfulness on isomorphism groupoids, not essential
surjectivity for displays. In particular it neither neutralizes every
global display gerbe nor constructs the next display. For the actual
two-map problem the outstanding object is still a choice of endpoint
level-two displays with a comparison extending the given level-one data.
