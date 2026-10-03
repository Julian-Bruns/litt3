# Proof of the actual m9 low-trace quadratic-moment theorem

ID: `admissible_degree_ten_m9_low_trace_quadratic_moments`.
Version1, 2 October2026. Computation-free actual-source argument.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_low_trace_quadratic_moments.md).
The root's focused whole-implication review
[passed](../../Research/audits/M9_LOW_TRACE_QUADRATIC_MOMENTS_AUDIT_2026_10_02.md).
No numerical calculation was performed.

## Actual input and leading quintic

Use [critical incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md),
[critical irreducibility](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_irreducibility.md),
and [the actual nonzero profiles](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md).
Retain the actual primitive degree-ten étale source $h:S\to X$, its
annihilator, both original finite étale maps, and its short polynomial
$F=v(T^5+q_s)^2+(T^5+q_s)S_s+t^3$. Put $D=S_s'$.
Its actual numerator satisfies $U(W)=uD(W)$ and
$U_5=v\rho$, $U_4=vm_5+s_4\rho$, $U_j\le25-j$ for $j\le3$.
Here $\rho\in\langle1,x,x^2\rangle$ and $m_5=\operatorname{Tr}u\in L_9$.
The general critical coefficient bounds are $9,14,16,17$;
$v,q_s$ have exact poles ten and seven, and $S_s$ coefficients have
bounds $9,14,16,17,20$.

At the original infinity point the étale source splits into TEN actual
Laurent sheets. Five big roots have exact pole two and five selected
roots have pole at most one. Their annihilator values have exact poles
ten and eight respectively. For a base uniformizer $\tau$, the
normalized source polynomial has reduction
$\tau^{30}F(\tau^{-2}z)\bmod\tau=z^5H(z)$, with
$H(z)=v_0z^5+(B/3)z^3+(C/2)z^2+e$ and $H'=z(Bz+C)$.
The five actual big residues $\beta_i\ne0$ are precisely its roots,
with multiplicity retained; hence $e\ne0$. The accepted cohort result
gives at least four distinct such residues, so $(B,C)\ne(0,0)$.

Since $m_5\in L_9$, the normalized numerator's leading polynomial is
$\tau^{28}U(\tau^{-2}z)\bmod\tau=Az^3$, where $A=(U_3)_{22}$.
Indeed $U_4$ has pole at most nineteen and the $U_5$ term has
evaluated pole at most twenty-six, below twenty-eight.

If $H$ has a repeated nonzero root, it must be $\beta_0=-C/B$,
with $B,C\ne0$. Since $H''(\beta_0)=-C\ne0$, it is exactly double,
and the other three roots are simple. On either colliding ACTUAL sheet
the leading derivative coefficient vanishes. The exact equality
$U=uD$ and the exact pole ten of $u$ force $A\beta_0^3=0$, hence
$A=0$. On any remaining simple big sheet, however, $uD$ has exact
pole twenty-eight, contradicting $A=0$. Thus $H$ is squarefree.
All five derivatives are now nonzero, and the same actual exact-pole
identity gives $A\ne0$.

## Exact pole ten when B is nonzero

On a simple big leading sheet, $U=uD$ gives
$u_{10}=A\beta^2/(B\beta+C)$, while $\phi_{10}=\beta^5$.
The selected sheets have energy pole nine, so they cannot contribute
to the pole-ten coefficient of $n_0$. Consequently
$L_0=(n_0)_{10}=\sum_{H(\beta)=0}A^2/[\beta(B\beta+C)^2]$.

For $B\ne0$, consider the rational differential
$A^2\,dz/((Bz+C)H(z))$ on $\mathbf P^1$.
Its residue at a simple root $\beta$ of $H$ is exactly the summand
above, because $H'(\beta)=\beta(B\beta+C)$.
Its only other finite pole is $\beta_0=-C/B$, with residue
$A^2/(BH(\beta_0))$. The squarefree condition ensures that this
denominator is nonzero. There is no residue at infinity.
The residue theorem gives
$L_0=-A^2/(BH(\beta_0))\ne0$.
This proof handles $C=0$ without a separate expansion at zero.

## First-order cancellations when B is zero

Now $C\ne0$, $\delta_2\le13$, and the $S_s$ coefficient bounds are
$9,13,16,17,20$. On each actual big sheet put $\beta=\tau^2W$.
All five $\beta_i$ are units of $k[[\tau]]$.
The numerator and derivative bounds give
$D(W)=\tau^{-18}(d(\tau)\beta+\tau e(\tau)\beta^2+
\tau j(\tau)+O(\tau^2))$, with $d(0)=C\ne0$, and
$U(W)=\tau^{-28}(b(\tau)\beta^3+\tau a(\tau)\beta^4+
\tau c(\tau)\beta^2+O(\tau^2))$.
The entire $U_5=v\rho$ term starts at order two in the latter
normalized expression. Division gives
$u=\tau^{-10}\beta^2(\eta(\tau)+\tau(M(\tau,\beta)+
r(\tau)/\beta)+O(\tau^2))$, with $\deg_\beta M\le1$.
Also $\phi=\tau^{-10}(\beta^5+O(\tau^3))$.

Modulo $\tau^2$ the normalized source polynomial is
$\tau^{30}F(\tau^{-2}T)\equiv
T^5(V(\tau)T^5+\tau S_3(\tau)T^3+S_2(\tau)T^2+
\tau S_1(\tau)T+S_0(\tau))$.
The displayed factors are coprime modulo $\tau$; Hensel uniqueness
identifies the actual big-root quintic modulo $\tau^2$ with the second
factor divided by $V$. Its missing coefficients therefore give
$\sum_i\beta_i=O(\tau^2)$,
$\sum_i\beta_i^2=O(\tau)$,
$\sum_i\beta_i^{-1}=O(\tau)$, and $\sum_i1=5=0$.

The big-sheet sum for $\mu_1$ is
$\tau^{-12}\sum_i(\eta^2+2\tau\eta(M(\tau,\beta_i)+
r/\beta_i)+O(\tau^2))$.
Its leading term vanishes identically and its first-order term vanishes
modulo $\tau$. Thus its pole is at most ten. Selected sheets contribute
at most ten as well.
For $\mu_2$ the big-sheet sum is
$\tau^{-14}(\eta^2\sum_i\beta_i+
2\tau\eta\sum_i(\beta_iM(\tau,\beta_i)+r)+O(\tau^2))$.
The same sums make its parenthesis divisible by $\tau^2$, giving pole
at most twelve; selected sheets contribute at most eleven.
The leading big contribution to $n_0$ vanishes by the inverse-root
sum, giving pole at most nine, as on the selected sheets.
Hence $n_0\le9$, $\mu_1\le10$, $\mu_2\le12$, with arbitrary $\rho$.
No cancellation at a critical root was used.

## Two additional rows on both large-critical strata

Let $R=\delta_1\mu_1+\delta_0n_0$, of pole at most twenty-six.
At a nonzero critical root the exact identity rewrites as
$Q(c)-v\rho^2=-\delta_3\mu_2+R/c+\delta_0\mu_1/c^2$.
The auxiliary critical curve is used only to evaluate this identity;
it is not substituted for the actual étale source.

If $\delta_2$ has exact pole thirteen, the unramified large critical
root $c_4$ has pole four. At this point $F(c_4)$ has exact pole fifty
and $F(c_4)-vc_4^{10}$ has pole at most forty-five. Write
$U(c_4)=v\rho c_4^5+vm_5c_4^4+R_U$.
Its first terms have bounds thirty-six and thirty-five, and
$R_U\le34$. The cross-error bound is $36+34-50=20$, the
square-error bound eighteen, and the denominator-error bound seventeen.
The $vm_5^2/c_4^2$ term has bound twenty. Therefore
$Q(c_4)-v\rho^2-2v\rho m_5/c_4\le20$.

A nonzero $R_{26}/c_4$ would have pole twenty-two, above all other
terms of the rewriting and above $Q(c_4)-v\rho^2\le21$.
Hence $R_{26}=0$, and the next necessary row is
$[-\delta_3\mu_2+R/c_4]_{21}=[2v\rho m_5/c_4]_{21}$.
Only the leading reciprocal-root coefficient is needed; it is fixed
by the critical cubic.

If $\delta_2\le12$, the large critical point has tame index two and
base-normalized slope $7/2$. Here $F(c)$ has exact normalized pole
forty-five and remainder at most $81/2$. The numerator's leading
terms have bounds $67/2,33$ and remainder $65/2$.
The corresponding cross, square and denominator errors have bounds
$21,20,35/2$, and $vm_5^2/c^2\le21$. Thus
$Q(c)-v\rho^2-2v\rho m_5/c\le21$.
A nonzero $R_{26}/c$ has normalized pole $45/2$, above the other
rewriting terms and above $Q(c)-v\rho^2\le43/2$. Hence $R_{26}=0$.
The next possible normalized pole $43/2$ gives
$R_{25}=2(v\rho m_5)_{25}$.
All comparisons use the actual index-two local valuation; multiplying
these half-integral bounds by two gives its integer orders. No base
Laurent splitting of the quadratic critical pair is presumed.

Both strata give $R_{26}=C(\mu_1)_{10}+E(n_0)_9=0$.
Their final rows are affine for fixed source, $\rho$ and $m_5$.
When $\rho=0$ they recover the previous homogeneous rows.

## Exact eight-coordinate necessary affine family

The exact fifteen-coordinate model and gap constraints are those of
[critical incidence](../../Theorems/cartier_and_spin/admissible_critical_quadratic_incidence.md).
Use its fixed remainder inputs recorded in the accepted
[m9 denominator proof](admissible_degree_ten_m9_zero_moment_denominator_exclusion.md):
the two $n_0$ gaps give $n_0\in\langle q,q_3,y\rangle$;
$R_1q$ has exact gap pole eleven while $R_1q_3\le8$.
There is no affine function of exact pole eleven.
The bounds $n_0\le9$, $\mu_1\le10$ therefore force
$n_0=\lambda q_3$ and $\eta_1\in L_{10}$.
Writing $\eta_1=C_1(x)+dy$, $\deg C_1\le3$, the exact formula is
$\mu_2=\eta_2+y\operatorname{rem}(Z^2n_0,P)/P
-2y^2\operatorname{rem}(ZC_1,P)/P$.
Its first remainder has pole at most seven and the second has possible
gap poles seventeen, fourteen and eleven. The bound $\mu_2\le12$
forces $C_1\in\langle q,q_3\rangle$ and $\eta_2\in L_{12}$.
Conversely this family satisfies the three moment bounds.
Its dimension is $1+3+6=10$.

The row $R_{26}=0$ is independent: its $\eta_1=y$ column has
nonzero coefficient $Cy_{10}$, with $n_0=\eta_2=0$.
The final row is independent of it. In the pole-thirteen stratum use
$\eta_2=x^4$, $n_0=\eta_1=0$, giving coefficient
$-(\delta_3)_9(x^4)_{12}\ne0$ at pole twenty-one while $R_{26}=0$.
In the half-integral stratum use $\eta_1=q_3$,
$n_0=\eta_2=0$, giving $C(q_3)_9\ne0$ in $R_{25}$ while
$R_{26}=0$. These columns satisfy the preceding gaps and moment bounds.
Thus the two further rows have rank exactly two on the ten-dimensional
family. For prescribed forcing they leave exactly eight affine
coordinates before imposing the nine finite selected SHORT equations.

The nine selected-row compatibility, critical square class and full
source identity have not been decided. In particular the necessary
moment family does not realize a source. The provenance of the leading
argument and the all-$\rho$ extension is retained in
[the leading-moment experiment](../../Research/experiments/oct02_m9_uniform/ACTUAL_LEADING_QUADRATIC_MOMENTS.md)
and [the all-$\rho$ experiment](../../Research/experiments/oct02_m9_uniform/ACTUAL_LOW_TRACE_B0_ALL_RHO.md).
