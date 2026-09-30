# Proof: the actual root grids and the degree92 cutoff

Retain the actual notation of the
[pole-shortening theorem](../../Theorems/cartier_and_spin/klein_four_pole_shortening.md).
Put m=j1+2j2, the number of triple common-pole points. Then
\[
n=12+a+3m,\quad g\le85,\quad g\le27+2(j_1+j_2)\le27+2m.
\]

## Common root divisors

Let Z_A and Z_P be the reduced finite root divisors of A and P,
of degrees4 and10. Since both endpoint maps are unramified above
Z_A, the A-identity gives a common reduced divisor C_A with
\[
u^*Z_A=C_A+D_0,\quad v^*Z_A=C_A+D_\infty,\quad M=\deg C_A=4n-4.
\]
Let F_u,F_v be the finite index-three P-root ramification divisors.
They are disjoint. At a hypothetical intersection both endpoints
would be constant through order two, so the A-identity would force
t-t(p) to have order at least three. A V4 inertia group has order
at most two, a contradiction. Cancellation only increases the order.

Riemann--Hurwitz gives deg F_u=deg F_v=g+n-5-m. The identity
P(v)/P(u)=r^3 then identifies the index-one P-root points on both
sides. Thus a common reduced divisor C_P satisfies
\[
u^*Z_P=C_P+3F_u,\quad v^*Z_P=C_P+3F_v,\quad
N=\deg C_P=7n-3g+15+3m.
\]
Both divisors consist of points where u and v are local parameters.
They and the common poles have disjoint supports.

## Singularity and diagonal inequalities

The integral image of (u,v) in P1 x P1 has bidegree(n,n), arithmetic
genus(n-1)^2 and normalization S, since L=k(u,v). Write x_ab for
its number of branches at an A-root pair and y_ab at a P-root pair.
Their totals are M,N. Distinct branches contribute at least one
intersection multiplicity each, giving sum binom(x_ab,2) and
sum binom(y_ab,2) as lower bounds for these delta invariants.

At (infinity,infinity) the total multiplicity is n-12. The first
blowup contributes binom(n-12,2). Every triple common-pole branch
remains singular after this blowup: local coordinates 1/u and
v/u-epsilon*c^4 have orders3 and at least2. The latter follows
from ord(t-c)=2 and ord((v-epsilon*t^4*u)/u)=2. Thus its further
delta contribution is at least one. Consequently
\[
g+\binom{n-12}{2}+m+
\sum\binom{x_{ab}}2+\sum\binom{y_{ab}}2\le(n-1)^2. \tag{1}
\]
These facts follow from the normalization exact sequence and the
genus drop binom(r,2) under blowup of a multiplicity-r plane curve;
they hold in characteristic five.

Let d_A,d_P count the diagonal branches in the two grids. All are
zeros of the same nonzero function u-v. Its pole degree is at most
n+12, hence
\[
d_A+d_P\le n+12. \tag{2}
\]
This is a same-source constraint, not an inequality for independently
chosen covers or root grids.

## Two exact integer certificates

For integers z,q>=0,
\[
\binom z2\ge qz-q(q+1)/2,
\]
because the difference is (z-q)(z-q-1)/2. Apply this to the four
diagonal and twelve off-diagonal A entries, and the ten diagonal
and ninety off-diagonal P entries.

With respective q-values20,23,2,5, the constant total is5532.
Using(2), the grid contribution in(1) is at least
89n+5N-5660. Substitution gives
\[
14g-16m\ge R_1(n)=(-n^2+227n-11016)/2. \tag{3}
\]
The genus bounds give14g-16m<=726: use378+12m for m<=29
and1190-16m for m>=29. For94<=n<=133 the concave R1 is at
least743. For n=92, m<=26 gives the sharper upper bound690,
whereas R1=702. For n=93, m<=27 gives702 whereas R1=723.
This excludes92..133.

With q-values29,34,3,8 the constant total is12180 and the grid
contribution is at least131n+8N-12376. Now
\[
23g-25m\ge R_2(n)=(-n^2+353n-24358)/2. \tag{4}
\]
The genus bounds imply23g-25m<=1230. On111<=n<=182 the
concave R2 is at least min(1252,3382)>1230. This excludes
111..182 and completes the entire92..182 interval.

At n=91, (3) has right side680. If m<=25, its left side is
at most378+12*25=678. Therefore m=26; the same inequality forces
g>=79, whereas g<=27+2m=79. Equality forces j=m, hence j2=0,
j1=26. The identity91=12+a+78 gives a=s=1 and e=27. This
proves the stated profile without relying on profile enumeration.

## Evidence and limits

The incoming theoretical argument is retained at
`../../../litt3-computation-data/overnight_three_replies_20260926/klein/klein_four_further/prior/REPORT.md`.
All eleven archived Klein-four verification commands passed locally,
including arithmetic, complete root spectra and redundant profile checks.
The proof above needs no numerical certificate of its own.

It proves neither emptiness at91 nor emptiness in14..90. Both actual
endpoint maps and the cubic reconstruction are retained throughout.
