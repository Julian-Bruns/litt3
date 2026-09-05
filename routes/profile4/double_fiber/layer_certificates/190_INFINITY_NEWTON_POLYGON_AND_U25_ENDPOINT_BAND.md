# The infinity Newton polygon and the terminal \(u^{25}\) coefficient band

## Status and scope

This note is **proved-text** from the profile boundary data in file 79 and
the displayed local coefficient convention in files 185 and 187.  It proves
three structural facts that were previously visible only in missing-program
transcripts:

1. near the \(z=0\) corner over \(x=\infty\), the coefficient of \(z^j\)
   in the bidegree equation has \(x\)-degree at most
   \(2,3,4,5\) for \(j=0,1,2,3\leq j\leq33\), respectively (the
   degree-six leading terms for \(j=34,35\) are fixed);
2. in the declared coefficient-space enlargement, the last new coefficient
   band, at the \(u^{25}\) layer, consists of exactly twenty variables;
   after the simple pivot and either repeated pivot triple, the free lists
   have sizes nineteen and sixteen; and
3. there is no as-yet-unseen coefficient variable at the \(u^{30}\) layer.
   The next equations are genuinely tail-exhausted residual equations.

For the last two assertions, work in the coefficient-space enlargement used
by the retained formal tower: the restrictions at \(x=0\) and \(x=1\) and
the Newton bounds at \(x=\infty\) are retained, while any further profile
equations may cut out a smaller affine subspace.  Proving exhaustiveness in
this larger space is therefore sufficient to prove that the actual profile
family has no omitted \(u^{30}\) coefficient.

This note does **not** display the affine base vector at \(u^{25}\), the
earlier pivot substitutions, or the repeated-\(e30\) residual.  It therefore
does not complete the extraction requested in file 181.

## The four branches at the infinity corner

Work over \(k=\overline{\mathbb F}_5\).  In the representative entry-zero
case of file 79, let

\[
 f(x,z)=\sum_{j=0}^{35}a_j(x)z^j,
 \qquad \deg a_j\leq6,
\tag{190.1}
\]

be the normalized integral bidegree-\((6,35)\) equation.  Its normalization
is the profile curve because \(k(C)=k(x,z)\).  Put \(t=x^{-1}\) and

\[
 F_\infty(t,z)=t^6f(t^{-1},z).
\tag{190.2}
\]

The zero divisor of \(z\) in file 79 is

\[
 P_1+P_\infty+C+F.
\]

Exactly four of these branches lie over \((t,z)=(0,0)\): the branch
\(P_\infty\) and the three reduced points in the atom \(F\).  On all four
branches, \(z\) has order one and is consequently a uniformizer.  The
profile of \(x\) gives

\[
 \operatorname{ord}_{P_\infty}(t)=31,
 \qquad
 \operatorname{ord}_{R}(t)=1\quad(R\in F).
\tag{190.3}
\]

Also, the exact boundary identity \(f(x,0)=K(x-1)^2\) gives

\[
 F_\infty(t,0)=Kt^4(1-t)^2.
\tag{190.4}
\]

Thus \(F_\infty\) is \(t\)-regular of order four at the origin.  By
Weierstrass preparation in \(k[[z]][[t]]\),

\[
 F_\infty(t,z)=U(t,z)W(t,z),
\tag{190.5}
\]

where \(U\) is a unit and \(W\) is monic of degree four in \(t\).  Since
\(z\) is a uniformizer on each branch and \(k\) is algebraically closed,
the four roots of \(W\) lie in \(k[[z]]\).  After numbering them suitably,

\[
 W(t,z)=\prod_{i=0}^3(t-\phi_i(z)),
 \qquad
 \operatorname{ord}_z\phi_0=31,
 \quad
 \operatorname{ord}_z\phi_i=1\ (1\leq i\leq3).
\tag{190.6}
\]

Write

\[
 W=t^4+b_3(z)t^3+b_2(z)t^2+b_1(z)t+b_0(z).
\]

The elementary symmetric expressions in (190.6) show

\[
 \operatorname{ord}_z b_0\geq34,
 \quad
 \operatorname{ord}_z b_1\geq3,
 \quad
 \operatorname{ord}_z b_2\geq2,
 \quad
 \operatorname{ord}_z b_3\geq1.
\tag{190.7}
\]

Cancellation can only increase these orders.  Multiplication by the unit in
(190.5) preserves the same lower bounds for the coefficients of
\(t^0,t^1,t^2,t^3\): for example, the coefficient of \(t^2\) is a sum of a
multiple of \(b_2\), a multiple of \(b_1\), and a multiple of \(b_0\), and
is therefore divisible by \(z^2\).  Hence

\[
\begin{array}{c|cccc}
 t\text{-power}&0&1&2&3\\ \hline
 z\text{-divisibility of }[t^a]F_\infty&z^{34}&z^3&z^2&z.
\end{array}
\tag{190.8}
\]

## Coefficient-degree bounds

A term \(x^dz^j\) of \(f\) becomes \(t^{6-d}z^j\) in \(F_\infty\).
Applying (190.8) successively gives

\[
 \boxed{
 \deg_x a_0\leq2,\qquad
 \deg_x a_1\leq3,\qquad
 \deg_x a_2\leq4,\qquad
 \deg_x a_j\leq5\quad(3\leq j\leq33).}
\tag{190.9}
\]

For instance, a \(z^0\)-term cannot occur with \(t\)-power
\(0,1,2\), or \(3\), so its \(x\)-degree is at most two.  A \(z^1\)-term
cannot occur with \(t\)-power \(0,1\), or \(2\), so its degree is at most
three.  The other cases are identical.  The two top coefficients
\(j=34,35\) can have degree six, but their degree-six coefficients are fixed
by \([x^6]f=z^{34}(z+1)\).  Consequently a difference with the same leading
boundary data has degree at most five in those two coefficients.

Fix the boundary values of every coefficient at \(x=0\) and \(x=1\), and
compare two equations having those boundary values and satisfying (190.9).
Their \(z^j\)-coefficient difference is divisible by \(x(x-1)\).  Therefore
the variable part can be written

\[
 x(x-1)U_j(x)z^j,
 \qquad
 \deg U_j\leq\min(j,3)\quad(0\leq j\leq33).
\tag{190.10}
\]

For \(j=34,35\), the preceding fixed-leading-coefficient observation gives
\(\deg U_j\leq3\) whenever such a variable part is retained.  In particular,
every allowed variable, for every \(j\), satisfies \(A\leq j\).  The
coefficients with \(j=34,35\) occur at much lower local order and do not
enter the endpoint count below.

The actual profile boundary \(f(x,0)=K(x-1)^2\), and any other global
profile relation, may impose further affine conditions on these variables.
Equation (190.10) is the ambient relaxation used for the layer count; in
particular it cannot omit an actual coefficient.

Pass to the reciprocal equation

\[
 \Phi(u,w)=w^{35}f(u,w^{-1}),\qquad u=x.
\]

With the notation of files 185 and 187, write

\[
 U_j(u)=\sum_{A=0}^{\min(j,3)} (u j_A)u^A.
\]

The variable \(u j_A\) perturbs the reciprocal equation by

\[
 \delta_{j,A}\Phi
 =u(u-1)u^Aw^{35-j}.
\tag{190.11}
\]

Along either a simple or a repeated branch at \(u=0\), one has
\(w=\pm u+O(u^2)\).  The leading \(u\)-order of (190.11) is consequently

\[
 N(j,A)=1+A+(35-j)=36+A-j.
\tag{190.12}
\]

## The exact \(u^{25}\) band

Assume from this point that the three second-blowup slopes are distinct, or
equivalently that the clean discriminant has been inverted.  This condition,
not the tangent cone alone, gives exact order five for \(\Phi_w\) on every
repeated branch.  The repeated residual
at \(u^{5m}\) uses the coefficients of \(z=w^{-1}\) through degree
\(5m+4\).  Those coefficients require the branch through \(w_{5m+6}\),
and the branch recursion requires the curve equation through order
\(5m+11\).  Thus the repeated \(u^{20}\) layer uses the equation through
order \(31\), while repeated \(u^{25}\) uses it through order \(36\).
The new ambient coefficient band is exactly

\[
 32\leq N(j,A)\leq36.
\tag{190.13}
\]

Combining (190.10), (190.12), and (190.13) gives

\[
 0\leq A\leq\min(j,3),
 \qquad 0\leq j-A\leq4.
\tag{190.14}
\]

There are exactly twenty ambient directions, arranged by \(A\) as follows:

\[
\begin{array}{c|l}
A&\text{variables}\\ \hline
0&u0_0,u1_0,u2_0,u3_0,u4_0\\
1&u1_1,u2_1,u3_1,u4_1,u5_1\\
2&u2_2,u3_2,u4_2,u5_2,u6_2\\
3&u3_3,u4_3,u5_3,u6_3,u7_3.
\end{array}
\tag{190.15}
\]

This also proves exact affineness in the enlarged coefficient space at this
layer.  Let \(J\) be the ideal of the twenty variables.  A perturbation of
order at least \(32\) changes a
repeated branch first in order \(32-5=27\).  Since \(\Phi_{ww}\) has order
at least two, the quadratic Taylor term starts in order at least
\(2+2\cdot27=56>36\).  Inverting \(w\) produces a quadratic term only from
order \(2\cdot27-3=51>29\), beyond every coefficient used by the
\(u^{25}\) residual.  The derivative of a new curve term has order at least
\(31\), so its product with a branch perturbation starts in order at least
\(31+27=58>36\).  Thus mixed terms involving a new coefficient also do not
occur.  On the simple branch \(\Phi_w\) has order three, so the corresponding
estimates are even stronger.  Finally, the Frobenius term in the
\(u^{25}\) residual is \(Z_5^5\); every new variable changes \(z\) only from
degree at least \(25\), so this term is constant in the new variables.
Therefore the simple and repeated \(u^{25}\) systems are affine-linear in
precisely the variables in (190.15), uniformly over the older-coordinate
ring.

File 101 proves that the simple equation has the unit pivot \(u2_0\).
After solving it, the nineteen repeated-layer variables are

\[
\begin{gathered}
u0_0,u1_0,u3_0,u4_0,\\
u1_1,u2_1,u3_1,u4_1,u5_1,\\
u2_2,u3_2,u4_2,u5_2,u6_2,\\
u3_3,u4_3,u5_3,u6_3,u7_3.
\end{gathered}
\tag{190.16}
\]

Under the clean normalized double-fiber hypotheses, files 182, 184--187
supply the response identities and the incoming graph required by the
determinant argument in file 104.  On
\(D(\Delta\rho_3)\), its pivot triple is

\[
 u5_3,\quad u0_0,\quad u2_1.
\]

Removing these variables from (190.16) leaves, in the order used by the
terminal transcript in file 148,

\[
\begin{gathered}
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,\\
u3_0,u3_1,u3_2,u3_3,u2_2,u1_0,u1_1.
\end{gathered}
\tag{190.17}
\]

On the fallback stratum
\(V(\rho_3)\cap D(\Delta\rho_4)\), the pivot triple is

\[
 u5_3,\quad u1_0,\quad u0_0,
\]

and the sixteen free variables are

\[
\begin{gathered}
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,\\
u3_0,u3_1,u3_2,u3_3,u2_2,u1_1,u2_1.
\end{gathered}
\tag{190.18}
\]

Thus the repeated-\(u^{25}\) solution in the enlarged space is an affine
graph with sixteen free coefficient variables on either priority chart.
The actual profile family is its intersection with the additional boundary
conditions; notably \(f(x,0)=K(x-1)^2\) removes the \(u0_0\) direction.
Formula (190.17) explains exactly, without a finite scan, the sixteen names
retained at \(P129\).

## Tail exhaustion and the remaining missing input

The coefficient restriction \(A\leq j\) in (190.10) gives

\[
 N(j,A)=36+A-j\leq36
\]

for every variable in the retained ambient family.  The next possible new
band would be \(37\leq N\leq41\), at the repeated \(u^{30}\) layer, and is
empty.  Hence the \(u^{30}\) equations cannot be solved by a further
coefficient variable: they are genuine equations on the older coordinates
and the sixteen variables in (190.17) or (190.18).

This exhaustiveness result does not determine those equations.  In
particular, the retained files do not display:

- the affine simple and repeated base vector \(b_{25}\) before the two
  \(u^{25}\) pivot solves;
- the earlier pivot substitutions expressing the base equation and branch
  series in one explicit older-coordinate ring; or
- the three repeated-\(e30\) affine generators after substituting the
  \(u^{25}\) graph.

The response lemmas determine selected columns, but not these affine base
terms.  Consequently the chart ideals requested in file 181 still cannot be
formed from the retained equations alone.
