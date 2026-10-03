# Proof: two local jets force the norm to vanish in every degree

Version4, 1 October2026. This proof removes the missed-point assumption in
[the earlier norm argument](finite_missed_point_cartier.md). It preserves
the actual map and primitive, and is independent of the degree.
Only unramifiedness over R_X is used, not global etaleness.
The local mechanism is formalized for arbitrary characteristic and curve
in [the primitive trace-jet criterion](primitive_trace_jet_criterion.md).

Write F25=F5(beta), beta^2=beta+3, and encode a+5b as a+b beta. Use
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad
A=(1,21,14,22,13),\quad X:y^3=P(x),\quad\theta=dx/y^2.
\]
The fixed f=Q/y^5 satisfies Q'=PA^2, div(df)=2R_X-10O, and has
pole order seven at O. The hypotheses imply E and G are disjoint,
by the valuation argument in the reconstruction proof.

## The admissible logarithmic character has zero trace

Once the principal norm conclusion below is known, write
div(t)=h_*E/5-nO and div(v)=h_*G-nO. For an annihilator a with
div(a)=2E-10H, properness gives
Norm_h(a)=c t^10 and Norm_h(q)=c' t^15/v^5 for constants c,c'.
Their logarithmic derivatives vanish in characteristic five, so
\[
\operatorname{Tr}_h(4\,da/a-dq/q)
=4d\log\operatorname{Norm}_h(a)-d\log\operatorname{Norm}_h(q)=0.
\]
The reconstruction theorem's regular-logarithm test identifies this
character as regular and nonzero exactly when the admissible class is
nontrivial. If it equals h^*eta for a regular differential eta on X,
its trace is n eta. For5 not dividing n this forces eta=0, proving
non-descent through this actual h leg. No unrelated second leg is
introduced by the calculation.

## A fixed endpoint Cartier criterion

Let W=H0(X,omega_X(R_X)). Its basis consists of x^i y^j theta/A,
with i<=9,6,3 for j=0,1,2 respectively. At t=x^3/y=0 the orders
are 28-3i-10j. Only x^6 y theta/A has order zero. The only pole
basis vector is x^3 y^2 theta/A; it is invariant under y->zeta y,
so its Laurent exponents are -1 modulo three and it has no constant
coefficient. All remaining vectors have positive order.

Consequently, a differential in W with no constant dt coefficient
has zero x^6 y theta/A coordinate. Cartier interchanges the j=0 and
j=1 spaces and preserves j=2. On the seven-dimensional j=1 space,
its square is B v^[1/25], with the following matrix over F25:
\[
B=\begin{pmatrix}
2&1&21&15&12&19&17\\
1&10&13&1&10&4&16\\
6&11&20&17&22&12&4\\
18&8&0&6&21&20&1\\
6&0&2&24&22&1&15\\
3&6&22&15&7&22&20\\
6&7&18&8&12&11&15
\end{pmatrix}.
\]
Entries are coded field elements, not ordinary integers. If a differential
is Cartier-fixed, its j=1 column v satisfies v^[25]=Bv. Put l=(0,...,0,1).
If lv=0, repeated 25th powers give lB^i v=0. The seven rows lB^i,
0<=i<=6, have determinant [18]!=0. Thus v=0, and Cartier fixity
also kills the j=0 component. Therefore
\[
C\omega=\omega,\quad [t^0dt]\omega=0
\quad\Longrightarrow\quad
\omega=\sum_{i=0}^3 r_i\frac{dx}{x-\alpha_i},\quad r_i\in\mathbf F_5,
\tag{1}
\]
where alpha_i are the four roots of A. Indeed the remaining j=2
space is U(x)dx/A, deg U<=3; Cartier fixity of its partial fractions
is exactly r_i^(1/5)=r_i. This argument applies over the full algebraic
closure, not only to F25-rational differentials.

## The actual norm satisfies the infinity condition

Put omega=dlog Nm_h(q)=Tr_h(dq/q). Its poles are at most simple
and supported on R_X, and C omega=omega. At O the expansion of f is
t^-7 times a unit in k[[t^3]]: the cubic automorphism acts on f by
zeta and on t by zeta^-1. Hence df/f=-7dt/t+O(t^2)dt.

At a point of E over O, q has pole order seven, and b has pole
order at most one. Thus b^5/f=O(t^2), and
\[
dq/q=(df/f)/(1+b^5/f)
\]
has no constant dt coefficient. At a point over O outside E,
q has pole order 10+5g, and dq/q has order 2+5g. It too has no
constant coefficient. Etaleness identifies each completed local ring
with k[[t]], and trace sums these germs. No division by n is used.
Thus omega satisfies (1) in every degree, including multiples of five.

## The finite jets give a four-dimensional differential operator

Choose a point of X above alpha=alpha_0, with local parameter u=x-alpha.
Write df=(c_2 u^2+c_3 u^3+...)du. At a selected point upstairs,
\[
q=(c_2/3)u^3+(c_3/4)u^4+O(u^5),\qquad
dq/q=3du/u+(3c_3/(4c_2))du+O(u)du.
\]
The fifth-power summand changes neither displayed coefficient. At an
unselected point, dq/q has order at least two, even if G has multiplicity.
If m is the number of selected points over this point, the residue of
omega is 3m and its constant du coefficient is m*3c_3/(4c_2).
Moreover Q'=PA^2 and the fifth-power denominator y^5 give
\[
c_3/c_2=P'(alpha)/P(alpha)+A''(alpha)/A'(alpha)=:s_alpha.
\]
Comparing with (1), whose residue here is r_0=3m, yields
\[
-s_alpha r_0+4\sum_{i=1}^3\frac{r_i}{alpha-alpha_i}=0.
\tag{2}
\]
This is valid also when m=0. It is not a small-multiplicity assumption.
There is a simpler way to combine the four point conditions without
adjoining any root. Write omega=U(x)dx/A, deg U<=3. Its residue and
constant coefficient at alpha are U/A' and
U'/A'-UA''/(2A'^2). The four conditions therefore say
\[
\mathcal L(U):=4PA'U'-3PA''U-P'A'U=0\pmod A.
\]
In the basis 1,x,x^2,x^3 of k[x]/(A), the matrix of this operator is
\[
\begin{pmatrix}
2&1&3&15\\6&23&23&24\\19&4&8&23\\6&20&22&21
\end{pmatrix},\qquad\det\mathcal L=[21]\ne0.
\]
Again the entries are F25 codes. Thus U=0 over the entire algebraic
closure. This proof uses only polynomial arithmetic over F25.
This is the additional compatibility that the isolated missed-point
or support scans did not use: the regular coefficient at a selected
point is tied to its residue by the actual equation dq=df.

## Divisors, torsion and the degree consequence

Since k is perfect, dlog Nm(q)=0 makes Nm(q) a fifth power. Its
divisor is 3h_*E-5h_*G-10nO. Thus h_*E=5B. Taking a fifth root
gives 3B-h_*G-2nO principal. If 5T~0, then
\[
h_*T\sim2(B-nO).
\]
The left side is killed by five; the right has prime-to-five order by
[the established marked-support arithmetic](admissible_line_support_arithmetic.md).
Both vanish. Thus $2(B-nO)$ is principal. The exact
[marked-divisor relation theorem](marked_divisor_relation_lattice.md)
identifies the subgroup generated by the twelve marked finite points
minus $O$ as a finite group of odd exponent. Since $B-nO$ is supported
on precisely these points and $O$, its class belongs to that group.
A class killed by both two and an odd integer is zero. Consequently
$B\sim nO$, and $h_*G\sim3B-2nO\sim nO$.
There are therefore global functions $t,v$ with divisors $B-nO$ and
$h_*G-nO$. Effectiveness of $B,h_*G$ makes them affine regular even
when either divisor has a positive coefficient at $O$.
This removes the two-torsion ambiguity in every degree; it does not
assume that $E$ is a full inverse image or that $T$ descends. The
principality upgrade uses $5T\sim0$ and is not a conclusion of the
primitive divisor equation alone.

The twelve finite points can all occur only if deg B=n>=12.
For n<5, every positive occupancy would be at most n and divisible
by five, which is impossible since deg E=5n>0. This last assertion
does not use the torsion hypothesis. The application through degree
nine is recorded separately in the degree-nine exclusion theorem.
There is no contradiction here for arbitrary large n.

## Exact verification

[The standard-library verifier](../../scripts/arithmetic/verify_uniform_admissible_norm.py)
reconstructs Q'=PA^2, the two Cartier character maps, B, its seven
cyclic rows, and the polynomial operator L from P and A. As an
independent cross-check, it also expands (2) at one root in the
eight-dimensional F5 field basis; four coefficient rows have determinant1.
It uses
[the independent field implementation](../../scripts/arithmetic/fixed_curve_finite_field.py).
It enumerates no support pattern, covering degree or geometric parameter.
The [exact data](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/uniform_admissible_norm.json)
and [executed log](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/logs/uniform_admissible_norm.log)
record determinants [18], [21], and the cross-check1. The global trace and valuation argument
above is separate from these two endpoint checks.
