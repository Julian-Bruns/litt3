# Split-root jets forbid low-order vertical derivative content

Version2,30 September2026. The same argument allows deg S=p-1;
it therefore also covers vertical content in the cubic-derivative
degree-ten sector. No new enumeration is used.
[Statement](../../Theorems/cartier_and_spin/split_source_vertical_flatness.md).
Write phi=W^p+q. Because bar S'=0 and deg S<p, the reduction of S
is constant. Thus
\[
F_0=(W-c_1)^p(W-c_2)^p=D(W)^p,
\qquad D=(W-c_1)(W-c_2).
\]
The two c_i may coincide. Neither is a root of bar phi: substituting
such a root into F0 would give the nonzero value bar tau. Consequently
D and bar phi are coprime.

Expand F=F0+sum_(j>=1) r^j F_j in k[W][[r]]. The leading coefficient
is exactly one, so deg F_j<2p for j>0. The split-root hypothesis gives
\[
D^{p-j}\mid F_j\qquad(1\le j<p).
\tag{1}
\]
Indeed split the roots into the p roots reducing to c1 and the p
reducing to c2. To contribute order r^j, a term can use nonconstant
parts from at most j linear factors. At least p-j factors W-ci remain
from each group. If c1=c2, this reasoning still holds, and in fact
gives the stronger factor (W-c1)^(2p-j).

Suppose s is the first index for which F_s is nonzero and
1<=s<(p+1)/2. The identity F'=phi*S' and the vanishing of all earlier
F_j imply recursively that all earlier coefficients of S' vanish.
Therefore
\[
F_s'=\bar\phi\,S_s',\qquad \deg F_s'\le2p-2.
\tag{2}
\]
If F_s' were nonzero, (1) would make it divisible by D^(p-s-1),
which is coprime to bar phi. Its degree would be at least
\[
p+2(p-s-1)=3p-2s-2>2p-2,
\]
contradicting (2). Hence F_s'=0. In characteristic p this means
F_s belongs to k[W^p]; since deg F_s<2p, it has degree at most p.
But (1) gives a nonzero factor of degree 2(p-s)>p. This is again
impossible. Thus F-F0 is divisible by r^((p+1)/2). Equation F'=phi*S'
then gives the same divisibility for S', since phi is monic and has
nonzero reduction.

If c1=c2=c, apply the stronger divisibility after (1). For a first
nonzero coefficient at any 1<=s<p, its derivative is divisible by
(W-c)^(2p-s-1) and by the coprime bar phi. A nonzero derivative would
have degree at least 3p-s-1>2p-2. A zero derivative again forces
degree at most p, whereas F_s is divisible by (W-c)^(2p-s) of degree
greater than p. This proves the r^p improvement.

For S=dW^4+aW^3+bW^2+cW+e in characteristic five, the coefficients
4d,3a,2b,c of S' have the same r-adic orders as d,a,b,c. The theorem gives
a uniform jet test at every vertical derivative point where the actual
roots and the original source frame are integral and tau is a unit.
It does not authorize discarding a nonintegral marked chart or a zero
of tau. These qualifications preserve the actual finite-etale source.

No numerical calculation is needed for this proof. A next application
is to intersect the coefficient locus with these forced higher-order
vanishings before computing a large square-norm locus.
