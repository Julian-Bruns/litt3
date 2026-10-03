# Global gap regularization and the critical residue pairing

1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md).
The source hypotheses and fixed data are those of the
[uniform annihilator theorem](../../Theorems/cartier_and_spin/admissible_annihilator_trace_vanishing.md).
The raw trace-dual numerator and its degree bound are supplied by
the uniform annihilator theorem. Its finite coefficient integrality
is proved below. The compact numerator parametrization is not an
input to this proof; its later concentration exclusions use this
incidence theorem.
All arguments below retain the actual everywhere étale source; no
generic separable replacement is used to establish its divisor bounds.

## Finite places and infinity

The divisor identity is
$\operatorname{div}\xi=E+5G-10H$. The finite primitive $w$ has
pole order $g_i$ at a point of $G$ and no other finite pole. Indeed
$q_f=(Q-B_0^5)/y^5$ is affine regular, including at the cubic branch
points because $P^2\mid Q-B_0^5$. Thus $\xi w^j$ is finite regular
for $j\le5$. Trace preserves regularity under the actual étale map,
including at zeros of $v$.

On a selected sheet at infinity, $\xi$ has pole nine and $W$ pole
at most one. Its contribution has pole at most $9+j$. On an
unselected sheet with $G$ multiplicity $g_i\ge0$, $\xi$ has pole
at most $10-5g_i$ and $W$ has pole $2+g_i$. Its contribution has
pole at most $10+2j-(5-j)g_i\le10+2j$ for $j\le5$.
These bounds prove the six short-frame infinity bounds in every degree.
The short moments need not be affine regular: $a=Z/y$ can introduce
finite branch-point poles. All global $L_N$ memberships below refer
to the affine polynomial parts $\eta_j$, rather than to $\mu_j$.
They do not require a finite-frame bound at infinity.

## Polynomial parts and the four gap conditions

Reduce $a^\ell c$ using $y^3=P(x)$ and divide its three polynomial
numerators by the needed powers of $P$. Every discarded term is of
the form $y^rR(x)/P^e$, with $0\le r\le2$, $e\ge1$ and
$\deg R<10e$. Its positive pole orders are contained in
$\{1,2,4,5,7,8,11,14,17\}$, precisely the gaps of
$\langle3,10\rangle$. There is no affine polynomial part with
any of these pole orders.

The short moment is
\[
\mu_j=\eta_j+\sum_{i<j}(-1)^{j-i}\binom ji R_{j-i}(n_i).
\]
Since the error has only gap poles at most seventeen, the bound
$\operatorname{pole}_O\mu_j\le10+2j$ forces
$\eta_j\in L_{10+2j}$. The error
must have zero coefficients at gaps larger than $10+2j$. These are
seventeen and fourteen for $j=1$, seventeen for $j=2$, and seventeen
for $j=3$. There are none for $j=0,4,5$. Conversely these conditions
give the required short bounds. The recursive formula reconstructs
all affine $n_j$ from the $\eta_j$ without adding variables.

For $c=p+\gamma y$, $R_1(c)=y^2\operatorname{rem}(Zp,P)/P$.
In particular the $j=1$ conditions are the first two forms in the
statement. Direct substitution gives
\[
\mu_1=\eta_1-y^2\operatorname{rem}(Zp,P)/P,
\]
\[
\mu_2=\eta_2+y\operatorname{rem}(Z^2p,P)/P
-y^2\bigl(2\operatorname{rem}(Zq,P)
+\gamma\operatorname{rem}(Z^2,P)\bigr)/P.
\]
Thus the $j=2$ condition is the third displayed form.

Here is the complete tiny arithmetic needed for independence. Use
$\beta^2=\beta+3$ and $[a+5b]=a+b\beta$. The columns $p=1,x$
of the two $j=1$ forms have matrix
\[
\begin{pmatrix}[16]&[5]\\[18]&[16]\end{pmatrix},
\qquad \det=[24]\ne0.
\]
The third form has coefficient $2[16]=[7]\ne0$ on the new
variable $q=1$. The fourth, at $j=3$, has coefficient
$-3[16]\ne0$ on the new scalar constant of $\eta_2$, from
$-3R_1(n_2)$. Hence the four forms are independent. The relevant
dimensions of $L_{10},L_{12},L_{14},L_{16},L_{18},L_{20}$ are
$5,6,7,9,10,12$. In particular $L_{16}$ has basis
$1,x,x^2,x^3,x^4,x^5,y,xy,x^2y$, so its dimension is nine.
This proves the exact fifteen- and forty-five-
dimensional moment models. These fixed checks use no parameter
enumeration or unreviewed computation.

## The exact integral quotient

The principal norm theorem supplies a global affine primitive content
$v$. On a split étale finite disk put $g_i=\operatorname{pole}(w_i)$.
Then $\operatorname{ord}v=\sum_i g_i$, and every coefficient of
$v\prod_{k\ne i}(T-w_k)$ has order at least $g_i$. The function
$\xi_i$ is integral at all finite points, with order $5g_i$ on $G$.
Thus every coefficient of $V_2$ is integral. For the corresponding
finite regularity of $U$, selected $\chi_i$ have at most simple poles.
All selected $w_i$ have the same residue $c$, and the integral
polynomials $v\prod_{k\ne i}(T-w_k)$ have the same reduction
$F\bmod r/(T-c)$. Their possible coefficient poles cancel because
the sum of the selected $\chi_i$ residues is zero by
$\operatorname{Tr}\chi=0$.
Also $D$ has affine coefficients: $F'$ is affine and division by
the monic affine polynomial $\phi_f$ preserves coefficient integrality.

At each root of $F$, $U^2=Du^2D=DV_2$, so $F$ divides $U^2-DV_2$
over $k(X)$. This proves the exact identity. At every finite place
$F$ has Gauss valuation zero by primitive content. Since its product
with $Q$ is integral, Gauss valuation multiplicativity proves that
every coefficient of $Q$ is integral, even at zeros of $v$.
The displayed degree bound follows from
$\deg U\le n-5$, $\deg D\le n-6$, $\deg V_2\le n-1$.

Partial fractions give
$V_2/F=\sum_{j\ge0}n_jT^{-j-1}$ exactly. Taking polynomial parts
of $U^2/F=Q+DV_2/F$ gives the stated formula for $Q$.
It includes all derivative degree drops without residue inversion.

In degree ten, on a selected infinity sheet the interpolation
coefficient has pole at most $d+(20-d)+(4-j)+9=33-j$.
Assign each small root the artificial upper pole budget one, even
when that root is regular, and each big root its actual pole $a_i$.
All budgets are at least one. Choosing $9-j$ factors from the
other roots therefore has total budget at most their full total
minus $j$. This proves the same upper bound when fewer than five
big roots enter. On an unselected sheet of root pole $a_i\ge2$,
the corresponding bound is $45-6a_i-j\le33-j$.
This proves all coefficients of $V_{2,s}$ have the claimed bounds.

At a selected finite endpoint, the five selected short roots belong
to the maximal ideal. Their product is $P_E(T)$. In a selected term
$\xi_i$ has order one, and the coefficients of
$P_E/(T-W_i)$ at $T^j$ have order at least $4-j$.
The primitive content times the unselected factors has integral
coefficients, including when unselected roots have $G$ poles.
Hence these terms have coefficient order at least $5-j$.
Nonselected terms contain all five factors $P_E$ and have the
same bound; their remaining content has order at least $g_i$ and
$\xi_i$ is integral. Summing gives the stated jets without any
distinct-slope or concentration hypothesis.

## Integral contact of the critical quotient

Work at a selected finite endpoint with $s=5b_P$ selected sheets,
and center at $C$ so those roots belong to $r^kR$. Give the centered
variable weight $k$ and $r$ weight one. The selected product has
weight exactly $sk$ because its leading coefficient is one. The
content times all unselected factors is integral with constant
coefficient a unit: every unselected regular root has nonzero residue,
and each unselected pole is canceled exactly by primitive content.
Thus $\operatorname{wt}F=sk$.

Selected interpolation terms give
$\operatorname{wt}U\ge(s-1)k-1$ and
$\operatorname{wt}V_2\ge(s-1)k+1$, from the respective selected
orders $-1$ of $\chi$ and $1$ of $\xi$. Nonselected terms contain
all $s$ selected factors, and their remaining content-adjusted
coefficients are integral, so satisfy both bounds as well.

The centered $\phi_f$ has constant coefficient of exact order three:
its value on any selected root has that order, and changing the root
to $C$ changes its fifth-power value only by an element of $r^{5k}R$.
Hence its weight is three. Differentiation decreases weight by at
most $k$, so $F'=\phi_fD$ has weight at least $(s-1)k$ and
$\operatorname{wt}D\ge(s-1)k-3$. This argument remains valid when
the initial derivative cancels in characteristic five.

The right side of $FQ=U^2-DV_2$ consequently has weight at least
$2(s-1)k-2$. Weighted Gauss valuation is multiplicative, and
$\operatorname{wt}F=sk$, so
$\operatorname{wt}Q\ge(s-2)k-2$. All coefficient assertions follow.
In degree ten $s=5$ and $Q$ is quadratic. At $k=2$ its constant
coefficient supplies four jet equations and its linear coefficient
two. For a fixed source and center they are linear in the fifteen
trace auxiliaries, with the only nonlinearity $v\rho^2$ in the
constant polynomial part. Their rank can depend on the source;
no rank assertion is needed for this necessary condition.

There is a sharper corner condition at $k=2$. The bounds on $U,D,V_2$
are then $2s-3,2s-5,2s-1$. Their initial forms in these weights have
polynomial degrees at most $s-2,s-3,s-1$, respectively, because
all centered coefficients are integral. Thus the weight $4s-6$
part of $U^2-DV_2$ has degree at most $2s-4$ in the centered variable.
The initial form of $F$ has exact degree $s$ and weight $2s$.
If the coefficient $Q_{s-3}$ were a unit, the weight $2s-6$ initial
form of $Q$ would have degree $s-3$, so the corresponding part
of $FQ$ would have degree $2s-3$. Its leading coefficient is nonzero
in the residue-field polynomial ring, contradicting the exact identity.
Consequently $Q_{s-3}$ has positive order. Higher actual weights or
cancellations on the left only strengthen this argument.

For degree ten, $s=5$ and this is $Q_2(P)=0$, the seventh condition.
Since $Q_2=-\delta_3\mu_0$, it need not be independent when
$\delta_3(P)=0$. At the other eight finite endpoints ordinary contact
provides one row each. The total fifteen conditions are retained
without any claim about their rank on special source loci.

## The zero-leading-critical second-contact boundary

Suppose $s=5,k=2$ and $\delta_3(P)=0$. In the selected centered
coordinate the critical coefficient orders are at least $5,3,1,1$.
Thus $D\bmod r=0$ and $F'\bmod r=0$. Primitive content gives
$F\bmod r=T^5R(T)$, with $R(0)\ne0$ and degree equal to the
number of regular unselected roots. It follows that $R'=0$, so
$R\in k[T^5]$. If $v(P)$ is a unit, all five unselected roots
have the same nonzero residue $c$. If $v(P)=0$, fewer than five
are regular; then $R$ is constant and all five unselected roots
are poles. This alternative forces $\operatorname{ord}_P v\ge5$.

In the unit case the five unselected roots form a first-order
cohort centered at $c$. Their $\phi$ values are units. The same
weighted derivative product argument gives
$\operatorname{wt}_{r,T-c}D\ge4$. At coefficient order one,
the selected restrictions allow only a polynomial $T^2(A+BT)$.
The unselected restriction forces a root of multiplicity at least
three at $c\ne0$, which is impossible unless $A=B=0$.
At coefficient order two the same polynomial requires multiplicity
at least two, again forcing zero. Therefore $\delta_2$ and
$\delta_3$ have order at least three.

The pole alternative is impossible on the fixed curve. Indeed
$L_{10}=\langle1,x,x^2,x^3,y\rangle$, and $x$ is unramified at all
finite marked endpoints. A nonzero member with order at least five
must have a nonzero $y$ coefficient and would force
$D^{(4)}y(P)=0$. Since $y=P^2/y^5$, Hasse differentiation gives
\[
D^{(4)}y=(C_3(x)/y)^5,
\]
where the coefficients of $C_3$ are the fifth roots of the
coefficients of $P^2$ at degrees $4,9,14,19$. They are
$([12],[2],[9],[12])$. With ascending coefficient conventions,
the exact Bezout identity is
\[
([2]+[14]x+[7]x^2)A
+([11]+[17]x+[15]x^2+[6]x^3)C_3=1.
\]
Thus $C_3$ is nonzero at every root of $A$, independent of the
choice of its three $y$ sheets. This rules out the pole alternative.
The executed tiny check and literal products are retained in
[the certificate](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/fivejet_v_boundary.json)
and [the source](../../scripts/oct01_nonzero_source/fivejet_v_boundary.py).
No larger source-family calculation is used for this cut.

We conclude $v(P)$ is a unit and $\operatorname{ord}_P s_4\ge3$.
In the selected centered coordinate all three coefficients
$\delta_3,\delta_2,\delta_1$ have orders at least three.
The centered quadratic quotient has constant coefficient of order
at least four, and its formula is
$v\rho^2-\delta_3\mu_2^C-\delta_2\mu_1^C-\delta_1\mu_0$,
where the centered moments are integral at this endpoint. Thus
$\rho^2$ has order at least three and $\rho$ has order at least two.
Since $\rho$ is a polynomial in $x$ of degree at most two, it is
the stated scalar multiple of $(x-x(P))^2$.
But $L_3$ and $L_6$ consist of polynomials in $x$ of degrees at
most one and two. Such a nonzero polynomial cannot vanish to
order three at an unramified finite $x$ point. This excludes exactly
the stated zero-leading-critical concentrated subboundary.
Finally the same Bezout identity bounds every nonzero $L_{10}$
section's endpoint order by four. The weighted critical bound above
is $\operatorname{wt}D\ge4k-3$ on a five-sheet contact; its cubic
coefficient has weight $\operatorname{ord}_P\delta_3+3k$.
Thus $k\le\operatorname{ord}_P s_4+3$, giving $k\le7$ when
$s_4\in L_{10}$; no new contact computation is needed.

## The critical residue pairing

Now work over $K=k(X)$ in the degree-ten polynomial model. Since
$F'=\phi_fD$ and $F$ is separable, $F$ and $D$ are coprime over
$K$. For any rational value in the degree-ten algebra, the usual
trace-dual interpolation formula gives
\[
\operatorname{Tr}(\xi w^j)
=\frac1v[T^9](T^jU^2D^{-1}\bmod F).
\]
Equivalently these are the total finite residues at the roots of $F$
of $T^jU^2/(DF)\,dT$. This interpretation uses simple roots of $F$;
it does not assume simple roots of $D$.

Suppose first $\deg D=3$ and write
$D=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0$. Set
$P_c=U^2/F\bmod D$, of degree at most two, and define
$\lambda(R)=\delta_3^{-1}[T^2](R\bmod D)$.
The sum of all residues at the critical polynomial is
$\lambda(T^jP_c)$. This is the nondegenerate Frobenius residue
pairing on $K[T]/D$, valid even when $D$ is repeated or inseparable.
It can be proved by expanding $R/D$ at infinity, so requires no
evaluation at distinct critical roots.

For $j=0,1$ the residue at infinity of $T^jU^2/(DF)\,dT$ is zero.
For $j=2$ it is $-U_5^2/(v\delta_3)$. Consequently, if
$z_j=\lambda(T^jP_c)$, then
\[
z_0=-n_0,\quad z_1=-n_1,\quad
z_2=U_5^2/(v\delta_3)-n_2.
\]
The inverse residue pairing is
\[
P_c=\delta_3(z_2+z_1T+z_0T^2)
+\delta_2(z_1+z_0T)+\delta_1z_0.
\]
One checks this by reducing $T^3$ and $T^4$ modulo $D$; its
diagonal pairing coefficients are $\delta_3^{-1}$, so no root
distinctness is involved. Substituting $U_5=v\rho$ gives exactly
the polynomial $Q$ in the statement. Thus $P_c=Q$ is equivalent
to all three trace identities, and is equivalent to $U^2\equiv FQ$
modulo $D$.

The final congruence divides by no $\delta_3$. It is an identity
over the global coefficient functions and consequently remains
valid at finite places where $\delta_3$ vanishes or roots of $D$
collide, including simultaneous content zeros. It is not asserted
that taking a pointwise inverse of $D$ in a degenerate fiber is legal.

If $D$ has global degree two, use instead
$\lambda(R)=\delta_2^{-1}[T](R\bmod D)$. The infinity
contribution is zero for $j=0$ and $U_5^2/(v\delta_2)$ for $j=1$.
The same calculation yields $Q$ with $\delta_3=0$, using only
$n_0,n_1$. If $D$ has degree one, its $j=0$ infinity contribution
is $U_5^2/(v\delta_1)$, giving $Q=v\rho^2-\delta_1n_0$.
If $D$ is a nonzero constant, its congruence imposes no condition.
The unused higher trace identities must still be imposed at these
global degree drops. These statements distinguish global degree
drop from vanishing of a leading coefficient at one base point.

## Higher degrees and scope

For a primitive admissible source the raw form is
$F=\phi\mathscr H+\tau$, and $F'=\phi\mathscr H'$.
The same residue construction applies to the critical algebra of
$D=\mathscr H'$, and the pairing
$[T^{d-1}](\,\cdot\bmod D)/\operatorname{lead}(D)$ is
nondegenerate for $d=\deg D$, including repeated roots.
For degrees eleven and twelve, $d\le5,6$, so the six regularized
moments control all needed residue coordinates. The polynomial
part of $T^jU^2/(DF)$ can contribute at infinity and must be included;
the degree-ten constant formula is not copied to these degrees.
Without using the degree-eleven profile, the first five auxiliary
spaces total37, with the same four independent constraints, hence
dimension33. For degree twelve all six give dimension45.
The expansion $U/F=\sum_{j\ge0}\operatorname{Tr}(\chi w^j)T^{-j-1}$
starts at $j=4$. Therefore $[U^2/F]_+$ in degrees eleven and twelve
uses respectively moments through five and six. Cancellation at
selected endpoints makes every such moment regular there, but at
$G$ its term has order $(5-j)g_i$. In particular the sixth may
have finite poles. Multiplication by $v$ clears these; it cannot
be declared affine without that regularization.

## Sharper exact degree-eleven moment spaces

The actual degree-eleven infinity profile has ten selected sheets
and one unselected sheet. The former have $W$ pole at most one and
$\xi$ pole nine. The latter has $G$ multiplicity
$g=11-d\in\{11,8,5,2\}$, $W$ pole $g+2$ and $\xi$ pole
$10-5g$. Hence
\[
\operatorname{pole}_O\mu_j\le
\max(9+j,10+2j-(5-j)g),\qquad 0\le j\le5.
\]
This gives $(9,10,11,12,13,20)$ for $d=0,3,6$, and
$(9,10,11,12,16,20)$ for $d=9$. This assertion concerns infinity
only. The finite affine moments $n_j$ and the same gap decomposition
then put $\eta_j$ in the corresponding global $L_N$ spaces.

At $j=1$ the gaps exceeding the bound ten are seventeen, fourteen
and eleven. Their coefficient forms on $\eta_0=p(x)$ are the
three top coefficients of $\operatorname{rem}(Zp,P)$. On the
columns $p=1,x,x^2$ their matrix is $K_3$ displayed in
[the fixed annihilator proof](admissible_annihilator_trace_vanishing.md),
with determinant $[23]\ne0$. Thus these three rows are independent.
At $j=2$ and $j=3$ the forbidden gaps are seventeen and fourteen.
At $j=4$ they are seventeen and fourteen in the first three profiles,
and only seventeen at $d=9$. There are no conditions at $j=5$.

The constraints at step $j$ contain the fresh variable
$\eta_{j-1}$ only through $-jR_1(\eta_{j-1})$. All earlier
constraints use only $\eta_0,\ldots,\eta_{j-2}$.
For $j=2,3,4$, the new variables $\eta_{j-1}=1,x$ are allowed
and give the two-row matrix above multiplied by the nonzero scalar
$-j$. Its determinant $[24]\ne0$ proves two new independent rows
at each two-gap step. The one-gap step instead has nonzero entry
$-4[16]$ on the new constant. This proves exact total ranks nine
or eight, with no source-parameter or finite-endpoint restriction.

The dimensions of $L_9,L_{10},L_{11},L_{12},L_{13},L_{16},L_{20}$
are $4,5,5,6,7,9,12$. Therefore the first three moments have
$4+5+5-(3+2)=9$ auxiliaries. The first five have
$4+5+5+6+7-9=18$, or $4+5+5+6+9-8=21$.
The sixth adds twelve unconstrained parameters, giving thirty or
thirty-three. Conversely the stated gap equations give precisely
the corresponding infinity bounds, so these counts describe exact
moment spaces, rather than merely upper bounds. They do not imply
existence of a source with those moments.

## The degree-eleven critical-content contact boundary

The established infinity reduction gives $v\in L_9$, so it is a
polynomial in $x$ of degree at most three. The derivative
$D=\mathscr H'$ has degree at most five, fourth coefficient zero
and fifth coefficient $v$ in characteristic five. Suppose the
five selected finite sheets have contact two and, additionally,
$D\bmod r=0$. Let $\ell$ count the unselected pole sheets.
Primitive reduction has degree $11-\ell$, and its derivative is
zero because $F'=\phi D$. Therefore $\ell\equiv1\pmod5$.
But every pole contributes at least one to $\operatorname{ord}_P v$,
which is at most three. Hence $\ell=1$ and the remaining five
unselected regular sheets have a common nonzero residue $c$.

Their first-order contact and unit $\phi$ values force
$\operatorname{wt}_{r,T-c}D\ge4$. The selected second-contact
bounds give coefficient orders at least $5,3,1$ in degrees $0,1,2$.
At coefficient order one the remaining polynomial has the form
$\alpha T^2+\beta T^3+\gamma T^5$; its root at $c$ has
multiplicity at least three. The first two Hasse derivatives give
$2\alpha c+3\beta c^2=0$ and $\alpha+3\beta c=0$.
Since $c\ne0$ these force $\alpha=\beta=0$, and its value then
forces $\gamma=0$. Thus $\operatorname{ord}_P v\ge2$.
It follows that $d=6$ or $9$, and the unique pole multiplicity
is two or three. This is a necessary boundary cut; at order two
the corresponding multiplicity-two equations allow nonzero
coefficients, so no further exclusion is inferred.

All bounds are consequences of the actual divisor and étale
hypotheses. Reversing the generic trace or critical pairing alone
does not prove conductor membership or integral regularity of $u$.
There is no additional source existence or common-cover claim.
