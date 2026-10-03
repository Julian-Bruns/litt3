# An opposite global adjunction form forces the reciprocal first trace

Version6,2 October2026. Let $X\xleftarrow{h}S\xrightarrow{q}Y$
be two ACTUAL finite étale maps from the same smooth projective
connected source. Retain an actual admissible divisor identity
$\operatorname{div}\phi=3E-5G-10H$ on the fixed genus-nine $X$,
where $H=h^*O$. Suppose an annihilator $a$ has
$\operatorname{div}a=2E-10H$ and its adjunction differential is
\[
\zeta=2h^*df/a=q^*\eta
\]
for a global regular differential $\eta$ on the ORIGINAL opposite
endpoint $Y$. Assume $\operatorname{Tr}_h(q^*\eta)=0$; it suffices
that $\operatorname{Hom}(J_X,J_Y)=0$. Then
\[
\operatorname{Tr}_h(1/a)=0,
\qquad \operatorname{Tr}_h(t^2/a)=0
\]
for every base function $t\in k(X)$. The same conclusion holds
with an explicitly supplied trace-zero $\zeta$, without requiring
that it descend from $Y$.
The two displayed trace equations are equivalent when $t\ne0$;
they are not two independent constraints.

There is also a five-coordinate observable requiring only the
ONE-leg actual annihilator hypotheses, with no opposite form.
In actual degree ten or eleven, choose the principal support
coordinate $t$ of infinity pole nine and any nonzero scalar
normalization $u$ of $a$. Then
\[
g=t^2\operatorname{Tr}_h(1/u)
=\operatorname{Tr}_h(t^2/u)
\in L_{10}=\langle1,x,x^2,x^3,y\rangle.
\]
Thus the actual two-map refinement above sets five scalar
coordinates to zero. The statement does not assert their
independence or exclude their common zero locus.

In degree ten choose the principal norm coordinate
$\operatorname{div}t=B-10O$, where $h_*E=5B$, and rescale $a$
to $u$ with $\operatorname{Nm}_h u=t^{10}$. Then
$u'=t^2/u$ is affine regular, has infinity pole at most ten on
every sheet, has norm $t^{10}$, and has first trace zero.
In the exact characteristic-carry model this imposes
$a_1'=e_1(u')=0$, equivalently $e_9(u)=0$.

For the primitive raw source and numerator $F,D,U$, the resulting
additional polynomial equation is
\[
[Z]\operatorname{Res}_{10,5}(F,U-ZD)=0.
\]
The resultant has its indicated formal degrees. Its equivalence
to the reciprocal trace uses $v\ne0$, $t\ne0$ and
$\operatorname{Res}(F,D)\ne0$ over $k(X)$, not unit values of
these functions at every finite point.

There is a finite-algebra residue test on every
degree-ten profile with five unselected infinity roots of pole two
(in particular the $m=3$ profile). Put $r=\deg U$. Then
$r\in\{3,4,5\}$, $F$ is invertible in $K[T]/(U)$, and
\[
\operatorname{Tr}_h(1/u)
=-\operatorname{lc}(U)^{-1}[T^{r-1}]
\bigl(D F' F^{-1}\bmod U\bigr).
\]
Thus reciprocal trace zero is one exact coefficient equation in
a quotient of dimension three through five. This formula retains
repeated roots of $U$ and common zeros of the critical quotient
$Q$ with $U$; it makes no division by $Q$ or $V_2$.

There is a compact version on the
[reduced-linear critical-denominator stratum](admissible_linear_critical_denominator.md).
Write $D=\delta_3 L R$, $L=T-c$, $R$ monic quadratic, and
$U=R p$. Then $\deg p\le3$, and
$Q=\gamma R$ with $\gamma=-\delta_3 n_0\ne0$. A constant
$p$ is excluded by the reciprocal trace, since
$\operatorname{Tr}_h W\ne0$ in this sector. For
$d=\deg p\in\{1,2,3\}$ the extra condition is exactly
\[
[T^{d-1}]\bigl((1+L V_2'V_2^{-1})\bmod p\bigr)=0.
\]
The inverse exists in $K[T]/(p)$, even when $p$ has repeated roots.
For $d=2,3$ the constant $1$ does not contribute. All these
statements are over the function field; no finite root simplicity
or leading-coefficient unit hypothesis is imposed. This reduces
the inverse-trace test to a quotient of dimension at most three.
If $\deg p=1$, its unique root is a second distinct rational
critical root, so the cubic $D$ fully splits over $K$. This
is a restriction, not an unconditional exclusion of this case.

This is an actual TWO-map refinement. Admissibility on a single
cover does not supply the opposite differential or its trace
vanishing. An arbitrary refinement of $Y$ does not preserve the
stated Jacobian hypothesis automatically. There is no reciprocal
$\phi'$ hypothesis, and no reciprocal low-weight trace vanishing
or numerator degree bound is asserted.
Nor may the trace-zero conclusion be passed to a primitive intermediate
source by cancelling a residual covering degree divisible by five.
The family-specific joint-field result below instead supplies both
actual intermediate maps, so it proves the intermediate trace directly.

There is a computation-free geometric reformulation on the actual
$h$ leg, valid in every admissible degree $n$. Put
\[
L_2=\mathcal O_S(E-5H),\quad
\theta_X=\mathcal O_X(R_X-5O)\simeq\mathcal O_X(8O),\quad
\theta_S=h^*\theta_X\otimes L_2^{-1}=\mathcal O_S(h^*R_X-E).
\]
The line $L_2$ is two-torsion, possibly trivial. With its square
trivialized by $a$ and $\theta_X^2$ identified with $\omega_X$
by $df$, the canonical section $s$ of the effective spin divisor
$h^*R_X-E$ has square $h^*df/a=\zeta/2$.
The finite-monodromy orthogonal bundle $V=h_*L_2^{-1}$ has rank
$n$ and a nondegenerate trace pairing, even when five divides $n$.
For $s\in H^0(X,V\otimes\theta_X)$ its quadratic value is
\[
Q_V(s)=\operatorname{Tr}_h(df/a)=\operatorname{Tr}_h(\zeta)/2.
\]
Thus the reciprocal-trace condition is isotropy of this marked
spin section. No anisotropy or trace nonvanishing is asserted.

In the degree-ten or degree-eleven support reduction, let $D_0$
be the three-point fiber over the omitted fourth root of $A$.
The common base-zero divisor of $s$ is exactly $D_0$.
Removing it gives a saturated line
\[
\mathcal O_X(-5O)\lhook\joinrel\longrightarrow V,
\]
represented, with the chosen square trivialization, by
$w=t/\sqrt a\in H^0(X,V(5O))$. Its quadratic value is
$t^2\operatorname{Tr}_h(1/a)\in L_{10}$. There is no forced
zero of a nonzero value at $O$. In the reciprocal-trace-zero case
this saturated degree-minus-five line is isotropic; degree-zero
semistability alone does not exclude it.

More precisely put $B_*=O+B_{\rm fin}$ for the REDUCED ten-point
support and $\bar E=h^*B_*-E$. There is a complementary section
$w^\dagger=\sqrt a\in H^0(X,V(5O))$, also defining a saturated
$\mathcal O_X(-5O)$ line, with exact pairings
\[
Q_V(w)=t^2\operatorname{Tr}_h(1/a),\qquad
Q_V(w^\dagger)=\operatorname{Tr}_h a,\qquad
B_V(w,w^\dagger)=n t.
\]
Their source zero divisors after the $5H$ twist are $\bar E$ and
$E$. Thus their mixed pairing is zero in degree ten and $t$ in
degree eleven. In degree eleven, if the reciprocal trace is zero,
their span is a saturated subbundle
$\mathcal O_X(-5O)^{\oplus2}\subset V$, whose restricted Gram
determinant has exact divisor $2B_*$. This is a degenerating
orthogonal rank-two subbundle, not a finite coefficient or an
invariant connection subbundle. No contradiction is asserted.
The reduced $B_*$ differs from the degree-eleven principal norm
divisor $B$, which has coefficient two at $O$.

The source degree-zero class $\mathcal B=\mathcal O_S(G-H)$
satisfies
\[
\mathcal B^5=L_2,\quad\mathcal B^{10}=\mathcal O_S,\quad
\mathcal T=\mathcal O_S(E-G-4H)=L_2\otimes\mathcal B^{-1}.
\]
Its five-primary component is nontrivial exactly when $\mathcal T$
is nontrivial. The principal norms give
$\operatorname{Nm}_h\mathcal B=\operatorname{Nm}_hL_2=\mathcal O_X$
and $\det V=\det h_*\mathcal O_S$. None of these statements
claims an etale trivialization of $\mathcal B$, or supplies the
opposite differential required by the two-map statement.

## The actual adjunction generates the joint field

Suppose the ORIGINAL opposite endpoint is a smooth member
$Y=C_s:V^2=U(U-1)(U-2)(U-3)(U-s)$, $s^5-s\ne0$, of the selected
genus-two family. This includes the main and backup endpoints.
In ANY actual covering degree retain
$\zeta=2h^*df/u=q^*\eta$ in its actual adjunction normalization.
Then, inside the original source field,
\[
k(X)(u)=h^*k(X)q^*k(Y).
\]
The normalization $S_0$ of this field is an ACTUAL common source:
the ORIGINAL $h,q$ factor through $S\to S_0$, and all three
factor maps are finite etale. Thus $u$ is primitive on every jointly
minimal span in this sector, in every degree.

If $\operatorname{Hom}(J_X,J_Y)=0$, the reciprocal trace on $S_0/X$
is zero directly from its actual opposite map, even when
$[k(S):k(S_0)]$ is divisible by five. No residual degree is cancelled.
For the selected main partner, its established actual source-degree
lower bound therefore implies
$[k(X)(u):k(X)]>(335999!)^2$. In particular algebraic annihilator
degrees ten and eleven are excluded in this genuinely two-leg sector;
no such large lower bound is claimed for the backup.

When the ORIGINAL nontrivial order-five admissible line and normalized
$\phi=h^*f+b^5$ are retained, the exact $b,\phi,E,G$ also descend to
$S_0$. If $b$ is primitive on the original source, that source is
already $S_0$, and $u$ is primitive there in every degree. Conversely
no automatic primitiveness of $b$ on an arbitrary joint source is asserted.

## An explicit same-target differential certificate

Additionally suppose the NONZERO actual character
$\nu=-d\log(u\phi)$ descends as $q^*\beta$ for a regular form on
the SAME $Y$. This is a separate two-leg hypothesis. Then $C\nu=\nu$,
$\zeta,\nu$ are independent, and their entire Cartier span is the
same pulled-back regular two-space. For $\Delta=h^*R_X-E$,
\[
\Delta=q^*P,\qquad \operatorname{div}\eta=2P,
\qquad \nu\text{ is nonzero at every point of }\Delta.
\]
The zeros of $\nu$ are simple. Write $D=d/df$ on the source. The
ORIGINAL target is recovered by the exact source functions
\[
v=\nu/\zeta=2(Du+u/\phi),\qquad
\tau=dv/\zeta=u\bigl(D^2u+(Du)/\phi-u/\phi^2\bigr),
\]
\[
q^*k(Y)=k(v,\tau),\qquad \tau^2=P_5(v),
\]
where $P_5(T)=\sum_{j=0}^5c_jT^j$ is a squarefree exact quintic
representing the ORIGINAL target with $P$ as infinity and
$\eta=dv/\tau$, $\beta=v\,dv/\tau$. It is not a freely chosen curve.
Its Cartier normalization gives
\[
c_0c_3+c_1c_2=0,\qquad c_4^2+2c_3c_5=1,
\]
\[
c_0c_4c_5\ne0,\qquad 2c_0c_4+2c_1c_3+c_2^2\ne0.
\]
Writing $C\eta=(a+bv)\eta$, both $a,b$ are nonzero and
\[
C^2\zeta=-a b^{-4/5}\zeta
 +(a^{1/5}+b^{-4/5})C\zeta.
\]

Conversely, start with an ACTUAL finite etale $h:S\to X$ and the
admissible $\phi,u$ above. If these explicit $v,\tau$ satisfy the
quintic identity for the fixed target with its prescribed form choices,
and $\nu$ is nonzero on $\Delta$, they define an ACTUAL finite etale
map $S\to Y$ of degree $8\deg h$, with the stated two form pullbacks.
This is the source-form specialization of the established
[canonical-pencil certificate](../quotient_geometry/genus_two_etale_pencils.md).
The endpoint-unit condition is essential: the even zero pattern alone
can allow tame index-three ramification. These criteria supply no
annihilator, no original opposite-form descent on an arbitrary span,
and no unmarked common-cover decision.

[Proof](../../Proofs/cartier_and_spin/actual_two_map_reciprocal_trace.md).
