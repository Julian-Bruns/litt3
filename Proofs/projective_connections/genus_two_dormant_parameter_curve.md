# Proof: a quadratic transformation of the universal quintic

[Statement](../../Theorems/projective_connections/genus_two_dormant_parameter_curve.md).

## 1. The smooth normalization and its degree-five map

Write P_t(T)=2 Psi_t(T), the monic polynomial of the
[universal dormant theorem](genus_two_dormant_quintic.md).
Put s=T-3t+1. Direct substitution gives
\[
P_t(3t-1+s)
=-s^3t^2+(s^4-2s^3+1)t+(s^5+s^4-s^3-s+1).
\]
The discriminant of this quadratic in t is
\[
(s^4-2s^3+1)^2
 +4s^3(s^5+s^4-s^3-s+1)=1+3s^4.
\]
Thus w=-2s^3t+s^4-2s^3+1 and the stated inverse formulas
identify the two function fields. The quartic has four distinct
geometric roots, so its double cover of the s-line is smooth of
genus one after projective normalization and is geometrically
connected. It has the rational point (s,w)=(0,1).

The poles of t give its degree without a resultant or a function-field
genus algorithm. At (0,-1) the numerator is a unit and s is a local
parameter, so the pole has order three. At each of the two geometric
points above s=infinity, w has pole order two and s has pole order
one; the displayed t has pole order one. At (0,1) its numerator
vanishes to order at least three, so there is no pole. Hence the
degree is five, and the infinity fiber has type (3,1,1). In particular
the map is separable, since a purely inseparable degree-five map
would have ramification index five everywhere. Its three poles
have tame indices.

The original monic quintic is therefore irreducible even over
bar(F5)(t). Its affine algebra is finite étale away from
0,1,2,3, by the exact discriminant
\[
\operatorname{Disc}_T(P_t)
=-[t(t-1)(t-2)(t-3)]^2.
\]
Here P is monic, so its resultant with its derivative equals this
discriminant even though characteristic five lowers the derivative
degree. Each of the four exceptional finite fibers factors as
one linear factor cubed times a separable quadratic. At its triple
point the partial derivative with respect to t is nonzero. Thus
the total curve is smooth there and t-a has order three. These
fibers again have type (3,1,1), all tame. There is no other
ramification. The five contributions of two also recover genus one
from Riemann--Hurwitz.

The [short checker](../../scripts/genus_two/check_dormant_parameter_curve.py)
verifies both birational identities, the resultant, all finite
factorizations and the nonzero parameter derivatives. Its
[receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/dormant_parameter_curve.json)
retains exact coefficients and source hash. The smooth quartic and
pole calculation prove the normalization; no numerical genus output
is required.

## 2. Arithmetic and geometric monodromy

The discriminant is a square already in F5(t), since -1=4.
Thus both monodromy groups lie in A5. Geometric connectedness makes
the geometric group transitive on five letters, hence its order
divisible by five. Tame inertia at any branch point is a 3-cycle,
so its order is also divisible by three. A subgroup of A5 with
order divisible by15 has order15,30 or60. Order15 would have a
normal Sylow5 subgroup, whose normalizer in A5 has order10.
Order30 would give an index-two quotient of A5, impossible because
3-cycles generate A5. Hence the geometric group is A5. The arithmetic
group lies between it and A5 and is therefore the same. In particular,
the Galois closure has no enlarged constant field.

Its inertia groups all have order three; taking the Galois closure
introduces no wild inertia. Riemann--Hurwitz gives
\[
2g-2=60\left(-2+5\left(1-\frac13\right)\right)=80.
\]
Thus g=41.

## 3. Verschiebung gives a much smaller connection equation

On the quartic normalization use (0,1) as origin. The formulas
\[
x=2(w+1)/s^2,\quad y=4(w+1)/s^3,\qquad
s=2x/y,\quad w=(x^2-3)/(x^2+3)
\]
give inverse birational maps to E_0:y^2=x^3+3x. Both curves are
smooth and projective, so the maps extend to an isomorphism. The
origin goes to the point at infinity. Substitution in t gives
\[
z=(t+1)^{-1}=xy/(2x^2+3).
\]
The five poles of z are the origin and the four points with x=1
or -1. They are simple and rational over F5.

The curve E_0 has ten F5-points, hence Frobenius trace -4 and
Verschiebung V=[-4]-pi. It has degree5, is separable, and its
invariant differential multiplier is one. The multiplication-by-five
formula has x-coordinate
\[
x([5]P)=\frac{x^{25}+2x^{15}+x^5}{x^{20}+3x^{10}+1}.
\]
Taking its rational fifth root gives the stated V_x. The choice
V_y=V_x'(x)y has differential multiplier one, fixing the possible
sign. In particular V is the actual dual isogeny, and its kernel
consists of the five poles of z. A direct rational-function identity
then gives
\[
z^5-z=3V_xV_y,\qquad
(z^5-z)^4=V_x^6(V_x^2+3)^2.
\]
These identities, including the elliptic equation for (V_x,V_y)
and the multiplication-by-five formula, are checked symbolically in
the [isogeny checker](../../scripts/genus_two/check_dormant_isogeny_quotient.py).
Its [receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/dormant_isogeny_quotient.json)
records the small rational functions and exact identities.

We must check that U=V_x^2 retains the connection, rather than
merely defining another degree-five cover. Write a=z^5-z. From U
and a recover the two coordinates on the target of V by
\[
V_x=\frac{a^2}{4U(U+3)},\qquad V_y=\frac{a}{3V_x}.
\]
Thus k(z,U) contains V^*k(E_0). The latter has prime index5 in
k(E_0). Moreover z does not belong to it: otherwise the degree-five
map z would factor through V with a degree-one map E_0 to P1,
impossible for a genus-one curve. Consequently k(z,U)=k(E_0).
Since [k(E_0):k(z)]=5, the polynomial U^3(U+3)^2-(z^5-z)^4
is the complete generic connection equation.

This identification extends over EVERY ordinary smooth parameter.
Here A is nonzero; the new monic quintic has discriminant -A^3, so
its scheme is finite étale. The original dormant scheme is also
finite étale on this open set by the original discriminant identity.
The function U has poles only above t=4, which has been removed.
It therefore gives a morphism of these finite étale covers, which
is an isomorphism because it is an isomorphism generically. This
also establishes the statement over every field of definition.

## 4. Two torsion orbits determine the whole first-height incidence

The [affine branch-family symmetry](../../Theorems/curve_arithmetic/prime_field_branch_family.md)
applies to this intrinsic section problem. In the coordinate
$1/(u+1)$ the five fixed branch points are $\mathbf F_5$ and the
moving point is $z$. The affine group $G=\mathbf F_5\rtimes\mathbf F_5^\times$
has two orbits on nonzero two-torsion: moving--fixed pairs (five labels)
and fixed--fixed pairs (ten). Representatives are $R=u-t$ and
$R=u(u-1)$. Coordinate changes preserve the actual dormant bundle
and permute its twists; the hyperelliptic choice of sign has no effect.

Here is the complete representative calculation, including the trivial
twist. Write $F=\sum a_j u^j$ and
\[
c=T^2+3a_4T+3a_3,\quad d=-a_2+(a_4+2T)c,\quad
N=2u^3+Tu^2+cu+d.
\]
The dormant equation is $\Psi=2a_0-2a_1T+a_2c-dc=0$.
For $M=R$ or $F/R$, all twisted quadratic coefficients are
$q=\sqrt M\,h/F$, with $\deg h\le\lfloor(4-\deg M)/2\rfloor$.
The [intrinsic Bol complex](dormant_bol_complex.md), tensored by
$N=\Theta\tau$ with $\Theta^2=\omega$ and $W=V_r\Theta^{-1}$,
identifies $H^0(V_r\tau)$ with the scalar kernel on $\omega^2\tau$,
since $\tau^5=\tau$. The [polynomial dictionary](../deformations/genus_two_pointed_polynomial_test.md)
gives its full basis above. Thus sections are exactly $q''=r_Tq$. In characteristic five it reduces to
\[
Fh''-J_Mh'-N_Mh=0,\qquad
J_M=M'S+2MS',\quad N_M=N+M'S'-\tfrac12 SM'',\quad S=F/M.
\]
The apparent $(M')^2$ term has coefficient $5/4$ and vanishes.
For either representative $M=R$, a nonzero solution must have
$h=u-b$, with $b=T+2t$ for $R=u-t$ and $b=3(T+t)$ for $R=u(u-1)$.
For $M=F/R$ it must be constant. For the trivial twist only $M=1$
contributes, with $\deg h\le2$.

Substitution and polynomial division give the following complete
geometric solutions on $t(t-1)(t-2)(t-3)\ne0$:

| Torsion representative | $M=R$, linear $h$ | $M=F/R$, constant $h$ |
| --- | --- | --- |
| $u-t$ | none | $t=4,\ T=1$ |
| $u(u-1)$ | $g(t)=0,\ T=H(t)$ | $t=4,\ T=2$ |

The trivial-twist coefficient matrix has rank three everywhere on this
open set. Here
\[
g=(t^3+2t+4)(t^3+3t^2+2t+3),\qquad
H=t^5+t^4+3t^3+3t^2+2t.
\]
Both cubic factors are irreducible and distinct. For a precise check of
completeness, saturating the coefficient ideals together with $\Psi$ by
$t(t-1)(t-2)(t-3)$ gives respectively
$(1)$, $(T+t,(t+1)^2)$, $(T-H,g)$ and $(T-2,t+1)$;
the saturated maximal-minor ideal for the trivial twist is $(1)$.
These are small polynomial identities, including the exceptional
nonreduced ideal, rather than a search over connection fibers.
Each nonzero section space in the table is one-dimensional.

The connection curve carries exactly this affine action.
Translations by $\ker V$ give $z\mapsto z+b$: the identity
$z^5-z=3V_xV_y$ makes the difference an $\mathbf F_5$ constant,
and it is nonzero for every nonidentity translation, since otherwise
$z$ would factor through $V$ and a degree-one map from an elliptic
curve to $\mathbf P^1$. The automorphism $(x,y)\mapsto(-x,2y)$
scales $z$ by3. These generate all $G$, preserve $U=V_x^2$ and
lift the same coordinate changes as the intrinsic connection action.
The lifts agree because the degree-five cover has no nontrivial deck
automorphism: such an automorphism would make it cyclic Galois,
contrary to its geometric monodromy $A_5$.

In $\mathbf F_5[t]/(g)$ the representative solutions give
\[
U=3t^5+3t^4+t^3+2t^2+t+4,\qquad
A=4t^5+2t^4+t+2.
\]
Their minimal polynomials are respectively
$D(U)=U^3+4U^2+3U+4$ and $Q(A)=A^3+3A^2+4$.
Thus the six seeds contain all three $U$-values. Each generates a
twenty-point $G$-orbit, since an ordinary $z\notin\mathbf F_5$ has
trivial affine stabilizer. Distinct $U$-values give distinct orbits,
so at least sixty ordinary points have incidence. The ten fixed--fixed
labels, each with exactly six solutions, give at most sixty incidences.
Consequently these are all the ordinary points, each in exactly one
twist with a one-dimensional section space. They are precisely
$D(V_x^2)=0$: its three roots avoid the branch values0,2 of $x^2$,
so its pullback by the separable degree-five $V$ has sixty points.

Moreover $A=3(U^2+U+1)$ modulo $D$ has the irreducible minimal polynomial
$Q$, hence its three values are distinct. Each affine orbit therefore
lies above a distinct twenty-point parameter orbit. This proves one
incidence point above each of the sixty first-height bad parameters.

The five points over $t=4$ form $\ker V$, on which the translation
subgroup acts transitively. The table contributes five moving--fixed
and ten fixed--fixed incidences there, hence exactly three twists
at each point, all one-dimensional. The trivial twist never contributes.

## 5. The elliptic subgroup, without point-by-point incidence tests

Write $\iota(x,y)=(-x,2y)$, so $\iota^2=[-1]$.
The endomorphism $[-2]+\iota$ has degree five, since its product
with its dual $[-2]-\iota$ is $[5]$, and has zero differential.
It is therefore $\epsilon\pi$ for an origin-preserving automorphism
$\epsilon$. At $P=(1,2)$ the addition formulas give
$2P=(4,1)$ and $3P=\iota P=(4,4)$, hence $([-2]+\iota)P=P$.
Among the four automorphisms $1,\iota,-1,-\iota$, only1 fixes this
order-five point. Thus
\[
\pi=[-2]+\iota,\qquad C=1+\pi+\pi^2=[2]-[3]\iota.
\]
Its degree is13, its differential one, and
$(\pi-1)C=\pi^3-1$ makes its kernel $\mathbf F_{125}$-rational.
Likewise $\pi^3=[-2]+[11]\iota$ gives
$\#E_0(\mathbf F_{125})=\deg(\pi^3-1)=3^2+11^2=130$.

The twelve points with $D(x^2)=0$ are exactly the nonzero kernel of $C$.
Indeed, reducing the usual doubling and tripling formulas modulo
$D(x^2)$ gives
\[
x([2]P)+x([3]P)=0,\qquad y([2]P)-2y([3]P)=0.
\]
Their denominators have factors only $x$, $x^2+3$ and $x^4+x^2+2$,
all coprime to $D(x^2)$. Thus $[2]P=[3]\iota P$ at all twelve
points; degree13 and reducedness exhaust the kernel. These two
small polynomial identities are checked by the retained symbolic
[isogeny verifier](../../scripts/genus_two/check_dormant_isogeny_quotient.py);
its former finite-point loops are removed.

Since $C$ commutes with $V$ and their degrees13 and5 are coprime,
$\ker(CV)=\ker C\oplus\ker V$. Both summands are rational over
$\mathbf F_{125}$, so this is exactly the odd-order subgroup of the
group of order130. Section4 identified the incidence locus as the
inverse image under $V$ of the twelve nonzero $\ker C$ points,
together with $\ker V$. This proves the complete subgroup statement.

The original [305-pair receipt](../../../litt3-computation-data/theta_dictionary_correction_20260916/pointed_dormant_elliptic_locus.json)
remains as provenance. The replacement needs only the
[two-orbit polynomial identities](../../../litt3-computation-data/archive_cleanup_20260930/dormant_incidence_symbolic_hindsight/verification_receipt.json)
and the [focused independent review](../../Research/audits/DORMANT_INCIDENCE_ORBIT_HINDSIGHT_AUDIT_2026_10_03.md).
The entire obsolete field-scan source is removed. The
[first-height transfer review](../../Research/audits/FIRST_HEIGHT_ELLIPTIC_TRANSFER_AUDIT_2026_10_03.md)
checks the intrinsic foundation and its use in the family theorem. These FIRST-height
equations imply no guessed higher-height torsion rule.
