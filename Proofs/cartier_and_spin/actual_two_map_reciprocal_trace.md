# Proof of the actual reciprocal first-trace equation

Version6,2 October2026.
[Statement](../../Theorems/cartier_and_spin/actual_two_map_reciprocal_trace.md).
Use the actual adjunction normalization in
[reconstruction](../../Theorems/cartier_and_spin/admissible_line_reconstruction.md),
the principal norm coordinate from
[uniform norms](../../Theorems/cartier_and_spin/uniform_admissible_norm.md),
and the exact degree-ten characteristic identity from
[the torsion numerator theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md).

The trace of differentials along a finite étale map satisfies
the projection formula. Since $df\ne0$ on the base,
\[
0=\operatorname{Tr}_h\zeta
=2df\,\operatorname{Tr}_h(1/a)
\]
forces the first claimed trace to vanish. Multiplication by
$t^2\in k(X)$ gives the second. If
$\operatorname{Hom}(J_X,J_Y)=0$, the correspondence homomorphism
between Jacobians defined by the actual span is zero. Its map on
regular differentials is $\operatorname{Tr}_h q^*$, so the
trace-zero hypothesis follows. This uses the two original
endpoints and the same source; it assumes neither a joint
Galois closure nor a covering-degree restriction.

The smaller observable already follows before any opposite-map
trace-zero hypothesis. The actual annihilator divisor gives
\[
\operatorname{div}(2h^*df/u)=2(h^*R_X-E),
\]
so its differential is regular. Trace along the actual finite
etale map sends regular differentials to regular differentials.
Since $df$ has exact pole eight at $O$, the projection formula
forces $\operatorname{Tr}(1/u)$, if nonzero, to vanish to order
at least eight at $O$. Indeed $\operatorname{div}df=2R_X-10O$
and $R_X$ contains $O$ with coefficient one. In degrees ten and
eleven the support
reduction makes $t$ a cubic polynomial, of exact pole nine.
Consequently $g=t^2\operatorname{Tr}(1/u)$ has infinity pole
at most ten. It is affine regular: $t^2/u$ has divisor
$2(h^*B-E)-(2n-10)H$, with $E\le h^*B$, and trace preserves
affine regularity. The infinity coefficient is minus10 in degree
ten and minus12 in degree eleven. Thus
$g\in L_{10}=\langle1,x,x^2,x^3,y\rangle$.
This yields a five-coordinate necessary observable, not a
nonvanishing theorem. Multiplying $t$ or the normalized $u$ by
legal nonzero constants preserves its space and vanishing.

Intrinsically, let $D_0$ be the omitted cubic fiber and put
$\tau=df/t^2$. The actual support gives
$\operatorname{div}\tau=10O+2D_0$, so
$\operatorname{Tr}\zeta=2\tau g$ identifies the observable with
$H^0(X,\omega_X(-2D_0))\simeq L_{10}$, of dimension five.
This independent divisor check explains exactly why the smaller
$L_6$ target is unavailable.

Scaling the annihilator by a nonzero constant preserves trace
zero for its reciprocal. In degree ten,
$\operatorname{div}(t^2/u)=2(h^*B-E)-10H$. Here
$E\le h^*B$: at an occupied finite endpoint $B$ has positive
integer coefficient, and at infinity it has coefficient one,
while $E$ is reduced. Thus the reciprocal is affine regular
and bounded by $10H$. Its norm is
$t^{20}/t^{10}=t^{10}$.

The characteristic-carry polynomial has linear coefficient
$-t^8a_1'$, where $a_1'=\operatorname{Tr}_h(u')$.
Equivalently the elementary reciprocal identity gives
$e_9(u)=\operatorname{Nm}(u)\operatorname{Tr}(1/u)
=t^8\operatorname{Tr}(u')$. The exact formal resultant identity
multiplies this characteristic polynomial by
$v^2\operatorname{Res}_{10,3}(F,D)$, a nonzero function on the
base. Its linear coefficient therefore vanishes precisely when
the reciprocal first trace does. No division at a finite zero of
this multiplier is used to state the polynomial equation.

## A residue test in the full numerator algebra

Assume all five unselected infinity sheets have $W$ of pole two,
as in every $d=10$ profile of
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md).
There are at least four distinct large leading residues, hence
at least one singleton residue. At that sheet all nine differences
$W_i-W_j$ have exact pole two. Since $v$ has pole ten,
$F'(W_i)=v\prod_{j\ne i}(W_i-W_j)$ has pole28.
The prescribed $\phi$ has pole ten there, so $D(W_i)$ has
pole18, and $U(W_i)=uD(W_i)$ has pole28.
If $\deg U\le2$, the coefficient bounds
$\operatorname{pole}_O A_j\le25-j$ would give pole at most27
on that sheet. Thus $r=\deg U\ge3$; the uniform upper bound
is five.

The primitive source polynomial $F$ is separable and coprime
to $U$. Apply the global residue theorem to
\[
\frac{D(T)F'(T)}{U(T)F(T)}\,dT.
\]
At its $F$ roots the residues sum to $\operatorname{Tr}(D(W)/U(W))
=\operatorname{Tr}(1/u)$. At infinity the residue is zero:
$\deg F'=8$, $\deg D=3$, and $\deg(UF)=r+10\ge13$.
At the roots of $U$, replace $D F'/F$ by its class in
$K[T]/(U)$. The sum of these residues is the coefficient of
$T^{r-1}$ in that class divided by $\operatorname{lc}(U)$.
This holds for multiple roots as well, by the Laurent residue
of the degree-less-than-$r$ remainder divided by $U$.
The negative of this sum is the asserted reciprocal trace.
Only $F$ is inverted in the finite algebra; no critical quotient
or numerator-root discriminant is inverted.

## A residue test in a quotient of dimension at most three

On the stated reduced-linear stratum, cancellation of $R$ in
$U^2-DV_2=FQ$ gives
\[
\gamma F=R p^2-\delta_3 L V_2.
\]
Here $p$ is coprime to $L$ because the reduced denominator is
exactly $L$, and it is coprime to the degree-ten irreducible
source polynomial $F$. The displayed identity therefore makes
$V_2$ a unit in $K[T]/(p)$, including for nonreduced $p$.
Reducing the identity modulo $p^2$ and its formal derivative
modulo $p$ gives
\[
L F'/F\equiv1+L V_2'/V_2\pmod p.
\]
All divisions in this line are by units in the indicated finite
algebra; there is no division by a discriminant of $p$.

For $d=\deg p\ge1$, apply the global residue theorem to
$L F'/(pF)\,dT$ over an algebraic closure of $K$. At each
simple root of $F$, its residue is $L(W_i)/p(W_i)$. At infinity
there is no residue: $\deg F'\le8$ and the differential's
rational coefficient has degree at most $-d-1\le-2$.
For any rational function $f_0$ regular on the roots of $p$,
the sum of the residues of $f_0/p\,dT$ is
\[
\frac1{\operatorname{lc}(p)}[T^{d-1}](f_0\bmod p).
\]
This follows by replacing $f_0$ by its degree-less-than-$d$
remainder and reading its residue at infinity. It is valid for
multiple roots, with their full local principal parts. Consequently
\[
\operatorname{Tr}_h(L(W)/p(W))
=-\frac1{\operatorname{lc}(p)}
[T^{d-1}]\bigl((1+L V_2'V_2^{-1})\bmod p\bigr).
\]
Since $1/u=\delta_3L(W)/p(W)$ and $\delta_3\ne0$, this is
exactly the compact vanishing criterion.

If $p$ is constant, the reciprocal trace instead equals
$\delta_3p^{-1}\operatorname{Tr}_h(W-c)$.
The degree is ten, zero in characteristic five, so this is
$\delta_3p^{-1}\operatorname{Tr}_h W\ne0$. The nonzero first
source moment is an explicit hypothesis of this sector. A
degree-one $p$ is retained: no nonzero first trace of $u$ is
assumed, and the constant $1$ in its residue formula cannot be
discarded.

For $p=a_0(T-r_0)$ of degree one, reducedness gives $r_0\ne c$.
The identity
\[
\frac{W-c}{W-r_0}=1+\frac{r_0-c}{W-r_0}
\]
and $\operatorname{Tr}(1)=10=0$ show that reciprocal trace zero
is equivalent to $\operatorname{Tr}(1/(W-r_0))=0$.
Since $F(r_0)\ne0$, logarithmic differentiation of $F$ makes
this equivalent to $F'(r_0)=0$. But
$F'=\phi D$ and $\phi(r_0)\ne0$: otherwise
$r_0^5=-q_s$ would imply $dq_s=0$, whereas $dq_s=df\ne0$.
Thus $D(r_0)=0$. Together with the already distinct rational
root $c$, this splits the cubic completely. It does not exclude
the remaining split-critical cases.

The proof supplies only this additional carry coefficient.
Indeed $u'/\phi$ has pole order three on $E$, whereas the
uniform annihilator lemma uses the simple pole of $u/\phi$.
Applying that lemma to the reciprocal would change its
hypotheses and is not justified here.

The same caution applies to a primitive intermediate source. If the
opposite form descends to that source, transitivity of trace multiplies
its intermediate trace by the residual covering degree. A degree
divisible by five annihilates this multiplier. Thus original two-map
trace vanishing alone does not supply the intermediate trace vanishing.

## The marked spin section and its finite orthogonal trace pairing

Write line-bundle products multiplicatively and put
$L_2=\mathcal O_S(E-5H)$. The actual annihilator gives
$L_2^2\simeq\mathcal O_S$, with the trivialization specified by
$a$; this line may be trivial. The base differential has divisor
$2R_X-10O$, so $\theta_X=\mathcal O_X(R_X-5O)$ squares to
$\omega_X$. Since $\operatorname{div}A=x^*\operatorname{div}_0A-12O$
and $R_X=O+x^*\operatorname{div}_0A$, its divisor differs from
$8O$ by $\operatorname{div}A$. Thus $\theta_X\simeq\mathcal O_X(8O)$.

Etaleness gives $\omega_S=h^*\omega_X$. Consequently
\[
\theta_S=h^*\theta_X\otimes L_2^{-1}
=\mathcal O_S(h^*R_X-E),\qquad\theta_S^2\simeq\omega_S.
\]
The divisor is effective because $E\le h^*R_X$, so it gives its
canonical nonzero section $s$. Under the square isomorphism defined
by $df$ and the specified trivialization $a$, its square is exactly
$h^*df/a$. A change by a legal nonzero scalar rescales this identity
and its quadratic value without changing vanishing. With the actual
adjunction convention $\zeta=2h^*df/a$, this is $\zeta/2$.

Multiplication using $(L_2^{-1})^2\simeq\mathcal O_S$ and the
finite etale trace give
\[
V\otimes V\longrightarrow\mathcal O_X,\qquad V=h_*L_2^{-1}.
\]
This symmetric pairing is perfect: etale locally on $X$ the source
splits into $n$ sheets and the line has a frame on each, giving a
diagonal form with nonzero entries. Its rank is $n$ even when
the scalar $n$ is zero in characteristic five. The two-torsion line
is trivialized by an etale double cover, since two is invertible.
Together with the actual finite etale $h$, this makes $V$ a finite
monodromy bundle; semisimplicity of its characteristic-five
representation is not required.

Projection formula identifies the marked section with an element
of $H^0(X,V\otimes\theta_X)$. Its quadratic pairing is
\[
Q_V(s)=\operatorname{Tr}_h(h^*df/a)
=df\,\operatorname{Tr}_h(1/a)
=\operatorname{Tr}_h(\zeta)/2.
\]
Thus reciprocal trace zero says precisely that this section is
isotropic. It is not a vanishing consequence of finite monodromy.
An isotropic section could produce a negative-degree line in the
degree-zero bundle $V$, which semistability permits. The marked
divisor and order-five coupling must impose further constraints
before any anisotropy or common-cover conclusion is drawn.

The reduced support in degrees ten and eleven consists of the
three selected cubic fibers and $O$; the fourth fiber $D_0$ is
omitted. At an occupied finite endpoint, some source sheets belong
to $E$ and some do not. The divisor $h^*R_X-E$ of $s$ has
coefficient zero on the selected sheets and one on the others.
Thus the pushforward section is not a common base zero there.
The same argument applies at $O$: its selected occupancy is five
in degree ten and ten in degree eleven, both strictly between
zero and the source degree. Over $D_0$ every sheet has coefficient
one, and outside $R_X$ every sheet has coefficient zero. Hence
the common base-zero divisor is exactly $D_0$, with multiplicity
one. This uses the actual etale local splitting, so there is no
cancellation between components in determining a common zero.

The omitted fiber satisfies $D_0\sim3O$, whence
$\theta_X(-D_0)\simeq\mathcal O_X(5O)$. Dividing out this
common zero gives a section of $V(5O)$ nonzero in every base
fiber, equivalently the saturated line $\mathcal O_X(-5O)$
in $V$. Under $\theta_X\simeq\mathcal O_X(8O)$ the original
section is represented by $A/\sqrt a$. Here square-root notation
means local functions on the etale double cover trivializing
$L_2$, with their sign descent; it does not assert that $a$ is a
square in $k(S)$. Since $A/t$ is a nonzero scalar multiple of
$x-\alpha$, where $D_0=x^*(\alpha)$, the divided section is
represented by $t/\sqrt a$, up to a legal nonzero constant.
Its trace pairing is $t^2\operatorname{Tr}(1/a)$. The earlier
regular-differential argument puts this function in $L_{10}$.
It need not vanish at $O$ as a section of $\mathcal O_X(10O)$.
A zero value makes the
saturated line isotropic, which is fully compatible with its
negative degree and does not contradict semistability of $V$.

For the complementary section, use the reduced support
$B_*=O+B_{\rm fin}$, so $\operatorname{div}t=B_*-10O$, and put
$\bar E=h^*B_*-E$. The actual selected occupancy makes this a
reduced divisor of degree $5n$ in both degrees. The normalized
principal divisor gives
\[
\operatorname{div}(t^2/a)=2\bar E-10H.
\]
For degree eleven this agrees with the earlier expression
$2(h^*B-E)-12H$, since its full norm divisor is $B=B_*+O$.
In particular no reducedness of $h^*B-E$ is asserted in that
degree. Under the local square-root description of $L_2^{-1}$,
the section $\sqrt a$ has numerator $a$, and so lies in the
SAME bundle as $t/\sqrt a$. After the $5H$ twist their source
zero divisors are respectively $E$ and $\bar E$. Each has a
nonzero component in every base fiber, and both lines are
saturated. Multiplication of their component functions gives
$t$ on every sheet. Trace therefore yields the mixed pairing
$n t$, while their individual norms are the two displayed
ordinary traces.

In degree eleven with reciprocal trace zero, the restricted
Gram matrix of these two sections is
\[
\begin{pmatrix}0&t\\ t&\operatorname{Tr}_h a\end{pmatrix}.
\]
Here $11=1$ in characteristic five. Away from $B_*$ its
determinant $-t^2$ is nonzero, so the two sections are independent
in each such fiber. At a finite point of $B_*$, the sections have
complementary nonempty sheet supports, of sizes five and six,
and are again independent. At $O$ the local $5O$ frame makes
$t/\sqrt a$ nonzero on the ten selected sheets and $\sqrt a$
nonzero on the single unselected sheet, with complementary zeros
of order one. Thus they are independent there as well. Their
map from $\mathcal O_X(-5O)^{\oplus2}$ has constant fiber rank
two, hence is a saturated subbundle. Its Gram determinant is a
section of $\mathcal O_X(20O)$, with exact zero divisor
\[
\operatorname{div}(t^2)+20O=2B_*.
\]
This precise degeneracy is compatible with the nondegenerate
ambient orthogonal bundle. The subbundle has negative degree;
neither finite monodromy of $V$ nor strong semistability makes
this subbundle a preserved finite coefficient or connection
subobject.

For the exact source class relations, set
$\mathcal B=\mathcal O_S(G-H)$ and
$\mathcal T=\mathcal O_S(E-G-4H)$. The principal divisor of
$\phi$ gives $L_2^3=\mathcal B^5$. Since $L_2^2=\mathcal O_S$,
\[
\mathcal B^5=L_2,\qquad\mathcal B^{10}=\mathcal O_S,
\qquad\mathcal T=L_2\otimes\mathcal B^{-1}.
\]
In the primary decomposition of this ten-torsion class, its
two-primary component is $L_2$, and $\mathcal T$ is the inverse
of its five-primary component. This proves the stated nontriviality
equivalence and distinguishes the two torsion orders. No etale
trivialization of the five-primary component is inferred.

Finally uniform principal norms give $h_*G\sim nO$, so
$\operatorname{Nm}_h\mathcal B=\mathcal O_X$. Norm compatibility
with the fifth-power relation then gives
$\operatorname{Nm}_hL_2=\mathcal O_X$. The finite-flat determinant
formula
\[
\det h_*L_2^{-1}=\operatorname{Nm}_h(L_2^{-1})
\otimes\det h_*\mathcal O_S
\]
proves $\det V=\det h_*\mathcal O_S$. This is the ordinary
permutation-sign line of the actual $h$ leg; it does not make the
isotropic quadratic value nonzero and does not add an opposite map.

## Joint-field and full-data descent in the selected genus-two family

These are corollaries of settled inputs, rather than new Cartier
machinery. Use the field-recovery mechanism in
[differential ratio recognition](../../Theorems/shared_tensors/differential_ratio_joint_field.md)
and Section4 of the
[all-six eigenline proof](../jacobians/torsion/family_small_torsion_specialization.md).
The latter holds at every smooth parameter and explicitly includes
the [backup](../curve_arithmetic/backup_curve_arithmetic.md).

The divisor $\operatorname{div}\zeta=2(h^*R_X-E)$ and the two
actual etale maps force every zero of $\eta$ to have order two.
Its canonical degree is two, so $\operatorname{div}\eta=2P$ for
a Weierstrass point. The all-six calculation excludes its Cartier
eigenline, including eigenvalue zero; thus $\eta,C\eta$ are
independent. In the family coordinate write
\[
\eta=(a+bU)dU/V,\quad C\eta=(c+dU)dU/V,
\quad ad-bc\ne0.
\]
Then $r=C\eta/\eta=(c+dU)/(a+bU)$ and
$dr/\eta=(ad-bc)V/(a+bU)^3$ generate the ORIGINAL $k(Y)$.

Let $K_0=h^*k(X)(u)$ and take its normalization $S_0$.
Intermediate maps of the actual etale $h$ are etale, by the
nonnegative different exponents in a separable tower. The form
$\zeta_0=2h_0^*df/u$ pulls back to $\zeta$ and is regular.
Cartier commutes with the etale pullbacks, so $C\zeta$ descends
as well. Both $r=C\zeta/\zeta$ and $dr/\zeta$ therefore belong
to $K_0$. They recover the original embedded $q^*k(Y)$, proving
factorization of the ORIGINAL $q$ through $S_0$. Its intermediate
map is etale by the same different-tower argument. Conversely
$u=2h^*df/q^*\eta$ belongs to the actual compositum, since its
two rational differentials belong to the one-dimensional differential
space of that compositum. This proves the joint-field equality.
The Hom-zero trace and the main partner's degree restriction now
apply to this actual common source, using
[the source-degree lower bound](../../Theorems/curve_arithmetic/genus_two_quotient_descent.md).
There is no division by a residual covering degree.

For full admissible-data descent, $E$ descends from the divisor of
$u$ because the intermediate map is etale. The original fixed-selection
Cartier modification is consequently the pullback of $Q_{\Delta_0}$,
where $\Delta_0=h_0^*R_X-E_0$. The
[reconstruction proof](admissible_line_reconstruction.md) gives this
modification negative degree and at most one degree-zero line: two
distinct lines would wedge to its negative-degree determinant.
Pass only to the actual Galois closure of $S/S_0$. The conjugates
of the original embedded degree-zero line agree, so that inclusion
descends by its canonical equivariance to a line $A_0$ on
$S_0^{(1)}$. Its Frobenius adjunction is an isomorphism
\[
F^*A_0\simeq\omega_{S_0}(-2\Delta_0)
 =\mathcal O_{S_0}(2E_0-10H_0)\simeq\mathcal O_{S_0},
\]
as is seen after the faithfully flat original pullback; the final
trivialization is the already descended $u$. Thus $A_0$ is genuinely
order five, with no prime-to-five ambiguity, and is nontrivial because
its original pullback is. Reconstruction gives its normalized
$[f^2]+2b_0^5[f]$. Equality with the original normalized embedded
line forces $b=b_0\circ\pi$, then $\phi=\phi_0\circ\pi$ and
$G=\pi^*G_0$ by their exact divisors. If the original $b$ was
primitive, $S=S_0$. This reasoning does not assert that $b$ is
automatically primitive on every joint source; a $b$-first intermediate
need not carry the annihilator trivialization.

## The same-space differential certificate

Now additionally retain $\nu=q^*\beta\ne0$. Logarithmic regularity
gives $C\nu=\nu$, and pullback injectivity gives $C\beta=\beta$.
Since $\eta$ is not a Cartier eigenline, it is independent of
$\beta$. Moreover $\beta(P)\ne0$: a regular genus-two form
vanishing at the Weierstrass point $P$ has double zero there and
would lie in that excluded eigenline. The same observation makes
the two zeros of $\beta$ simple. Hence $\nu$ is nonzero on
$\Delta=q^*P$ and has reduced zero divisor.

Differentiate $\nu=-(du/u+df/\phi)$ and use $D\phi=1$ to get
\[
\nu/\zeta=-\tfrac12(Du+u/\phi)=2(Du+u/\phi),
\]
\[
dv/\zeta=\tfrac u2Dv
 =u(D^2u+(Du)/\phi-u/\phi^2).
\]
On $Y$, $v=\beta/\eta$ has exact pole $2P$ and is a Mobius
hyperelliptic coordinate. The function $\tau=dv/\eta$ has exact
pole $5P$ and simple zeros at the other five Weierstrass points.
Its square is therefore a squarefree exact quintic $P_5(v)$.
These coordinates recover the original quotient, not an arbitrary
genus-two curve. The converse below uses precisely this fixed-target
model and its prescribed form choices.

The standard hyperelliptic Cartier coefficient rule reads
$C\eta=([T^4]P_5^2)^{1/5}\eta+
([T^9]P_5^2)^{1/5}v\eta$ and similarly $C(v\eta)$ uses degrees
three and eight. Since $C\beta=\beta$, those latter coefficients
are zero and one. They give the two displayed coefficient equations.
Non-eigenline, ordinariness (the family determinant is
$3(s+1)^4\ne0$), and $\beta(P)\ne0$ give the displayed opens.
With $C\eta=(a+bv)\eta$, $a,b\ne0$ and $C(v\eta)=v\eta$,
one further Cartier application gives
\[
C^2\eta=-a b^{-4/5}\eta
 +(a^{1/5}+b^{-4/5})C\eta,
\]
retaining its inverse-Frobenius scalar action.

Finally suppose an already actual $h$-source satisfies the
same-target quintic identity and the endpoint-unit condition. Then
$v=\nu/\zeta$ has exact pole divisor $2\Delta$, so it is
nonconstant and separating (its pole orders are two). The quintic
identity defines a finite separable map to the specified smooth
genus-two target. Its degree is
$\deg v/2=\deg\Delta=8\deg h$. Riemann--Hurwitz has
$2g(S)-2=16\deg h=2\deg q$, so its effective different has
degree zero and the second map is everywhere etale. The two form
equalities hold directly from the source coordinates. This is also
the no-common-zero specialization of the settled
[canonical-pencil certificate](../../Theorems/quotient_geometry/genus_two_etale_pencils.md).
Without the unit condition, a tame index-three point over a nonzero
target differential can contribute a source zero of order two;
even zeros alone do not establish the second map's etaleness.
