# Multi-branch wild orbifolds: exact finite reduction for the genus-nine atlas

**Status:** independently audited **PASS**, 2026-09-05.
Auditor: `/root/canonical_trace_algebra`. No breaking objections; the
parameterized scope and global case division are recorded in the
[audit](audits/ALL_DEGREE_COMMON_ORBIFOLD_BOUND_AND_LOGARITHMIC_TORSION_AUDIT.md).

This is a necessary condition for a finite common orbifold of the fixed curves; it does not
assert that every surviving numerical signature is realized.  In
particular, it does not address a coreless common cover.

## 1. Set-up and exact integer form of Riemann--Hurwitz

Let `k` be algebraically closed of characteristic five.  Let `S` be a
smooth proper effective Deligne--Mumford orbifold with coarse curve
`P1`.  Suppose that the fixed genus-nine curve `X` and the fixed ordinary
genus-twenty-five curve `Y` admit representable finite etale maps to `S`.
Write

\[
 n=\deg(X\longrightarrow \mathbf P^1).
\]

Then the degree from `Y` is `3n`.  At every stacky point let `e` and `d`
be the inertia order and local different exponent.  Put

\[
 \delta=-2+\sum_i\frac{d_i}{e_i}.
\]

Riemann--Hurwitz for `X` gives

\[
                         \delta=\frac{16}{n},             \tag{1.1}
\]

and uniformity of the coarse map gives `e_i | n`.

At a wild point write

\[
 I=P\rtimes C_m,\qquad q=|P|=5^a,\qquad e=qm,
\]

where `(m,5)=1`, and put

\[
 \epsilon=\sum_{j\geq1}(|P_j|-1),\qquad A=\epsilon-1,
 \qquad x=\frac ne.                                      \tag{1.2}
\]

The exact different formula is

\[
 d=e-1+\epsilon=e+A,
 \qquad n\frac de=n+xA.                                 \tag{1.3}
\]

The local results in
[file 13](13_PROOF_LOCAL_RAMIFICATION.md) give

\[
 4\mid\epsilon,\qquad m\mid\epsilon,qquad
 A\equiv3\pmod4,qquad A\geq q-2.                       \tag{1.4}
\]

In particular `A >= 3`.  The ordinary-atlas theorem
[recorded here](ORDINARY_ATLAS_LOCAL_DIFFERENT_BOUND.md) gives `d<2e`,
so

\[
                              A<e.                       \tag{1.5}
\]

If `m=1`, the same theorem says that the pure 5-group inertia is weakly
ramified.  Thus in that case

\[
                         \epsilon=q-1,\qquad A=q-2.      \tag{1.6}
\]

At a tame point of order `t`, put `y=n/t`.  Its exact contribution after
multiplication by `n` is `n-y`.

Let `w` be the number of wild points and `c` the number of tame points.
Combining these formulas with (1.1) gives the useful integer identity

\[
 \boxed{
 16=(w+c-2)n+\sum_{i=1}^{w}x_iA_i-\sum_{j=1}^{c}y_j.}
                                                               \tag{1.7}
\]

Here every `x_i,y_j` is a positive integer, every `x_iA_i >= 3`, and
`y_j <= n/2`.

## 2. The finite reduction

Assume that `S` has at least two stacky points and at least one wild
point.

### Theorem

All signatures are eliminated or bounded as follows.

1. There cannot be three or more wild points.

2. There cannot be exactly two wild points and no tame point.  If there
   are exactly two wild points and at least one tame point, then
   `n <= 20`.

3. Suppose there is exactly one wild point.

   * If there are at least three tame points, then
     \[
       n\leq \frac{26}{c-2};                              \tag{2.1}
     \]
     in particular `n <= 26`.
   * If there are two tame points, then `n <= 78`.
   * If there is one tame point and the wild inertia is a pure
     5-group, then `n <= 160`.

Consequently, the only multi-branch wild family not given a uniform
degree bound by these exact constraints is

\[
 \boxed{\text{one mixed wild point }(m>1)
        \quad+\quad\text{one tame point}.}               \tag{2.2}
\]

For (2.2), the entire remaining numerical condition is

\[
 \boxed{
 xA-y=16,\qquad xe=yt=n,\qquad e=qm,\qquad
 4\mid A+1,\qquad m\mid A+1,\qquad q-2\leq A<qm.}     \tag{2.3}
\]

Thus any further all-degree argument on the finite-orbifold side may be
concentrated on this two-point mixed signature.

### Proof

If `w >= 3`, (1.7), `x_iA_i >= 3`, and `y_j <= n/2` give

\[
 16\geq (w-2+c/2)n+3w.                                  \tag{2.4}
\]

For `w=3,c=0`, this forces `n<=7`.  Since every wild inertia order is
divisible by five and divides `n`, necessarily `n=5`; all three inertia
groups are then pure of order five.  Equations (1.6) and (1.7) give
`16=5+3+3+3=14`, a contradiction.  Every other case with `w>=3` is
already impossible from (2.4).

Now take `w=2,c=0`.  Equation (1.7) is

\[
                         x_1A_1+x_2A_2=16.               \tag{2.5}
\]

Because each `A_i` is at least three and is congruent to three modulo
four, the only unordered possibility is

\[
                  (x_1,A_1)=(3,3),\qquad (x_2,A_2)=(1,7).
                                                               \tag{2.6}
\]

For `A=3`, one has `epsilon=4`, hence `q=5` and `m|4`; thus
`e=5m` with `m in {1,2,4}`.  Since `x=3`, this gives

\[
                         n\in\{15,30,60\}.               \tag{2.7}
\]

For `A=7`, one has `epsilon=8` and again `q=5`, while `m|8`.
The case `m=1` is impossible by (1.6), so `m in {2,4,8}`.  Since
`x=1`, this gives

\[
                         n\in\{10,20,40\}.               \tag{2.8}
\]

The two sets are disjoint, contradicting the common value of `n`.

If `w=2,c>=1`, (1.7) gives

\[
 16\geq cn/2+6,
\]

and hence `n<=20/c<=20`.

It remains to take `w=1`.  If `c>=3`, (1.7) gives

\[
 16\geq \frac{c-2}{2}n+3,
\]

which is (2.1).  If `c=2` and the two tame orders are not both two,
then, after ordering them, `1/t_1+1/t_2<=1/2+1/3=5/6`.
Thus

\[
 16=n\left(1-\frac1{t_1}-\frac1{t_2}\right)+xA
       \geq n/6+3,
\]

so `n<=78`.  If both tame orders are two, (1.7) instead says
`xA=16`, impossible because `A` is congruent to three modulo four.

Finally let `w=c=1` and suppose the wild inertia is pure.  By (1.6),

\[
 \delta=1-\frac2q-\frac1t.
\]

For `q=5` this is at least `1/10`, because positivity forces `t>=2`;
for `q>=25` it is at least `1/2-2/25=21/50`.  Equation (1.1) therefore
gives `n<=160`.  With mixed inertia, (1.7) is exactly (2.3), and none of
the preceding estimates separates the positive wild excess `A/e` from
the tame deficit `1/t`.  This proves the theorem.  \(\square\)

## 3. Why the residual family is a real numerical bottleneck

The universal numerical relations used above do allow the two terms in
(2.3) to approach one another.  For example, for every `q=5^a` the
formal data

\[
\begin{aligned}
 m&=2(q+1),& \epsilon&=2(q+1),& A&=2q+1,\\
 e&=2q(q+1),& t&=q+1,& n&=32q(q+1),\\
 x&=16,& y&=32q
\end{aligned}                                             \tag{3.1}
\]

satisfy `4|epsilon`, `m|epsilon`, `q-2<=A<e`, `e|n`, `t|n`, and

\[
 -2+\left(1+\frac Ae\right)+\left(1-\frac1t\right)
       =\frac1{2q(q+1)}=\frac{16}{n}.                     \tag{3.2}
\]

These are **formal numerical inertia data only**.  No claim is made that
there is a local action with this filtration, still less a global
orbifold or common cover.  In fact, the graded tame-character constraints
of file 13 may rule out particular proposed filtrations.  The point of
(3.1) is narrower: the exact different identity, ordinary-atlas bound,
divisibility `m|epsilon`, and uniform degree divisibility do not by
themselves yield a bound in (2.2).  The missing input must couple the tame
branch to the mixed wild inertia more strongly, or use global monodromy.
