# Proof: all ample common extensions come from a bounded Cartier height

[Statement](../../Theorems/cartier_and_spin/common_cartier_extension_trace.md).
Work over $\overline{\mathbf F}_p$, $p$ odd, on the actual coreless
no-clump span, with $p\nmid g(Y)-1$. Every construction retains its
specified source comparison and relative coefficient twists.

## 1. Common cohomology and exact adjunction

The no-clump hypothesis makes common images saturated: their determinant
defects are common effective divisors and must vanish. Thus common
kernels and cokernels are vector bundles. Gluing endpoint extensions,
including their comparison on the original source, gives
\[
\begin{split}
H^0(X,M_X)\oplus H^0(Y,M_Y)&\longrightarrow H^0(Z,M_Z)
\longrightarrow\operatorname{Ext}^1_{\rm common}(\mathcal O,M)\\
&\longrightarrow H^1(X,M_X)\oplus H^1(Y,M_Y)
\xrightarrow{f^*-g^*}H^1(Z,M_Z).
\end{split}
\tag{1}
\]
Indeed the endpoint pullbacks admit a comparison precisely when their
extension classes agree; its choices differ by $H^0(Z,M_Z)$, modulo
endpoint extension automorphisms.

For any finite etale $h:D\to C$, the quotient
$h_*\mathcal O_D/\mathcal O_C$ becomes trivial on a normal closure
over THIS endpoint, even when $p$ divides the degree. If $M$ has
no sections after any finite etale pullback, its tensor product
with this quotient has none. The unit sequence therefore makes
$H^1(C,M)\to H^1(D,h^*M)$ injective. We use this for negative
strongly semistable bundles and duals of ample bundles.

Frobenius pullback and finite direct image are exact adjoint
functors on the common triples, by etale base change. Their
degree-one Yoneda adjunction uses pullback and pushout by the
counit, or pushforward and pullback by the unit. The triangle
identities make these constructions inverse. All scalar
Frobenius twists are retained.

## 2. Strongly semistable positive coefficients in every rank

Let $E$ be common strongly semistable with $\mu(E_Y)>0$.
The later [all-slope no-clump coefficient theorem](../shared_tensors/common_finite_coefficients.md)
gives $\operatorname{Hom}_{\rm common}(E,B_s)=0$ at every height.
The Frobenius unit sequence and Section1's exact adjunction
therefore make
\[
F^{[s]*}:\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\longrightarrow
\operatorname{Ext}^1_{\rm common}(F^{[s]*}E,\mathcal O)
\tag{2}
\]
injective for every $s\ge1$. A nonzero class cannot disappear
under Frobenius.

Represent a class by
$0\to\mathcal O\to M\to E\to0$.
By [Langer's strong HN theorem, Theorem5.1 for GL and its cited vector-bundle Theorem2.7](https://arxiv.org/pdf/math/0312260),
one Frobenius pullback makes every HN grade of $M$ strongly
semistable on both endpoints. These filtrations are common because
HN commutes with the actual etale maps. Write $M',E'$ for this
pullback, with $\mu(E'_Y)>0$.

Let $K$ be the first HN term of $M'$. Its slope is positive,
since $\deg M'=\deg E'>0$. The map $K\to E'$ is nonzero:
a positive semistable bundle has no map to $\mathcal O$.
Its kernel lies in $\mathcal O$. But every nonzero common
saturated subbundle of the strongly semistable $K$ has slope
$\mu(K)>0$, by [quotient rigidity](../shared_tensors/common_finite_coefficients.md).
A line inside $\mathcal O$ has nonpositive degree. Thus this
kernel is zero.

The image $I$ is saturated in $E'$ because there is no clump.
Quotient rigidity on $K$ and on $E'$ gives
$\mu(I)=\mu(K)=\mu(E')$ and makes $E'/I$ strongly semistable.
If $I\ne E'$, the common exact sequence
\[
0\longrightarrow\mathcal O\longrightarrow M'/K
\longrightarrow E'/I\longrightarrow0
\tag{3}
\]
has positive degree. Its first HN grade $K_2$ is strongly
semistable and has slope $0<\mu(K_2)<\mu(K)=\mu(E')$.
Its map to $E'/I$ is nonzero, since it cannot lie in
$\mathcal O$. This contradicts the no-clump vanishing of
common morphisms between strongly semistable bundles of
different slopes.

Therefore $I=E'$, and $K\to E'$ splits the Frobenius-pulled
extension. Injectivity (2) makes the original class zero.
This proves the positive strongly semistable vanishing using
only the original common HN filtration; no endpoint or source
refinement is needed.

## 3. All ample coefficients reduce to a bounded Cartier height

Let $E$ be any common bundle ample on the endpoints. By
[Langer's strong HN theorem, Theorem5.1 for GL and the cited vector-bundle Theorem2.7](https://arxiv.org/pdf/math/0312260),
one common Frobenius pullback $F^{[a]*}E$ has strongly semistable
HN grades on both endpoints. These filtrations and grades are
common, since HN commutes with the two etale maps. The last grade
is a quotient of an ample bundle, hence has positive degree. All
earlier slopes are larger, so every grade has positive slope.
Section2 and the extension long exact sequences consequently give
\[
\operatorname{Ext}^1_{\rm common}(F^{[s]*}E,\mathcal O)=0
\quad\text{for every }s\ge a.
\tag{4}
\]
Also $\operatorname{Hom}(F^{[s]*}E,\mathcal O)=0$ on each
endpoint: a nonzero image would be a nonpositive line quotient
of an ample bundle. Fix the target span here and let the sources
of $F^{[s]}$ be its inverse relative twists. Exact adjunction and
the unit sequence then identify
\[
\operatorname{Hom}_{\rm common}(E,B_s)
\xrightarrow{\sim}\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\quad(s\ge a).
\tag{5}
\]

This height can be bounded by the RANK, without any effective bound
on Langer's exponent. Take $s$ at least both $a$ and
$h=\lfloor\log_p(\operatorname{rk}E+1)\rfloor$. The image of
any common map $E\to B_s$ is saturated and hence is precisely
one of the canonical $P_j\subset B_s$. Its rank is $p^j-1$,
so $j\le h$. On this fixed target $P_j$ IS the bundle $B_j$
from the corresponding inverse twist. The inverse image of $P_j$
in $A_s$ is exactly its intermediate subalgebra $A_j$. Thus the
boundary in (5) is the pullback of the canonical extension for
$B_j$, along the actual surjection $E\twoheadrightarrow B_j$.
It already comes from the boundary map at height $h$.

That boundary is injective, since
$\operatorname{Hom}(E,A_h)=\operatorname{Hom}(F^{[h]*}E,\mathcal O)=0$.
This proves the boundary isomorphism, including $h=0$, where every
map in (5) must have zero image. Frobenius pullback by the indicated
height kills each canonical extension by evaluation; hence it kills
every extension class represented in (5).

If $E$ is common-simple and the class is nonzero, the map
$E\to B_s$ is injective as well. Its image $P_j$ can be simple
only for $j=1$. It follows that $E\simeq B_1$ with its actual
comparison. Conversely $B_1$ is ample: its first Frobenius
pullback has positive canonical-line grades, and ampleness descends
through finite surjective maps. The higher Cartier lattice gives
$\operatorname{End}_{\rm common}(B_1)=k$, so the proved boundary
isomorphism gives its nonzero canonical line.

## 4. The canonical extensions and their exact trace hyperplanes

Put $q=p^r$. Evaluation splits the constant summand of
$F^{[r]*}A_r$; the remaining augmentation ideal has diagonal
grades $\omega,\ldots,\omega^{q-1}$. Thus $F^{[r]*}B_r$ is
ample, and so is $B_r$, by finite-surjective descent of ampleness.
Apply Section3 with $d=q-1$ and $h=r$:
\[
\operatorname{Ext}^1_{\rm common}(B_r,\mathcal O)
\simeq\operatorname{End}_{\rm common}(B_r)=k.
\tag{6}
\]
The scalar endomorphism assertion is exactly the interval-morphism
part of the [higher Cartier lattice](higher_cartier_common_filtration.md).
The boundary sends the identity to the actual unit extension
$0\to\mathcal O\to A_r\to B_r\to0$.

The positive diagonal filtration also gives $H^0(B_r^\vee)=0$
after every finite etale pullback. Section1 therefore makes both
endpoint pullbacks on $H^1(B_r^\vee)$ injective, and (1) identifies
their intersection with the common line spanned by $e_{r,Z}$.
The unit extension is nonsplit on each endpoint separately:
\[
\operatorname{Hom}(B_{r,C},A_{r,C})
=\operatorname{Hom}(F_C^{[r]*}B_{r,C},\mathcal O_C)=0.
\]
Hence the endpoint Serre functionals $\lambda_{r,C}$ are nonzero.
The transpose of $f^*-g^*$ is
$(\operatorname{Tr}_f,-\operatorname{Tr}_g)$. Its image annihilates
exactly $(e_{r,X},e_{r,Y})$, proving the stated equality
$\lambda_{r,X}(s_X)=\lambda_{r,Y}(s_Y)$ and cokernel dimension one.

Riemann--Roch gives
\[
h^0(C,B_{r,C}\omega_C)=2(q-1)(g(C)-1).
\tag{7}
\]
Thus the joint trace rank is
$2(q-1)(g(X)+g(Y)-2)-1$, including $18(q-1)-1$ for genera
nine and two.

## 5. A sharp rank bound for the actual joint trace defect

Let $E$ be common ample of rank $d$, and let $m_B(E)$ be the
multiplicity of the ACTUAL common simple bundle $B_1$ in a
Jordan--Holder series of $E$. Such a series exists: every proper
common subobject has strictly smaller positive rank. Its multiplicities
are intrinsic in this abelian finite-length category.

For $h\ge1$, the canonical image lattice shows that $B_h$ has unique simple
socle $B_1$, with scalar endomorphisms. Thus for every common
simple $S$,
\[
\dim\operatorname{Hom}_{\rm common}(S,B_h)=
\begin{cases}1,&S\simeq B_1,\\0,&S\not\simeq B_1.\end{cases}
\tag{8}
\]
Apply the left-exact functor $\operatorname{Hom}(-,B_h)$
successively to a composition series. Section3 gives
\[
\dim\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\le m_B(E)\le\lfloor d/(p-1)\rfloor.
\tag{9}
\]
The case $h=0$ follows directly from the height-zero boundary formula.

For an ample bundle, $H^0(E^\vee)$ vanishes after every finite
etale pullback. Using a one-endpoint normal closure to trivialize
$h_*\mathcal O/\mathcal O$, as in Section1, therefore proves
injectivity of each endpoint map on $H^1(E^\vee)$. The gluing
sequence (1) identifies the kernel of their difference with the
common extension group in (9). Serre duality then identifies
that dimension with the cokernel dimension of the ACTUAL joint
trace on $E\omega$.

The bound is sharp for every $d\ge1$. Write $d=(p-1)a+b$ with
$0\le b<p-1$, and take the common ample bundle
\[
E=B_1^{\oplus a}\oplus\omega^{\oplus b}.
\tag{10}
\]
Sections2 and4 give $a$ independent canonical extension classes
and no contribution from the canonical-line summands. For $d=(p-1)a$,
equality in (9) characterizes $E\simeq B_1^{\oplus a}$.
Indeed equality forces all composition factors to be $B_1$;
then every map $E\to B_h$ has image contained in $B_1$, since
all the other canonical factors of $B_h$ have larger rank and
are different simple objects. Consequently equality means
$\dim\operatorname{Hom}(E,B_1)=a$. Successively choosing
independent quotient maps shows that $E\to B_1^{\oplus a}$
is surjective: a proper image would have a nonzero map from
the semisimple quotient to $B_1$, giving a linear dependence.
The ranks agree, so this is an isomorphism.

For general endpoint genera, put
$t=\deg E_Y/(g(Y)-1)=\deg E_X/(g(X)-1)$.
Riemann--Roch and $H^0(E_C^\vee)=0$ give joint target dimension
\[
(g(X)+g(Y)-2)(t+d).
\tag{11}
\]
Subtracting the defect bound gives the stated trace rank. For the
fixed genera nine and two this is
$9(\deg E_Y+d)-\lfloor d/(p-1)\rfloor$.

## 6. The retained rank-four and tensor corollaries

Specialize to $p=5$, $g(Y)=2$, with no common regular projective
connection. The [low-rank classification](low_rank_common_frobenius_instability.md)
make a positive semistable common coefficient of rank at most four
either strongly semistable or the common-simple $B_1\otimes L$.
In the latter case positivity gives $\deg L_Y\ge0$, so it is ample.
Section2 handles the former case; Section3's simple-ample criterion
handles the latter. The only nonzero extension group is the
canonical line for an actual common isomorphism $E\simeq B_1$.
This recovers the earlier classification without another filtration
and adjunction calculation.

Return to the general odd-characteristic hypotheses. Fix $m\ge2$.
Every quotient $E$ of $B_1^{\otimes m}$ is
ample: tensor products and quotient bundles preserve ampleness
on a proper curve. Section3 reduces its common extension group
to maps $E\to B_h$. If one of these is nonzero, its actual image
is some $B_j$, so it gives a common surjection
\[
B_1^{\otimes m}\twoheadrightarrow B_j,\qquad j\ge1.
\tag{12}
\]
Pull this surjection back through $j$ relative Frobenius steps.
The source has a filtration by canonical lines whose exponents
range from $mp^{j-1}$ to $(p-1)mp^{j-1}$. They are all at least
two. The target $F^{[j]*}B_j$ is the augmentation ideal of
the Frobenius diagonal algebra and has its canonical quotient
\[
F^{[j]*}B_j\twoheadrightarrow I/I^2\simeq\omega.
\tag{13}
\]
No source grade admits a nonzero morphism to $\omega$, even
on either endpoint separately, by positivity of the difference
of their degrees. A filtration induction therefore makes the
composite of (12) and (13) zero. That contradicts its being
surjective. Hence the common Hom group and the extension group
are zero. This proves the tensor-quotient vanishing without asserting that
these tensor powers are semistable; some are not.

The bounded-height and sharp-defect arguments retain their
[original ample-extension audit](../../Research/audits/COMMON_AMPLE_EXTENSIONS_AUDIT_2026_09_21.md).
The shorter positive strongly semistable proof, general scope and
final integration passed a
[focused independent review](../../Research/audits/COMMON_CARTIER_EXTENSION_GENERAL_SCOPE_AUDIT_2026_10_03.md).
They use the later quotient-rigidity/no-clump theorem and the general
odd-characteristic higher Cartier lattice. The rank-four
specialization retains its separately recorded author inputs.
