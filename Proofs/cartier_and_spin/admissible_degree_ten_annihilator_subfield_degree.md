# Quadratic descent contradicts the next-to-leading coefficient

Version2,1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_annihilator_subfield_degree.md).
Use the actual support and profile in
[the nonzero profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md),
the primitive degree-ten source from
[the support reduction](admissible_degree_ten_eleven_reduction.md),
and the degree-five numerator from
[the compact numerator theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_torsion_numerator.md).
The parent and annihilator-transfer agent independently focused-reviewed
the new implication. No computation or critical irreducibility is needed.

Write $U(W)=uD(W)$, $\deg U\le5$, $\deg D=3$, and
$U_5=v\rho$, where $\rho\in\langle1,x,x^2\rangle$.
The raw irreducible source polynomial $F$ has degree10 and leading
coefficient $v$. Its next coefficient is $[T^9]F=s_4\ne0$.
The exact numerator coefficient is
\[
U_4=v m_5+s_4\rho,\qquad m_5=\operatorname{Tr}_h(u).
\]

Suppose $[K(u):K]=2$, so $u^2+a u+b=0$ with $a,b\in K$.
Evaluating at the primitive source coordinate gives
\[
F\mid U^2+aUD+bD^2.
\]
The polynomial on the right has degree at most10. Its leading
coefficient is $v^2\rho^2$, because $UD$ and $D^2$ have degrees
at most8 and6. Hence the exact identity is
\[
U^2+aUD+bD^2=v\rho^2F,
\]
including $\rho=0$, when the right side is zero.

The residual degree $[k(S):K(u)]$ is five. Trace transitivity
therefore gives $m_5=5\operatorname{Tr}_{K(u)/K}(u)=0$ in
characteristic five, and $U_4=s_4\rho$.
Compare the coefficient of $T^9$ in the exact polynomial identity.
The terms $aUD$ and $bD^2$ have degree at most8 and6, so
\[
2(v\rho)(s_4\rho)=v\rho^2s_4.
\]
Thus $(2-1)v s_4\rho^2=0$. Both $v$ and $s_4$ are nonzero
functions, forcing $\rho=0$. This argument applies to every
one of the nine nonzero profiles, without a finite unit assumption.

Now $\deg U\le4$, so $U^2+aUD+bD^2$ has degree at most8 and
its divisibility by the degree-ten $F$ makes it identically zero.
Therefore the rational function $U(T)/D(T)$ is algebraic over
$K$ inside the rational function field $K(T)$. Since $K$ is
algebraically closed in $K(T)$, that rational function lies in
$K$. This contradicts the selected-sheet divisor: a base function
has the same order on all ten etale sheets over a point, whereas
$u$ has order two on exactly five selected sheets and order zero
on the other five over each selected finite endpoint. This excludes
quadratic descent.

Finally let $S\to S_0\to X$ be the intermediate factorization for
$K(u)$ and let $e=[k(S):K(u)]$. Both maps are finite etale, as
intermediate maps of the actual finite etale cover. Write $u_0$ for
the descended function and $H_0$ for the pullback of $O$ to $S_0$.
From
\[
\pi^*(\operatorname{div}u_0+10H_0)=2E
\]
and the etaleness of $\pi$, the divisor in parentheses is even,
and $E=\pi^*E_0$ for a reduced effective divisor $E_0$.
This also holds at infinity: the selected and unselected orders
of $u$ are minus8 and minus10 and are constant on each intermediate
fiber. At every selected finite endpoint, $E$ occupies exactly
five of the ten source sheets. Therefore
\[
5=e\,\operatorname{ord}_P(h_{0*}E_0),
\]
and $e$ divides five. Since $e$ also divides ten, it is1 or5.
The latter would make $[K(u):K]=2$, which was just excluded.
Thus $e=1$ and $u$ is primitive over $K$.

## Alternative short proof using intermediate trace

Section4 of the returned
[reciprocal report](../../../litt3-computation-data/oct01_pro_replies/reciprocal_trace_profile_10_3/reciprocal_trace_profile_10_3/REPORT.md)
gives a second conceptual proof, useful for minimizing the final
coefficient calculation. Suppose the occupancy argument leaves
$e=5$ and put $M=K(u)$, so $[M:K]=2$.
The nonzero polynomial $U-uD$ annihilates $W$ over $M$.
It cannot vanish identically, since that would make $u\in K$
and contradict its mixed selected-sheet orders. Since
$[M(W):M]=5$ and its degree is at most five, it has exact
degree five. In particular $A_5=v\rho\ne0$, and its monic
associate is the minimal polynomial of $W$ over $M$.

Its fourth coefficient gives
\[
\operatorname{Tr}_{k(S)/M}W=-A_4/A_5.
\]
Residual degree five gives $m_5=\operatorname{Tr}_{k(S)/K}u=0$,
hence $A_4/A_5=s_4/v\in K$. Trace transitivity now yields
\[
\operatorname{Tr}_{k(S)/K}W=-2s_4/v.
\]
But the ninth coefficient of $F/v$ gives the same trace as
$-s_4/v$. Since $s_4\ne0$, this is impossible.
This argument excludes the same residual-degree-five case without
any critical irreducibility or finite unit hypothesis.

This removes only the automatic trace blindness from a residual
degree divisible by five. It does not make a particular trace
nonzero or supply the opposite actual etale map.
