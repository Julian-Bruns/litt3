# The entry-zero trace and the exceptional first-layer cokernel

## Status and scope

This note is **proved-text** for every actual profile-4 pair in the
entry-zero case of file 79.  It gives the exact coefficient of `z^34` in
the bidegree equation and identifies the rank-two compatibility from file
192 as a trace equation.  The latter identification does not by itself
make that equation vanish in a relaxed coefficient family: it says exactly
which missing trace component has to be computed.

Write

\[
 f(x,z)=\sum_{j=0}^{35}a_j(x)z^j,
 \qquad a_{35}=x^4(x-c)(x-d),
\tag{193.1}
\]

and put

\[
 D=(x-1)\frac d{dx},\qquad
 \mathcal E(q)=D^4q-q+q^5.
\tag{193.2}
\]

## 1. The global trace is fixed

### Proposition 193.1

For an actual entry-zero profile pair,

\[
 \operatorname {Nm}_{k(C)/k(x)}(r-1)
 =\kappa\,
 \frac{(x-c)^{31}(x-1)}{x^2(x-d)^{31}}
\tag{193.3}
\]

for some `kappa in k^*`.  Consequently

\[
\begin{aligned}
 T:=\operatorname {Tr}_{k(C)/k(x)}(z)
  &=(x-1)\left(
       \frac1{x-c}+\frac1{x-1}-\frac1{x-d}-\frac2x
     \right)\\
  &=4+\frac2x+\frac{c-1}{x-c}
       +4\frac{d-1}{x-d}.
\end{aligned}
\tag{193.4}
\]

In particular,

\[
 \boxed{
 a_{34}(x)=x^3\left(
 x^3+3(c+1)x^2+(cd+3c+d)x+3cd
 \right).}
\tag{193.5}
\]

Moreover,

\[
                         \mathcal E(T)=0.
\tag{193.6}
\]

### Proof

The divisor of `r-1` is

\[
 31Q_1+A+D_0+G-31Q_\infty-B-E,
\]

where `D_0=U_(1,1)` denotes the degree-two atom (the subscript avoids
confusion with the differential operator).  Under `x`, the zero terms have
values and multiplicities

\[
 (c,31),\quad(0,1),\quad(1,2),\quad(\infty,1),
\]

and the pole terms have values and multiplicities

\[
 (d,31),\quad(0,3),\quad(1,1).
\]

Pushing the divisor forward gives (193.3).  Since

\[
 z=D\log(r-1),
\]

logarithmic differentiation commutes with norm and trace in the separable
extension `k(C)/k(x)`.  Applying `D log` to (193.3), and reducing the
integer exponents modulo five, proves the first line of (193.4).  The second
line is its partial-fraction expansion.

For a monic-normalized degree-35 equation, Vieta gives

\[
 T=-\frac{a_{34}}{a_{35}}.
\]

Substitution of (193.1) and (193.4), followed only by multiplication, gives
(193.5).  Notice that it has leading coefficient one,
`a_34(0)=0`, and

\[
 a_{34}(1)=-\,(1-c)(1-d),
\]

as required by all three boundary restrictions in file 79.

Finally, every conjugate of `z` satisfies `mathcal E(z)=0`.  The operator
`D^4-1` is additive, and in characteristic five

\[
 \left(\sum_i z_i\right)^5=\sum_i z_i^5.
\]

Taking the sum over all 35 conjugates therefore gives
`mathcal E(T)=0`.  Equivalently, (193.6) may be checked termwise from the
four logarithmic-derivative summands in (193.4).  This proves the
proposition. \(\square\)

## 2. Meaning of the exceptional scalar

At the `x=0,z=infinity` corner, let

\[
 z_-(u),\quad z_1(u),z_2(u),z_3(u)
\]

be the four polar Laurent branches.  The first is the simple branch and the
last three have second-blowup slopes `s_1,s_2,s_3`.  On the clean locus put

\[
 P_0(s)=\gamma\prod_{i=1}^3(s-s_i),\qquad
 \ell_i=P_0'(s_i),\qquad p_i=\ell_i^{-1},
\tag{193.7}
\]

where `gamma=2a` in the notation of files 188 and 192.  Let `b_5` be the
affine repeated-`u^5` residual after the simple equation has been solved,
so that

\[
 b_5(s_i)=[u^5]\mathcal E(z_i).
\tag{193.8}
\]

### Proposition 193.2

With `lambda` denoting extraction of the `s^2` coefficient in the etale
cubic algebra,

\[
 \boxed{
 \lambda(p^{-1}b_5)
 =\gamma\sum_{i=1}^3[u^5]\mathcal E(z_i).}
\tag{193.9}
\]

If the simple residual has been solved, then, for

\[
 S_{\rm pol}=z_-+z_1+z_2+z_3,
\]

one has

\[
 \boxed{
 \lambda(p^{-1}b_5)
 =\gamma[u^5]\mathcal E(S_{\rm pol}).}
\tag{193.10}
\]

Let `S_reg` be the trace of the other 31 branches, which are regular at
`u=0`.  Then

\[
 T=S_{\rm pol}+S_{\rm reg}
\]

and hence

\[
 \boxed{
 \lambda(p^{-1}b_5)
 =-\gamma[u^5]\mathcal E(S_{\rm reg}).}
\tag{193.11}
\]

### Proof

Lagrange interpolation in the cubic algebra gives, for every element `h`,

\[
 \lambda(h)=\gamma\sum_{i=1}^3\frac{h(s_i)}{P_0'(s_i)}.
\tag{193.12}
\]

Since `p(s_i)=ell_i^(-1)`, equations (193.8) and (193.12) immediately give
(193.9).  The solved simple equation says

\[
 [u^5]\mathcal E(z_-)=0.
\]

The operator `mathcal E` is additive in characteristic five, so adding this
zero term to (193.9) proves (193.10).  Hensel factorization at `u=0`
separates the four roots tending to `w=0` from the 31 roots tending to
`w=eta`; their reciprocal traces sum to the global trace `T`.  Proposition
193.1 gives `mathcal E(T)=0`, and additivity now turns (193.10) into
(193.11). \(\square\)

## Consequence for the hard locus

On `c^2+cd+d^2=0`, file 192 shows that (193.9) is the sole cokernel
equation at repeated `u^5`.  Propositions 193.1--193.2 show that this is not
an unexplained third branch equation: it is exactly the degree-five trace
compatibility between the four polar sheets and the order-31 regular
cluster.  Formula (193.5) fixes the total trace, but neither it nor the three
boundary fibers separately fixes `S_reg`.  Thus a proof that the hard locus
is empty still has to compute this regular-cluster term (or impose an
equivalent global coefficient condition); discarding it would lose a genuine
necessary equation.
