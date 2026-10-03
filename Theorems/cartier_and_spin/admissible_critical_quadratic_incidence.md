# Compact global quadratic traces and critical residue incidence

Version7, 1 October2026. Work over $k=\overline{\mathbf F}_5$ on the
fixed genus-nine curve $X:y^3=P(x)$, with $O$, $f$, $B_0$ and $L_0$
as in [the uniform annihilator theorem](admissible_annihilator_trace_vanishing.md).
Write $Z=B_0-L_0$, $a=Z/y$, and
$L_N=H^0(X,\mathcal O_X(NO))$. Let $h:S\to X$ be an actual
connected finite étale cover of degree $n$, and retain reduced $E$,
effective $G$, and actual functions
\[
\operatorname{div}\phi=3E-5G-10H,\qquad
\phi=h^*f+b^5,\qquad \operatorname{div}u=2E-10H,
\]
where $H=h^*O$, $E\le h^*R$, $E\cap G=\varnothing$ and
$\deg E=5\deg h$, $\deg G=\deg h$.
Put $W=b+L_0/y$, $w=W+a$, $\chi=u/\phi$ and $\xi=u^2/\phi$.

## Six moments in every actual degree

The functions
$n_j=\operatorname{Tr}_h(\xi w^j)$ are affine regular for
$0\le j\le5$, including at every zero of primitive content. Their
short-frame counterparts satisfy the infinity bounds
\[
\operatorname{pole}_O\mu_j\le10+2j,\qquad
\mu_j=\operatorname{Tr}_h(\xi W^j).
\]
The short moments may have finite poles at the cubic branch points.
For affine $c$, write $a^\ell c=\Pi_\ell(c)+R_\ell(c)$, where
$\Pi_\ell(c)$ is its affine polynomial part in the basis $1,y,y^2$.
Every positive pole of $R_\ell(c)$ is a Weierstrass gap at $O$ and
is at most seventeen. Define, recursively,
\[
\eta_j=n_j+\sum_{i<j}(-1)^{j-i}\binom ji\Pi_{j-i}(n_i).
\]
Then $\eta_j\in L_{10+2j}$. Conversely the affine moment tuples with
these six short-frame infinity bounds are parametrized exactly by the six
$\eta_j$ spaces and four independent linear gap constraints: two
at $j=1$, one at $j=2$ and one at $j=3$. Thus their parameter space
has dimension $5+6+7+9+10+12-4=45$, independent of the covering degree.
This is a parametrization of necessary moment data, not a realization
of a cover or an annihilator.

## The first three moments have exactly fifteen auxiliaries

Write $\eta_0=p(x)+\gamma y$ and $\eta_1=q(x)+\delta y$, with
$\deg p\le3$, $\deg q\le4$. The first three moments are precisely
\[
n_0=\eta_0,\qquad n_1=\Pi_1(\eta_0)+\eta_1,
\]
\[
n_2=2\Pi_1(\eta_1)+2\Pi_1(\Pi_1(\eta_0))
-\Pi_2(\eta_0)+\eta_2,
\]
where $\eta_0\in L_{10}$, $\eta_1\in L_{12}$,
$\eta_2\in L_{14}$ and
\[
[x^9]\operatorname{rem}(Zp,P)=[x^8]\operatorname{rem}(Zp,P)=0,
\]
\[
[x^9]\bigl(2\operatorname{rem}(Zq,P)
+\gamma\operatorname{rem}(Z^2,P)\bigr)=0.
\]
These three forms have rank three, so the auxiliary space has dimension
$5+6+7-3=15$.

## An integral interpolation identity in every primitive degree

For a primitive source choose the affine primitive content $v$ supplied
by [the principal norm theorem](uniform_admissible_norm.md), and write
$F=v\prod_i(T-w_i)$, $F'=\phi_fD$, where
$\phi_f=T^5+q_f$ and $q_f=f-(B_0/y)^5$. The annihilator interpolator
$U=\sum_i\chi_i v\prod_{k\ne i}(T-w_k)$ has degree at most $n-5$.
There is also an affine polynomial
\[
V_2=\sum_i\xi_i v\prod_{k\ne i}(T-w_k),\qquad
\deg V_2\le n-1,\qquad V_2(w)=u^2D(w).
\]
It satisfies the exact identity
\[
U^2-FQ=DV_2,
\]
where $Q$ has affine coefficients, degree at most
$\max(2\deg U-n,\deg D-1)\le n-7$, and the exact expression
\[
Q=[U^2/F]_+-\left[D\sum_{j\ge0}n_jT^{-j-1}\right]_+.
\]
Here $[\ ]_+$ denotes the polynomial part of the Laurent expansion
at infinity in the polynomial variable $T$. Only $j<\deg D$ occurs
in the second term. There is no inversion of a leading coefficient
of $D$. This identity retains the affine quotient $V_2$, which is
stronger finite-place information than a generic congruence alone.

At a selected finite endpoint with $s=5b_P$ selected sheets, suppose
all selected short roots satisfy $W_i-C\in r^kR$, where $k\ge1$
and $C\in rR$. In the centered coordinate $T$ give $r$ weight one
and $T$ weight $k$. The exact quotient has
\[
\operatorname{wt} Q(T+C)\ge(s-2)k-2.
\]
Equivalently its coefficient of $T^j$ has order at least
$(s-2)k-2-kj$. This is additional necessary integral contact
information from the exact interpolation identity.
At $k=2$ the coefficient of $T^{s-3}$ has the sharper order at least
one, even though the preceding bound would allow order zero.

## Denominator-free cubic incidence in degree ten

In an actual primitive degree-ten source use the finite-frame raw
polynomial and its trace-dual numerator
\[
F=v\phi_f^2+\phi_f S+t^3,\quad
\phi_f=T^5+q_f,\quad D=S'=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0,
\]
\[
U(w)=uD(w),\qquad \deg U\le5,\qquad [T^5]U=v\rho,
\quad \rho=\operatorname{Tr}_h((u/\phi)W^4)\in\langle1,x,x^2\rangle.
\]
The $n_j$ above also satisfy
\[
n_j=\frac1v[T^9]\bigl(T^jU^2D^{-1}\bmod F\bigr),
\qquad j=0,1,2.
\]
Define the polynomial
\[
Q=v\rho^2-\delta_3n_2-\delta_2n_1-\delta_1n_0
-(\delta_3n_1+\delta_2n_0)T-\delta_3n_0T^2.
\]
Then every actual source satisfies the polynomial critical incidence
\[
U^2\equiv FQ\pmod D.
\]
More precisely, the same $Q$ gives the preceding exact identity with
affine $V_2$. Writing $V_{2,s}(T)=V_2(T+a)$, every coefficient has
pole at most $33-j$ at $O$, and at every selected finite endpoint
its coefficients of $T^j$ have orders at least $5-j$ for $0\le j\le4$.
For a complete five-sheet contact of order $k$, the three shifted
coefficients of $Q_s(T+C)$ have orders at least
$3k-2$, $2k-2$, $k-2$, respectively. Ordinary contact therefore
forces its constant coefficient to vanish at every one of the nine
selected finite endpoints. At $k=2$ the constant and linear coefficients
have orders at least four and two, giving six linear jet conditions on
the fifteen trace auxiliaries, with dependence on the numerator only
through the quadratic term $\rho^2$. No uniform independence of these
six conditions is asserted.
At $k=2$ the quadratic coefficient also vanishes at the endpoint,
giving a seventh necessary linear condition. Combined with the eight
ordinary constant-coefficient conditions at the other endpoints, these
are fifteen linear conditions on the fifteen trace auxiliaries, with
quadratic forcing only in $\rho$. Their rank is not asserted to be
fifteen; the last condition can vanish when $\delta_3$ does.
When $\deg D=3$, this congruence is equivalent over $k(X)$ to the
three displayed trace identities. It needs neither distinct critical
roots nor a unit leading critical coefficient at any finite place.
The denominator-free necessity also holds when $D$ has global degree
two, one or zero. At those global degree drops the congruence alone
encodes only the first two, first one or none of the trace identities,
respectively; the full fifteen-auxiliary trace model remains necessary.
No points with $v=0$ or a repeated critical root are deleted.

There is a further cut of the zero-leading-critical contact boundary.
At a complete second-order five-sheet contact, if $s_4(P)=0$, then
$v(P)\ne0$ and $\operatorname{ord}_P s_4\ge3$.
Moreover $\operatorname{ord}_P\rho\ge2$, so
$\rho=c(x-x(P))^2$ for a scalar $c$, including $c=0$.
Consequently this entire subboundary is excluded when the pole of
$s_4$ at $O$ is three or six. The case $s_4(P)\ne0$, other pole
values, and the unconcentrated source loci are not excluded by this cut.
The fixed input is that no nonzero section of $L_{10}$ vanishes to
order five at any finite marked endpoint; its exact small certificate
is given in the proof.
The same fixed five-jet input bounds the order of any nonzero
$L_{10}$ section by four at these endpoints. Hence the established
bound $k\le\operatorname{ord}_P s_4+3$ sharpens to $k\le7$ whenever
$s_4\in L_{10}$.

For primitive degrees eleven and twelve, the same six-moment framework
controls the first five and six critical residue moments, respectively,
because $\deg \mathscr H'\le5,6$ for
$F=\phi\mathscr H+\tau$. The residue pairing remains valid at repeated
critical roots; its infinity term must be retained. No universal cubic
formula in these degrees is asserted. The first five moment model has
dimension $5+6+7+9+10-4=33$; the six-moment model has dimension45.
The term $[U^2/F]_+$ has degree at most one or two, respectively.
In degree twelve its constant coefficient can use
$\operatorname{Tr}(\chi w^6)$, which need not be affine: its possible
$G$ poles must be regularized by $v$.

For the actual degree-eleven profiles there is a sharper exact model.
Write $d=\operatorname{pole}_O v\in\{0,3,6,9\}$. The short infinity
bounds for $\mu_0,\ldots,\mu_5$ are
\[
(9,10,11,12,13,20)\quad(d=0,3,6),\qquad
(9,10,11,12,16,20)\quad(d=9).
\]
The corresponding affine $\eta_j$ belong to the six $L_N$ spaces
with these indices. The gap constraints at $j=1,2,3,4$ have ranks
$3,2,2,2$ in the first three profiles, and $3,2,2,1$ at $d=9$;
their combined ranks are nine and eight. Thus the first three moments
have exactly nine auxiliaries, the first five exactly eighteen or
twenty-one, and all six exactly thirty or thirty-three, respectively.
These are models of necessary moment tuples and retain every endpoint
and all four infinity profiles. None asserts finite regularity of the
short moments or realization of the tuples.

In degree eleven retain the established profile reduction
$v\in L_9$, with infinity pole $d\in\{0,3,6,9\}$. At a complete
second-order contact of the five selected finite sheets, impose the
additional critical-content condition $D\bmod r=0$.
Then exactly one unselected sheet has a pole, its multiplicity is two
or three, and the five other unselected sheets have one nonzero
common residue. In particular $d$ must be six or nine. Thus this
critical-content contact boundary is excluded at $d=0,3$; complete
contact alone does not imply the content condition, and no full
degree-eleven profile exclusion is asserted.

The theorem applies to all nine surviving degree-ten infinity profiles.
These are necessary quadratic incidences. Generic trace identities or
the critical congruence alone do not imply conductor membership,
affine integrality of $u$, the prescribed divisor, or an actual source.
The separate [linear annihilator exclusion](admissible_linear_annihilator_exclusion.md)
rules out affine-linear $u$ in degrees ten and eleven, and hence
rules out the degree-ten branch $\rho=n_0=n_1=n_2=0$ when its
critical cubic is squarefree. No uniform rank assertion supplies
these trace vanishings here.
They do not settle the unmarked common-cover problem.

[Proof](../../Proofs/cartier_and_spin/admissible_critical_quadratic_incidence.md).
