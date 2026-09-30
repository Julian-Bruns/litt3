# Proof: supported divisors and the remaining linear systems

The uniform norm theorem gives B effective of degree n, coefficients
at most floor(n/5)=2, and 2B~2nO. The established orbit argument gives
at least seven support points. Since n<12, some finite point is absent.
This last fact follows from degree alone and introduces no assumption.

For each allowed B=b_O O+sum b_i P_i, test the sections of
L(2(n-b_O)O) vanishing to order2b_i at the twelve finite points.
The affine monomials x^a y^j,0<=j<=2,3a+10j<=2(n-b_O), are a
basis. All required Hasse jets have orders at most three and are
obtained by expanding y^3=P(x) at an unramified cubic point. The
total imposed zero degree equals the allowed pole degree. Thus a
nonzero kernel is equivalent to the required exact divisor identity,
not merely an inequality of divisors.

The [Sage source](../../scripts/arithmetic/admissible_small_supports.sage)
enumerates all integer weights0,1,2, retaining O separately. The
twelve finite points form one coefficient-Frobenius orbit, which
reduces the enumeration to8583 orbits for n=10 and13414 for n=11.
Every matrix is computed over the full field of definition F_(5^24),
so its rank remains the same over the algebraic closure. There is no
search over possible section coefficients. Both complete runs leave
sixteen divisors. Their unique sections are polynomials in x:
\[
B=(n-9)O+x^*D,\qquad \deg D=3,\quad
\operatorname{Supp}D\subset\operatorname{div}_0 A,\quad
\operatorname{mult}D\le2.
\]
Twelve have D=2r+s and four have distinct roots. The former are
excluded by [the short local proof](admissible_double_fiber_boundary.md).
The exact rank lists are
[degree ten](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/admissible_10_supports.json)
and [degree eleven](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/admissible_11_supports.json).

## Exact necessary equations for the remaining four cases

Put m=n-5, and let t_B be the monic cubic of the selected roots.
The primitive is of degree n over k(X): a proper intermediate etale
quotient would have degree a proper divisor of n but at least the
ten projected support points, by the uniform occupancy theorem.
Its polynomial is
\[
F_b(B)=(B^5+f)H_m(B)+\kappa t_B^3/v,\qquad\kappa\ne0.
\]
Write N_i=y^i v a_i for coefficients of H_m, with N_0=v.
Then N_i is in L((n+12i)O). Correcting b at the cubic branch points
by B_0/y, the exact finite-pole conditions are
\[
\sum_{i=0}^j\binom{m-i}{j-i}(-B_0)^{j-i}N_i
\equiv0\pmod {y^j},\quad1\le j\le m.
\]
These have ranks148 on195 columns at n=10 and209 on275 columns
at n=11, leaving47 and66 dimensions respectively. The construction
also reproduces the returned degree-nine ranks100 on128 columns.

Set Z=yb, U=Z+L, and d=Q-L^5. At each selected root, five actual
branches have U vanishing at least once. Consequently the coefficient
of U^j in
\[
(U^5+d)\sum_{i=0}^m N_i(U-L)^{m-i}+\kappa t_B^3y^n
\]
is divisible by (x-r)^(5-j) for0<=j<5, in each cubic character.
At infinity there are exactly e_O=5(n-9) selected sheets, where b
has pole at most one. On other sheets its pole is at most2+mult(G).
Since ord_O v=mult_O(h_*G)-n, the original j-th coefficient numerator
has pole bound
\[
n+12j-\max(0,j-(n-e_O)).
\]
This argument retains arbitrary multiplicities and locations of G.

[The exact reconstruction source](../../scripts/arithmetic/admissible_higher_collision.sage)
combines these linear conditions. Its homogeneous kernel dimensions
are18 and14, and in each case kappa can be nonzero. The
[degree-ten data](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/admissible_10_collision.json)
and [degree-eleven data](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/admissible_11_collision.json)
record the ranks and the repeated-fiber regression witnesses. These
linear conditions are necessary, not sufficient for etaleness or for
the order-five class, and none is promoted to an actual cover.
