# A local endpoint ledger excludes affine-linear annihilators

1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
The global inputs are the actual support reduction and
[primitive discriminant budget](../../Theorems/cartier_and_spin/admissible_degree_ten_critical_parity_section.md).
The conditional numerator consequence uses
[the exact quadratic incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md).

Work in a split étale disk $R=k[[r]]$ at a finite selected endpoint.
All $s$ selected short roots $W_i$ belong to $rR$ and have $u_i$
of exact order two. Each unselected $u_j$ is a unit. An unselected
regular $W_j$ has nonzero residue: residue zero would make
$\phi_j=W_j^5+q_s$ have positive order, whereas its unselected
valuation is zero. An unselected nonregular root has a $G$ pole.
The same argument works after any common regular translation of
the finite coordinate. The coefficient $A$ is nonzero whenever this
disk has both selected and unselected sheets, because a base-field
$u$ has the same valuation on all sheets. More generally, $A=0$
would force $E$ to be a union of five complete fibers: the selected
and unselected valuations differ at every base point, including
infinity, so no fiber can be partially selected. Since $E$ is reduced
and has degree $5n$, exactly five fibers are selected, possibly
including infinity. This gives projected support five,
contrary to the parity theorem's lower bound
$\lceil25n/(4n+1)\rceil\ge6$ for $n\ge6$.

Suppose first that $A$ has pole order $a>0$. From
$B_1/A=u_i/A-W_i$ on any selected sheet one obtains
$\operatorname{ord}(B_1/A)\ge1$. Every unselected root has order
zero or a negative order. Thus $W_j+B_1/A$ has that same
nonpositive order, and $A(W_j+B_1/A)$ has negative order.
This contradicts $u_j$ being a unit. Therefore $A$ has no pole
at this endpoint.

If $A$ is a unit, $B_1/A\in rR$ and
$W_i\equiv-B_1/A\pmod{r^2}$ on every selected sheet.
The unselected roots cannot have poles, since $B_1$ is integral
and their $u_j$ are units. Hence $v$ is a unit in this disk.
Every selected-selected difference has order at least two and all
other differences have nonnegative order. The raw discriminant
formula gives
\[
\operatorname{ord}\operatorname{Disc}(F)
\ge2\binom{s}{2}\cdot2=2s(s-1).
\]
Since $\operatorname{ord}_P t=s/5$, division by $t^{20}$ subtracts
$4s$. This proves the unit-case bound.

If $A$ has zero order $a\ge1$, each selected product $A W_i$
has order at least two. Therefore $B_1$ has order at least two.
For each unselected $j$, the unit identity $u_j=A W_j+B_1$
then forces $W_j$ to have exact pole order $a$. Primitive content
has order $\ell a$. Selected-selected differences have order at
least one, unselected-unselected differences have order at least
$-a$, and cross differences have exact order $-a$.
The complete lower ledger is
\[
\operatorname{ord}\operatorname{Disc}(F)
\ge(2n-2)\ell a-\ell(\ell-1)a-2s\ell a+s(s-1)
=\ell(\ell-1)a+s(s-1).
\]
Subtracting $4s$ proves the second bound. Collisions among the
unselected roots only increase the lower bound. Finite zeros of
$v$ are included through its exact primitive content order.

For $n=10,11$ the support theorem gives nine distinct finite
selected endpoints, each with $s=5$. At every such point either
$A$ is a unit and the bound is twenty, or $A$ has a positive-order
zero and the bound is $20a$ in degree ten and $30a$ in degree
eleven. Thus the nonzero function $C$ has at least 180 finite zeros.
It is affine regular and has its only possible pole at $O$, of
order at most 160 or 170, respectively. Equality of the total
zero and pole degrees contradicts this. The actual sources in
these degrees are primitive by the support-content corollary of
[the annihilator theorem](../../Theorems/cartier_and_spin/admissible_annihilator_trace_vanishing.md),
so no extra primitivity assumption is needed for the exclusion.

For the conditional assertion, $Q=0$ gives $U^2=DV_2$.
Over $k(X)$ a squarefree $D$ dividing $U^2$ divides $U$.
Since $D$ is cubic and $\deg U\le5$, the quotient $U/D$ has degree
at most two. The following quadratic exclusions apply. If $\rho=0$,
then $\deg U\le4$ and the quotient has degree at most one, so the
earlier exclusion applies in every profile. A repeated critical
factor would invalidate this divisibility step; it is retained as
an explicit hypothesis. The three zero moments together with
$\rho=0$ make the displayed exact cubic quotient zero; no rank
assertion is used to infer them.

## Four degree-ten one-big quadratic profiles

Suppose $u=A W^2+B_1W+B_2$ in one of the four stated profiles.
The annihilator interpolation identity at the primitive root gives
$U(W)=D(W)u$. Since $\deg D=3$ and $\deg(Du)\le5<10$, this
identity is the polynomial equality $U=Du$. Its leading coefficient
therefore gives $A\delta_3=v\rho$. If $A=0$, the linear exclusion
already applies. Otherwise put $p_A=\operatorname{pole}_O A$,
allowing a negative pole bound when $A$ vanishes. Since $\delta_3$
has exact pole twelve and $\rho$ has pole at most six,
\[
p_A\le d-6.
\]
On selected sheets the quadratic term has pole at most $d-4\le5$,
and on the four pole-two unselected sheets it has pole at most
$d-2\le7$. Write $p_B=\operatorname{pole}_O B_1$ and
$p_C=\operatorname{pole}_O B_2$, using $-\infty$ for zero functions.
Because $u$ has exact pole eight on each selected sheet,
\[
p_C\le\max(p_B+1,8).
\]
If $p_B<8$, all three terms on a pole-two unselected sheet have
pole at most nine, contrary to its required pole ten. If $p_B>8$,
the term $B_1W$ has exact pole $p_B+2>10$, while the other two
terms have strictly smaller poles and cannot cancel it.
Consequently $p_B=8$ and $p_C\le9$.

On the unique big sheet, $B_1W$ now has exact pole $20-d$.
The quadratic term has pole at most
$d-6+2(12-d)=18-d$ and the constant term has pole at most nine.
For each $d=0,3,6,9$, the unique largest pole is $20-d>10$.
This contradicts the required pole ten of $u$ there. The proof
uses only upper budgets on selected roots, so also covers regular
selected roots and coincident leading residues.

## Five pole-two roots in degree ten

Now $d=10$ and the profile theorem gives at least four distinct
nonzero leading residues $\beta$ of the five unselected roots.
Let $R=\max(p_A+4,p_B+2,p_C)$. If $R>10$, the order-$R$
initial part of $A W^2+B_1W+B_2$, evaluated at such a root, is a
polynomial of degree at most two in $\beta$. It is nonzero as a
polynomial, since at least one coefficient attains the defining
maximum. Yet it must vanish at every one of the at least four
distinct residues, because $u$ has pole only ten. This is impossible.
Hence $p_A\le6$, $p_B\le8$ and $p_C\le10$.
On selected sheets the first two terms have poles at most eight
and nine, respectively, while $u$ has pole eight. Thus $p_C=10$
is impossible and $p_C\le9$.

Writing $m=\operatorname{pole}_O\delta_3$ and using
$A\delta_3=v\rho$ gives
$10+\operatorname{pole}_O\rho-m\le6$ for nonzero $\rho$.
Since $\rho\in\langle1,x,x^2\rangle$, a nonzero $\rho$ has pole
zero, three or six. At $m=3$ none is possible. At $m=6$ only
a constant is possible, and at $m=9$ its $x^2$ coefficient vanishes.
If $\rho=0$, the leading quadratic coefficient $A$ is zero and
the earlier linear exclusion applies.

## The zero critical quotient and the gap cases

Every quadratic expression has $U=Du$ as a polynomial, as above.
The second interpolator has $V_2(W)=D(W)u^2$, and both $V_2$
and $Du^2$ have degree below ten (the latter has degree at most
seven). Primitivity therefore gives $V_2=Du^2$. Consequently
$U^2-DV_2=0$ and the exact critical quotient is $Q=0$.
Comparing its quadratic, linear and constant coefficients gives
\[
n_0=n_1=0,\qquad n_2=v\rho^2/\delta_3.
\]
The first two vanishings make the second moment invariant under
translation of the coordinate. Thus $n_2$ is both the finite-frame
and short-frame moment, and is affine with pole at most fourteen.
For $m=6$, $\rho$ is a nonzero constant and $n_2$ has exact
pole four. For $m=9$, its possible exact poles are one and seven.
All are gaps of the fixed semigroup $\langle3,10\rangle$.
These two profiles are therefore impossible.

Write $v=V(x)+\gamma y$ with $\deg V\le3$ and $\gamma\ne0$;
its exact pole is ten. At $m=12$, a constant $\rho$ would make
$n_2$ a nonzero affine function vanishing at infinity, and a
linear $\rho$ would give gap pole four. Hence $\deg\rho=2$ and
$n_2$ has exact pole ten. Express $\delta_3=q(x)+\sigma y$ and
$n_2=p(x)+\epsilon y$, where $\epsilon\ne0$ is constant.
In $\delta_3n_2=v\rho^2$, the $y^2$ coefficient gives
$\sigma\epsilon=0$, hence $\sigma=0$. The $y$ coefficient then
gives $q\epsilon=\gamma\rho^2$. Thus
\[
\delta_3=c\rho^2,\qquad n_2=v/c\qquad(c\ne0).
\]
At $m=10$, the $y$ coefficient of $\delta_3$ is nonzero, while
$n_2$ has pole at most twelve and hence again has only a constant
$y$ coefficient. Comparing $y^2$ forces that coefficient to be
zero; comparing $y$ and then the constant coefficient gives
\[
\delta_3=cv,\qquad n_2=\rho^2/c\qquad(c\ne0).
\]
The following arguments exclude these two proportionality cases.

## Finite-frame content and the pole-twelve profile

At a finite point use the regular finite coordinate $w=W+a$,
$a=(B_0-L_0)/y$, and write
\[
u=A w^2+B_f w+C_f,\qquad
B_f=B_1-2Aa,\quad C_f=B_2-B_1a+Aa^2.
\]
The translation is essential at cubic branch points: the short
coordinate and its linear coefficient can have finite poles there.
The finite raw polynomial $F_f$ is affine and primitive over every
finite DVR. If $\ell$ roots have poles $g_i>0$, its content has
order $\operatorname{ord}v=\sum_i g_i$, and its nonzero reduction
has degree $10-\ell$. This follows directly by writing
$v\prod_i(T-w_i)$: the pole-root factors contribute units after
content cancellation, and the other factors contribute their
regular reductions. Also $\xi=u^2/\phi$ is integral on every
finite sheet, since its divisor is $E+5G-10H$.

In the $m=12$ case $A=v/(c\rho)$. Suppose it has a finite pole
where $v$ is a unit. All ten roots are then regular. The highest
pole terms of $A w^2+B_f w+C_f$ give a nonzero polynomial of
degree at most two in the residue of $w$; integrality of $u$
forces it to vanish at every root residue. There are at most two
distinct residues. Grouping the integral residues of $\xi$ by
these values, $n_0=n_1=0$ forces both group sums to be zero.
Therefore $n_2$ also vanishes at this point, contrary to $n_2=v/c$
being a unit. This Vandermonde argument does not require reduced
critical fibers or distinct roots inside each residue group.

If $A$ has a pole where $v$ vanishes, then
$0<\operatorname{ord}v<\operatorname{ord}\rho$. Away from a cubic
branch point, a quadratic polynomial $\rho(x)$ has zero order at
most two, so $\operatorname{ord}v=1$. At a cubic branch point,
the local parameter is $y$, while $x-\alpha$ has order three;
the nonzero $\gamma y$ term of $v$ likewise forces every zero
there to have exact order one. But $v=0$ and
$\delta_3=c\rho^2=0$ kill the degree-ten and degree-nine
coefficients of $F_f$. Its reduction has degree at most eight,
whereas content order one gives exactly one pole root and
reduction degree nine. This is impossible. Thus $A$ is affine.
Its exact pole at infinity is $10-6=4$, a gap. The $m=12$ case
is excluded.

## A fixed derivative certificate and the pole-ten profile

First no function of exact pole ten on this curve can have a
finite zero of order at least ten. Write such a function as
$\gamma(y+V(x))$ with $\gamma\ne0$, $\deg V\le3$.
At a cubic branch point every zero has order one, as just noted.
At any other finite point, a zero of order ten forces its degree-ten
norm polynomial $P(x)+V(x)^3$ to be $(x-\alpha)^{10}$.
Differentiating gives $P'=-3V^2V'$. A nonconstant $V$ would
give a repeated factor of $P'$, while constant $V$ would give
$P'=0$. Both contradict the fixed squarefreeness certificate.
In the convention $\beta^2=\beta+3$, code $[a+5b]=a+b\beta$,
the ascending coefficients are
\[
P'=[22,6,15,11,0,15,7,17,8],\quad
P''=[6,5,8,0,0,7,9,19].
\]
The ascending coefficient vectors
$[9,22,12,21,16,7,14]$ and $[17,2,4,23,8,19,18,7]$
multiply $P'$ and $P''$ to give one. The literal identity is
recorded in the
[certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/fixed_derivative_squarefree.json)
and reproduced by
[the source](../../scripts/oct01_nonzero_source/fixed_derivative_squarefree.py).

Now $m=10$ gives $A=\rho/c$, which is affine. Suppose $B_f$ or
$C_f$ has a finite pole. Where $v$ is a unit all ten roots are
regular. The highest pole terms are a nonzero linear polynomial
in their residues, so all ten residues coincide. Thus the reduction
of $F_f$ is a scalar multiple of $(T-c_0)^{10}$ and has zero
derivative. Since $F_f'=\phi_f D_f$ and $\phi_f$ is nonzero
monic, this gives $D_f=0$ in the residue polynomial ring, contrary
to its unit leading coefficient $\delta_3=cv$.

Where $v$ vanishes, $\delta_3$ also vanishes. The finite raw form
$F_f=\phi_f\mathscr H_f+t^3$ therefore reduces either to a
constant or to a polynomial of degree between five and eight:
the degree-five and degree-four coefficients of $\mathscr H_f$
are $v$ and $\delta_3/4$, respectively. If its reduction is
constant, all ten roots have poles and content gives
$\operatorname{ord}v\ge10$, already impossible by the preceding
fixed certificate. Otherwise let $k$ be its degree, the number
of regular roots. Highest pole terms of $B_f w+C_f$ force all
these regular residues to equal $c_0$.
If $k=6,7,8$, differentiating the reduction and using the
divisibility by $\phi_f$ forces its fifth-power root to be
$c_0$. Hence all $k$ regular sheets are selected: a regular root
with $\phi_f$ of positive valuation is in $E$. An actual finite
fiber has only zero or five selected sheets. This contradiction
leaves $k=5$ and exactly five pole roots.

Put $q=\operatorname{ord}\rho\ge0$ and let $p>0$ be the pole
of $B_f$. A regular root exists, so integrality of $u$ implies
that $C_f$ has pole at most $p$, and $B_f$ must indeed have a
pole whenever either coefficient does. On each pole root of
order $g$, the $B_f w$ term has pole $p+g$, strictly exceeding
that of $C_f$. It must cancel $A w^2$, forcing
$g=q+p$. All five pole roots have this same order.
On them $\xi w^j$ has positive order $(5-j)g$ for $j=0,1,2$.
On the five regular roots $w=c_0$ in the residue field.
Since $n_0=0$, their residues therefore give
$n_2(P)=c_0^2 n_0(P)=0$. The identity $n_2=\rho^2/c$ implies
$q\ge1$. Thus $g=q+p\ge2$ and content again gives
$\operatorname{ord}v=5g\ge10$, impossible. We have proved that
both $B_f$ and $C_f$ are affine at every finite point, including
cubic branch points and selected endpoints.

The short coefficient $B_1=B_f+2Aa$ has pole at most eight
at infinity. Its polynomial part is affine; its nonpolynomial
remainder is exactly
\[
\frac{2}{c}\,y^2\frac{\operatorname{rem}(Z\rho,P)}{P},
\qquad Z=B_0-L_0.
\]
The top three remainder coefficients would have the gap poles
seventeen, fourteen and eleven. Use their leading orders in
descending order; no assertion about arbitrary subleading Laurent
coefficients of affine functions is needed. Initially the remainder
has pole at most seventeen. Since $B_1$ has pole at most eight,
the affine part has pole at most seventeen and hence at most
sixteen, so the gap-seventeen coefficient must vanish. The
remainder then has pole at most fourteen, forcing the affine
part to have pole at most thirteen and the gap-fourteen coefficient
to vanish. Finally the remainder has pole at most eleven, forcing
the affine part to have pole at most ten and the gap-eleven
coefficient to vanish. On $\rho\in\langle1,x,x^2\rangle$, these
fixed coefficient matrix, in rows of degrees seven, eight, nine,
is
\[
\begin{pmatrix}[24]&[0]&[13]\\[18]&[16]&[2]\\[16]&[5]&[14]\end{pmatrix},
\qquad\det=[23]\ne0.
\]
This is the fixed three-row translation certificate used in
[the quadratic trace calculus](admissible_critical_quadratic_incidence.md).
It forces $\rho=0$, contrary to a nonzero quadratic coefficient.
The last degree-ten quadratic profile is excluded.

## The degree-eleven and general degree reduction

In degree ten $D$ has degree three and $U$ degree at most five.
If $u=L(W)$ with $\deg L\le6$, then $DL$ has degree at most
nine, below the primitive minimal degree ten. Hence $U=DL$ and
$\deg L\le2$. The preceding exclusions apply to every profile.

For every primitive actual source, the raw form is
$F=(T^5+q_s)\mathscr H+t^3$ with $\deg\mathscr H=n-5$ and
leading coefficient $v$. If $5\nmid n$, its derivative
$D=\mathscr H'$ has exact degree $n-6$: the leading derivative
coefficient is $(n-5)v\ne0$. Suppose $u=L(W)$ with $\deg L\le5$.
The identity $U(W)=D(W)L(W)$ has polynomial degrees at most
$n-5$ and $n-1$, respectively, both below the minimal degree $n$.
Thus $U=DL$ as polynomials. It follows that
$\deg L\le(n-5)-(n-6)=1$.
In degree eleven this linear expression is excluded by the finite
endpoint budget. The degree reduction alone does not give
nonexistence; the global argument below excludes the remaining
degrees not divisible by five.

## Arbitrary primitive degrees not divisible by five

Suppose $n\ge12$ and $5\nmid n$. The preceding degree reduction
gives $u=A W+B_1$. Comparing the leading coefficients of $U=Du$
gives
\[
A=\rho/(n-5),\qquad \rho\in\langle1,x,x^2\rangle.
\]
The case $A=0$ was already excluded. Thus $A$ is affine, has
pole at most six at $O$, and vanishes at at most six finite
points of $X$.

Use $w=W+a$ as above and put $B_f=B_1-Aa$. If $B_f$ has a
finite pole of order $p>0$ at $P$, that point is not selected:
on any selected sheet $u,w,A$ are integral, so $B_f=u-Aw$
is integral. Write $q=\operatorname{ord}_P A\ge0$. On every
one of the $n$ unselected sheets, the unit $u_i$ then gives
$w_i=(u_i-B_f)/A$ of exact pole $p+q$. Content has exact order
$n(p+q)$, and every difference $w_i-w_j=(u_i-u_j)/A$ has
order at least $-q$. Since $t$ is a unit at this unselected point,
\[
\operatorname{ord}_PC\ge
(2n-2)n(p+q)-n(n-1)q
=n(n-1)(2p+q)\ge2n(n-1).
\]
This includes arbitrary content multiplicity and coincident roots.

We next bound the contribution from all selected finite endpoints.
Let their selected sheet counts be $s_i=5b_i$, let
$e=\#(E\cap h^{-1}(O))$, and put $S=\sum_i s_i=5n-e$.
There are at most twelve endpoints. Let $k\le6$ count those
selected endpoints at which $A$ vanishes. At a unit endpoint
the local lower bound is $2s_i^2-6s_i$. At a zero endpoint,
taking its zero order at least one, it is
\[
2s_i^2-2ns_i+n^2-4s_i-n.
\]
The same formula holds when $s_i=n$: there are no unselected
sheets, and the earlier content ledger simply has $\ell=0$.
Pad to twelve slots by adding zero sheet counts as unit-type
slots. If $Z$ is the sum of $s_i$ at the actual zero endpoints,
the full selected lower bound is
\[
2\sum_i s_i^2-6S-2nZ+kn^2+2Z-kn
\ge2\sum_i(s_i-\tfrac n2\mathbf1_{A(P_i)=0})^2
 +\tfrac k2 n^2-6S-kn
\ge \frac{(S-kn/2)^2}{6}+\frac k2 n^2-6S-kn.
\]
The first inequality drops only the nonnegative term $2Z$;
the second is Cauchy on exactly twelve slots. No positive
zero-type constant is assigned to a padded slot.

Set $a=e/n\in[0,1]$. Add the unselected pole-point contribution
and subtract the total allowed pole degree
$M=4n^2-24n-e^2+5e$. The excess is at least
\[
g_k(a)n^2-(8+k)n+e,
\quad g_k(a)=\frac{(5-a-k/2)^2}{6}+\frac k2-2+a^2.
\]
The exact completion
\[
g_k(a)=\frac76\left(a-\frac{10-k}{14}\right)^2
 +\frac{(k-3)^2}{28}+\frac54
\]
shows that this excess is at least
$\frac54n^2-14n+e>0$ for every $n\ge12$.
The nonzero affine $C$ cannot have more zeros than its pole
budget. Thus $B_f$ has no finite pole.

It remains to use infinity. If $e>0$, a selected sheet has
$u$ of exact pole eight and $AW$ of pole at most seven, so
$B_1$ has exact pole eight. If $e=0$ and $B_1$ had pole
greater than ten, it would have to cancel $AW$ on every sheet.
Since $A$ has pole at most six, every $W_i$ would then have
pole at least five. The universal bound
$\operatorname{pole}W_i\le2+\operatorname{mult}_{Q_i}G$
would force $\sum_{Q_i/O}\operatorname{mult}_{Q_i}G\ge3n$,
contrary to $\deg G=n$. Hence in this case $B_1$ has pole at
most ten. In both cases $B_f$ is affine and $B_1=B_f+Aa$
has pole at most ten. The descending gap-seventeen,
gap-fourteen, gap-eleven argument and the same invertible
three-row remainder matrix therefore force $\rho=0$.
This contradicts $A\ne0$ and proves the universal primitive claim.

For the nonprimitive corollary let $S'$ be the smooth intermediate
curve with field $k(X)(W)$, of degree $m$ over $X$; put
$d=[k(S):k(S')]$. The intermediate maps are finite étale and
$m\mid n$, so $5\nmid m$. A polynomial $u=L(W)$ descends
to $S'$, as do $b$ and $\phi=f+b^5$, since they all belong
to the same field $k(X)(W)$.
Their exact valuations descend, yielding reduced $E'$, effective
$G'$, and the same divisor identities in degree $m$.
Moreover $T'=E'-G'-4h'^*O$ satisfies $5T'\sim0$ because
$\operatorname{div}(\phi u)=5T'$. Its pullback is $T$, so
nontriviality of $T$ implies nontriviality of $T'$.
The reconstruction theorem makes $S'$ an actual admissible
witness. If $m\le9$, use
[the complete small-degree exclusion](../../Theorems/cartier_and_spin/admissible_degree_nine_exclusion.md).
The case $m=10$ is impossible since $5\nmid m$; $m=11$ is
excluded above; and every $m\ge12$ is excluded by the primitive
argument just proved. This retains actual étaleness and
nontrivial admissibility rather than substituting an arbitrary
separable source.

Finally assume $5\mid n$ and $M=\operatorname{Tr}W\ne0$.
The leading coefficient of $\mathscr H$ is $v$, whose derivative
vanishes because $n-5$ is divisible by five. Its next coefficient
is $-vM$, so the leading derivative coefficient is $vM$ and
$\deg D=n-7$. For a polynomial $L$ of degree at most six,
$\deg DL\le n-1<n$, whence $U=DL$ and $\deg L\le2$.
For quadratic $L$, $\deg DL^2\le n-3<n$, so the same
interpolation argument gives $V_2=DL^2$ and $Q=0$.
The leading degree of $[U^2/F]_+$ is $n-10$, with coefficient
$v\rho^2$. The contributions of $n_0,n_1,n_2$ to
$[D\sum_jn_jT^{-j-1}]_+$ have degrees $n-8,n-9,n-10$.
The first two must vanish, and the third gives
$vM n_2=v\rho^2$. Because $n_0=n_1=0$, this moment is
translation invariant, affine, and has its short-frame pole at
infinity at most fourteen. It belongs to $L(14O)$.
The leading equality $A(vM)=v\rho$ then gives
$A=\rho/M=n_2/\rho$. If $\rho=0$, the expression is linear;
the displayed structure concerns genuinely quadratic expressions.
