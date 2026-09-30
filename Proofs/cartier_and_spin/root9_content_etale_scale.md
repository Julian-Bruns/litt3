# The repeated first-jet root must split without ramification

29 September2026. [Statement](../../Theorems/cartier_and_spin/root9_content_etale_scale.md).
Use the actual local polynomial displayed in the statement. The
degree-ten source and its finite-endpoint Newton bounds are those in
the [two-profile proof](admissible_degree_ten_two_profiles.md). At this
endpoint five primitive roots have positive valuation and five are
units. The preliminary change of primitive and multiplication of its
equation use local units only.

Put W=T*z. Direct expansion through order six gives
\[
T^{-5}F_\mu(T,Tz)=p(z)+Tq_\mu(z)+O(T^2),
\]
where
\[
p(z)=D_0z^5+(mB/2)z^2+mC_1z+\ell_0
\]
and
\[
q_\mu(z)=\ell_1+D_1z^5+(mC_2+m_1C_1)z
 +(mB_1/2+m_1B/2)z^2+(mA/3)z^3+\mu V(0)m^2.
\]
No fifth-power term is discarded. It is precisely the term D0*z5
that explains the degree12 endpoint-content equation.

The content condition is p(omega)=0 at the unique critical point
omega=-C1/B of p. Since B is nonzero, p''=mB is nonzero. Thus omega
is exactly a double root, and all three other roots of p are simple.

An actual finite étale cover splits completely over the completed
local ring k[[T]]. Its five small primitive roots therefore have
power-series expansions W_i(T). Exactly two have first coefficient
omega. Evaluating the product of the five small-root factors at
W=T*omega gives order at least seven: two factors have order at
least two and the other three have order one. The five remaining
root factors are units. Consequently
\[
\operatorname{ord}_T F_\mu(T,T\omega)\ge7,
\qquad q_\mu(\omega)=0.
\]
Its coefficient of mu is V(0)*m2, a nonzero constant. This proves
the unique-scale formula. Square discriminant parity by itself would
not prove this: two distinct ramified collisions can contribute an
even sum. The argument uses the actual local étale splitting.

## Folding the fifth power on the content curve

Set kappa=D1/D0. The source makes this a constant at the specified
endpoint. The contact equation gives
\[
D_1\omega^5=\kappa(mB\omega^2/2-\ell_0).
\]
The numerator of the forced scale therefore becomes
\[
\ell_1-\kappa\ell_0+(mC_2+m_1C_1)\omega
 +(mB_1/2+m_1B/2+\kappa mB/2)\omega^2
 +(mA/3)\omega^3.
\]
Substituting omega=-C1/B now requires B3 rather than B5 as a
denominator. In characteristic five, one may take
\[
N=-\bigl((\ell_1-\kappa\ell_0)B^3
 -(mC_2+m_1C_1)C_1B^2
 +(3mB_1+3m_1B+3\kappa mB)C_1^2B
 -2mAC_1^3\bigr),\quad D=V(0)m^2B^3.
\]
Then mu=N/D. Each local source coefficient has H-degree at most two
and Z-degree at most15; the fixed factors give the stated bounds.
This avoids introducing any new denominator beyond the already
specified local units and B.

The [exact exporter](../../scripts/arithmetic/root9_endpoint_homogeneous_scales_20260929.sage)
with `--branch 0 --compact` verifies the contact equation, constant
kappa, equality with the older formula modulo the full content
curve, and the unchanged local parity equation. Its model and log
are retained in
[the endpoint evidence](../../../litt3-computation-data/conceptual_continuation_20260929/root9_endpoint_content/1/).
The proof of the local splitting implication is formal and independent
of a finite-field search. The degree bounds and explicit coefficient
presentation use the actual source. The condition B!=0 remains stated;
its complementary finite incidence is handled by separate certificates.
