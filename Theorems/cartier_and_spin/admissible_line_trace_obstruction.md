# Trace excludes every admissible line on covers of degree at most three

Version 2, 24 September 2026. Use the fixed X, O, primitive f=Q/y^5,
positive plane P_X and canonical line lambda_X of
[the admissible-line criterion](admissible_line_reconstruction.md).
Let Z be the ten finite cubic branch points and let
B=(22,16,11,3,15,11,2,6,12,14), so B^5=-Q modulo P.
The boundary of B|Z in the sequence for O_X(12O), transported
by division by y, defines a nonzero class
\[
\epsilon\in H^1(X,O_X(2O)).
\]
For EVERY effective divisor G_0 of degree at most three, including
nonreduced divisors and divisors containing O,
\[
\epsilon\longmapsto H^1(X,O_X(2O+G_0))
\quad\text{is nonzero}.
\tag{1}
\]
For any actual finite etale h:S->X of degree n, a saturated
degree-zero line in h^(1)*P_X with adjunction divisor 2Delta,
where Delta<=h^*R_X is reduced of degree8n, supplies an effective
G on S of degree n such that
\[
h^*\epsilon=0\quad\text{in }H^1(S,O_S(2h^*O+G)).
\tag{2}
\]
When 5 does not divide n, trace implies that epsilon dies after
adding h_*G downstairs. Consequently no such line exists on ANY
connected etale cover of degree one, two or three. This excludes
twisted degree-zero lines as well as the admissible order-five lines;
no Galois or divisor-descent hypothesis is required.

There is also a stronger base contact bound. A saturated line
L in P_X different from lambda_X cannot have determinant contact
I+G_0 with I<=R_X^(1) reduced and deg G_0<=3. Therefore, for
Q_I=lambda_X+P_X(-I), every other saturated line M satisfies
\[
\deg M\le5-|I|.
\]
All 7,722 modifications with 4<=|I|<=10 are stable; those with
|I|=3 or11 are semistable. Negative-degree modifications remain
without nonnegative lines after every further etale pullback.

More generally let D_h(G)=sum_P max_{Q over P}mult_Q(G) P. If
5 does not divide n and deg D_h(G)<=3, the class h^*epsilon is
nonzero after adding G, regardless of n. This uses the smallest
downstairs pole divisor containing G after pullback, rather than h_*G.

The trace criterion is only necessary on larger covers. Uniform
survival for every G of degree at most n is FALSE: an
[actual connected étale cover](../../Research/notes/failed_route_evidence/primitive_trace_etale_counterexample_statement.md)
of degree 15625 kills the class with a reduced divisor of degree
15624. That example supplies no admissible line. Degree four and
arbitrary five-divisible covers remain undecided for the actual
line problem; neither original common-cover problem is solved.

[Proof and independent arithmetic check](../../Proofs/cartier_and_spin/admissible_line_trace_obstruction.md).
