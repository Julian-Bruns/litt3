# Proof: a logarithmic Hessian identifies the two actual kernels

[Statement](../../Theorems/deformations/bt_cartier_tangent_identification.md).
We retain the actual logarithmic character form and the canonical
double torsor. All Frobenius pushforwards in the proof are absolute;
their $\mathcal O_C$ action on scalar coefficients is $a\cdot h=a^5h$.
Using relative Frobenius instead gives the same proof on $C^{(1)}$
with the coefficient twist. No choice of an isomorphism of the two
$k$-curves is made.

## The fourth-order kernel is a bundle, not just a tangent space

Use the canonical double $\pi:C_s\to C$, including the split case,
from [the dormant-pair construction](../projective_connections/etale_double_dormant_pairs.md).
On it write the tautological quadratic as $q=a(du)^2$, so that
$a^2=s_u$ and $r=a''/a$. The two potentials $r+a$ and $r-a$ are
dormant. On rational quadratics put
\[
B(v)=\frac{v''-rv}{a}.
\tag{5}
\]
The established actual operator identity is
\[
D^4(a^2v)=a^4(B^2v-v).
\tag{6}
\]
Thus on its rational kernel $B$ is an involution. For a regular
$v$ in that kernel, $Bv$ is regular as well. Its only possible
poles are simple ones at the simple zeros of $a$. If $Bv$ has
leading term $c/u$ there, applying $B$ once more has leading term
$2c/(a_1u^4)$, where $a=a_1u+O(u^2)$. This contradicts $B^2v=v$.
This is a local argument, valid on every open and at every stalk.

The projections $(1+B)/2$ and $(1-B)/2$ consequently split this
REGULAR kernel into the two actual Bol kernels $V_{r+a}$ and
$V_{r-a}$. Conversely each of these lies in it. Their sum is a
locally free rank-four kernel: their intersection is zero since
their equations differ by $2a$, and the projections give the
inverse to the direct-sum map. Descent by the involution, which
exchanges the two summands, identifies this kernel on $C$ with
$\mathcal E_r^{\rm abs}$. The use of local sections here is the
sheaf version of the proved tangent factorization, not an inference
from equality of global dimensions.

## Relating the logarithmic and quartic normalizations

The logarithmic character cover has Cartier-fixed form $\Omega$,
and its fourth power is a nonzero constant multiple of the pulled
back normalized quartic. This is the actual crystalline calculation
in [the Cartier bridge](versal_bt_cartier_rigidity.md).
On a common tame refinement write $\Omega=o\,du$. The ratio
$a/o^2$ is constant: its square is a nonzero constant, and the
refinement is reduced. Thus $a=\zeta o^2$ for a nonzero constant
$\zeta$ on each connected component. We never need to choose the
constant or identify it with its fifth power.

The Cartier criterion for a rational function $h$ is
\[
C(h\Omega)=0\quad\Longleftrightarrow\quad D^4(oh)=0.
\tag{7}
\]
This follows in the basis $1,u,\ldots,u^4$ over fifth powers;
$D^4$ extracts the same coefficient as Cartier, up to the nonzero
factor $4!$. Since $a^3=\zeta^3o^5o$, equation (7) is equivalent to
\[
D^4(a^3h)=0.
\tag{8}
\]
Therefore multiplication by $a$ sends a rational logarithmic
kernel section to a rational fourth-order tangent section $v=ah$.
It also gives exactly the right lattices: $h$ is allowed simple
poles at $S$, and $a$ has simple zeros there, so $v$ is regular.

Multiplication by $a$ alone changes sign on the canonical double.
Applying the involution $B$ removes this ambiguity. By $r=a''/a$,
\[
B(ah)=h''+2\frac{a'}a h'
      =h''+\frac{s_u'}{s_u}h'.
\tag{9}
\]
Both sign changes cancel; (9) descends to the original curve.
The preceding regularity argument shows its value is a regular
section of $\mathcal E_r^{\rm abs}$ even over $S$.

Conversely, if $v$ is a regular tangent section, $Bv$ is regular.
Thus $h=Bv/a=(v''-rv)/s_u$ has at most simple poles at $S$.
Equations (6)--(8) show $C(h\Omega)=0$. The two constructions
are inverse because $B^2=1$. This also proves that the inverse
is independent of the sheet of the canonical double.

## Coordinate and coefficient checks

Under $u=u(x)$, the quartic coefficient becomes
$s_x=s_u(u')^4$. The expression on the right of (9), computed
in $x$, is
\[
(u')^2\left(h_{uu}+\frac{(s_u)_u}{s_u}h_u\right)
       +(1+4)u''h_u.
\]
The last term is zero in characteristic five. Hence (9) transforms
as a quadratic differential, as asserted. The inverse is also
intrinsic: the numerator is the regular Bol operator on quadratics,
valued in quartics, divided by the fixed quartic $s$.

All the displayed operators kill derivatives of fifth-power
scalars. They are therefore $\mathcal O_C$-linear for the absolute
Frobenius pushforward action specified at the start. Every identity
is checked on an actual tame refinement and descends faithfully;
it is compatible with arbitrary actual etale base change. This
proves the sheaf isomorphism (1), with its scalar convention.

## Pairing, obstruction functional, and arbitrary-degree trace

The [actual tangent bundle](../projective_connections/tangent_bundle_cyclic_refinements.md)
has a perfect canonical-valued alternating pairing and the stated
stable or split-polystable classification. Transport these through
(1). Serre duality now gives
$H^1(\mathcal B_H)\simeq H^0(\mathcal B_H)^*$.
The class supplied by the actual extension torsor lies in this
space at every level. No other deformation class has been
substituted for it.

For finite etale $q$, trace on $q_*q^*\mathcal B_H$ is the actual
finite-flat trace, tensored with $\mathcal B_H$. Serre duality
identifies it with the dual of pullback on $H^1$; the alternating
pairing is compatible with the actual etale cotangent identification.
This proves (4). If a next-level object exists on $D$, functoriality
of the absolute extension torsor gives $q^*e_N(A_N)=0$, so (4)
annihilates the trace image. A surjective trace therefore forces
$e_N(A_N)=0$ and produces some actual next-level object on $C$.

For a cyclic group of order $d=5^a$, pullback identifies this trace
with the norm $N=(\gamma-1)^{d-1}$ on global tangent sections.
A block of length less than $d$ has zero norm, while a full block
contributes its one-dimensional invariant line. This yields the
last assertion. No division by a covering degree is used.
