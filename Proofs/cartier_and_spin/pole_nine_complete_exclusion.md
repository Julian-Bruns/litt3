# Proof: the cubic endpoint moment obstruction

24 September 2026. The complete returned proof is retained in
[the original report](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/originals/cubic/cubic_delta9_complete/REPORT.md).
This record states its mathematical reduction and exact computational
scope. Both exhaustive implementations were executed successfully.

The established comparison reduction supplies a separating cubic
parameter t on a smooth proper curve, and functions u,v. Normalize
the scalar so that
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\]
At each of three distinct unramified points over t=0, v has pole
order three and u is regular; over infinity their roles reverse.
Other poles coincide. Their common order m is1 or3, and a triple
pole has parameter ramification index at least two. The hypothesis
is weaker than the full actual-cover problem, so its exclusion is
sufficient. Epsilon is arbitrary and nonzero over the algebraic closure.

## Local data and the global moment equations

At a common pole, put c=t(P), lambda equal to the leading ratio v/u,
and d=P_9=[22]. Comparing the quartic and differential identities gives
lambda=epsilon c^4 and c^29=1. If b_c=d c(lambda^-1-1), expansion of
the same identities shows that the only pairs (m,e) are
\[
(1,1),\quad(3,3),\quad(3,2).
\]
Their local trace residues are m b_c and m lambda b_c. In particular
(3,2) contributes weight three. When lambda=1 only (3,2) can occur,
with zero residue. The trace has no higher pole at these points.
These assertions use each completed local factor, not a presumed
global cyclic action on the cubic cover.

At an endpoint root alpha of A, the first two jets have the form
\[
v=\epsilon(b t^{-3}+c_1t^{-2}+\cdots),\quad
u=\alpha+u_1t+u_2t^2+\cdots,
\]
\[
b^{29}=3A'^3P^2/A_4^3,\quad u_1=A_4b^4/A',
\quad c_1=b^5(A_4/A')(P'/P+A''/(4A')),
\quad u_2=4u_1c_1/b-(A''/(2A'))u_1^2.
\]
Thus there are exactly116 geometric endpoint labels: four roots of A
and29 choices of b. They are forced algebraic values, not a restriction
on unknown cover coefficients. Sum the relevant endpoint coefficients
as C_0,U_0,C_infinity,U_infinity. For common-pole weights w_c in F5,
put M_j=sum w_c c^j. Global partial fractions give
\[
\epsilon(U_0-dM_{-2})=C_\infty-dM_{-6},\qquad
U_\infty-dM_2=\epsilon(C_0-dM_6).
\]
Eliminate epsilon by cross multiplication, so zero factors are not lost.

## The exact finite certificate

Let E=F_(5^7), Q=5^7, and use the quadratic extension E(beta),
beta^2=beta+3. Since Q=-1 modulo29, the negative moments are
conjugates of the positive ones. Put X=dM_2, Y=dM_6, and
rho=d/d^Q=[18]. The necessary equation becomes
\[
(C_\infty-\rho Y^Q)(C_0-Y)
 -(U_\infty-X)(U_0-\rho X^Q)=0.
\]
Writing X=x_0+x_1 beta and Y=y_0+y_1 beta and temporarily treating
Z=N(Y)-N(X) as a fifth independent variable produces eight linear
equations over E. Here N(a+b beta)=a^2+ab+2b^2.

The proved arithmetic symmetries reduce the zero endpoint triples
to333 cases; all266916 unordered infinity triples are retained.
Both eliminations check their complete product of88,883,028 pairs.
Only the pair of triples (0,0,0) and (58,58,58), in the retained label
convention, is linearly consistent. Its rank-five solution is
\[
(x_0,x_1,y_0,y_1,Z)=(3,1,3,1,2).
\]
It has X=Y, contradicting Z=N(Y)-N(X). Thus even the relaxed moment
system has no solution. No bound on n or on auxiliary monodromy is
used in this last obstruction.

The [retained source](../../scripts/arithmetic/pro_cubic_returns_boundary_20260924/cubic/cubic_delta9_complete/verify.py)
reconstructs the constants and invokes both exhaustive scans. The
[replay log](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/logs/cubic_replay.log)
records both passes. Original input tables, historical regression checks,
manifests and output counts remain in the external evidence directory.
This completes delta9 only; higher comparison poles are separate cases.
