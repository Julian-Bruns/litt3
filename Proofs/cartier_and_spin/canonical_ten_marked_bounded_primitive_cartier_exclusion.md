# Proof: the actual embedded kernel has a forbidden degree-three line

Version 2, 3 October 2026. See the
[exact scoped statement](../../Theorems/cartier_and_spin/canonical_ten_marked_bounded_primitive_cartier_exclusion.md)
and [independent audit](../../Research/notes/oct03_ten_hour/cartier_kernel_y_audit.md).
The original endpoint maps stay on the same source. The calculation uses
the actual Cartier embedding, not a native power quotient.

## The source bound

Because $q$ is étale over genus-two $Y$, $\deg\omega_T=2N$.
The actual scalar root $L^{16}=\omega_T$ gives $\deg L=N/8$; no
$M^8=\omega_\Gamma$ identification is used.
Put $E=q^*F_Y^*K\otimes L^{-10}$. Its actual horizontal presentation makes
it globally generated and $\deg E=5N-3(10N/8)=5N/4$.
For a line $S\subset F_Y^*K$ of degree $m$, the étale pullback and twist
give a line subbundle $q^*S\otimes L^{-10}\subset E$ of degree
$mN-5N/4$. The rank-two quotient therefore has degree
$(5/2-m)N$. A globally generated quotient has globally generated
determinant, hence nonnegative degree. Thus $m\le5/2$, or $m\le2$.
This also applies to lines in $H_Y$ and does not require saturation of
$K\subset B_Y$.

## The exact marked bounded-primitive family

Assume now the additional saturated-annihilator marking in the statement.
On $Y$, $H^0(\mathcal O_Y(5P))$ has basis $1,z,z^2,w$.
A lift $\mathcal O_{Y^{(1)}}(-P^{(1)})\to F_{Y*}\mathcal O_Y$
is therefore represented by one of these functions. Differentiation gives
the adjunction in the span of $dz,z\,dz,z^3\eta$, because
$dw=2cz^3\eta$. Its vanishing at both $z=0$ points removes $dz$.
If the $z\,dz$ coefficient vanished, the remaining $z^3\eta$ would have
order three at both wild points. This contradicts the original surjective
evaluation of $K$: a saturated annihilator with a third-order adjunction
zero has its entire annihilator fiber in the zeroth-evaluation kernel.
Normalize the nonzero coefficient to obtain
$\delta_e=z\,dz+ez^3\eta=d(z^2/2+e w/(2c))$.

Let $\Phi=az^5+cz^4+d$ and $R=az^5+(c-e^2)z^4+d$.
For $e\ne0$, the remaining adjunction zeros satisfy $w=-ez^2$ and
$R=0$. If $e^2\ne c$, the five roots of $R$ are distinct and nonzero,
because $R'=4(c-e^2)z^3$. These five zeros, and the two wild zeros, are
simple. For $e=0$ the other five zeros are the hyperelliptic branch points,
again simple. At $P$, $\delta_e$ has pole five, so as a map
$\mathcal O_Y(-5P)\to\omega_Y$ it has no zero there.
Thus these embeddings are saturated and their rank-three annihilators
have surjective evaluation.

If $e^2=c$, the residual polynomial is $az^5+d$ and its single root
gives an adjunction zero of order five. The inclusion of $A$ into $B_Y$
then has a fiber zero, so it is not a saturated line embedding. It is
excluded under the stated saturation hypothesis.

## The actual global section

Use the accepted horizontal Taylor isomorphism
$F_Y^*B_Y\simeq J^3\omega_Y$. In a rational $z$ frame write jet coordinates
$(x_0,x_1,x_2,x_3)$ using Hasse coefficients. The canonical alternating
form, in this frame, is
$x_0y_3-x_3y_0+3(x_1y_2-x_2y_1)$.
For $g=\delta_e/dz=z+ez^3/w$, a vector $(0,A_1,B_1,C_1)$ belongs to
the actual $F_Y^*K_e$ precisely when
$gC_1+3g'B_1+g''A_1=0$.

Consider the explicit rational vector
$A_1=1/\Phi$,
$B_1=2cz^3/\Phi^2+ez/w^3$,
$C_1=e/w^3+cez^4/w^5-cz^2/\Phi^2$.
It satisfies that equation identically. For example multiply by $w^7$,
substitute $w^2=\Phi$, and compare the even and odd coefficients.
The universal identity holds for independent symbolic $a,c,d,e$ in
characteristic five; it is not a finite-field sample.

Here is a regularity check, including the coordinate corrections.
For $z=z(t)$ write $q=dz/dt$. On the evaluation kernel the jet coordinates
transform by
$A_t=q^2A_1$,
$B_t=q^3B_1+4qq'A_1$,
$C_t=q^4C_1+2q^2q'B_1+(4qq''+3(q')^2)A_1$.
At a finite hyperelliptic branch point take $t=w$, so
$q=2w/\Phi'$. Put $h=ez/w^3$. Then
$B_1=2A_1'+h$ and
$C_1=4h'+2e/w^3-cz^2/\Phi^2$.
The pair $(A_1,2A_1')$ transforms to $(A_t,2A_t')$; here
$A_t=4/(\Phi')^2$ is regular. For its third coordinate the possible
order-minus-two pole cancels modulo five; the expression is even in $w$,
so the result is regular. The pair $(h,4h')$ transforms to
$(h_t,4h_t')$, with $h_t=8ez/(\Phi')^3$ regular. The remaining top terms
$2e/w^3-cz^2/\Phi^2$, multiplied by $q^4$, are regular.
At other finite points the displayed vector has no poles.

At $P$ use the exact uniformizer $t=z^2/w$. Set $T_0=az^5+d$; its
$z$ derivative is zero. Direct differentiation gives
$q=3w^3/(zT_0)$,
$q'=\Phi^2/(z^3T_0)$,
$q''=w^5/(z^5T_0)$,
and hence $4qq''+3(q')^2=0$ exactly.
The leading expansions are
$z=a^{-1}t^{-2}+O(1)$ and $w=a^{-2}t^{-5}+O(t^{-3})$.
Consequently $A_t$ has order four,
$B_t=2a^2t^3+O(t^4)$,
and $C_t$ has order at least three.
Thus the rational vector is a global section $\sigma_e$ of the actual
$H_e$, and it has a zero of order exactly three at $P$.
Its intrinsic first jet is $\eta^2$, whose divisor is $4P$.
Away from $P$ this jet is nonzero, so $\sigma_e$ has no other fiber zeros.
Its zero divisor is exactly $3P$.

Saturating its image produces $\mathcal O_Y(3P)\subset H_e$.
The actual determinant is
$\det H_e=F_Y^*(\omega_{Y^{(1)}}A)\otimes\omega_Y^{-1}
\simeq\mathcal O_Y(3P)$.
The quotient by this line is therefore $\mathcal O_Y$.
Since $H^1(\mathcal O_Y(3P))=0$, that sequence splits:
$H_e\simeq\mathcal O_Y(3P)\oplus\mathcal O_Y$.
The line of degree three contradicts the original horizontal source
bound and proves the stated whole marked-branch exclusion.

## Verification and the remaining gap

The result extends to an exact cohomological classification in the larger
marked wild-zero chart $\delta=z\,dz+bz^2\eta+ez^3\eta$.
The original wild-avoiding first jet makes the two wild adjunction zeros
simple, hence justifies normalization of the nonzero $z\,dz$ coefficient.
Put $F=bz^2+ez^3$, $R=\Phi-(F/z)^2$,
$U=F'\Phi-2cz^3F$, $V_1=U'-cz^2F$, and
$T_1=cz^4+3\Phi-3FF'/z$.

Every section in the evaluation kernel of $J^3\omega_Y(-3P)$ has the
following complete form: its first jet is $p\eta^2$ for a constant $p$,
$A_1=p/\Phi$, $B_1=2A_1'+h$, $h=(h_0+h_1z)/w^3$, and
$C_1=4h'+(Q_0+wq_3)/\Phi^2$, where $\deg Q_0\le2$ and $q_3$ is constant.
Indeed the successive homogeneous differences are sections of
$\omega_Y^3(-3P)$ and $\omega_Y^4(-3P)$, with function bases respectively
$1,z$ and $1,z,z^2,w$. The base lift $(0,p/\Phi,2(p/\Phi)',0)$ has zero
order at least three at $P$, by the exact coordinate identity above.
Thus these bounds are sufficient as well as necessary.

The odd part of the actual annihilator equation fixes
$Q_0=4b h_0+(e h_0-bq_3)z+(2e h_1-e q_3-cp)z^2$.
The remaining condition is
$zR(q_3+4h_1)+pV_1+T_1(h_0+h_1z)=0$.
Four of its coefficients are
$[z^0]=d(2bp+3h_0)$,
$[z^2]=4b^2h_0$,
$[z^3]=-b^2q_3$,
$[z^6]=a(q_3+ep+2h_1)$.
If $b\ne0$, these force $h_0=p=q_3=h_1=0$, so no nonzero section occurs.
If $b=0$, saturation forces $c-e^2\ne0$; the remaining degree-five
coefficient gives $(c-e^2)(q_3+3h_1)=0$. Consequently
$h_0=0$, $h_1=ep$, $q_3=2ep$, with $p$ free. This is exactly the
one-dimensional explicit section already found. Because
$H^0(\omega_Y(-3P))=0$, these sections are all of
$H^0(F_Y^*K(-3P))=H^0(H_Y(-3P))$.
This proves the stated cohomological test, not a classification of every
degree-three line with a different Picard class.

The [source check](../../scripts/arithmetic/oct03_cartier_kernel_family.py)
uses only the Python standard library and checks the universal annihilator
identity, the general marked-chart elimination, and its entire $b=0$
family and the four decisive coefficients of the cohomological test. Run
`python3 scripts/arithmetic/oct03_cartier_kernel_family.py`.
It passed with Python 3.14.7. The concise
[receipt](../../../litt3-computation-data/oct03_ten_hour/cartier_kernel_y/polynomial_checks.json)
contains the executed check outcomes. The independent audit checks
regularity, exact zero order, the saturated flag and the source degree
contradiction; the certificate alone does not replace these arguments.

In the larger marked chart the fourth exact differential $z^2\eta$ has
minimal primitive pole fifteen, by the accepted
[primitive normal form](moving_origin_pole_fifteen_primitive_normal_form.md).
The excluded $b=0$ family is exactly the liftable bounded-primitive
subspace. Therefore a marked surviving source must have $b\ne0$.
Neither this nonlifting term nor the annihilator marking is removed here.
No equality $H_Y=\omega_YV_Y$ is assumed; indeed the explicit $H_e$ has
a degree-three line, while the native extension by lines of degrees one
and two cannot have such a line. No endpoint map is descended.
