# A smaller critical parity section in the m3 profile

Version1,1 October2026. Retain an ACTUAL nontrivial admissible
degree-ten source with infinity profile $(d,m)=(10,3)$, as in
[reconstruction](admissible_line_reconstruction.md) and
[the nine-profile theorem](admissible_degree_ten_nonzero_profiles.md).
Use short $W$, finite $w=W+a$, $a=Z/y$, and
\[
F=v(T^5+q)^2+(T^5+q)S+t^3,\quad
D=S'=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0,\quad U=uD.
\]
Let $Q$ be the degree-at-most-two critical quadratic trace polynomial
in [the exact incidence theorem](admissible_critical_quadratic_incidence.md),
so $U^2\equiv FQ\pmod D$. All resultants below have their displayed
FORMAL degrees, including coefficient degree drops.

There is a nonzero constant $c\in k$ such that
\[
\delta_3=c(x+[12]),\qquad \operatorname{pole}_O\delta_2=14.
\]
Over the algebraic closure of the completed infinity field, exactly
one critical root has pole11 and the other two have pole at most2.
No global rationality or distinctness of these roots is assumed.

Put
\[
\Delta=\operatorname{Res}_{10,3}(F,D),\quad
\Theta=\operatorname{Res}_{3,5}(D,U),\quad
\Lambda=\operatorname{Res}_{3,2}(D,Q).
\]
Then
\[
\delta_3^2\Theta^2=\Delta\Lambda,
\qquad R_Q=\Lambda/t\in L_X(70O)\setminus\{0\}.
\]
The divisor of $R_Q$ is even. In fact, with the established critical
section $C=\Delta/t^5$,
\[
CR_Q=(\delta_3\Theta/t^3)^2.
\]
Thus the half-divisors define the same two-torsion class; this does
NOT assert that either function is a square. The norm of $R_Q$ to
the $x$-line is a polynomial square up to nonzero scalar of degree
at most70.

The statement requires no global squarefreeness assumption on $D$.
Nonvanishing follows from
[critical coprimality on m3](admissible_degree_ten_m3_critical_coprimality.md).
Finite content zeros, branch points, repeated finite critical roots
and leading coefficient zeros are retained. This is a necessary
smaller parity observable, not an existence criterion or source
exclusion.

[Proof and exact fixed rows](../../Proofs/cartier_and_spin/admissible_degree_ten_m3_small_critical_parity.md).
