# Proof: the mixed norm is empty and the surviving poles are constrained

25 September2026. Use the fixed P,A,Q and the actual primitive conditions
in [the preceding boundary theorem](admissible_degree_ten_derivative_boundary.md).
All previous support and norm reductions are accepted at their stated
scope. In particular the four supports have B=O+x^*(three A-roots),
v in L_X(10O), and the square alternative for P+g^3 is already impossible.
The new report and exact data are preserved
[here](../../../litt3-computation-data/quartic_quotient_trace_replies_20260925/extracted/trace_zero_quadratic_degree10/REPORT.md).

## An identity in the polynomial ideal

Let g=sum g_i x^i, i=0..3, H=x^2+h_1x+h_0, J=x^2+j_1x+j_0.
The coefficients of P+g^3-H^2J^3 are ten polynomial equations in the
eight variables g_0,...,g_3,h_0,h_1,j_0,j_1 over F25. The coefficient
of x^10 cancels. This is the full ideal, without field equations,
saturation, squarefreeness, or nonvanishing assumptions.

The supplied certificate is an identity1 in this ideal. Each node of
its directed acyclic graph is either an input coefficient or an explicit
linear combination of earlier nodes with monomial multipliers. There
are1271 retained nodes,384974 edges and91,659,180 scalar products;
the final node1528 is exactly1. The
[independent verifier](../../scripts/arithmetic/pro_quartic_quotient_trace_20260925/degree10/src/verify_dag.py)
multiplies out every identity in F25, checks coefficient and exponent
ranges, checks topological ordering, and does not invoke a Groebner
basis algorithm. The driver separately reconstructs every input
coefficient from P+g^3-H^2J^3. Both checks passed locally.

Consequently the ideal has no zero over the algebraic closure. The
previous norm reduction shows that every nonzero-y candidate in the
trace-zero sector would solve either this system or the already closed
square system. Thus all nonzero-y candidates are excluded.

## Trace and pole bookkeeping on the actual cover

Put D_2=v a_2=N_2/y^2. The finite regularity congruence at i=2,
together with a_1=0, says that N_2 is divisible by y^2 in the entire
affine coordinate ring. The given bound N_2 in L_X(34O) therefore
gives D_2 in L_X(14O). Its basis is
1,x,x^2,x^3,x^4,y,xy, with the stated pole orders.

At a finite base point, subtract the common principal part of b:
write w_i=b_i+B_0/y at a cubic branch point, and w_i=b_i otherwise.
Then q_i=w_i^5 plus an integral function. The multiplicities of G
at the points of this fiber are exactly the positive pole orders of
w_i. Because there are ten sheets and Tr(b)=0, both Tr(w)=0 and
sum w_i^2=sum b_i^2. Thus
\[
a_2=-\tfrac12\sum_i w_i^2.
\tag{1}
\]
The largest pole order must occur at least twice. If it occurs exactly
twice, their leading coefficients are opposite, so(1) has a pole
of exactly twice that order.

There is also a finite support gap. If m=ord(v)>0 and r sheets have
poles, multiply the shifted primitive polynomial by a local parameter
to the power m. Its reduction has degree10-r. The W^5 and W^4
coefficients of the shifted H_5 vanish in this reduction; hence its
degree is at most three. The reduced full polynomial therefore has
degree5,6,7,8, or0. Thus r is2,3,4,5, or10. For the surviving
polynomial v, m<=6 at every finite point, so r<=5.

At infinity five selected b-sheets have pole order at most one. The
other five have pole orders2+m_i, where the nonnegative m_i sum to
10-3d. The positive maximum m_i is repeated. If exactly two equal
the maximum M, equation(1) gives pole order4+2M for a_2, so D_2
has pole order4+2M+3d. It must belong to the displayed nongap list.
Enumerating the partitions of10-3d with at most five parts proves
the table in the statement. For d=2 this excludes(2,2), which would
require the gap14. The four remaining leading poles of b have order
three, so a_2 has pole at most six; D_2 is in L_X(12O).

For completeness, at d=1 the partition(3,3,1) forces D_2 to have
pole order13; partition(2,2,2,1) forces D_2 into L_X(10O). In the
latter case the three highest leading coefficients are the roots of
Z^3-c for c!=0: their first two elementary symmetric functions vanish.
At d=0, the first two partitions force pole12, the two partitions
beginning3,3,2 force pole10, (3,3,3,1) gives pole at most10, and
five2's give D_2 in L_X(6O). These statements follow from the same
trace equations and the missing pole orders.

## Finite polynomial-v branches

A simple root r of v must be a root of P. Its order at the unique
cubic branch point is three. The support gap and repeated-maximum
condition leave only(1,1,1), which makes a_2 have pole at most two.
Thus D_2 vanishes at that branch point. For two distinct P-roots r,s,
write D_2=d(x)+lambda y with deg d<=4. The two vanishings give
d(r)=d(s)=0 and the displayed formula for a_2.

For a squared root away from P, v has order two at each of the
three unramified points, so the partition is(1,1). Its two leading
coefficients are opposite and nonzero. Equation(1) forces a double
pole of a_2, hence D_2 is nonzero there.

For v=(x-r)^2 with P(r)=0, its order is six. The support gap and
repeated maximum leave(3,3),(2,2,2),(2,2,1,1). The last possibility
would give pole four for a_2 and order two for D_2. But a section
d(x)+lambda y in L_X(12O) has local order zero or one if lambda is
nonzero, and order divisible by three otherwise. Order two is
impossible. For(2,2,2), a_2 has pole at most four, hence D_2 has
order at least two, forcing lambda=0 and d(r)=0. This proves all
finite assertions including collisions.

## Local continuation after receipt

[An exact linear probe](../../scripts/arithmetic/degree_ten_polynomial_v_probe.py)
combined these infinity subspaces with the full previously verified
coefficient family. It reconstructs every N_2 from the projected D_2,
and checks the homogeneous kernels. None of the tested subspaces
forces kappa=0. In particular the constant-v, D_2 in L_X(6O) space
still has homogeneous dimension five. These are not covers.

Write D_2=sum d_i x^i+(d_y+d_xy x)y. The projection to
(v_0,...,v_3,d_0,...,d_4,d_y,d_xy,kappa) has rank11 and its sole
linear relation is3d_0+[24]d_1+2d_2+[18]d_3+d_4=0. This is a computational observation
about the necessary family, not a new exclusion or proof of etaleness.
The exact probe output is retained with the local checks. The next
step must use compatibility beyond these linear spaces, in particular
the actual cover and order-five class.
