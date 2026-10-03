# Proof of m6 critical coprimality and root restrictions

Version1,1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m6_critical_coprimality.md).
Use the actual infinity coefficients and at least four distinct large
residues in
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
the direct numerator bounds in
[the torsion numerator theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md),
and the fixed gap rows in
[the reduced-linear proof](admissible_linear_critical_denominator.md).
The parent and source agent independently reviewed the new complement,
canceled-root and finite-itinerary arguments. No source search is used.

Write $D=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0$.
The short infinity bounds are6,14,16,18, with $\delta_3$ affine
of exact pole6. If $D(c)=0$, then $\delta_3(c+Z/y)$ is affine:
scaling the finite-frame cubic root equation by $\delta_3^2$
makes $\delta_3(c+Z/y)$ integral over the affine ring, which is
normal. This retains all finite coefficient drops.

A root of infinity pole at most four would give $\delta_3c$ pole
at most ten. The successive translation gaps17,14,11 then vanish;
the fixed three-by-three gap matrix on $L_6$ is invertible, forcing
$\delta_3=0$. A root of pole greater than eight makes the cubic
term uniquely leading in $D(c)$. Thus its pole $r$ is5,6,7 or8.

Factor $D/\delta_3=(T-c)(T^2+bT+e)$. Then
\[
e=-\delta_0/(\delta_3c),\quad
b=(e-\delta_1/\delta_3)/c,
\quad \operatorname{pole}_O e\le12-r,\quad
\operatorname{pole}_O b\le10-r.
\]
Each scaled finite critical root is integral, hence the rational
complementary coefficient $\delta_3b_f$, where $b_f=b-2Z/y$,
is affine. Since $\delta_3b$ has pole at most $16-r\le11$,
its gaps17 and14 force $\delta_3=\kappa q$ for the fixed
two-gap kernel $q=([13],[18],[24])$. The remaining gap11 form
on $q$ is[7], nonzero. Thus $\delta_3b$ has exact pole11,
which forces $r=5$ and $b$ of exact pole5.

After subtracting the fixed affine polynomial part of $(Z/y)\delta_3$,
the affinity equations give the leading relations
\[
\delta_3c\sim-R_1\delta_3,\qquad
\delta_3b\sim2R_1\delta_3,
\quad b\sim-2c.
\]
Here the affine residual functions have bound11 and hence bound10,
so cannot affect the leading gap11. Since $e$ has pole at most7,
\[
\delta_2=\delta_3(b-c)\sim-3\delta_3c,
\qquad\delta_1=\delta_3(e-bc)\sim2\delta_3c^2.
\]
Their exact poles are11 and16. At any rational critical root,
$D'(c)=\delta_3(c^2+bc+e)\sim-\delta_3c^2\ne0$.
A repeated factor of a cubic in characteristic five would be
rational, so $D$ is squarefree over $K$.

Suppose now $U(c)=0$. Write $U=\sum A_jT^j$, with
\[
A_5=v\rho,\quad A_4=vm_5+s_4\rho,\quad
\rho\in\langle1,x,x^2\rangle,\quad m_5\in L_{10},
\quad\operatorname{pole}_O A_j\le25-j\ (j\le3).
\]
If $\rho$ has degree two, $A_5c^5$ has pole41 and all other
terms have pole at most40. If $\rho$ has degree one, it has pole38.
Any $A_4$ pole19 or20 would then give uniquely leading pole39 or40,
so $A_4\le17$; its possible poles above12 are13,16,19,20, since
$m_5$ is affine in $L_{10}$ and $s_4\rho$ has pole at most9.
Thus $A_4\le16$, and $A_5c^5$ of pole38 becomes uniquely leading.
Hence $\rho$ is constant, possibly zero.

Now $A_5c^5\le35$. An $A_4$ pole greater than17 is uniquely
leading; its same nongap list again gives $A_4\le16$.
An $A_3$ pole22 would give uniquely leading pole37, against
$A_4c^4\le36$, $A_5c^5\le35$ and lower terms at most33.
Therefore $A_3\le21$. At each large infinity sheet $W$ has pole2,
so $U(W)$ has pole at most27. The pole18 initial polynomial of
$D(W)$ is linear in its nonzero leading residue, with nonzero
linear coefficient from $\delta_1$. Among at least four distinct
large residues one therefore has exact $D(W)$ pole18. Since $u$
has exact pole10 there, $U(W)=uD(W)$ has pole28, a contradiction.
There is no canceled rational critical root.

A degree-one gcd would provide such a root. A degree-two gcd,
if irreducible, leaves a reduced linear denominator and is excluded by
[the reduced-linear theorem](../../Theorems/cartier_and_spin/admissible_linear_critical_denominator.md);
if reducible it already gives a canceled rational root. A full
degree-three gcd makes $u$ polynomial of degree at most two,
excluded by
[the polynomial theorem](../../Theorems/cartier_and_spin/admissible_linear_annihilator_exclusion.md).
Thus $\gcd(D,U)=1$.

For the remaining uncanceled root, literal division gives
\[
qZ=([22]+[15]x)P+R,\quad
R=([22],[2],[23],[9],[22],[20],[10],[7]).
\]
Thus $R/y$ has exact pole11. The affine function
$g=q c_f-([22]+[15]x)y^2=q c+R/y$ has pole at most11,
hence lies in $L_{10}$. This gives the five-parameter normal form.
The fixed roots of $q$ are[12],[16], with $P$ values[6],[1],
so each of the six possible finite poles is simple and unramified.

At either three-point fiber, the numerator is
$Q_i y^2+\gamma y+p_3(x_i)$ with $Q_i=[5],[9]\ne0$.
It cannot vanish at all three $y$ values, so there is a pole on
each fiber. If it vanishes at two, the remaining third value is
$\gamma/Q_i$, implying $\gamma^3=P_iQ_i^3$.
But $Q_i^3=[23]$ on both fibers, and $P_iQ_i^3=[5],[23]$
are distinct. Thus there are at most three canceled numerator
values among the six, giving at least three poles.

The complementary coefficient gives the matching upper bound.
At every pole of $c_f$ the monic factor
$T-c_f$ has Gauss content valuation minus one. Since $D_f$
is affine, its complementary quotient has content valuation at
least one. Its linear coefficient is $\delta_3b_f$, so $b_f$
is regular there because $\delta_3$ has order one. Furthermore
\[
q b_f=-2([22]+[15]x)y^2+h,\qquad h\in L_{10}.
\]
Indeed $h=q b_f+2\Pi_1(q)=q b-2R/y$ is affine with infinity
bound11, hence bound10. The same two-fiber argument applies to
this numerator: scaling the nonzero $Q_i$ by minus two leaves
the two required cubes distinct, so it has at most three zeros
among the six points. At every pole of $c_f$ its numerator
vanishes, and there are at least three such poles. Thus there
are exactly three, and the numerator vanishes at precisely those
points. Its own poles are therefore the complementary three.
Both fibers must contain a pole of $c_f$, so the only distributions
are one plus two or two plus one. This proves the sharper itinerary
without a critical-fiber simplicity hypothesis.

The fixed quadratic and its unramified roots are certified in
[the tiny itinerary script](../../scripts/oct01_annihilator_transfer/fixed_linear_denominator_itinerary.py).
The new literal division is recorded in
[the external exact data](../../../litt3-computation-data/oct01_local_continuation/annihilator_transfer/m6_rational_root_normal_form.json).
The source agent independently reproduced the division and all fiber
products with
[a separate tiny producer](../../scripts/oct01_nonzero_source/m6_rational_root_fiber_itinerary.py),
retaining
[its exact output](../../../litt3-computation-data/oct01_local_continuation/nonzero/data/m6_rational_root_fiber_itinerary.json).
No original source or second map is constructed by these necessary
conditions.
The later
[critical irreducibility proof](admissible_degree_ten_m6_critical_irreducibility.md)
excludes every hypothetical rational-root itinerary by exact source
coefficient identities. The geometric restrictions above retain the
input reduction and its provenance; they no longer describe an open
rational-root boundary.
