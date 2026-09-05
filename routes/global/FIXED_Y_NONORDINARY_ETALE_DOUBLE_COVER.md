# The fixed genus-twenty-five curve has a nonordinary etale double cover

**Status:** proved by exact scalar arithmetic, 2026-09-05.  The accompanying
certificate uses no optimized finite-field matrix rank or kernel routine.

## Statement

Let `k` be the algebraic closure of `F_5`, and let `Y` be the fixed curve
of file 76,

\[
 Y:\quad z^2=f(t),\qquad
 f(t)=(t^{25}+t^5+t)(t^{25}+t^5+t-1)(t-4).              \tag{1}
\]

There is a connected etale double cover

\[
                              W\longrightarrow Y        \tag{2}
\]

whose Jacobian is nonordinary.  In fact, `J(W)` has a genus-two isogeny
factor of 5-rank one.

## Explicit genus-two factor

Work over

\[
 \mathbf F_{125}=\mathbf F_5[b]/(b^3+3b+3).
\]

The polynomial

\[
\begin{aligned}
g(t)={}&t^5+(2b^2+b+3)t^4+(2b+1)t^3
 +(3b^2+4b)t^2\\
 &\hspace{34mm} +(4b^2+3)t+b^2                         \tag{3}
\end{aligned}
\]

is a square-free divisor of `f`.  Thus its five finite roots, together
with infinity, form a six-element subset of the 52 branch points of `Y`.
Let

\[
                              C_g:\quad u^2=g(t).        \tag{4}
\]

This is a smooth genus-two curve.

Write `g(t)^2=sum c_j t^j`.  In the standard basis, its characteristic-five
Hasse--Witt matrix is

\[
 H=\begin{pmatrix}c_4&c_3\\c_9&c_8\end{pmatrix}
 =\begin{pmatrix}
 b^2+2b&3b^2+4b+2\\
 4b^2+2b+1&b^2+b+4
 \end{pmatrix}.                                         \tag{5}
\]

Direct scalar multiplication in `F_125` gives

\[
                         \det H=0,\qquad H\ne0.          \tag{6}
\]

More precisely, the matrix of the 125-power iterate in this convention is

\[
\begin{aligned}
Q=H H^{(5)}H^{(25)}
 =\begin{pmatrix}
 3b^2+4b&4b^2+4\\
 b^2+3&2b^2+b+1
 \end{pmatrix},\qquad Q^2=Q,\quad\operatorname{tr}Q=1.  \tag{7}
\end{aligned}
\]

Hence `Q` has rank one, and `C_g` has 5-rank one.  In particular it is
nonordinary.

## The etale biquadratic cover

Put

\[
                              h(t)=f(t)/g(t).             \tag{8}
\]

The polynomials `g` and `h` are square-free and coprime, of degrees five
and 46.  Let `W` be the smooth normalization of

\[
                         u^2=g(t),\qquad w^2=h(t).        \tag{9}
\]

The two square classes are independent, so `W` is connected and is a
biquadratic cover of the `t`-line.  The function `z=uw` satisfies
`z^2=f(t)`, and the simultaneous sign involution

\[
                         (u,w)\longmapsto(-u,-w)         \tag{10}
\]

has quotient `Y`.

The map `W -> Y` is etale.  Indeed, the branch sets of `g` and `h`
partition the branch set of `f`, including infinity on the odd-degree
`g` side.  At a branch of either factor, a local parameter for `Y` differs
from the corresponding parameter on `W` by a unit.  Equivalently, the
involution (10) has no fixed point.

The three nontrivial quotients of the Klein four action are `Y`, `C_g`,
and the hyperelliptic curve `C_h:w^2=h(t)`.  Since the full quotient is
`P^1`, the standard norm/pullback decomposition gives

\[
                         J(W)\sim J(Y)\times J(C_g)\times J(C_h). \tag{11}
\]

The dimensions are `25+2+22=49`, agreeing with
`g(W)=2(g(Y)-1)+1=49`.  Since `J(C_g)` is nonordinary, so is `J(W)`.
This proves the statement.

## Strategic boundary

The logarithmic-differential theorem for a residual two-point orbifold
forces some connected cyclic cover of `Y` of degree dividing `t` to be
nonordinary.  The cover above shows that this necessary phenomenon already
occurs in degree two on the actual fixed `Y`.  Therefore one cannot exclude
the residual rows merely by claiming that every cyclic cover of degree
`2`, `4`, or `8` is ordinary.  The torsion class tied to the particular
wild fiber remains much more specific and is not tested by this example.

The exact computation is reproduced by
[`FIXED_Y_NONORDINARY_ETALE_DOUBLE_COVER_CERTIFICATE.sage`](FIXED_Y_NONORDINARY_ETALE_DOUBLE_COVER_CERTIFICATE.sage).
