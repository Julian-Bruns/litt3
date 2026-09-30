# Excluding the rational simultaneous quotient in covering degree seven

24 September 2026. This proof uses the forced boundary constants in
[the degree-six exclusion](degree_six_tensor_exclusion.md) and the
minimal common-pole denominator in
[the genus bound](new_line_degree_six_genus_bound.md). Both maps are
actual finite etale maps to the fixed X. No arbitrary one-leg model
or simultaneous Galois closure replaces them.

## The rational model and its two ends

At covering degree seven, a putative distinct-field comparison has
pole degree six and one common pole. Suppose its simultaneous cubic
quotient is rational. Normalize the degree-two comparison coordinate
as in the preceding boundary calculation. The common value is
r in mu29. The quadratic presentation and the two functions have
the form
\[
F(z)=\frac{w}{z-r},\quad w^2=B(z),\quad
x_1=A(z)+b(z)F(z),\quad z^3x_2=C(z)+d(z)F(z),
\]
where B is monic squarefree of degree two with B(0) nonzero,
b,d have degree at most three, and A,C have denominator z-r and
numerators of degree at most four. The common pole may be ramified
for the quadratic map. It is retained throughout.

Use the scalar abbreviations
\[
(a,b,c,d,e,f,h,i,j,k)
=(\alpha_0-\alpha_j,\alpha_k-\alpha_l,F_1,F_2,F_3,F_0,G_0,G_1,G_2,G_3).
\]
The lower-case scalars b,d are distinguished from the polynomials
b(z),d(z). Write
\[
F=\rho(1+uz+vz^2+\cdots),\qquad
F=1+\ell/z+m/z^2+\cdots,\qquad T=\rho/\varepsilon.
\]
Matching the two endpoint expansions gives
\[
\begin{aligned}
2\varepsilon b(z)&=a/T+(c-ua)z/T+(j-\ell h)z^2+hz^3,\\
2d(z)&=f/T+[k-\ell i+(\ell^2-m)b]z+(i-\ell b)z^2+bz^3,\\
e&=T(j-\ell h)+uc+(v-u^2)a,\\
d&=T[k-\ell i+(\ell^2-m)b]+uf.
\end{aligned} \tag{1}
\]
Unlike the elliptic calculation, an endpoint leading difference can
be zero. All those cases are included. If both f and h are zero,
the verified endpoint constants force all ten differences to vanish.
Then (1) forces b(z)=0, contradicting k(S)=k(z,x_1). This alone
excludes580 normalized configurations. In all other configurations
at least one of f,h is nonzero; neither a nor b is assumed nonzero.

## The common pole supplies two further conditions

Write d_+,e_+,j_+,k_+ for half the corresponding branch sums, in the
same order as in the elliptic proof. The pole ratio forced by the
actual tensor comparison is
\[
d(r)=\varepsilon r^7b(r),\qquad
\varepsilon(r^8e_+-d_+)=r^8j_+-k_+. \tag{2}
\]
The derivation compares the weights4 and17 of x and theta at O.
The second identity follows from the rational numerators of A,C,
so it remains valid at a ramified common pole, where both residues
of the rational parts vanish.

Use variables X=rho*r, which is nonzero, and W=1-ur. Then
\[
\begin{aligned}
\rho^2&=X^2/r^2,&u&=(1-W)/r,\\
\ell&=r-X^2W/r,&
m&=(X^2-\ell^2+4r\ell-r^2)/2,\\
v&=(r^2/X^2-1+4ru-r^2u^2)/(2r^2),\\
B(z)&=z^2-2X^2Wz/r+X^2.
\end{aligned} \tag{3}
\]
Thus squarefreeness is exactly X^2W^2-r^2 nonzero. The equations
do not require W nonzero, or B(r) nonzero.

The complete arithmetic check below shows that the two coefficients
in the second equation (2) are nonzero in every configuration not
already excluded. Hence it determines a nonzero epsilon. Retain
these as checked facts about the finite boundary choices, rather
than imposing them as additional hypotheses.

The first equation (2), simplified using (1), becomes
\[
D(X)W=N(X),\quad
D=\varepsilon(f-r^7a)+X^3(b-r^7h),\quad
N=-r[\varepsilon(d-r^7c)+X(i-r^7j)]. \tag{4}
\]
Substitution of (3) into the last two equations of (1), with only
the nonzero denominators cleared, gives E_0+E_1W+E_2W^2=0 and
G_0+G_1W+G_2W^2=0, where
\[
\begin{aligned}
E_0&=2\varepsilon r^2eX^2-2r(j-rh)X^3-2\varepsilon rcX^2-\varepsilon r^2a,\\
E_1&=-2hX^5+2\varepsilon(rc-a)X^2,&E_2&=3\varepsilon aX^2,\\
G_0&=2\varepsilon r^3d-2r^2(k-ri)X+r^2bX^3-2\varepsilon r^2f,\\
G_1&=2(r^2b-ri)X^3+2\varepsilon r^2f,&G_2&=-3bX^5.
\end{aligned} \tag{5}
\]

There is exactly one actual common pole over r. Cancellation on
the opposite sheet requires the numerator identity
a_num(r)^2=B(r)b(r)^2. It also applies at a ramified pole, where
the rational numerator must vanish. In the present coordinates it is
\[
4X^2r^4(j_+-\varepsilon e_+)^2
-[r^2+X^2(1-2W)]L(X,W)^2=0, \tag{6}
\]
with
\[
L(X,W)=(\varepsilon a+X^3h)W+\varepsilon cr+jrX.
\]
Moreover L must be nonzero. Indeed
epsilon*b(r)=r*L/(2X). If L=0, (6) makes the rational numerator
zero too, so there is no pole on either sheet. At a ramified point
the vanishing of b(r) similarly removes the possible simple pole.
This justifies removing the L=0 locus; it is not an arbitrary open
condition used to suppress a remaining solution.

## Exact elimination, including the denominator-zero locus

For D nonzero, substitute W=N/D in (5) and multiply by D^2.
Compute the polynomial gcd and remove its factors supported at
X*D=0. In every one of the retained boundary configurations the
result is a nonzero constant. Therefore this chart has no geometric
point, over any extension field.

The locus D=N=0 is checked separately. A necessary condition for
the two quadratics (5) to have a common W is their quadratic
Bezout determinant. Intersecting this with gcd(D,N), and removing
X=0, leaves958 configurations. In each the remaining polynomial
in X is linear. At its exact nonzero root, take the gcd in W of
both equations (5) and (6). It is already a nonzero constant in
every case. This stronger fact was checked independently for all958
configurations. Although the native program also implements removal
of factors supported on L=0 or X^2W^2-r^2=0, neither removal is
needed for the final exclusion. In particular W=0 is never discarded.

This procedure also handles a drop in either quadratic degree.
The Bezout test is only necessary; the terminal gcd uses the actual
specialized polynomials. No root is accepted or rejected merely
by the nominal matrix rank, and no free-parameter case is ignored.

## Coverage and evidence

All four choices for each of the remaining root indices are kept.
All29th-root phases are kept modulo the verified order-seven
Frobenius action multiplying their exponent triple by24 modulo29.
There are3,485 phase representatives, hence223,040 root-and-phase
configurations before choosing r, and6,468,160 after all29 values
of r are included. There is no finite-field restriction on X,W
or any hypothetical model coefficient: constant gcds exclude
roots over the algebraic closure.

The exact native certificate has four partitions of1,617,040
configurations. Partition zero has580 double-zero-endpoint
exclusions and232 exceptional contact configurations; each other
partition has242 exceptional contacts. All other configurations
are excluded on the D-nonzero chart by the two jet equations.
Every exceptional contact configuration is also checked on that
chart; none survives its separate D=N=0 test.

The [native source](../../scripts/arithmetic/degree7_genus0_boundary.cpp)
uses the unchanged finite-field engine from the degree-six reply,
with its norm-checked inverse. Records contain the stage, one
nonzero witness coordinate and its value. A high bit marks every
configuration needing the separate contact test. Full replay
reconstructs the calculations and compares every record.
The [independent Sage check](../../scripts/arithmetic/verify_degree7_genus0_reference.py)
uses an absolute field of degree56 over F5 and reconstructs the
unexpanded jet equations. It checks all958 exceptional contacts,
including completeness of the specialized X roots, plus a
deterministic selection of regular cases. The
[symbolic audit](../../scripts/arithmetic/audit_degree7_genus0_formulas.py)
checks the coefficient formulas, contact equation and pole equation.

Executed results, hashes and exact check scopes are recorded in
[the focused audit](../../Research/audits/DEGREE_SIX_ACTUAL_RETURN_FOCUSED_2026_09_24.md)
and the external degree7_genus0_* evidence files. This excludes
the rational simultaneous quotient at degree seven. Together with
the elliptic exclusion and genus bound, it proves recognition at
that degree; the original unmarked common-cover problem is a
different, still unresolved assertion.
