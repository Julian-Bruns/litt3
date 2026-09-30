# A critical-cover argument for the root-nine scale family

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_critical_scale_budget.md).
The source recipe, divisions and degree140 graph are those of the
[accepted root-nine construction](degree140_root9_six_scale_curves.md).
The argument transfers the normalization-index method in Sections40–43
of the received primitive-constant report, with different local data at
O and at the marked cubic branch. It does not assume the constant
family's positive-content theorem for the linear family.

## A small global certificate for the critical discriminant

The original congruences show that the barred discriminant is
\(\Delta=(4G_3^2+3G_2G_4)/P^2\). It is regular on affine X.
The poles of G2,G3,G4 are at most33,46,57, and the pole46 coefficient
of G3 is the fixed nonzero epsilon. Hence Delta has exact pole32.
Write
\[
\Delta=\delta_0(x)+\delta_1(x)y+\delta_2(x)y^2,
\qquad \deg(\delta_0,\delta_1,\delta_2)\le(10,7,4).
\]
A square root would be regular on affine X with pole16 at O, hence
would have the form a(x)+b(x)y, with degrees at most5 and2. It would
force \(\delta_1^2-4\delta_0\delta_2=0\).

Use original source coordinates h,w and put u=h*w2,q=w3. Reconstruct
the accepted affine source and its Cramer coordinates, form Delta by
exact division by P2, and take coefficients x12,x13,x14 of that last
obstruction. Clearing only the original w and Cramer denominators,
and removing a power of w from each row, gives polynomials p12,p13,p14
in K[u,q]. Their respective u/q degrees and term counts are
\[
(8,18;94),\qquad(5,9;36),\qquad(2,4;7).
\]
The new exact certificate is
\[
b_{12}p_{12}+b_{13}p_{13}+b_{14}p_{14}=q,
\]
with35,73,184 terms in the three multipliers. No new ratio polynomial
is inverted. Since q is an original unit, this excludes all geometric
critical squares, including coefficient-drop specializations.

The [source reconstruction](../../scripts/arithmetic/root9_critical_discriminant_20260929.sage)
checks all divisions, pole bounds, the coordinate change, and the
identity over the complete ratio ring. The
[independent standard-library checker](../../scripts/arithmetic/verify_root9_critical_identity_20260929.py)
multiplies the saved identity literally using the original quartic tower
over F25; it does not call a Groebner algorithm or Sage. Both passed.
The [5.7KB certificate and receipts](../../../litt3-computation-data/conceptual_continuation_20260929/root9_critical/)
are retained outside the repository. Only this new identity was checked;
the accepted affine-source and Cramer certificates were not replayed.

The double cover C is therefore connected. Its ramification consists
of odd zeros of Delta; their number is at most32. Its pole32 is even,
so the two points above O are unramified. Tame Hurwitz gives
\(17\le g(C)\le33\).

## The critical scale is a separable map

Put phi=W5+Qbar and
\(Sbar=g_2W^3+g_3W^2+g_4W+g_5\). The actual transformed polynomial is
\[
\bar f_\lambda=\lambda v\phi^2+\phi Sbar+t^3,
\qquad \bar D=Sbar'=3g_2W^2+2g_3W+g_4.
\]
The exact resultant transformation is Res_Z(f,S')=y40 Res_W(fbar,Dbar).
Consequently the displayed e(lambda) is the actual regular quadratic
whose cubic norm is the residual. Its leading coefficient is
\[
d_2=v T^2/t^5,\qquad T=\operatorname{Res}_{(5,2)}(\phi,\bar D).
\]
T is a nonzero regular affine function: phi is irreducible over k(X),
because dQbar is nonzero, while Dbar has degree two.

The universal quadratic-resultant identity gives scale discriminant
Delta3 times a square. If it is zero, e is d2 times a rational square
in k(X)(lambda). Its norm has square class t*v in k(x), which is
nonsquare, since t*v has four distinct simple roots. Every specialized
residual has exact degree140 and is nonzero; thus no constant scale
is a square in this case. Otherwise e is irreducible over k(X).

For the rest of the proof assume primitivity. It is equivalent to the
norm being primitive as a polynomial in lambda over k[x]: at an
unramified cubic fibre one takes a product of three residue polynomials;
at a branch fibre one takes the cube of one residue polynomial. The
cyclic cubic orbit of the monic irreducible quadratic e/d2 has length
three. If it had length one, Gauss's lemma and primitivity would make
the norm a constant times a polynomial cube, contradicting x-degree140.
Thus the norm plane curve is irreducible and has function field k(C).
In particular lambda:C->P1 has degree140.

At O the exact coefficient poles are140 for d0,132 for d2, and at
most136 for d1. The source degree bounds give the upper bounds; the
leading coefficient of d0 is the required F6 unit. For d2, before the
barred change, the term -Q(2G3)^5 in the critical resultant has unique
pole287, so division by y40*t5 and multiplication by v gives pole132.
Both roots of the quadratic in lambda have pole4. The critical cover
already splits over the completed local field at O, so these are two
distinct points, even if their leading scale values agree. Their pole4
proves separability of lambda in characteristic five.

The critical-point formula is
\[
\lambda=-\frac{Sbar}{v\phi}-\frac{t^3}{v\phi^2}.
\]
Away from t*v=0 on affine X, a pole of W cannot give a pole of lambda:
the two summands have orders at least2m and10m when W has pole m.
If W is finite, a zero of phi gives a pole of twice its order, since
t is a unit. All such poles are even.

## Ten odd poles and thirty units of boundary index

At each of the nine points over t=0, d2 has positive odd valuation.
At Q_r=([9],0), it has valuation a=3+2 ord(T), also positive odd and
at least three. Primitivity makes at least one of d0,d1 a unit at
each of these points. The following elementary quadratic calculation
therefore applies.

If d1 is a unit, one root has pole a and the other is finite. Otherwise
d0 is a unit; put b=ord(d1)>0. If2b<a, the two roots are unramified
and have poles b,a-b. If2b>a, there is one ramified point of C and
lambda has pole a on C. Equality is impossible because a is odd.
Exactly one pole is odd in every case. Thus lambda has exactly ten
odd poles in all. Its two poles4 at O contribute four extra units
above the minimum of two for an even pole. If r_infinity counts all
distinct poles, degree140 gives
\[
140\ge2r_\infty-10+4,\qquad r_\infty\le73.
\]
The different at a pole is at least its pole order minus one, with
wild contributions retained. Hence the finite different has degree
\[
d_{fin}\le(2g-2+280)-(140-73)=2g+211.
\]

The norm plane curve has bidegree(140,6) in P1_x times P1_lambda,
so arithmetic genus695. Its boundary on lambda=infinity contributes
at least30 to its delta-invariant:

- Above each of the three t-roots there are at least three distinct
  branches, one from each of the three X-points. Their pairwise
  intersections contribute at least three, for a total of nine.
- At x=infinity the two branches have parameter orders(3,4). Each
  contributes at least three internally, and their mutual intersection
  is at least12. The contribution is at least18, whether or not their
  first weighted coefficients coincide.
- At x=r the contribution is at least three. If d1 is a unit, the
  pole branch has orders(3,a), a>=3, so multiplicity at least three.
  If2b<a, the two branches have orders(3,b),(3,a-b). In the smallest
  case b=1,a-b=2 their internal contributions and intersection are
  at least0,1,2; every larger case gives at least as much. If2b>a,
  there is one branch with orders(6,a), again of multiplicity at
  least three. These cases cover the entire marked branch.

Here the standard elementary plane-branch bounds follow by blowing up:
a branch of multiplicity m contributes at least m(m-1)/2. A(3,4)
branch contributes three; two(3,4) branches have intersection at least12
by their first weighted equations. No smoothness of the plane model is
assumed. Consequently the finite normalization-index degree i satisfies
\[
i\le695-g-30=665-g.
\]

## Distinct scales and nonreduced length

Let d(lambda) be the discriminant of the normalized finite algebra
over the affine scale line, and let j(lambda) generate the index of
the monogenic plane order. Discriminants change by the square of the
lattice determinant, so the polynomial discriminant D in x is d*j2.
The product d*j has degree at most
\[
(2g+211)+(665-g)=g+876\le909.
\]
At a scale with s distinct x-values, the different contributes at least
140-r, where r counts normalization points in that fibre. The index
contributes at least r-s: reduction to the residue fields maps the
normalization quotient onto the r-dimensional product modulo the
s-dimensional image of the plane order. Thus ord(d*j)>=140-s.
A square residual has s<=70. There can therefore be at most
floor(909/70)=12 distinct square scales.

Also deg(D)<=2g+211+2(665-g)=1541. The source gives the uniform
identity lambda24 divides D. Here is a short verification of its origin.
At lambda=0 the degree10 polynomial drops to degree8, giving a factor
g2^2 in the fixed-degree resultant. Setting g2=0 then drops both the
remaining degree8 polynomial and the critical quadratic, giving a third
factor g2. This is a universal resultant identity. The new source
calculation checks that J=Norm(g2)/v has degree12 and is generically
coprime to t. Consequently R(x,0) has factor J3. Therefore R(x,0) and
its x-derivative have gcd of degree at least24. The resultant matrix
over k[[lambda]] has corank at least24 at zero, so its determinant is
divisible by lambda24. This is a coefficient identity on the integral
ratio ring and consequently holds at every specialization, not just
where the generic coprimality persists.

Let I be the normalized square ideal in k[lambda,lambda^-1]. The
universal trace-form argument gives D in I70: modulo I the monogenic
algebra is k[x]/(B2), with B monic of degree70. Its free rank70 ideal
(B)/(B2) is in the radical of the trace form. Using its monic basis
together with1,...,x69 makes70 whole rows of the trace matrix lie in I,
so its determinant lies in I70. This retains nilpotents.

Write I=(g), with g monic and g(0)!=0. Separability makes D nonzero.
Then g70 divides D/lambda24, whose degree is at most1517. Therefore
deg(g)<=21, which is exactly the length of the scale scheme. This is
not a bound on the number of ratio pairs or on their residue degrees.

The [independent focused audit](../../Research/audits/ROOT9_CRITICAL_SCALE_BUDGET_2026_09_29.md)
passed the local-pole, normalization-index and nonreduced trace-form
arguments. It did not replay the accepted source certificates.

The remaining fixed-content ratios and the primitive global square
decision are open. Neither bound supplies the original two-map common
cover or a contradiction to its existence.
