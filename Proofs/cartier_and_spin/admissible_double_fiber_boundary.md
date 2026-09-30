# Proof: local cluster coefficients and a short trace

24 September 2026. This is a conceptual replacement for the previously
executed large collision systems, not an additional assumption on them.
Let n=10 or11 and B=(n-9)O+2x^*(r)+x^*(s). Put
t_B=(x-r)^2(x-s). Then B~nO, so the norm identities give h_*G~nO.
Choose v with div(v)=h_*G-nO. Necessarily
v=a(x)+b y, deg a<=3, b constant.

The primitive b_0 in q=f+b_0^5 generates k(S)/k(X). Indeed its
intermediate etale quotient inherits the same primitive divisor
conditions and projected support. The unrestricted norm theorem
forces every positive occupancy on that quotient to be a multiple
of five; its support has seven points, hence its degree is at least seven.
No proper divisor of10 or11 has this property. The torsion condition
need not descend to this quotient for this argument.

The polynomial of b_0 therefore has the exact form
\[
F(B)=(B^5+f)H_{n-5}(B)+\kappa t_B^3/v,\quad\kappa\ne0.
\]
Set Z=yB and multiply by y^n v. Write J(Z)=v y^(n-5)H(Z/y),
whose leading coefficient is v. With
L=(18,20,20,15) and d=Q-L^5, translate U=Z+L. The polynomial becomes
\[
(U^5+d)\sum J_jU^j+\kappa t_B^3 y^n.
\tag{1}
\]
The coefficient functions are regular at all three points above r
after multiplication by v. Exactly ten selected sheets there have
U vanishing to order at least one. Even if the remaining sheet at
n=11 has a pole from G, clearing v gives the necessary divisibility
\[
[U^j](1)\text{ is divisible by }(x-r)^{10-j},\qquad j<10.
\tag{2}
This follows directly by expanding the selected ten linear factors;
the cleared remaining factor is regular. It uses actual etaleness.

## Degree ten

Here J_5=v. The U^5 and constant equations in (2) give
J_0+dv=0 modulo(x-r)^5 and
\[
\kappa t_B^3 y^{10}-d^2v=0\pmod{(x-r)^8}.
\]
Since d has order three and t_B order two, division by (x-r)^6
gives, at all three cubic sheets,
\[
v\equiv\kappa y\,\mathcal R(x)\pmod{(x-r)^2},\qquad
\mathcal R=(x-s)^3P^3/(d/(x-r)^3)^2.
\]
The basis 1,y,y^2 is a basis over the unramified x-local ring.
Thus a vanishes to order two, and the constant b equals kappa R
to order two. In particular R'(r)=0 would be necessary.

Let p=P'(r)/P(r) and a_1=A''(r)/A'(r). From Q'=PA^2,
d_4/d_3=(3/4)(p+a_1). Therefore
\[
\mathcal R'(r)/\mathcal R(r)
=3/(r-s)+4p+a_1\ne0.
\]
The inequality is checked at the three choices of s for one r;
coefficient Frobenius covers all twelve ordered pairs. Equivalently,
it follows from the F5-independence of the four residue coefficients
in the independent cross-check of the uniform norm proof. This
contradicts the required derivative vanishing.

## Degree eleven

Here J_6=v. The U and U^6 equations in (2) say
dJ_1=0 modulo(x-r)^9 and J_1+dv=0 modulo(x-r)^4.
Thus J_1 has order at least six, and v vanishes at each point
above r. Consequently b=0 and a(r)=0: v is a polynomial of degree
at most three, divisible by x-r.

The U^5 and constant equations again give
kappa t_B^3 y^11=d^2J_5 modulo(x-r)^8. Reducing after division
by(x-r)^6 shows that J_5(r) is a nonzero multiple of y^2.
Write N_1=yv a_1 for the next coefficient of the unshifted J.
Since J_5=N_1-Lv, its polynomial-in-y component at r is the same
as that of N_1 and is zero.

Take B_0=(8,14,19,2,10,19,3,24,18,16), so P^2 divides Q-B_0^5.
The correction b_0+B_0/y has no finite poles except G. Its trace,
multiplied by v, is regular there. Since n=11=1 in k, it follows
that N_1-B_0v is divisible by y. Also N_1 belongs to L(23O),
so its polynomial component is precisely B_0v modulo P and has
degree at most seven. Thus v in span(1,x,x^2,x^3) satisfies
\[
[x^8](B_0v\bmod P)=0,\quad[x^9](B_0v\bmod P)=0,
\quad v(r)=0,\quad(B_0v\bmod P)(r)=0.
\]
This four-dimensional system has determinant
[11]+[8]r+[17]r^2+[2]r^3, nonzero in F25[r]/(A).
Hence v=0, contradicting its definition. Multiple points of G,
including its possible unselected sheet over r, were retained.

## Verification

[The standard-library verifier](../../scripts/arithmetic/verify_double_fiber_boundary.py)
checks both primitive corrections, the Hasse coefficient ratio,
the three nonzero degree-ten derivatives and the degree-eleven
trace determinant. Its
[exact data](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/double_fiber_boundary.json)
and [log](../../../litt3-computation-data/cubic_full_return_boundary_replies_20260924/logs/double_fiber_boundary.log)
are retained. The independently generated large collision matrices
are consistent regression evidence but are not needed in this proof.
