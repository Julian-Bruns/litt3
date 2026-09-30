# Proof: exclusion of every uniform quotient of the new-line tensor

Version2 retains the complete necessary-profile calculation and adds
the returned local inertia obstruction. The etale Galois-closure
hypothesis is essential and is kept throughout.

Write N=deg phi. If C has positive genus, pullback of its Jacobian
has finite kernel and nonzero image in the geometrically simple
J(X). Thus its genus is9. Separable Hurwitz forces N=1. Hence
a nontrivial quotient has rational coarse curve.

Because the Galois closure is etale over X, the completed extension
at a point above a branch value is Galois, and every point of that
fiber has the same index e and different delta. Let r be the order
of s downstairs and m_x the order of tau upstairs. Then
\[
m_x=e r+13\delta,\qquad m_x\in\{0,16\}.
\tag{1}
\]
For a tame branch, delta=e-1, so e divides m_x+13. The only
possibilities are e=13,m_x=0 or e=29,m_x=16; both have r=-12.
For wild inertia in characteristic five, delta>=e+3, since the
first positive ramification group has order at least5. Equation
(1) therefore gives r<=-14. In either case a branch value is a
pole of s.

The ramification-group formula also gives delta=e-1 mod4: every
positive group has order a power of5. Reducing (1) modulo4 yields
e(r+1)=1 mod4, so every inertia order e is odd.

Suppose s has a zero. Its fiber is unramified and contributes
N points to R, so N<=13. Nontrivial possible inertia orders
dividing N are then5 or13. If N=5, all different contributions
are multiples of4, contrary to their Hurwitz sum16+2N=26.
If N=10, they are multiples of8, contrary to the sum36. If
N=13, every different contribution is12, contrary to the sum42.
All other N<=13 have no permitted ramification, also impossible
for a genus-nine cover of P1. Thus s has no zeros.

Its poles have total order26 and each has order12 or at least14.
There are at most two. A single pole would have order26 and its
fiber would contain all R. At such a point (1) would require
13delta=26e+16, impossible modulo13. Consequently there are exactly
two poles, of orders12 and14. The first is tame, with index13
or29; the second is wild.

If the tame index were29, its entire fiber would lie in R. If the
wild fiber did not lie in R, then N=13*29=377, incompatible with
its wild index dividing N. If it also lay in R, then
N(1/29+1/e)=13, so the positive integer N/e equals377/(e+29).
The only positive divisor of377 greater than29 is377 itself;
this gives e=348, not divisible by5. Both cases are impossible.
The tame index is therefore13, its fiber avoids R, and the wild
fiber is exactly R. Counting it gives N=13e, and (1) gives
delta=(14e+16)/13. Thus e=10 mod13. Combining 5|e and e=3 mod4
from (1) at r=-14 gives e=75 mod260.

At a point of R lift to the actual geometric Galois closure
pi:W->X. The inertia group I for W->P1 has order e, because
pi is etale and the residue field is algebraically closed. It
fixes pi^*tau, whose local expression is z^16 u(z)(dz)^13,
with u a unit. If sigma(z)=a_sigma z+O(z^2), comparison of
leading coefficients gives a_sigma^29=1.

The kernel of I->k^*, sigma->a_sigma, is a five-group. Indeed,
a nonidentity finite automorphism tangent to the identity cannot
have order prime to five: its first nonidentity coefficient in
the r-fold iterate is multiplied by r. Cauchy's theorem then
excludes every prime other than five from the kernel order.
The image has order prime to five and is cyclic. Thus, writing
e=5^s h with 5 not dividing h, one has h dividing29. Both
5 and29 are1 mod4, so e=1 mod4. This contradicts e=75 mod260.
The nontrivial quotient cannot exist.

For clarity, the useful primitive parametrization of the impossible
profile is retained below. It explains why a tensor identity alone
would not certify the required local Galois condition.

Choose coordinate t with the tame value0 and wild value infinity.
Then s is a constant multiple of (dt)^13/t^12. For a tensor
comparison write
\[
(dt)^{13}/t^{12}=c\,(df)^{13}/A^{10}.
\]
Set z=t\,df/dt, a rational function since phi is separating.
Then z^13=c^-1 t A^10. Differentiation gives dz=df/3, hence
3z=f+b^5 for some b. Substitution gives the asserted form of t
up to a constant. Conversely direct differentiation of that form
gives (dt)^13/t^12=3^13 tau, for any b; d(A^-10)=d(b^5)=0.

At a finite R-point, ord A=1 and ord df=2. If t has a pole there,
F=f+b^5 is either a unit or has a pole of order divisible by5.
Writing that order5m, including m=0, gives e=65m+10. At O,
ord A=-12 and ord df=-8. The order of F is either -7 or -5j
with j>=2. The first would make t vanish, whereas this point is
in its wild pole fiber. Thus e=65j-120 and j=m+2. No other pole
of F is permitted, since t has no other pole. This proves the
pole-divisor statement. It supplies no uniform bound on m and
does not replace the local Galois-closure condition by the tensor
identity that holds for every b.
