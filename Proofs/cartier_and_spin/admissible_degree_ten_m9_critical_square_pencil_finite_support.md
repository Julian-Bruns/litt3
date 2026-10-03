# Proof of finite square support for the actual m9 critical trace pencil

ID: `admissible_degree_ten_m9_critical_square_pencil_finite_support`.
Version3, 2 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_square_pencil_finite_support.md).
This is a necessary reduction on the stated rank-fourteen open, not
an exclusion of all actual m9 sources.

## Actual source data and the exact moment rows

Write $K=k(X)$, $X:y^3=P(x)$, $a=Z/y$, and
$L_j=H^0(X,\mathcal O_X(jO))$, with the conventions of
[critical incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md).
The original finite frame has affine coefficients, and the short
polynomial is $F_s(T)=F_f(T+a)$; thus $D_s(T)=D_f(T+a)$.
For the actual m9 source retain
$F_s=v(T^5+q_s)^2+(T^5+q_s)S_s+t^3$, $D_s=S_s'$,
and the SAME actual interpolator $U$ and affine quotient $V_2$.
The source bounds are $v$ exactpole10, $q_s$ exactpole7,
$t^3$ pole27, and
$\delta_3$ exactpole9, $\delta_2$ exactpole14,
$\delta_1$ pole at most16, $\delta_0$ pole at most17.
The cubic coefficient is affine, hence $\delta_3\in k[x]$
of degree three. Write
$S_s=s_4T^4+s_3T^3+s_2T^2+s_1T+s_0$.
Its coefficient bounds are9,14,16,17,20: the last follows from
$F_s(0)$ pole at most25 and
$F_s(0)=vq_s^2+q_ss_0+t^3$, which forces the pole27 terms to
cancel and $s_0$ to have exact pole20.
The actual numerator satisfies
$U_5=v\rho$, $U_4=vm_5+s_4\rho$,
$\operatorname{pole}U_j\le25-j$ for $j\le3$,
$\rho\in\langle1,x,x^2\rangle$ and $m_5\in L_{10}$.

For affine $b$, write $a^\ell b=\Pi_\ell(b)+R_\ell(b)$
for its affine polynomial part and remainder in the basis $1,y,y^2$.
The first-three finite quadratic moments are
$n_0=\eta_0$,
$n_1=\Pi_1\eta_0+\eta_1$, and
$n_2=2\Pi_1\eta_1+2\Pi_1(\Pi_1\eta_0)-\Pi_2\eta_0+\eta_2$.
Here $\eta_0\in L_{10}$, $\eta_1\in L_{12}$,
$\eta_2\in L_{14}$ satisfy the three independent gap equations
$[x^9]\operatorname{rem}(Zp,P)=[x^8]\operatorname{rem}(Zp,P)=0$
and
$[x^9](2\operatorname{rem}(Zq,P)+\gamma\operatorname{rem}(Z^2,P))=0$,
where $\eta_0=p(x)+\gamma y$ and $\eta_1=q(x)+\delta y$.
The dimensions are $5+6+7-3=15$.
The short moments are
$\mu_1=n_1-an_0$, $\mu_2=n_2-2an_1+a^2n_0$,
with pole bounds12 and14. Their short incidence polynomial is
$Q=v\rho^2-\delta_3\mu_2-\delta_2\mu_1-\delta_1n_0
-(\delta_3\mu_1+\delta_2n_0)T-\delta_3n_0T^2$.
The finite formula replaces the short $\delta_i,\mu_i$ by
finite $d_i,n_i$. Every finite $n_i$ here is affine.

Newton's polygon gives a unique formal critical root $c_\infty$
of pole five; the other two roots have poles at most two.
This is a local root, not a rational root in $K$.
At this root,
$F(c)=vc^{10}+R_F$ with $R_F$ pole at most54,
and $U(c)=v\rho c^5+vm_5c^4+R_U$ with $R_U$ pole at most37.
Thus the actual identity gives
$Q(c)=v(\rho+m_5/c)^2+R$ with $R$ pole at most18.
For the five infinity rows take the coefficients of poles23,22,21,20,19
of
$-\delta_3\mu_2+(\delta_1\mu_1+\delta_0n_0)z_*
+\delta_0\mu_1z_*^2-2v\rho m_5z_*-vm_5^2z_*^2$,
and set them to zero, where
$z_*=-\delta_3/\delta_2-\delta_1\delta_3^2/\delta_2^3$.
Indeed $z=1/c_\infty$ satisfies
$\delta_0z^3+\delta_1z^2+\delta_2z+\delta_3=0$ and
$\operatorname{ord}(z-z_*)\ge11$ by one Newton step and Hensel:
the residual has order at least minus three, the derivative exact
order minus fourteen. This replacement changes the trace expression
only by pole at most17, hence preserves these five rows.
The other nine rows are the actual selected SHORT equations
$Q_s(0)=0$ at all three sheets over the three selected roots of $A$.
These are not finite-frame origin equations.

Their combined rank14 is a HYPOTHESIS on the actual source in this
theorem. Fixing the source, $\rho,m_5$ fixes their right sides,
so consistency leaves a one-dimensional affine moment line.
The map from moments to $Q-v\rho^2$ is injective: read $n_0$,
then $\mu_1$, then $\mu_2$ from its quadratic, linear and constant
coefficients. Thus its direction $Q_1$ is nonzero.

For completeness, properness is witnessed only in the following
necessary LINEAR coefficient family. Let $\delta_3$ range in the
three-dimensional plane
$\{b\in\langle1,x,x^2,x^3\rangle:[x^9]\operatorname{rem}(Zb,P)=0\}$
and take $A_2\in L_{14}$,
$A_1\in L_{16}$, $A_0\in L_{17}$.
Put
$d_2=A_2-3\Pi_1\delta_3$,
$d_1=A_1-2\Pi_1d_2-3\Pi_2\delta_3$,
$d_0=A_0-\Pi_1d_1-\Pi_2d_2-\Pi_3\delta_3$.
Impose the gap17 in
$A_1+2R_1d_2+3R_2\delta_3$ and the nine selected equations
$A_0+R_1d_1+R_2d_2+R_3\delta_3=0$.
For fixed leading coefficient these ten equations have rank10
on the25 regularizer coordinates; the full necessary family
has dimension18, with surjective leading-plane projection.
The explicit construction, leading-plane calculation and exact
rank14 witness are recorded in
[the author reduction](../../Research/experiments/oct02_m9_uniform/POLE_FOURTEEN_CRITICAL_INFINITY_TRACE_REDUCTION.md).
The executed witness includes its complete14-by15 matrix, a nonzero
14-by14 minor and all coordinates in
[the exact certificate](../../../litt3-computation-data/oct02_m9_uniform/pole14_combined_rank_prototype.json),
from [its source](../../scripts/oct02_m9_uniform_pole14_combined_rank.sage).
The completed run took1.196 seconds; two PRE-RANK failures are preserved
and supply no rank evidence. This author necessary-model witness does
not realize an actual etale source. It only proves that the rank-drop
support is proper in the specified necessary family.

## General statement, including nonsquare factors and inseparability

Let $k$ be algebraically closed of odd characteristic $p$, let $C/k$
be a smooth connected proper curve of genus $g_C$, and put $L=k(C)$.
Fix $g\in L^*$ and $q\in L$. We seek constants $\theta\in k$ for
which $g(\theta-q)$ is a NONZERO square in $L$.

If $q=q_0\in k$, then for $\theta\ne q_0$ the product is square
if and only if $g$ is square. Hence this constant-ratio alternative
can be empty or cofinite; no finite-support theorem applies. The
zero product at $\theta=q_0$ is excluded by the NONZERO convention.

Suppose $q$ is nonconstant. Write $q=r^{p^e}$, with $e$ maximal and
$dr\ne0$. The map $r:C\to\mathbf P^1$ is separable of degree $N$.
Let $B$ be the points where $\operatorname{ord}_Pg$ is odd. Then:

* If some point of $B$ is not a pole of $r$, EVERY possible $\theta$
  must equal $q(P)$ for EVERY such point. Distinct values give empty
  support; otherwise at most ONE constant survives. Its actual square
  condition is checked separately.
* If all of $B$ lies over infinity, a necessary fixed condition is
  $\operatorname{ord}_Pg-m_P$
  even at EVERY pole of $r$. If this fails, the support is empty.
  Here $m_P$ is the positive pole multiplicity of $r$ at $P$.
  If it holds, a constant $\theta=\lambda^{p^e}$ has EVEN divisor
  for $g(\theta-q)$ exactly when the finite fiber $r^{-1}(\lambda)$
  has all multiplicities even. These constants form a finite set.
  If $N$ is odd the set is empty. If $N$ is even, its cardinality is
  at most $\lfloor4+4(g_C-1)/N\rfloor$.

In particular the support of ACTUAL squares is finite whenever $q$
is nonconstant. A finite even divisor need not define a square: the
unramified two-torsion class is retained. This lemma decides a finite
PARITY support containing the square support and then requires a
square-class check on its surviving candidates.

There is a STRONGER bound for ACTUAL squares, independent of genus:
their cardinality is at most $1+v_2(N)$, where $v_2$ is the
two-adic valuation of the separable degree. In particular, if $N$
is odd there is at most one actual square value, even when divisor
parity alone has several candidates.

## Proof and compact candidate certificates

Since $k$ is algebraically closed, each $\theta$ has a unique
$p^e$-th root $\lambda$. In odd characteristic
$\theta-q=(\lambda-r)^{p^e}$, so its divisor parity is the same
as that of $\lambda-r$. At a point where $r$ is finite and $g$ has
odd order, $\lambda-r$ must vanish, forcing $\lambda=r(P)$ and
$\theta=q(P)$. This proves the first alternative, with no claim
that $g$ itself is square.

In the second alternative, at each pole of $r$ the parity is fixed
by $\operatorname{ord}_Pg-p^em_P$,
equivalent to the stated condition because $p$ is odd. Away from those
poles $g$ has even order everywhere. Thus parity holds exactly when
each zero of $\lambda-r$ has even order, giving the fiber criterion.
For an even fiber, each ramification index is at least two, and the
fiber has at most $N/2$ geometric points. Its contribution to the
different divisor is at least $\sum(e_P-1)\ge N/2$, also in the
presence of wild ramification. Riemann--Hurwitz gives total different
degree $2g_C-2+2N$. Distinct fibers have disjoint support, proving
the bound and finiteness. If $N$ is odd an even fiber is impossible.

No parameter sweep is needed to certify this support. If the first
alternative holds, record the finite odd divisor of $g$, its values
under $q$, and the resulting zero-or-one candidate. Otherwise compute
the different divisor of the SEPARABLE map $r$ and its finite images.
Only these finitely many branch values can be candidates; for each,
record the full fiber divisor and discard it unless every coefficient
is even. Record the pole-parity check and, for surviving constants,
the square class of $g(\theta-q)$. A nonsquare unramified twist remains
explicit until this last check. These data are a finite geometric
certificate, even when the original pencil $q$ is inseparable.

To prove the stronger bound, suppose $\theta_1,\ldots,\theta_m$
are distinct square values and let $\lambda_i^{p^e}=\theta_i$.
Dividing their square identities gives that
$(\lambda_i-r)/(\lambda_1-r)$ is square in $L$ for every $i>1$:
its odd $p^e$-th power is square, hence so is the ratio itself.
In $k(r)^*/k(r)^{*2}$ these $m-1$ classes are independent. Indeed
the valuation at $r=\lambda_j$, for $j>1$, is odd only for the
$j$-th class. The corresponding multiquadratic extension of $k(r)$
has degree $2^{m-1}$ and is contained in $L$. Therefore
$2^{m-1}\mid[L:k(r)]=N$, proving the claim and finiteness
without any assumption that $g$ is square. This argument also
retains the unramified twists: it uses actual square identities,
not merely even divisors.

## Actual m9 application on the rank-fourteen open

Use the actual source and moment rows given immediately above.
Fix an ACTUAL pole-fourteen m9 source outside its proper combined
rank-drop support, and fix $\rho,m_5$. The fourteen source-dependent
linear moment equations either are inconsistent, excluding this data,
or leave one affine trace parameter $\theta$. Thus
$Q_\theta=Q_0+\theta Q_1$ with $\deg_TQ_i\le2$.
The nonzero trace-kernel direction gives $Q_1\ne0$: the map from
$(n_0,\mu_1,\mu_2)$ to $Q-v\rho^2$ is injective, read successively
from its quadratic, linear and constant coefficients using
$\delta_3\ne0$. By the audited critical irreducibility, both
$F(c)$ and $Q_1(c)$ are nonzero in $L=k(X)[c]$.
Put $g=F(c)Q_1(c)$ and $q=-Q_0(c)/Q_1(c)$.
The actual critical identity requires
$U(c)^2=g(\theta-q)$, a NONZERO square in this cubic field.

Whenever this ratio is nonconstant, only FINITELY many affine trace
coordinates can satisfy the critical square identity, for each fixed
actual source and fixed $\rho,m_5$. The support is constructed by
the preceding branch/odd-divisor certificates. The constant-ratio
alternative remains explicit. In particular, the selected endpoints
alone do NOT prove nonconstancy: both the particular $Q_0$ and the
homogeneous $Q_1$ have SHORT constant coefficient zero there. It is
the linear trace expression that equals $v\rho^2$, not $Q_{0,s}(0)$.
No equation $Q_f(0)=0$ is introduced.

There are direct sufficient conditions at the high critical infinity
point. If $\rho$ has EXACT pole six, $Q_0(c_\infty)$ has exact
pole22, from $v\rho^2$; the other forcing terms have bounds21,20
and the error has bound18. If $\rho$ has pole at most three but
$m_5$ has EXACT pole ten, its exact pole is20, from $vm_5^2/c^2$;
the other terms have bounds16,18,18. In either case $Q_1(c_\infty)$
has pole at most18, so their ratio has a pole and is nonconstant.
Thus the unexcluded constant-pencil boundary is narrowed to
$\rho\in L_3$ and $m_5\in L_9$, together with the separate
rank-drop support; no assertion is made on that boundary.

In fact NONZERO $\rho\in L_3$ also rules out a constant ratio,
by finite integrality rather than by endpoint values. If the ratio
were constant, some $Q_\theta(c)$ would be zero. Its degree at most
two and critical degree three force $Q_\theta$ to be the zero
polynomial. The finite formula then gives successively
$n_0=n_1=0$ and $n_2=v\rho^2/\delta_3$.
But $n_2$ is affine, $\delta_3$ is a degree-three polynomial in
$x$, and $v=V_3(x)+\varepsilon y$ with $\varepsilon\ne0$.
Comparing the $y$ coefficient in the affine basis $1,y,y^2$ would
require $\delta_3\mid\varepsilon\rho^2$ in $k[x]$, impossible
when $\deg\rho\le1$ and $\rho\ne0$.
Together with the infinity argument, this proves nonconstancy whenever
$\rho\ne0$ OR $m_5$ has exact pole ten.

Conversely, when $\rho=0$ and $m_5\in L_9$, all fourteen linear
equations are homogeneous: the infinity forcing has pole at most18
and the endpoint forcing is zero. On the rank-fourteen open the
trace solution is therefore a VECTOR line and one can take $Q_0=0$.
The ratio is constant. For its nonzero parameters the critical square
condition is either true for all or false for all, according to the
square class of $F(c)Q_1(c)$. Thus this is a genuine limitation of
the pencil-square method, not merely an omitted nonconstancy proof.

## Uniform critical genus bound and at most112 candidates

Let $C$ be the smooth normalization of the irreducible critical cubic.
Its binary discriminant is unchanged by the short-to-finite translation.
The finite cubic has affine coefficients, so the discriminant is affine.
The short pole bounds9,14,16,17 give discriminant pole at most60:
the five cubic discriminant terms have respective bounds60,57,59,52,56.
It therefore has finite zero degree at most60.

At any finite point divide the integral binary cubic by its common
local content. Its discriminant order decreases by four times that
content, remaining nonnegative. Since the residue field is infinite,
an integral projective change of coordinate makes its leading coefficient
a unit: choose a residue value where the primitive residual cubic does
not vanish and use reciprocal coordinate about it. The resulting monic
integral cubic presents a rank-three order in the normalization. The
different exponent is at most its discriminant exponent, the difference
being twice the index length. The projective coordinate change has unit
determinant, so the original discriminant order bounds this exponent.
Consequently the finite different degree of $C\to X$ is at most60.

On the pole-fourteen branch the unique pole-five critical root gives
one UNRAMIFIED infinity point. The remaining quadratic factor contributes
at most one to the infinity different (degree three in characteristic5
is tame). Thus the total different degree is at most61; it is even by
Riemann--Hurwitz, hence at most60. Since $g_X=9$,
$2g_C-2=3(2g_X-2)+\deg\operatorname{Diff}$ gives $g_C\le55$.

In the nonconstant-pencil second alternative $N$ is even and at least2,
so the uniform candidate bound is at most
$4+4(55-1)/2=112$. The first alternative has at most one candidate.
Thus the rank-fourteen open with nonconstant ratio has at most112 critical
PARITY candidates for its one trace coordinate, for each fixed source
and fixed $\rho,m_5$. Testing square classes and the full original
source identity can further discard them. This is not a finite
enumeration of sources: the source coefficients, the proper rank-drop
locus and the constant-pencil boundary remain open.

## Affine critical integrality and a bounded branch certificate

There is a useful elementary integrality statement behind the finite
certificate. Let $R$ be an integrally closed affine curve ring and
let $D=d_3T^3+d_2T^2+d_1T+d_0$ have coefficients in $R$.
For $n_0,n_1,n_2,b\in R$ put
$Q=b-d_3n_2-d_2n_1-d_1n_0-(d_3n_1+d_2n_0)T-d_3n_0T^2$.
For any critical root $c$ in a finite field extension, $Q(c)$ is
integral at EVERY point of the normalization over $\operatorname{Spec}R$.
At a point where $c$ is integral this follows directly. Where $c$
has a pole, use $D(c)=0$ to write
$Q(c)=b-d_3n_2+(d_1n_1+d_0n_0)/c+d_0n_1/c^2$.
All terms are then integral. No leading-coefficient unit or restriction
on local critical multiplicities is required.

The same cancellation works in EVERY critical degree. Write
$D(T)=\sum_{i=0}^d d_iT^i$ over $R$ and fix $n_j\in R$
for $0\le j<d$. For
$H(T)=[D(T)\sum_{j=0}^{d-1}n_jT^{-j-1}]_+$ one has
$H(c)=-\sum_{j=0}^{d-1}n_j\sum_{i=0}^{j}d_ic^{i-j-1}$
at a nonzero critical root. This follows by subtracting the negative
part of $D(c)c^{-j-1}=0$. At every point where $c$ has a pole,
the displayed powers are strictly negative, so $H(c)$ is integral;
where $c$ is integral use its polynomial expression. Thus the
trace-contraction part of the incidence is integral on the whole
finite critical normalization in every degree. If the remaining
polynomial part $[U^2/F]_+$ is a constant in $R$, the WHOLE
$Q(c)$ is integral as well. For higher admissible degrees where
that part has positive degree, its possible critical poles remain
explicit; the present argument does not remove them.

Apply this with the ORIGINAL finite-frame trace moments and
$b=v\rho^2$. Every coefficient and every finite trace moment is
affine on $X$. Thus both $Q_0(c)$ and $Q_1(c)$ have NO finite poles
on $C$, even over the zeros of the critical leading coefficient.
This is a polynomial identity for necessary moment data; it does not
assume the existence of $U$ or the square identity.

At infinity the high critical root has pole five. The five imposed
linear rows give $Q_1(c_\infty)$ pole at most18, while the particular
$Q_0(c_\infty)$ has pole at most22: its terms $v\rho^2$,
$2v\rho m_5/c$ and $vm_5^2/c^2$ have respective bounds22,21,20,
and the remaining error has bound18. At either other critical root,
the short coefficients of $Q_i$ have bounds26,24,19 and the root
has pole at most two. Hence its value has pole at most26. These
bounds also count a ramified quadratic infinity point correctly:
multiply its base-normalized pole bound by its ramification index.
The common pole divisor $H$ for $Q_0(c),Q_1(c)$ therefore has
degree at most $22+26+26=74$.

For a nonconstant ratio $q=-Q_0(c)/Q_1(c)$, these two sections of
$\mathcal O_C(H)$ define a pencil after their common base divisor
is removed. Consequently $\deg(q:C\to\mathbf P^1)\le74$ and
the degree $N$ of its separable part is at most74. Together with
$g_C\le55$, its different divisor has degree at most
$2\cdot55-2+2\cdot74=256$.
In the even-fiber alternative, the squarefree polynomial
$B(\Theta)=\prod(\Theta-q(P))$, with the product over DISTINCT
finite images of the separable different support, is therefore a
necessary parameter-support certificate of degree at most256.
Purely inseparable powers change the image values but do not increase
their number. Complete fiber parity reduces its roots to at most112,
after which square-class and full source-identity checks remain.
In the other alternative the odd divisor supplies a degree-one or
empty certificate instead. These bounded branch certificates depend
on the fixed actual source and trace forcing, not on an enumeration
of source parameters.

The independent-square-class bound now gives at most SEVEN actual
square values: $N\le74$ implies $v_2(N)\le6$.
This sharpens the at-most112 parity candidates after their twist
checks. The finite candidate certificate can still be constructed
from the branch divisor; the seven-value bound alone does not
locate its surviving roots or satisfy the full interpolation identity.

## Hom-disjoint correspondences sharpen the bound to four

The accepted [fixed-pair arithmetic](../../Theorems/curve_arithmetic/fixed_pair_arithmetic.md)
gives $g(X)=9$, a degree-three map $x:X\to\mathbf P^1$,
nonhyperellipticity and absolute simplicity of $J(X)$.

We use the following correspondence fact. If $h:C\to X$ and
$r:C\to M$ are nonconstant maps of smooth proper connected curves,
$r$ has degree $e$, and $\operatorname{Hom}(J(M),J(X))=0$, then
$D_m=h_*r^*(m)$ is a BASEPOINTFREE moving family of degree-$e$
divisors in one linear equivalence class on $X$.
Indeed the induced map on Jacobians is $h_*r^*=0$, so all $D_m$
are linearly equivalent. The family cannot be constant, because a
constant divisor would contain the image of every point of $C$
under $h$. Nor can a point $P\in X$ lie in every $D_m$:
all such $m$ would have to lie in the finite set $r(h^{-1}(P))$.
The associated complete linear series is therefore basepointfree
and moving. A generic two-dimensional space of its sections has
no common zeros, since the field is infinite, giving a degree-$e$
map $X\to\mathbf P^1$. In particular $e\ge\operatorname{gon}(X)=3$.
This is the [Hom-disjoint correspondence lemma](../../Theorems/curve_arithmetic/hom_disjoint_correspondence_gonality.md);
ramification of either map is harmless.

Suppose five distinct square parameters existed. Their multiquadratic
subfield has degree16,
and its smooth curve $M$ has genus five:
its tame degree16 cover of the line is branched at five points,
each with inertia two, so $2g_M-2=-32+5\cdot8=8$.
Again $\operatorname{Hom}(J(M),J(X))=0$: already its dimension five
is smaller than the absolutely simple target dimension nine.
The correspondence degree is $e=N/16\ge3$, so $N\le74$ forces
$e=3$ or $4$.

If $e=4$, the basepointfree trace series supplies a degree-four map
on $X$. Together with its degree-three $x$, the two function fields
generate $k(X)$, since their common index divides both three and four.
Castelnuovo--Severi then gives $g_X\le(3-1)(4-1)=6$, a contradiction.

If $e=3$, the trace series is the UNIQUE trigonal pencil on $X$.
Uniqueness follows from Castelnuovo--Severi: two distinct degree-three
pencils would generate its field and give genus at most four.
Its degree-three complete series has dimension one by Clifford.
Writing the divisor family in this pencil gives $f:M\to\mathbf P^1$
such that $x\circ h=f\circ r$. Here $\deg h=3$ is the actual
critical-cover degree, so $3\cdot3=3\deg f$ and $\deg f=3$.

But the genus-five multiquadratic curve $M$ cannot be trigonal.
A genus-five curve has at most one degree-three pencil by the same
Castelnuovo--Severi argument. Thus its group
$G=(\mathbf Z/2)^4$ preserves that pencil and acts on its target line.
In odd characteristic an elementary abelian two-subgroup of
$\operatorname{PGL}_2$ has order at most four: conjugate one involution
to $z\mapsto-z$ and use its diagonal/antidiagonal centralizer.
The kernel of the action has order at least four. Since it fixes $f$,
Artin's fixed-field theorem makes its order divide
$[k(M):k(f)]=3$, impossible. This excludes five values.

Hence at most FOUR actual square parameters remain. The argument
uses auxiliary correspondences only to constrain the critical pencil;
neither auxiliary map replaces either original actual etale map.
It is not a source existence or common-cover decision.
The [focused independent correspondence/four-bound audit](../../Research/audits/HOM_DISJOINT_CORRESPONDENCE_GONALITY_AUDIT_2026_10_02.md)
passed this new implication without numerical replay. The preceding
source/pencil and proper-model assertions retain their Version2
[focused review](../../Research/audits/M9_CRITICAL_FINITE_SQUARE_SUPPORT_AUDIT_2026_10_02.md).

## The additional source-only condition on the homogeneous boundary

Retain an ACTUAL degree-ten m9 source, with short critical coefficients
of poles9,14,at most16,at most17. Suppose $\rho=0$ and
$m_5=\operatorname{Tr}(u)\in L_9$. Let $c=c_\infty$ be its
unique FORMAL pole-five critical root. The original interpolator has
$U_5=0$, $U_4=vm_5$, and $U_j$ pole at most $25-j$ for $j\le3$.
Write $m_5=\alpha x^3+b$, with $b\in L_6$; $\alpha$ may be zero.

The exact estimates at this root are
$F(c)=vc^{10}+R_F$, $R_F$ pole at most54, and
$U(c)=vm_5c^4+R_U$, $R_U$ pole at most37.
The first leading term has exact pole60; the second has pole at most39.
Thus $Q(c)=U(c)^2/F(c)$ differs from $vm_5^2/c^2$ by pole at
most16: the cross term has bound $39+37-60=16$, the squared remainder
has bound14, and changing the denominator has bound12.
Moreover $m_5^2-\alpha^2x^6$ has pole at most15. Multiplying it by
$v/c^2$, of order zero, keeps that bound. Hence
$Q(c)-\alpha^2G$ has pole at most16, where $G=vx^6/c^2$
has EXACT pole18.

For any chosen local uniformizer write $Q_j$ and $G_j$ for the
coefficients of pole $j$. Necessarily
$Q_{18}=\alpha^2G_{18}$ and $Q_{17}=\alpha^2G_{17}$.
Eliminating $\alpha^2$ gives the additional HOMOGENEOUS linear row
$Q_{17}-(G_{17}/G_{18})Q_{18}=0$ on the exact fifteen moment coordinates.
There is no assumption $\alpha\ne0$ and no normalization of $u$.

The five previous infinity rows and the nine selected SHORT equations
are also homogeneous for $\rho=0,m_5\in L_9$. Therefore this new row
forms a fifteen-by-fifteen homogeneous matrix. EVERY actual source on
this boundary must have rank at most fourteen: if its rank were fifteen,
all first-three moments would vanish, making $Q=0$. Critical incidence
would then give $D\mid U$, contrary to the established actual critical
coprimality. This necessity does NOT require the original fourteen rows
to have rank fourteen.

## Precision and the proper necessary-model support

The old first reciprocal-root approximation
$z_*=-\delta_3/\delta_2-\delta_1\delta_3^2/\delta_2^3$
has error order at least11 and is NOT accurate enough to read pole17:
the coefficient $\delta_1\mu_1+\delta_0n_0$ can have pole28.
For this new row take a second FULL Newton step for
$f(z)=\delta_0z^3+\delta_1z^2+\delta_2z+\delta_3$,
$z_{**}=z_*-f(z_*)/f'(z_*)$.
The step has order at least11; the new residual has order at least6
because its quadratic coefficient has pole at most16. Since $f'$ has
exact order minus fourteen, Hensel gives
$\operatorname{ord}(z_{**}-1/c)\ge20$.
Substitution therefore preserves both new jets, and the row is computed
from rational source data without adjoining a critical root.

One NEW probe uses the STORED necessary-source witness of the previous
fourteen-row reduction, chooses $v=y$ of exact pole ten, and appends
this new row. The old fourteen-by-fifteen matrix is READ from its exact
certificate; its rank is not rerun. The augmented determinant is nonzero,
so the new matrix has rank fifteen. The complete extra row, determinant,
field and witness data are in
[the exact new certificate](../../../litt3-computation-data/oct02_m9_uniform/pole14_constant_boundary_extra_row.json),
generated by
[the new source](../../scripts/oct02_m9_uniform_pole14_constant_boundary_extra_row.sage).
Execution completed in1.137 seconds under a fifteen-second hard cap.

Consequently the augmented determinant vanishing is a PROPER additional
necessary-source Fitting support in the coefficient family with
$v\in L_{10}$ of exact pole ten. The witness is NOT an actual etale
source; actual sources may all lie on the determinant-zero support.
This reduces the genuine homogeneous boundary to a source-dependent
closed condition, retaining all original source constraints and both
actual finite etale maps. No numerical sweep, finite-origin equation,
or claim of full m9 exclusion is made.

## Leading content coefficient and the lower-trace boundary

The new row has a useful interpretation without computing another
determinant. For $v=V_3(x)+\varepsilon y$, write $v_{10},v_9$
for its two leading Laurent coefficients. The exact local parameter
$\tau=x^3/y$ gives no next-order term in $x$ after its leading
pole-three term. Consequently the ratio $G_{17}/G_{18}$ is
$v_9/v_{10}-2(\delta_2)_{13}/(\delta_2)_{14}$.
Indeed $\delta_3$ likewise has no pole-eight coefficient, and
$1/c$ has first two terms given by $-\delta_3/\delta_2$;
its additional Newton correction begins only at order eight.
Thus, whenever the original fourteen rows have rank14 and their
kernel has $Q_{18}\ne0$, the new necessity determines
$v_9/v_{10}=Q_{17}/Q_{18}+2(\delta_2)_{13}/(\delta_2)_{14}$.
The right side depends only on the critical cubic, through its
homogeneous trace kernel. This is a single leading-content condition,
not an exhaustion of the remaining source coefficients.

If instead $m_5\in L_6$, then $vm_5c^4$ has pole at most36,
so $U(c)$ has pole at most37 and $Q(c)$ at most14. All four
additional coefficients18,17,16,15 must vanish. If the homogeneous
kernel has pole17,16 or15 at this point, no $m_5\in L_9$ can realize
it: exact pole18 requires $m_5$ exactpole9, and $m_5\in L_6$
requires pole at most14. These extra rows and their ranks have NOT
been computed. The proved new proper support uses only the single
pole18/17 relation and retains every lower-coefficient boundary.
