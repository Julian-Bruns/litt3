# Proof of critical numerator coprimality in m9 with zero fourth moment

Version12,2 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_zero_moment_denominator_exclusion.md).
Use the actual bounds and at least four distinct large residues in
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
the direct numerator coefficients in
[the torsion numerator theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md),
and the root affinity, gap matrices, and already excluded poles
three and four in
[the reduced-linear theorem](../../Theorems/cartier_and_spin/admissible_linear_critical_denominator.md).
The independent
[squarefreeness proof](admissible_degree_ten_m9_critical_squarefreeness.md)
provides the missing function-field condition, using only coefficient
and fixed-pencil inputs and no numerator hypothesis.
The new argument is a coefficient and residue budget; no computation
or source realization is used.

Here $\delta_3\in L_9$ has exact pole nine and is a cubic
polynomial in $x$. The other short coefficient bounds are14,16,18.
A rational critical root has pole at most five, because a larger
pole makes its cubic term uniquely leading. Its finite-frame root
$c_f=c+Z/y$ satisfies $\delta_3c_f$ affine. The same holds for
$\delta_3b_f$, where
\[
D/\delta_3=(T-c)(T^2+bT+e),\qquad b_f=b-2Z/y.
\]
This follows from normality and the integrality of each critical
root multiplied by $\delta_3$.

Suppose first $c$ has pole five. The relations
$e=-\delta_0/(\delta_3c)$ and
$b=(e-\delta_1/\delta_3)/c$ give $e\le4$, $b\le2$.
Thus $\delta_3b\le11$; the gaps17 and14 force
$\delta_3\in\langle q,q_3\rangle$. Its translation remainder
then has pole at most11, whereas $\delta_3c$ has exact pole14.
Affinity of $\delta_3c_f$ would require an affine leading pole14,
which is a gap. This contradiction excludes pole five.

For all roots of pole at most four, $\delta_3c\le13$; the same
two gaps17 and14 directly force the displayed pencil. If its
pole is at most one, $\delta_3c\le10$ also kills gap11, leaving
the single cubic kernel $q_3$. All steps separate successive
leading gaps and do not assume affinity of short lower coefficients.

Now let $\rho=0$ and suppose the critical gcd has degree two.
The independent result makes $D$ squarefree. Write
\[
D=\delta_3(T-c)R,\quad U=Rp,\quad R=T^2+bT+e,
\quad u=\frac{p(W)}{\delta_3(W-c)},\quad\deg p\le2.
\]
The already established reduced-linear theorem excludes a root
of pole four and also pole three with $\rho=0$ in this profile.
The preceding paragraph excludes pole five; hence $c$ has pole
at most two.

Since $b=c+\delta_2/\delta_3$, initially $b\le5$.
If it had pole five, $\delta_3b$ would have exact gap pole14,
but the established pencil has translation remainder of pole
at most11, contradicting affinity of $\delta_3b_f$. Thus $b\le4$.
Also $e=\delta_1/\delta_3+bc$ gives $e\le7$.

At every large leading residue other than a possible leading
residue of $c$ when its pole is two, $W-c$ has exact pole two.
There are at least three distinct such residues. Consequently
$p(W)$ has exact pole21 there, since $u$ has pole ten and
$\delta_3(W-c)$ pole eleven. If any weighted coefficient budget
$\operatorname{pole}(p_j)+2j$ exceeded21, its initial polynomial
would be nonzero of degree at most two and would have to vanish
at these three distinct residues. This is impossible. Therefore
\[
\operatorname{pole}p_2\le17,\qquad
\operatorname{pole}p_1\le19,\qquad
\operatorname{pole}p_0\le21.
\]
But $p_2=U_4=v m_5$, since $\rho=0$, with $m_5=\operatorname{Tr}u$
affine in $L_{10}$. Its possible nonzero poles are10,13,16,19,20;
the bound17 therefore sharpens to16. Multiplying $p$ by $R$ gives
$U_3=p_1+bp_2\le20$ and $U_2=p_0+bp_1+ep_2\le23$.
The universal bounds $U_1\le24$, $U_0\le25$ now give
\[
\operatorname{pole}(U(W))\le27
\]
on every large pole-two sheet.

At a singleton leading large residue, which exists among at least
four distinct residues, all nine source-root differences have pole
two. Thus $F'(W)$ has pole28, $\phi(W)$ pole ten, and $D(W)$
pole18. The identity $U(W)=uD(W)$ instead gives pole28 there,
a contradiction. This closes the whole reduced-linear case.

Finally suppose a rational root $c$ of pole four is CANCELED
by $U$, still with $\rho=0$. Then $U_5=0$, $U_4=vm_5$,
and its possible nonzero poles are the same nongap list.
The equation $U(c)=0$ makes a pole19 or20 of $U_4$ uniquely
leading, against $U_3c^3\le34$ and lower terms at most31.
Thus $U_4\le16$. A pole22 or21 of $U_3$ would then be
uniquely leading (34 or33), against $U_4c^4\le32$ and lower
terms at most31. Therefore $U_3\le20$, giving the same
$U(W)\le27$ contradiction at a singleton large residue.
No squarefreeness or degree-two-gcd assumption was used in this
last canceled-root argument.

## Sharper rational-root coefficients

The actual constant coefficient bound is $\delta_0=s_1\le17$, by
[critical parity](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
Once a rational root forces $\delta_3\in\langle q,q_3\rangle$,
the non-affine remainder of $a\delta_3$ has pole at most11.
The finite quadratic coefficient is affine and
$\delta_{2,s}=\delta_{2,f}+3a\delta_3$. Its bound14 therefore
sharpens to13: an affine leading gap14 cannot occur, and the
remainder has lower pole. At a singleton large residue the exact
identity $D(W)=F'(W)/\phi(W)$ has pole18. The cubic, quadratic,
and constant terms have bounds15,17,17, so $\delta_1$ has exact
pole16. A root of pole two is impossible because $\delta_1c$
would have exact pole18 uniquely above the other terms.

## The remaining canceled pole-three branch

First there is a further cancellation valid for ANY rational
critical root. Write $z$ for an infinity uniformizer and
$\beta_i=z^2W_i$ on the five large sheets. The coefficient
$s_0$ has exact pole20: the fifth elementary source coefficient
has its unique largest term from the product of the five large
roots, and $F_5=2vq_s+s_0$ with $2vq_s\le17$.
The source polynomial therefore has leading scaled form
\[
z^{30}F(z^{-2}T)\bmod z
=T^5(v_*T^5+B_*T^2+C_*),\qquad v_*,B_*,C_*\ne0.
\]
Here $B_*$ comes from $s_2$, with $\delta_1=2s_2$ of exact
pole16; the preceding $\delta_2\le13$ removes the possible
degree-three term. The five large leading roots are distinct
and nonzero because the displayed quintic has derivative
$2B_*T$. Newton and reciprocal coefficient identities give
$\sum\beta_i=\sum\beta_i^{-1}=\sum1=0$.

The leading values of $D$ and $U$ on these sheets are
$z^{-18}d_*\beta$ and $z^{-28}(a_*\beta^4+b_*\beta^3)$.
Indeed the $U_5$ term has pole at most26, and lower numerator
terms have pole at most27. Thus the leading $u$ is
$z^{-10}\beta^2(\alpha\beta+\eta)$, and the possible
pole-ten coefficient of $u^2/\phi$ is
$\alpha^2\beta+2\alpha\eta+\eta^2/\beta$.
Its sum is zero by the three displayed sums. The selected
sheets contribute at most pole9. Since $n_0$ is affine,
this proves $n_0\in L_9$ on every rational-root branch.

Let $\rho=0$ and $U(c)=0$ with $c$ of pole three. A pole20
of $U_4$ would make $U_4c^4$ uniquely leading above
$U_3c^3\le31$ and lower terms. Hence $U_4\le19$.
If $U_4\le16$, the equation $U(c)=0$ forces $U_3\le20$
(poles22 and21 would be uniquely leading), giving the already
excluded $U(W)\le27$ on all large sheets. The nongap list
therefore forces $U_4$ of exact pole19, and cancellation at $c$
forces $U_3$ of exact pole22.

Factor $D=\delta_3(T-c)(T^2+bT+e)$. The sharper constant bound
gives $e\le5$, while $\delta_1=\delta_3(e-bc)$ of exact
pole16 forces $b$ of exact pole4. Over an algebraic closure of
the completed infinity field the two complementary roots are
$d$ of pole4 and $d_0$ of pole at most1.

Write $U=(T-c)p$. Polynomial division gives $p_3=U_4$ of
pole19 and $p_2\le22$, $p_1\le25$, $p_0\le28$.
Thus $p(d)$ has exact pole31, uniquely from $p_3d^3$.
Also $d-c$ has pole4 and $F(d)$ has pole50, since all ten
source roots have pole at most2 and $v$ has pole10.
The critical identity forces $Q=(T-c)q_1$, because $F(c)\ne0$,
and becomes
\[
(T-c)p^2-\delta_3(T^2+bT+e)V_2=Fq_1.
\]
Evaluation at $d$ makes $q_1(d)$ of exact pole16.
The explicit quadratic coefficients, together with
$c+d+d_0=-\delta_2/\delta_3$, give
\[
q_1(d)=-\delta_3(\mu_1-n_0d_0).
\]
Consequently $\mu_1-n_0d_0$ has exact pole7.

The fixed two-gap conditions on $n_0\in L_{10}$ give
$n_0\in\langle q,q_3,y\rangle$. If $n_0=0$, then
$\mu_1=\eta_1$ is affine and cannot have leading gap7.
If $n_0$ has pole6 it is proportional to $q$, whose translation
remainder $R_1q$ has exact gap11. Since $n_0d_0\le7$, the
equation would force $\mu_1\le7$, contrary to that remainder:
an affine term cannot cancel its leading gap11. Thus $n_0$
has pole9 or10.

Now $n_0d_0\le11$ gives $\mu_1\le11$. In
$\mu_1=\eta_1-R_1n_0$, the remainder has pole at most11,
so the affine regularizer initially in $L_{12}$ has no pole12
and belongs to $L_{10}$. If $n_0$ has pole9, then
$n_0d_0\le10$ forces $\mu_1\le10$; its $q$ coefficient
must vanish to remove the gap11 remainder. Therefore in this
case $n_0$ is proportional to $q_3$. The preceding universal
leading cancellation excludes its pole-ten alternative, leaving
exactly the stated pole-nine line in this canceled branch.

These necessary restrictions leave canceled roots of pole three
with the stated traces unresolved. The pole-at-most-one branch
is excluded below. They do not prove whole-profile exclusion.

## First-order cancellation and the smaller trace space

Continue on the canceled pole-three branch with $\rho=0$.
On each large sheet, with $\beta=z^2W$, the exact coefficient
budgets give
\[
D(W)=z^{-18}\bigl(d(z)\beta+z e(z)\beta^2+z j(z)+O(z^2)\bigr),
\quad d(0)\ne0,
\]
\[
U(W)=z^{-28}\bigl(B(z)\beta^3+z A(z)\beta^4
+z C(z)\beta^2+O(z^2)\bigr).
\]
The first-order quadratic term in $D$ is allowed: it is exactly
the possible pole13 of $\delta_2$. Division therefore gives
\[
u=z^{-10}\beta^2\bigl(\eta(z)+z(M(z,\beta)+r(z)/\beta)+O(z^2)\bigr),
\quad\deg_\beta M\le1.
\]
The leading factor is constant in $\beta$, because $U_4$ has
pole19 rather than20. Also $\phi=z^{-10}(\beta^5+O(z^3))$.

To order $z^2$, the scaled source polynomial has the form
\[
z^{30}F(z^{-2}T)
\equiv T^5(V(z)T^5+zS_3(z)T^3+S_2(z)T^2
+zS_1(z)T+S_0(z))\pmod{z^2}.
\]
Its two factors are coprime modulo $z$, so Hensel uniqueness
identifies the large-root quintic modulo $z^2$ with the second
displayed factor, divided by $V$. It has no degree-four term
to that order; hence $\sum\beta_i=O(z^2)$.
The leading quintic also gives $\sum\beta_i^2\bmod z=0$.
Consequently its large-sheet contribution to $\mu_2$ is
\[
z^{-14}\left(\eta(z)^2\sum_i\beta_i
+2z\eta(z)\sum_i(\beta_iM(z,\beta_i)+r(z))+O(z^2)\right),
\]
whose parenthesis has order at least two. The constant sum is
$\sum1=5=0$. Selected sheets have $u^2W^2/\phi$ pole at
most11. Thus $\operatorname{pole}_O\mu_2\le12$; no affine
regularity of this SHORT moment is claimed.

Write $\eta_1=C(x)+dy$, with $\deg C\le3$, and
$n_0=\lambda q_3$. The exact finite/short regularizer formula is
\[
\mu_2=\eta_2+y\operatorname{rem}(Z^2n_0,P)/P
-2y^2\operatorname{rem}(ZC,P)/P.
\]
The first remainder has pole at most7. The second can have
successive leading gap poles17,14,11. The bound12 forces its
first two coefficients to vanish, so $C\in\langle q,q_3\rangle$.
After those vanish the errors have pole at most11, which forces
the affine $\eta_2\in L_{14}$ to have no pole13 and belong
to $L_{12}$. This space has basis $1,x,x^2,x^3,x^4,y$ and
dimension six. Together with the one-dimensional line for
$n_0$ and the three-dimensional space $\langle q,q_3,y\rangle$
for $\eta_1$, this gives the stated upper bound of ten trace
coordinates. It is not a count of actual sources or their
annihilators.

## Exclusion of canceled rational roots of pole at most one

Assume $\rho=0$, $D(c)=U(c)=0$, and
$\operatorname{pole}_O c\le1$. Then $\delta_3=\kappa q_3$
for $\kappa\in k^*$, $\delta_2\le13$, and $\delta_1$ has exact
pole sixteen. Factor $D=\delta_3(T-c)R$, with
$R=T^2+bT+e$. The identities
$b=c+\delta_2/\delta_3$ and
$e=\delta_1/\delta_3+bc$ show that $e$ has exact pole seven.
If $\delta_2$ has exact pole thirteen, $b$ has pole four and
the complementary roots $d,d_0$ have poles four and three.
The distinct integral Newton slopes give two simple Hensel roots
in the base completion $k((z))$. If $\delta_2\le12$, then
$b\le3$ and both complementary roots have pole $7/2$ in a
quadratic extension with half-integral valuation group. This
retains every coefficient drop.

The critical identity is $U^2-DV_2=FQ$. Since $F$ and $D$
are coprime, $F(c)\ne0$, and $U(c)=0$ gives $Q(c)=0$.
The explicit quadratic $Q$ gives
$\mu_2+b\mu_1+en_0=0$ and hence
\[
Q=-\delta_3(T-c)(n_0T+\mu_1+bn_0),\qquad
Q(d)=-\delta_3(d-c)(\mu_1-n_0d_0).
\]
If $n_0\ne0$, put $a=\mu_1/n_0$. Then
\[
\mu_1^2-n_0\mu_2=n_0^2(a-d)(a-d_0).
\]
At a critical root of pole $r>2$, every source root has smaller
pole, so $F(d)$ has exact pole $10+10r$. The bounds
$U_4=v\operatorname{Tr}(u)$ with nonzero poles
$10,13,16,19,20$, and $U_j\le25-j$ for $j\le3$, give
$U(d)\le36$ for $r=4$ and $U(d)\le34$ for $r=7/2$.
Therefore the exact identity $U(d)^2=F(d)Q(d)$ gives
$Q(d)\le22$ and $Q(d)\le23$, respectively, including zeros.

The earlier rational-root cancellation puts $n_0\in L_9$;
the two fixed high-gap conditions give
$n_0\in\langle q,q_3\rangle$. A nonzero $n_0$ has pole
six or nine. In the pole-six case its first short moment
$\mu_1=\eta_1-R_1n_0$, $\eta_1\in L_{12}$, has pole
eleven or twelve: $R_1q$ has exact gap pole eleven, which
an affine regularizer cannot cancel.

For complementary poles four and three, the bound on $Q(d)$
gives $\mu_1-n_0d_0\le9$. This is impossible for $n_0$
of pole six, since $n_0d_0$ has pole nine and $\mu_1$ has
pole eleven or twelve. For $n_0$ of pole nine it forces
$\mu_1$ of exact pole twelve. Thus
$\mu_1^2-n_0\mu_2$ has exact pole twenty-four, since
$\mu_2\le14$. But $a-d_0\le0$ and $a-d$ has pole four,
so its displayed Hankel expression has pole at most twenty-two.
The case $a=d_0$ gives zero and is also impossible.

For two complementary roots of pole $7/2$,
$\delta_3(d-c)$ has pole $25/2$. If $n_0$ has pole nine,
$n_0d_0$ has pole $25/2>12$, so $Q(d)$ has exact pole
twenty-five. If $n_0$ has pole six, $n_0d_0$ has pole
$19/2$, while $\mu_1$ has pole at least eleven, so $Q(d)$
has pole at least $47/2$. Both contradict $Q(d)\le23$.
Consequently $n_0\ne0$ is impossible.

Now suppose $n_0=0$. If also $\mu_1=0$, the canceled
identity gives $\mu_2=0$ and $Q=0$. Squarefreeness of $D$
then gives $D\mid U$, so $u=U(W)/D(W)$ is polynomial
of degree at most one, contrary to the polynomial-annihilator
exclusion. This also handles any additional canceled factor.
Otherwise $\mu_1$ is a nonzero affine function in $L_{12}$,
with pole $N\in\{0,3,6,9,10,12\}$, and
$Q=-\delta_3\mu_1(T-c)$.

If both critical roots have pole $7/2$, $Q(d)$ has strict
half-integral pole $25/2+N$. The pole of $F(d)$ is the integer
forty-five; the valuation of $U(d)$ is half-integral, so the
pole of $U(d)^2/F(d)$ is an integer, a contradiction.

It remains to consider critical poles four and three. The poles
of $Q(d),Q(d_0)$ are $13+N,12+N$. If $U_4$ has pole
twenty, its fourth term uniquely leads at both roots. Then
$U(d),U(d_0)$ have poles thirty-six and thirty-two. The
identity forces $N=9$ and $N=12$, respectively, impossible.
If $U_4$ has pole nineteen, its fourth term uniquely leads
at $d$, giving $U(d)$ pole thirty-five and $N=7$, an absent
affine nongap. Therefore $U_4\le16$, including zero.

If $U_3$ has pole twenty-two, its cubic term uniquely leads
at $d$, giving $U(d)$ pole thirty-four and $N=5$, impossible.
If $U_3$ has pole twenty-one, its cubic term uniquely leads
at both roots, giving $U(d),U(d_0)$ poles thirty-three and
thirty, and hence incompatible $N=3,N=8$. Finally, if
$U_3\le20$, all terms of $U(d)$ have pole at most thirty-two.
Thus $13+N\le14$ forces $N=0$. But $d\in k((z))$ and
$F(d)$ has even pole fifty, so $U(d)^2/F(d)$ cannot have
odd pole thirteen. Only an upper bound was used here: the
possible tie and cancellation between $U_4d^4$ and $U_3d^3$
are retained.

This excludes every canceled rational root of pole at most one
on the actual $\rho=0$ m9 sector. The independent
[focused audit](../../Research/experiments/oct02_reciprocal_m9_small_root_audit.md)
passed the valuation argument and its input transfer; no settled
numerical certificate was replayed. Canceled pole-three roots,
critical cubics with no rational cancellation, and the whole
source/common-cover problem remain open.

## Stronger pole-three quotient and trace bounds

Continue with canceled $c$ of pole three. The complementary
critical roots $d,d_0$ have poles four and at most one.
At $d$, $U_4d^4$ has exact pole thirty-five, above all other
numerator terms. Thus $Q(d)=U(d)^2/F(d)$ has exact pole
twenty. The identity
$Q(d)=-\delta_3(d-c)(\mu_1-n_0d_0)$ gives
$\mu_1-n_0d_0$ of exact pole seven. With $a=\mu_1/n_0$,
$a-d_0$ has exact zero order two and $a-d$ pole four.
Consequently $\mu_1^2-n_0\mu_2=n_0^2(a-d)(a-d_0)$ has
exact pole twenty. Since $\mu_1\le10$, this forces
$\mu_2\le11$. Its regularizer formula above has remainder
pole at most eleven; the affine $\eta_2\in L_{12}$ can no
longer have pole twelve and belongs to $L_{10}$. This gives
the sharpened nine-coordinate trace bound.

Write $U=(T-c)p$, $\deg p=3$. On the five distinct large
leading residues, $p(W)=U(W)/(W-c)$ has exact pole twenty-five.
The initial-polynomial argument bounds every weighted coefficient
$\operatorname{pole}p_j+2j$ by twenty-five. The leading values
of $U$ are proportional to $\beta^3$, while $W-c$ has a
residue-independent leading term, so the initial polynomial of
$p$ is proportional to $\beta^3$. Hence $p_2\le20$,
$p_1\le22$, $p_0\le24$, and $p_3=U_4$ has pole nineteen.
The equalities $U_1=p_0-cp_1$, $U_0=-cp_0$ sharpen these to
$p_1\le21$ and $p_0\le22$.

The finite-frame quotient is integral at every finite DVR.
For integral $c_f$, use monic division of the integral $U_f$.
For $c_f$ of pole $h>0$, multiplicativity of Gauss valuation
in $U_f=(T-c_f)p_f$ gives
$\operatorname{Gauss}(p_f)\ge h$. In particular all four
coefficients vanish to at least order $h$ at each finite root
pole. At a selected endpoint where $c(P)\ne0$, the factor
$T-c$ has contact weight zero and $p$ retains weight three.
Where $c(P)=0$, it has weight one and $p$ retains weight two.

## Exclusion of the entire fixed q3 leading line

Assume now $\delta_3\in k^*q_3$ and normalize its scalar
away in the finite factor numerators. Put
$K=\operatorname{quo}(Zq_3,P)=([20],[13],[16])$. The affine
root-factor numerators are exactly
\[
q_3c_f=y^2K+C_4+\gamma y,\qquad
q_3b_f=-2y^2K+B_4+(d_0+d_1x)y,
\]
with $\deg C_4,\deg B_4\le4$.
The cubic $q_3$ is squarefree and coprime to $P,A,K$.
Its three roots are $[8]$ and two quadratic conjugates.
Neither $c_f$ nor $b_f$ has a clearing polynomial $J(x)$
of degree at most two. Such a polynomial would make $Jc$
or $Jb$ have short pole at most nine or ten, respectively;
affinity of the finite product would force all three fixed
gap forms17,14,11 to vanish, contradicting their invertible
matrix. Therefore both functions have at least one simple
pole above EACH $q_3$ root.

At a point above such a root, finite critical Gauss content
permits total pole order at most one across
$(T-c_f)(T^2+b_fT+e_f)$. The $c_f$ and $b_f$ pole-sheet
supports are disjoint. Their numerators have nonzero quadratic
$y$ coefficient, so each has support one or two; at least one
has one-sheet support in each fiber. One-sheet $c_f$ support
at $(r,y_c)$ forces $\gamma=K(r)y_c$ and hence
$\gamma^3=K(r)^3P(r)$. The three latter values are distinct,
so this occurs in at most one fiber. One-sheet $b_f$ support
forces $d_0+d_1r=-2K(r)y_b$. None of the27 cube-root
choices at all three fibers admits this affine-linear
interpolation. Thus $c_f$ has one-sheet support in exactly
one fiber and two-sheet support in the others; its pole
divisor consists of five explicit points.

For any such choice, $\gamma$ and the three values of $C_4$
are fixed. If $C_0$ is their quadratic interpolant, every
remaining geometric freedom is
$C_4=C_0+q_3(\mu+\nu x)$, $\mu,\nu\in k$. Thus
$c=c_{\rm base}+\mu+\nu x$, with
$c_{\rm base}=(y^2K+C_0+\gamma y)/q_3-Z/y$.
The base term has pole one; exact pole three means $\nu\ne0$.
Selected endpoint zero sets are precisely the strata of the
nine affine equations
$\mu+\nu x(P)=-c_{\rm base}(P)$. These fixed line
arrangements exhaust arbitrary coefficients over $k$.

The integral cubic quotient coefficient space has an exact
fifty-column parametrization. Choose arbitrary affine
$\eta_j\in L_{22-j}$, $0\le j\le3$, and define finite
coefficients downward by
\[
(p_f)_j=\eta_j-
\sum_{h=j+1}^3\binom hj\Pi_{h-j}((p_f)_h).
\]
All proper-remainder poles are gaps at most seventeen, below
the four bounds $22-j\ge19$, so these are exactly all integral
cubics with the short bounds. The dimensions are14,13,12,11.
Four coefficient zeros at each of the five root poles give
twenty rows. Weight-two contact at every selected endpoint
gives another27 rows. This47-by-50 matrix has rank47 in
every case. The three extra weight-three rows at an endpoint
are $(j,t)=(0,2),(1,1),(2,0)$. After restricting to the
exact three-dimensional base kernel, the rows at endpoints
outside EVERY possible zero stratum of $c$ have rank three.
Hence the full quotient kernel is zero, contrary to $p\ne0$.

The self-contained
[source](../../scripts/oct02_m9_uniform_quotient_probe.sage)
constructs all arithmetic, coefficient columns, jets, pole
itineraries and endpoint-zero strata over $\mathbf F_{5^{24}}$.
That field contains all fixed roots, and all ranks extend to
$k$. Simultaneous cubic rotation of $y$ and inverse rotation
of $T$ cycles the distinguished pole sheet while preserving
the coefficient/contact spaces. Frobenius25 interchanges the
quadratic $q_3$ roots and permutes endpoints. Therefore two
distinguished fibers, one pole sheet in each, nine relative
other-sheet choices and all four omitted $A$ roots cover every
case, including zeros of $v$ and arbitrary $\mu,\nu\in k$.

The executed commands were
$\texttt{sage scripts/oct02_m9_uniform_quotient_probe.sage --c-fiber 0 --certificates}$
and the same with $\texttt{--c-fiber 1}$. Each produced36
records, all base ranks47, all37 zero strata with zero
quotient kernel, and maximum selected-root zero count two.
The
[first-fiber certificate](../../../litt3-computation-data/oct02_m9_uniform/quotient_probe_q3_0_certified.json)
and
[quadratic-fiber certificate](../../../litt3-computation-data/oct02_m9_uniform/quotient_probe_q3_1_certified.json)
contain the field modulus and coordinates, explicit nonzero47-minors,
base kernels and nonzero3-minors. Generation used Sage10.9,
one core,14.75s and15.29s. The independent
[focused audit](../../Research/experiments/oct02_reciprocal_q3_pole_three_audit.md)
passed the global classification and rank transfer, reconstructed
one record in each certificate, and checked its large minor,
kernel vectors and a maximal-zero-stratum small minor. It
did not replay settled computations or the entire new sweep.

Thus the fixed $q_3$ leading line is excluded. The next argument
uniformly removes additional endpoint strata in the moving pencil.

## Every canceled pole-three root has at least three selected zeros

The full self-contained argument and exact scope are in the
[small-stratum report](../../Research/experiments/oct02_m9_uniform/EMPTY_ENDPOINT_ZERO_STRATUM_EXCLUSION.md).
Here is its canonical proof, using the reusable
[norm-minor denominator obstruction](../../Theorems/cartier_and_spin/critical_denominator_norm_minor_obstruction.md).

Let $J$ contain all selected zeros of $c$, and let $V_J$ be the
fixed fifty-column integral cubic space with contact weight two at
$J$ and three elsewhere. The actual quotient belongs to $V_J$.
This includes a selected POLE of $c$: its factor $W-c$ has weight
$-h$, so weighted Gauss content gives the stronger quotient contact
weight $3+h$. The critical-factor Gauss bounds make $\delta_3c_f$
affine. The established three-gap clearing argument makes the monic
minimum x-clearing polynomial of $c_f$ exactly
$\delta_\lambda=q_3+\lambda q$, of degree three.

For $J=\varnothing$, the space $V_J=V$ has dimension two;
it is $H^0(X,\mathcal E_{25}(-3O))$ in the canonical lower
numerator bundle. A new fixed calculation constructs a basis $g,h$.
The gcd of the six coefficient-minor norms is exactly $t(x)^3$,
where $t$ is the selected monic cubic x-support. At every selected
point the coefficient evaluation has rank one. Its annihilator line
in $\mathbf P(V)$ is constant across each three-sheet x-fiber and
distinct for the three fibers. No evaluation is zero.

It follows that every nonzero $p\in V$ has common finite coefficient
zeros above at most ONE selected x-root, and nowhere else: a common
zero forces every minor norm to vanish, hence a root of $t$.
The norm-gcd exponent three at a selected root shows that some minor
has order one at each of its three sheets. Indeed all six minors
vanish on all three sheets, and the norm order is the sum of their
orders. A common coefficient zero of order at least two would make
every minor have that order after completing $p$ to a constant basis,
a contradiction. Thus the common finite zero divisor of $p$ is
bounded by one SIMPLE full x-fiber.
Gauss content then bounds the finite poles of $c_f$ by that divisor,
so a polynomial of degree one clears them, contrary to minimum degree
three. This excludes the empty stratum for all parameters.

For all four omitted $A$ roots, a complete fixed contact calculation
checked all 144 two-endpoint sets. The 108 cross-x pairs have rank48
and hence section dimension two. They contain $V$, so equal $V$.
Every singleton is contained in such a pair. Thus the same argument
excludes all singleton and two-zero cross-fiber strata, without
symmetry compression.

Each of the other36 pairs, on one x-fiber, has a four-dimensional
section space. Let $H_J$ be the determinant of its four integral
coefficient columns. For every pair the fixed calculation gives
$H_J\ne0$ and monic norm $N_J(x)$ of degree80. Its remainder on
division by $\delta_\lambda$ has three coefficient polynomials
$R_{J,i}(\lambda)$ with explicit unit Bezout identity
$\sum_i B_{J,i}R_{J,i}=1$.
The norm-minor theorem requires the actual minimum clearing polynomial
$\delta_\lambda$ to divide $N_J$, which this identity rules out
for EVERY geometric parameter.

This application includes every denominator multiplicity and ramified
fiber. Explicitly, a root of clearing exponent $\ell$ supplies an
unramified pole $h=\ell$ or a branch pole $h\ge3\ell-2\ge\ell$.
The integral quotient coefficients and determinant have that order.
Norm order is summed over points with residue degree one, including
at a branch point; it is NOT divided by three. Thus the full cubic
divides the norm, not merely its radical. No discriminant, endpoint
value or branch coefficient has been inverted.

Sources are the
[two-section rank-drop script](../../scripts/oct02_m9_uniform_empty_stratum.sage),
[pair-contact script](../../scripts/oct02_m9_uniform_pair_contact.sage),
and [same-fiber norm script](../../scripts/oct02_m9_uniform_same_fiber_determinant.sage).
Exact certificates are
[two-section data](../../../litt3-computation-data/oct02_m9_uniform/empty_stratum_rank_drop.json),
[all pair ranks](../../../litt3-computation-data/oct02_m9_uniform/pair_contact_ranks.json),
and [all36 same-fiber norm/Bezout records](../../../litt3-computation-data/oct02_m9_uniform/same_fiber_determinants.json).
The first two calculations used Sage10.9, one core,1.334s and6.603s.
The same-fiber calculation first completed in19.30s but lost its JSON
to a Sage-integer serialization error. Corrected generation saved31
records in19.315s and resumed ONLY the five missing records in3.704s,
retaining all exact sections, determinant norms, remainder coefficients
and unit Bezout identities. The
[independent norm-minor audit](../../Research/experiments/oct02_m9_uniform/NORM_MINOR_OBSTRUCTION_AUDIT.md)
verifies the reusable valuation argument without replaying these ranks.

Therefore $c$ has at least three selected zeros. On the ordinary
five-pole itinerary its two remaining coefficients $\mu,\nu$ define
the nine affine endpoint-zero lines. Their no-three-concurrence at
$\lambda=0$ was checked in the accepted fixed-$q_3$ certificates.
Each triple-concurrence condition is a function on the finite sheet
cover and has nonzero norm at zero. Hence it supports only finitely
many parameter values. Off those values every zero set has size at
most two and is now excluded uniformly. This is a generic moving-
pencil exclusion; explicit norms and their exceptional roots are
not decided by the argument.

## The entire three-zero $1+1+1$ stratum is excluded

Suppose the selected zero set $J$ has exactly three points, one on
each selected x-fiber. Its fixed quotient space $V_J$ has dimension
five. Form the $4\times5$ affine coefficient matrix $M_J$ of a
constant basis, and its five signed maximal minors $\kappa_i$.
They give the projective coefficient-kernel map
$\psi_J:X\to\mathbf P(V_J)$ after removing their common local
base divisor.

There are108 configurations: four omitted $A$ roots and27 sheet
choices. Simultaneous cubic rotation and arithmetic Frobenius25
partition them into nine orbits of12. The exact Frobenius25
permutation of the four $A$ roots is a four-cycle.
Cubic rotation acts on short quotient polynomials by
$p_{\rm new}(x,y,W)=p(x,\omega y,\omega^2W)$, with
$c_{\rm new}(x,y)=\omega c(x,\omega y)$. Since
$a(x,\omega y)=\omega^2a(x,y)$, this also preserves finite-frame
affinity, coefficient pole bounds and every weighted endpoint contact.
Frobenius25 fixes the coefficient data over $\mathbf F_{25}$ and
transfers the same conditions while permuting endpoints.
Thus exactly nine fixed representatives suffice, without independent
rotations of individual endpoint sheets.

For EACH representative, every cofactor has pole at most82 at infinity
and some attains82. The contact lattice determinant has order six at
each weight-three endpoint and three at each weight-two endpoint.
Consequently the common finite base divisor has degree at least
$6\cdot6+3\cdot3=45$.
The exact gcd of cofactor norms has degree45. Thus the base divisor
is precisely this forced divisor $D_J$, with no other finite base
point; any further common zero would increase the norm gcd degree.
The kernel map therefore has coordinate line bundle
$L_J=\mathcal O_X(82O-D_J)$, of degree37, with no base point at
infinity. Off the selected endpoints the coefficient matrix has
rank four, including at cubic branch points.

The330 degree-seven monomials in its five coordinate sections were
expanded exactly in $x^ny^c$, $0\le c\le2$. For all nine
representatives their coefficient matrix has rank251. Riemann-Roch
gives $h^0(X,L_J^7)=7\cdot37+1-9=251$; hence the monomials
span the COMPLETE section space. Its degree259 is at least
$2g+1$, so that complete linear system is very ample. It is the
seventh Veronese of $\psi_J$, therefore $\psi_J$ itself is a
closed embedding.

If all four coefficients of $p$ vanish at an ordinary affine point
$Q$, then $\psi_J(Q)=[p]$. Embedding permits at most one such point.
Its common zero order is at most one: choose a nonzero coordinate
of $p$ and normalize it to one. The other four columns form an
invertible local matrix, so $M_Jp$ equals that matrix times the
coordinate differences $p_i-(\psi_J)_i$. If all differences had
order at least two, the projective tangent of $\psi_J$ would vanish,
contradicting immersion. This uses the local parameter on $X$, so
retains ramification of the trigonal x-map.

Selected poles are excluded separately. A selected pole of $c$ of
order $h>0$ lies outside its zero set $J$ and forces quotient
contact at least $3+h$, hence at least four. The four extra rows are
$(j,t)=(0,3),(1,2),(2,1),(3,0)$.
All81 three-zero sets not confined to one x-fiber were checked for
one omission, at each of their six outside endpoints:486 restrictions.
Every restriction leaves one quotient line, and the gcd of its four
coefficient norms has degree one. The norm-minor theorem contradicts
the required minimum cubic clearing polynomial. Frobenius25 covers
the other three omissions. This also excludes selected poles in every
exactly-three-zero $2+1$ stratum, whose ordinary poles are excluded below.

All finite poles of $c_f$ in the $1+1+1$ stratum are consequently
ordinary. They lie among at most one common zero of $p$, of order
at most one. A single x-factor clears $c_f$, contradicting minimum
degree three. This proves the entire claimed stratum exclusion.

Exact orbit source and data are
[symmetry source](../../scripts/oct02_m9_uniform_111_orbits.sage) and
[nine-orbit certificate](../../../litt3-computation-data/oct02_m9_uniform/111_endpoint_orbits.json).
The first representative's explicit nonzero251-minor is in
[the Veronese certificate](../../../litt3-computation-data/oct02_m9_uniform/veronese111_embedding.json),
from [the coefficient source](../../scripts/oct02_m9_uniform_veronese_embedding.sage)
and [restricted-minor completion](../../scripts/oct02_m9_uniform_veronese_minor.sage).
The second representative uses
[the native bridge source](../../scripts/oct02_m9_uniform_111_native.sage) and
[orbit1 rank factorization](../../../litt3-computation-data/oct02_m9_uniform/111_native_orbit1.json).
The remaining seven NEW representatives use
[batch source](../../scripts/oct02_m9_uniform_111_native_batch.sage) and
[native monomial/RREF source](../../scripts/oct02_m9_uniform_veronese_native.cpp);
their [batch index](../../../litt3-computation-data/oct02_m9_uniform/111_native_remaining_batch.json)
records completion of orbits2 through8, with separate exact cofactor
and row-factorization files for each. The native algorithm verifies
the full original-row identity $C M=R$ and the identity at its251
pivot columns; the saved row combinations give the lower-rank
certificate. The geometry supplies the matching upper bound251.

Only the CHANGED native monomial generator was compared against Sage,
on3456 exact field entries in six columns; its
[focused comparison record](../../../litt3-computation-data/oct02_m9_uniform/native_veronese_generator_check.json)
passed. Existing embeddings were not replayed. Generation used one
core: orbit1 total21.776s; the seven new optimized cases total38.084s.
The first representative's generic Sage rank took39.083s, and its
necessary251-minor completion took64.069s, exceeding an estimated
40s allowance; hard in-process alarms were installed subsequently.

The full selected-pole source is
[weighted-contact source](../../scripts/oct02_m9_uniform_all_triple_selected_poles.sage),
with [all486 exact lines and norm gcds](../../../litt3-computation-data/oct02_m9_uniform/all_triple_selected_poles.json).
Its first hard20s run retained51 completed triples; only the remaining
30 were resumed in12.330s. No cofactor or embedding rank was replayed.

## Section-span deficit excludes the entire three-zero $2+1$ stratum

The exact216 configurations of type $2+1$ form eighteen orbits of12
under the SAME diagonal cubic rotation and arithmetic Frobenius25
used above. No independent endpoint rotations are assumed.
Every representative has a dimension-five fixed quotient space
and signed coefficient minors attaining pole82 at infinity.
Their exact common norm gcd has degree47. Local series at each
selected endpoint give common order3 at the two zero points of
the doubled x-fiber, order5 at the singleton zero point and order6
at the six other selected endpoints. These orders sum to47; hence
there is no further finite common base point. The reduced coordinate
bundle $L_J$ has degree35, and the coefficient matrix has rank4
away from the selected endpoints, including cubic branch points.

For every one of the eighteen representatives, the330 degree-seven
coordinate monomials have exact rank236. Riemann-Roch gives
$h^0(X,L_J^7)=245+1-9=237$, so their span $S_J$ has codimension1.
This does NOT assert that these kernel maps embed. The following
general observation gives precisely the bound needed here.

Use [the general section-span clearing bound](../../Theorems/cartier_and_spin/section_span_clearing_degree_bound.md).
For completeness its fiber-length argument is as follows.
Let $\psi:C\to\mathbf P^m$ be any nonconstant morphism from a
smooth projective curve of genus $g$, with coordinate line bundle
$L$. Let the degree-$n$ coordinate monomial span have codimension
$t$ in $H^0(C,L^n)$, and suppose $\deg L^n\ge2g+t+1$.
Then every scheme-theoretic fiber of $\psi$ has length at most
$t+1$. Otherwise choose a length-$(t+2)$ subscheme $Z$ in that
finite fiber. The degree bound gives $H^1(L^n(-Z))=0$, so full
sections restrict surjectively to a space of dimension $t+2$.
A codimension-$t$ subspace restricts with dimension at least2.
But on a scheme fiber all projective-coordinate ratios are constant:
after trivializing by a nonvanishing coordinate, every degree-$n$
monomial is a constant multiple of one section. Its restriction span
has dimension at most1, a contradiction. This retains inseparability,
tangent multiplicities and several distinct fiber points.

Here $\deg L_J^7=245\ge2\cdot9+1+1$ and $t=1$.
Every kernel-map fiber therefore has length at most2. At a rank4
point, the common coefficient-zero ideal of a constant quotient
section $p$ is exactly the fiber ideal over $[p]$: choose a nonzero
coordinate $p_i$; the other four columns are locally invertible,
and identify the coefficient vector with the four projective-coordinate
differences. Thus the common finite coefficient zeros of $p$ away
from selected endpoints have total length at most2.

Selected poles were independently excluded by the486 strengthened
contact quotient-line tests above. At a point of the actual zero set
$J$, the root $c$ is zero and cannot have a pole. Consequently all
finite poles of $c_f$ lie off the selected endpoints. Gauss content
makes their local pole orders $h_Q$ at most the common coefficient
zero orders, so $\sum_Q h_Q\le2$. For the finite separable x-map,
the minimum clearing polynomial has degree
$\sum_a\max_{Q\mid a}\lceil h_Q/e_Q\rceil\le\sum_Qh_Q\le2$.
This contradicts the already proved minimum degree3. The argument
retains every repeated leading-cubic root, cubic branch point and
selected-endpoint critical denominator. It excludes ALL type-$2+1$
exact-three-zero strata.

Exact orbit enumeration is
[the permutation source](../../scripts/oct02_m9_uniform_21_orbits.py) and
[eighteen-orbit data](../../../litt3-computation-data/oct02_m9_uniform/21_endpoint_orbits.json).
Two NEW prototype ranks, for orbits0 and3, use
[the prototype source](../../scripts/oct02_m9_uniform_21_native.sage) and
[prototype0 data](../../../litt3-computation-data/oct02_m9_uniform/21_native_prototype0.json),
[prototype1 data](../../../litt3-computation-data/oct02_m9_uniform/21_native_prototype1.json).
Their common base support was localized by
[the local-series source](../../scripts/oct02_m9_uniform_21_base_localization.sage) and
[exact local orders](../../../litt3-computation-data/oct02_m9_uniform/21_kernel_base_localization.json).
The remaining sixteen NEW representatives use
[the checkpointing source](../../scripts/oct02_m9_uniform_21_native_batch.sage) and
[complete batch index](../../../litt3-computation-data/oct02_m9_uniform/21_native_remaining_batch.json).
Each per-orbit record stores the exact contact kernel, its coefficient
sections and cofactors, norm gcd, nine local base orders and native
row-factor certificate. The same already verified native monomial
generator and full augmented-row identity are used; no settled rank
is replayed. The geometry gives upper bound237 and the exact factors
give rank236, which is the sufficient threshold for this argument.
The two prototypes took7.341s total. The sixteen-case batch retained
thirteen completed NEW ranks under its hard75s cap; a resume skipped
all completed records and ran only the remaining three in16.416s
under a25s cap. Initialization errors before any completed batch
rank were corrected and are documented in the
[full scope note](../../Research/experiments/oct02_m9_uniform/21_KERNEL_GEOMETRY.md).

## Every unramified singleton critical support is excluded

Suppose $\rho=0$ and a canceled rational critical root $c$ has pole3
at infinity. Normalize its leading critical coefficient as
$\delta=\delta_\lambda=q_3+\lambda q$; the nonzero scalar multiple
in the original $\delta_3$ is absorbed into the numerator coefficients.
Write $c_f=c+a$, $b_f=b-2a$, where $a=Z/y$. Exact source reductions give
$\delta c_f=y^2K_\lambda+C_4+\gamma y$ and
$\delta b_f=-2y^2K_\lambda+B_4+(d_0+d_1x)y$,
with $Z\delta=P K_\lambda+R_\lambda$, $\deg K\le2$,
$\deg C_4,\deg B_4\le4$ and scalar $\gamma$.
Both roots have minimum polynomial clearing denominator precisely
$\delta$, of degree3. At every unramified root of multiplicity
$\ell$, each root reaches pole order $\ell$ somewhere, and their
maximal pole supports are disjoint by Gauss content in the integral
critical polynomial. The quotient $U=(W-c)p$ is affine in the finite
frame, with four coefficients vanishing at least to the local pole
order of $c_f$ at every finite pole. Its exact selected zero set $J$
relaxes weighted contact from3 to2 there.

The claim is that $c_f$ CANNOT have maximal pole support consisting
of exactly one sheet over any unramified root of $\delta$.
No simplicity assumption on that root or the other critical roots is
made at the outset.

### A selected pair forces a finite parameter support

At an unramified singleton support over $r_0$, the nonzero numerator
vanishes on the other two cubic sheets. Its quadratic coefficient
$K(r_0)$ cannot vanish, since a nonzero linear polynomial vanishes
on at most one of three distinct sheets. Hence
$\gamma=K(r_0)y_0\ne0$ and $\gamma^3=K(r_0)^3P(r_0)$.
This is a residue statement even for a repeated $\delta$ root.

At a selected endpoint fiber $x=s$, the short numerator is
$\delta c=C_4+\gamma y-R_\lambda y^2/P$.
It is a nonzero polynomial of degree at most2 in $y$, because
$\gamma\ne0$. Therefore $J$ has at most two points in each selected
fiber. Version10 excludes every selected zero set of size at most3
in this situation. Thus $|J|\ge4$, and some selected fiber contains
two zeros. If its remaining sheet has coordinate $z_s$, then
$\gamma=-R_\lambda(s)z_s/P(s)$, so
$\gamma^3=-R_\lambda(s)^3/P(s)^2$.
Consequently
$E_s(\lambda)=\operatorname{Res}_x(\delta_\lambda,
P(s)^2K_\lambda(x)^3P(x)+R_\lambda(s)^3)=0$.

The four exact polynomials $E_s$ have degree10, factor over the
$A$-root field $\mathbf F_{5^8}$ in degrees1,1,8, and have pairwise
Bezout gcd1. The first linear factor is $\delta_\lambda(s)=0$.
Each support is coprime to the discriminant of $\delta$,
$\operatorname{Norm}_\delta(P)$ and $\operatorname{Norm}_\delta(K)$.
Thus the original possibly repeated/branch critical cubic is now
forced to have three simple unramified roots with nonzero $K$.
Two doubled selected fibers would require two coprime $E_s$ to
vanish simultaneously, which is impossible. It follows that $J$
has EXACTLY four points, with distribution $2+1+1$.

Exact support and factor data:
[four resultants](../../../litt3-computation-data/oct02_m9_uniform/same_fiber_zero_parameter_resultants.json),
[six pairwise Bezout identities](../../../litt3-computation-data/oct02_m9_uniform/two_pair_support_exclusion.json).
The resultant calculation is a finite necessary-condition support,
not a finite-field search over source coefficients.

### The selected-boundary linear factor is impossible

Suppose $\delta(s)=0$. Its root is simple by the support calculation.
The two selected zeros of $c$ force $\delta c$ to have order at
least2 on their sheets. Put $H=-R_\lambda/P$. At $s$ the residue
conditions give $\gamma=H(s)z_s$; also $H(s)=K(s)\ne0$.
For the local parameter $x-s$, each sheet satisfies
$y'=P'y/(3P)$. Subtract the first derivatives of
$C_4+\gamma y+Hy^2$ at the two zero sheets. Their distinct
coordinates sum to $-z_s$, and the difference of derivatives equals
$-z_s(y_1-y_2)(H'+P'H/(3P))$.
Its vanishing requires
$3P(s)R_\lambda'(s)-2P'(s)R_\lambda(s)=0$.
For each of the four selected roots at
$\lambda=-q_3(s)/q(s)$, this scalar is NONZERO.
Therefore all four selected-boundary factors are excluded. This
uses actual first jets; a two-sheet residue cancellation alone would
not justify removing this factor.

Source:
[first-jet scalars](../../scripts/oct02_m9_uniform_endpoint_pair_derivative.sage).
Certificate:
[all four nonzero values](../../../litt3-computation-data/oct02_m9_uniform/endpoint_pair_first_jet_obstruction.json).
One core0.057s, hard5-second alarm.

### Normalization and exact geometric parameter coverage

Fix $z^3=P(s_0)$ at an $A$ root, and write $Y=y/z$.
All selected $Y$ coordinates lie in $\mathbf F_{5^8}$: the four
$A$ roots are one Frobenius25 orbit, so all cube roots are
$\omega^jz^{25^i}$, and
$z^{25^i-1}=P(s_0)^{(25^i-1)/3}\in\mathbf F_{5^8}$.
The normalized curve is $Y^3=P/P(s_0)$, and normalized short/finite
coordinates are divided by $z^2$; in particular
$a/z^2=Z/(P(s_0)Y)$.
This is an invertible constant coordinate change after base extension.
It retains the source and its two maps and preserves all pole and
weighted contact bounds.

For a fixed omission there are81 type-$2+1+1$ zero sets. Diagonal
cubic rotation fixes the remaining sheet of the doubled fiber to
one chosen cube root, leaving27 representatives: three choices of
doubled fiber and nine single-sheet pairs. No independent endpoint
rotations are used. Frobenius25 covers the four omitted-root choices.
For each doubled fiber there are two remaining parameter factors,
one linear and one irreducible of degree8 over $\mathbf F_{5^8}$.
For the latter, one root in $\mathbf F_{5^{64}}$ suffices because
the map $v\mapsto v^{5^8}$ fixes every normalized endpoint and coefficient and
permutes its eight roots transitively. Thus EXACTLY54 fixed
parameter/contact-space tests cover all geometric possibilities.
All quotient coefficients may lie in an arbitrary algebraic extension;
the matrix kernels and divisibility obstructions hold after base
extension. They are not restricted to finite-field point solutions.

### Singleton evaluation makes the norm obstruction square

Every one of the27 fixed contact spaces has dimension8 inside the
50-dimensional affine cubic coefficient space. For every one of
the six parameter-factor representatives the gcd
$\gcd(\delta,K^3(P/P(s_0))-(\gamma/z)^3)$ is linear. It therefore
locates the unique singleton critical fiber, and its singleton
coordinate is $Y_0=(\gamma/z)/K(r_0)$ in $\mathbf F_{5^{64}}$.
The other critical roots need not be split or adjoined.

The four necessary coefficient evaluations $p_{f,j}(r_0,Y_0)=0$
cut EACH eight-dimensional contact space to dimension4. For a
constant basis of that four-dimensional space form its four-by-four
coefficient determinant $H_p$. Its trigonal norm modulo $\delta$
has gcd with $\delta$ of degree1 in ALL54 tests. In particular
$\delta$ does not divide that norm. The
[norm-minor obstruction](../../Theorems/cartier_and_spin/critical_denominator_norm_minor_obstruction.md)
requires the minimum clearing polynomial of $c_f$ to divide every
maximal coefficient-minor norm, including this one. Contradiction.
This single determinant handles all remaining finite poles and all
geometric $C_4$ parameters; no search over their two free coefficients
is needed.

The two new prototypes were run first, one for each ordinary factor.
The full batch references those certificates and ran ONLY52 new
tests. All determinants were calculated in the nine-dimensional
algebra modulo $\delta$, using $Y^3=P/P(s_0)$, so no large-field
critical-sheet tower is introduced. Sources:
[linear prototype](../../scripts/oct02_m9_uniform_four_zero_prototype.sage),
[degree-eight prototype](../../scripts/oct02_m9_uniform_four_zero_degree8.sage),
[complete batch](../../scripts/oct02_m9_uniform_four_zero_batch.sage).
The exact54-record index is
[ordinary batch certificate](../../../litt3-computation-data/oct02_m9_uniform/four_zero_ordinary_batch.json),
and all27 fixed contact kernels are in
[contact-space certificate](../../../litt3-computation-data/oct02_m9_uniform/four_zero_contact_spaces.json).
The prototypes took0.684s and1.287s; the52-new-test batch took18.875s
on one core under a60-second hard alarm. Initialization failures
were corrected before the relevant completed computations; no
completed parameter/contact norm certificate was replayed.

## The entire remaining canceled pole-three branch is excluded

Use the preceding affine factor numerators, exact minimum clearing
denominators and Gauss bounds. Every actual quotient p has weighted
contact at least2 at all nine selected endpoints, regardless of its
root zero set or poles. Both actual finite etale maps remain retained.

At an unramified root $r$ of multiplicity $\ell$, minimum clearing
degree forces each of $c_f,b_f$ to attain pole $\ell$ on at least
one sheet. If $K(r)=0$, both residue numerators are nonzero linear
polynomials in the three distinct y-values. Each therefore has
maximal pole support on at least two sheets. The supports intersect,
contradicting the Gauss bound $h_c+h_b\le\ell$.
Thus $K(r)\ne0$ at every unramified critical root.

At a cubic-branch root, $y$ is a local parameter and
$\operatorname{ord}(x-r)=3$. If $\delta$ has multiplicity
$\ell$, each minimum clearing denominator forces
$h_c,h_b\ge3\ell-2$. Gauss gives
$6\ell-4\le3\ell$, so $\ell=1$. Repeated branch roots are
impossible. For a simple branch root the two positive pole orders
are among $(1,1),(1,2),(2,1)$.
Consequently $C_4(r)=B_4(r)=0$: a nonzero constant numerator
would give pole3, leaving no positive pole for the other factor.
If $\gamma\ne0$, then $c_f$ has pole2, so Gauss forces
$D_1(r)=0$ and $b_f$ pole1. If $\gamma=0$ and $K(r)=0$,
the $c_f$ numerator has order at least3, contradicting its required
pole. If $K(r)=0$ and $\gamma\ne0$, the forced $D_1(r)=0$
makes the $b_f$ numerator order at least3, again impossible.
Thus $K$ is nonzero at branch roots as well.

### Gamma-zero branch parameters are excluded

Suppose $\gamma=0$. At a selected fiber the short numerator is
$\delta c=C_4-Ry^2/P$. If $R(s)\ne0$, its three distinct y-values
give at most one actual selected c-zero, even if $\delta(s)=0$:
an actual zero necessarily makes that numerator vanish. If all
three selected R-values were nonzero, the entire selected zero set
would have size at most3, distributed over distinct fibers if its
size is3. The established small-stratum exclusions rule this out.
Hence $R_\lambda(s)=0$ for some selected $A$ root $s$.

The product $T_R(\lambda)=\prod_{A(s)=0}R_\lambda(s)$ has exact
degree4 and Bezout gcd1 with the cubic-branch parameter polynomial
$\operatorname{Res}_x(\delta_\lambda,P)$, as well as with the
discriminant, Kummer-zero and selected-critical parameter polynomials.
The latter disjointness gives $\delta(s)\ne0$ on this support;
only then may one identify vanishing numerator values with actual
c-values and infer a full three-zero selected fiber.
Therefore no $\gamma=0$ source can lie on a cubic-branch parameter.
This retains larger selected zero sets: the argument needs only
existence of a full three-zero fiber, not equality $|J|=3$.

Source:
[gamma-zero support](../../scripts/oct02_m9_uniform_zero_gamma_boundary.sage).
Exact four linear factors and Bezout identities:
[certificate](../../../litt3-computation-data/oct02_m9_uniform/zero_gamma_selected_support_boundary_exclusion.json).
One core0.052s, hard5-second alarm.

### Full cube divisibility retains repeated unramified roots

At each unramified critical root, maximal c-support cannot have
size1 by the preceding singleton exclusion, cannot have size3 because $b_f$ must attain
its own maximal pole on a disjoint sheet, and is therefore size2.
On those two sheets $c_f$ has pole $\ell$, so Gauss forces $b_f$
to be regular. Its numerator
$N_b=B_4+D_1y-2Ky^2$ vanishes to order at least $\ell$ along
both analytic sheets. Their difference is
$(y_1-y_2)(D_1-2K(y_1+y_2))$.
The factor $y_1-y_2$ is a unit, and $y_1+y_2=-y_b$ for the
remaining cubic sheet. Thus
$D_1=-2Ky_b\pmod{(x-r)^\ell}$ and
$D_1^3+8K^3P=0\pmod{(x-r)^\ell}$.
This is a jet identity to the FULL multiplicity of the leading
cubic, not merely its radical.

Every branch root is simple. Gamma-zero branch parameters were just
excluded; when $\gamma\ne0$, the local classification gives
$D_1(r)=0$. Since $P(r)=0$, the same cube polynomial vanishes
there modulo $x-r$. Combining all local factors yields the global
necessary condition
$\delta_\lambda\mid D_1^3+8K_\lambda^3P$.
It includes arbitrary repeated unramified roots and all simple
branch roots before their parameter supports are excluded.

The actual exact pole4 of $b$ forces $D_1=A+Bx$ with $B\ne0$.
Indeed
$b=(B_4+D_1y+2y^2R/P)/\delta$.
The rational term has pole at most3 and the proper remainder term
at most2. A constant $D_1$ term has pole at most1, whereas its
nonzero x-coefficient has pole4. Thus a zero slope is not an
unhandled actual coefficient boundary.

### A complete finite parameter support, including leading drops

Write $\delta=x^3+d_2x^2+d_1x+d_0$ and
$g_0+g_1x+g_2x^2=-8K^3P\pmod\delta$.
Put $t=A/B$ and $\kappa=B^3\ne0$. The cube congruence is
$g=\kappa[(t^3-d_0)+(3t^2-d_1)x+(3t-d_2)x^2]$.
Therefore the two polynomials
$f=g_1(3t-d_2)-g_2(3t^2-d_1)$ and
$h=g_0(3t-d_2)-g_2(t^3-d_0)$ have a common FINITE t-root.
Their exact resultant in t is
$\operatorname{Res}_t(f,h)=g_2^2F(\lambda)$, where $F$ has
degree12 and factors over $\mathbf F_{25}$ into distinct
irreducible factors of degrees4 and8.

The leading drop $g_2=0$ is not discarded. Since $\kappa\ne0$,
it forces $t=d_2/3$, and hence
$g_0(d_2^2/3-d_1)-g_1(d_2^3/27-d_0)=0$.
This drop polynomial has Bezout gcd1 with $g_2$, so no actual
source lies there. Thus every remaining actual source has
$F(\lambda)=0$. The primitive polynomial $F$ is coprime to
the discriminant and cubic-branch parameter polynomials, as well as
the Kummer-zero and selected-critical supports. The leading cubic
is consequently forced to be simple ordinary, despite allowing all
those boundaries at the start.

Sources:
[raw resultant](../../scripts/oct02_m9_uniform_no_single_resultant.sage) and
[leading-drop exclusion](../../scripts/oct02_m9_uniform_no_single_leading_drop.sage).
Exact polynomial data:
[degree-twelve support](../../../litt3-computation-data/oct02_m9_uniform/no_single_affine_cube_parameter_support.json) and
[drop Bezout identity](../../../litt3-computation-data/oct02_m9_uniform/no_single_leading_drop_exclusion.json).
The raw support has degree14 including the extraneous quadratic
drop factor; only the proved drop obstruction permits removing it.
The final corrected records took0.094s and0.053s, respectively.

### Universal two-sheet content gives zero quotient space

Normalize $Y=y/z$ by an endpoint cube root as in Version11.
All selected Y-values and coefficient-space data lie in
$\mathbf F_{5^8}$. A degree4 parameter lies in that field; a
degree8 parameter lies in $\mathbf F_{5^{16}}$.
For one root of EACH irreducible factor, the finite-t gcd has degree1.
All t-values are therefore recovered; there is no remaining multiple-t
or leading-drop stratum. The normalized slope $B/z$ is a cube root
of $\kappa/P(s_0)$, and lies in $\mathbf F_{5^{48}}$.
Its three choices are covered by the diagonal cubic rotation.

At a critical x-root the unique b-pole sheet has
$Y_b=-\widetilde D_1/(2K)$, where
$\widetilde D_1=D_1/z$. The other two sheets are c-poles.
For every finite quotient coefficient
$p_{f,j}=h_{j,0}+h_{j,1}Y+h_{j,2}Y^2$, vanishing on those two
sheets is equivalent to
$Kh_{j,1}+(\widetilde D_1/2)h_{j,2}=0\pmod\delta$ and
$K^2h_{j,0}-(\widetilde D_1^2/4)h_{j,2}=0\pmod\delta$.
These supply24 linear rows on the fixed50-dimensional affine
quotient coefficient space. The minimum contact2 at all nine
selected endpoints supplies27 further rows. No values of
$\gamma$, $C_4$, $B_4$, $\mu$, $\nu$ or selected zero set are
enumerated or restricted by these universal rows.

For one root of each factor and EVERY one of the four omissions,
the51-by50 matrix has exact rank50. Arithmetic Frobenius25 acts
jointly on parameter and omission, transferring each factor root
to every conjugate while permuting the four omissions. Taking all
four omissions for each of the two representative roots therefore
covers every joint parameter/omission orbit. Only diagonal cubic
rotation is used for slope phases; no independent sheet rotations
are presumed. All source coefficients remain arbitrary geometric
scalars because full matrix rank is preserved by base extension.
Thus the actual nonzero quotient $p$ cannot exist.

The first quartic prototype took0.743s and stored rank50/kernel0.
The complete batch references that certificate and executed ONLY
seven new ranks in3.458s under a30-second hard alarm. Each new
record contains an explicit nonzero50-by50 minor and its row indices.
Sources:
[prototype](../../scripts/oct02_m9_uniform_no_single_content_prototype.sage) and
[complete batch](../../scripts/oct02_m9_uniform_no_single_content_batch.sage).
Certificates:
[quartic prototype](../../../litt3-computation-data/oct02_m9_uniform/no_single_content_quartic_prototype.json) and
[all eight joint representatives](../../../litt3-computation-data/oct02_m9_uniform/no_single_content_complete.json).
No critical x-roots or their sheet towers were adjoined.

The known compact F25 encoding defect and its necessary corrected
certificate regeneration are documented in the [complete scope note](../../Research/experiments/oct02_m9_uniform/ALL_RATIONAL_CANCELLATION_EXCLUSION.md).
The original coordinate-list singleton certificates and settled ranks
were unaffected. The author boundary argument passed a focused root
mathematical review and an independent [whole-branch audit](../../Research/audits/M9_FULL_RATIONAL_CANCELLATION_AUDIT_2026_10_02.md),
which reviewed the new implications and recorded fields without
replaying settled numerical certificates. Its gamma-zero inference-order
clarification is applied above.

## Coprimality and remaining scope

The actual critical cubic is squarefree by the independent theorem.
A gcd of degree one would supply a canceled rational root, now
impossible for every pole profile and finite boundary. Degree-two
gcds were excluded in the first part of this proof. If D divides U,
the actual annihilator u=U(W)/D(W) is polynomial in W of degree at
most one because rho=0 gives degree U at most four. This contradicts
[the actual low-polynomial annihilator theorem](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
Therefore gcd(D,U)=1 over k(X). The uncanceled critical cubic may
still be reducible or irreducible. Neither the actual m9 profile nor
the unmarked common-cover problem is decided by coprimality.
