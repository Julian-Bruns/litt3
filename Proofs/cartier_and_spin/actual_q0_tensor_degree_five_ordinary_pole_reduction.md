# Proof: delete rational, conjugate, mixed and both-Weierstrass positions

Version1,3 October2026. New whole configuration reduction, whole scoped review PASS. No new calculation is used. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

The [accepted rational theorem](actual_q0_tensor_degree_five_rational_quotient_exclusion.md) leaves genus ONE/TWO. Each has two shared simple infinity poles. The [first-jet lemma](actual_q0_tensor_simple_infinity_first_jet.md) gives uniform z-ramification status at these points, so a mixed ordinary/Weierstrass pair is impossible. The [whole conjugate theorem](actual_q0_tensor_degree_five_conjugate_pole_exclusion.md) deletes a pair with the same z-coordinate. It remains to delete two DISTINCT Weierstrass pole coordinates a,d.

In the original fixed-X coordinates, a Weierstrass pole forces ρ=ONE. Under the separate signs used by a necessary normal form it forces ρ=±ONE, and always a³=d³=ρ²=ONE. This retains the transformed p9 coefficients; it does not assume an independent centered sign preserves both copies of P.

For genus TWO, or the elliptic shared-linear-root presentation, use the [complete calibrated distinct form](actual_q0_tensor_degree_five_calibrated_distinct_form.md). In its unnormalized root notation,
\[
M=(z-r)(z-a)(z-d),\quad r^3=1,\quad
\Psi=z[L^2+D T_r(z-a)(z-d)],\quad T_r=(z^3-1)/(z-r).
\]
Both actual Weierstrass simple poles force L(a)=L(d)=ZERO. At least one of a,d differs from r. At that coordinate, T_r also vanishes because a³=d³=ONE. Hence Ψ has order at least TWO there, contradicting the actual simple Weierstrass branch. In the elliptic presentation Ψ=h²Φ, h is nonzero at both actual poles, so the same simple-branch contradiction applies. No smooth genus-two claim is made for Ψ. This is independent of the earlier [paired-Weierstrass norm gate](actual_q0_tensor_degree_five_two_weierstrass_exclusion.md), whose evidence remains intact.

For completeness consider the other elliptic odd numerator types. Exact polar divisors give
\[
x_1=A_1/[zJ]+b y/[z^2J],\quad
x_2=A_2/J+c y/J,\quad J=(z-a)(z-d),
\]
where deg Ai≤THREE, b,c degree at most TWO and c has degree TWO. A common root cannot occur at ZERO,a,d because it would remove an actual triple or simple odd pole. If b,c are proportional, the q-leading equation at each pole forces a=d, already impossible. Thus their gcd has degree ZERO or ONE. Degree ONE is the shared-root model just handled. In degree ZERO the odd equation A2c=A1b gives A1=cL,A2=bL with deg L≤ONE. At each actual Weierstrass pole, the order-TWO even polar coefficient must vanish and b,c are nonzero, so L(a)=L(d)=ZERO. Consequently L=ZERO and BOTH xi are purely odd under the elliptic quadratic involution.

A pure-three degree-FIVE map from genus ONE has FIVE ramification points, exactly one at its triple infinity pole and FOUR at finite values. The finite values are distinct because degree FIVE cannot contain two index-THREE points in one fiber. Oddness reflects these four values by x↦−x; infinity is fixed. An involution on four distinct finite values with at most one fixed value must pair them into TWO different pairs of equal sum. All are roots of the actual fixed P, up to the necessary affine coordinate normalization. The accepted [strong-Sidon arithmetic](../curve_arithmetic/fixed_x_branch_strong_sidon.md), affine invariant, excludes this. Thus the remaining coprime elliptic both-Weierstrass position is impossible too.

All shared simple poles in the surviving alternative are therefore ordinary and have distinct z-coordinates. This is a necessary surviving configuration, not its existence or exclusion. All original maps remain on the SAME source above B.
