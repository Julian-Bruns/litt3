# Small phase packets exclude reciprocal scalar classes

27 September2026. Put B=F25,E=F_(5^8),K0=F_(5^14), and retain the
fixed root Fourier coefficients from the quadratic-scalar proof.
Because E and K0 are linearly disjoint over B, the same projection
argument works for ANY lambda in K0*, not only lambda in B. Thus
lambda U_L+V_L in K0 implies
\[
S_3(17)=0,\quad
\lambda S_1(17)=[10]S_1(4),\quad
\lambda S_2(17)=[18]S_2(4).
\tag{1}
\]
Here S_l(r)=sum_j(sum_i 2^(li)m_ij)xi^(rj), and m_ij are integer
label multiplicities. Prime-field independence of every at most
nine distinct phases makes the first equation phasewise:
\[
m_{0j}+3m_{1j}+4m_{2j}+2m_{3j}=0\pmod5.
\tag{2}
\]
Each occupied phase therefore contains at least two labels; there
are at most four occupied phases at cardinality eight or nine.

## Complete small enumeration

Call a nonzero nonnegative vector v=(m0,m1,m2,m3) satisfying(2)
a packet. Keep every packet of total weight at most the cardinality,
including fifth-multiple vectors. Enumerate ordered packet lists whose
total weight is exactly eight or nine. Assign distinct increasing phases
to their entries, with the first phase zero. This retains all endpoints
up to a common phase shift; packets are not permuted or identified.
There are98 possible packets through weight eight and142 through nine.

For each list and phases, compute the four sums in the last two
equations(1). If either denominator is nonzero it determines lambda;
the other equation is then checked exactly. If both denominators and
both numerators vanish, retain a FREE-scalar endpoint separately.
No division by a zero sum is performed.

A common phase shift s replaces lambda by xi^(-13s)lambda. Since
13 is coprime to29, all shifts are accounted for by the class
lambda^29. Let C_m be the set of these classes from nonfree
cardinality-m endpoints. Complete results are

| Cardinality | Normalized endpoints | Free endpoints | Nonfree memberships | Distinct classes | Classes whose reciprocal also occurs |
| ---: | ---: | ---: | ---: | ---: | ---: |
|8|126,341|29|66,704|8,122|0|
|9|635,980|228|19,500|30|0|

These are exact finite coefficient exhaustions, not samples of scalars.
At the two endpoints the membership scalars are epsilon and epsilon^-1.
If both are nonfree, their29th powers must be reciprocal members
of C_m. The final column excludes this possibility.

## The free endpoints are also excluded

For a free endpoint, all three nonconstant Fourier sums vanish.
Prime-field phase independence implies that the four root counts at
every phase agree modulo five. Cardinality eight then consists of
two complete four-root blocks. Cardinality nine consists of one such
block and a fivefold singleton, whose four field sums are zero.

Suppose one endpoint is free and epsilon belongs to K0. Its C and E
sums lie in K0, so the two old moment equations put the other endpoint's
C and E sums in K0 too. All three nonconstant Fourier projections of
the c-row are nonzero; phase independence forces the other endpoint
to be free as well. The double-block eight-label system was completely
excluded in the all-scalar norm calculation. At cardinality nine,
removing only the zero FIELD contributions leaves the already excluded
one-block four-label system. This does not remove actual divisor points.

## Independent arithmetic and coverage

The [absolute-field producer](../../scripts/arithmetic/uniform_eight_k0_membership.py)
uses Sage10.9, the degree14 F5 polynomial and the explicit embedded beta.
Run with --mass8 or --mass9 (with a space before the number) and an
external --output path. The
[relative-field verifier](../../scripts/arithmetic/verify_uniform_eight_k0_membership.cpp)
uses seven F25 coordinates, explicit polynomial multiplication and
inversion, and a different recursion for packet lists. Its arguments
8 and9 repeat the whole domain independently. Every field key records
all coordinates injectively; no probabilistic fingerprint decides equality.

The evidence is general8_absolute.json,general9_absolute.json and
general8.log,general9.log in
[the external directory](../../../litt3-computation-data/uniform_eight_k0_20260927/).
The original uniform profile(2,2,2,2) is a separately retained check:
29,149 normalized endpoints,24,360 nonfree memberships,2,849 classes,
and no reciprocal pair. In that smaller profile all nonfree memberships
are half-turn invariant. The general eight-label enumeration has FOUR
non-half-turn exceptions, which were retained; the general theorem does
not assume that intermediate stronger assertion.

The only earlier arithmetic inputs are the fixed Fourier projections
and the complete prime-field rank bounds8 and9. The final step uses
the proved balanced four- and eight-label trace exclusions. No cubic
quotient, Galois closure or integer common-pole weight assumption enters.
