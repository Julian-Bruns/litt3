# Bounded wild-jump denominators bound two-branch atlas degrees

Author: /root, 2026-09-06. Status: author proof, not independently audited.
This generalizes the finiteness mechanism of the checked
[integral-jump theorem](../../Theorems/Thm_integral_jump_bound.md).
That theorem and its sharper genus-nine certificate remain relevant.

## Theorem

Fix p>=3, h>0, and an integer L>=1. In the two-branch orbifold atlas
setting of the integral-jump theorem, assume that every positive upper
jump of the wild-subgroup extension L_local/L_local^(I_1) belongs to
(1/L)Z. Then the atlas degree n is effectively bounded in terms of p,h,L.

Consequently, an unbounded sequence of jointly minimal cored candidates
for the fixed genus9/genus25 pair would require unbounded upper-jump
denominators. The dimensions of their largest complex irreducible wild-inertia
representations, and the minimum indices of their abelian subgroups,
would also be unbounded. This is a necessary-complexity conclusion,
not a proof that any such sequence exists or a bound for coreless spans.

## 1. All ramification conventions retained

Write q=|P|=p^a, P=I_1, e=qt, c=delta-e, 0<c<e. As in the checked
theorem, the genus equation and the tame congruence give

    c m-q t0=D,  D|h,  gcd(m,t0)=1,
    t0|(c+1), hence t0|(m+D),
    n=(h/D)q g0 t0 m,  g0|(c+1)/t0.                  (1)

Here m is the REDUCED tame order (called m0 in the earlier notes).
All m,t0,g0 are prime to p. If the wild extension has one positive
jump, the single-jump theorem already applies; its first upper jump
equals its first lower jump and is an integer. Assume at least two.
Then q>=p^2. Let the upper jumps be u_1<...<u_r and let

    0=a_0<a_1<...<a_r=a,  [P:P^(u_i+)]=p^a_i.

The Herbrand/different calculation, valid also for fractional jumps, is

    c+1=sum_i(p^a_i-p^a_(i-1))u_i.                    (2)

Since u_1>=1 and u_r>=1+1/L, it follows that

    c-q >= (p-1)q/(pL)-2.                            (3)

For U=u_r, the same weighted-sum argument gives

    c+1 >= ((p-1)U+1)q/p-1.                          (4)

## 2. Finite ranges without bounding the group order first

The region q<=max(p^2,4pL/(p-1)) is finite. For any fixed q, equation
(1) alone bounds the remaining variables, by the checked theorem's
bounded-q argument:

    m<=q+(q+D)/(q-2),  c<=q+(q+1)D,

followed by the divisor bounds on t0,g0. Thus assume

    q>max(p^2,4pL/(p-1)).

If m>=t0, (1) and (3) give q<=pL(D+2)/(p-1), again a finite region.
Otherwise m<t0. Set w=(m+D)/t0. If w>=2, then m<D. If w=1,

    (c-q)m=D(q+1).

The chosen lower bound on q makes (3)'s right side at least
(p-1)q/(2pL). Since q>=p^2>=9, this yields the convenient coarse bound

    m <= M := ceil[3pLD/(p-1)].                       (5)

It also covers w>=2. Now t0 is a divisor of m+D larger than m, so
t0/m<=1+D/m. Applying (1), (4), and q>=p^2 shows

    U <= [p^2(D+1)-p+D+2]/[p(p-1)].                  (6)

Notice that this is an upper bound on the jump itself, not its
denominator. The scaled jumps v_i=L u_i are therefore increasing
positive integers at most

    V := floor[L(p^2(D+1)-p+D+2)/(p(p-1))].            (7)

The first v_1 is a positive multiple of L, because the first jump is
always integral. Allowing extra integer choices would only enlarge
the necessary sieve.

## 3. The scaled carry equation is still finite

Fix the finite parameters D,m,t0,v_1. Put E=m(v_1+L)+LD. Equations
(1)--(2) are equivalent to

    p^a(v_r m-Lt0)
       =E+m sum_(i<r)(v_(i+1)-v_i)p^a_i.             (8)

The exact carry recursion of the integral-jump theorem applies without
any change except the terminal target. Necessarily p|E. Start at
(rank,current value,carry)=(1,v_1,E/p). A transition selects Delta>=0
with current value+Delta<=V and p dividing carry+m Delta, increments
the rank, and replaces the carry by (carry+m Delta)/p. Termination at
total rank a requires carry=current value*m-Lt0. At least one positive
change is required in this multijump branch.

All carries are positive. Zero-change steps strictly decrease the carry;
positive changes strictly increase a bounded integer. The tree is finite,
and successive division of (8) proves its completeness, as before.
An explicit bound follows by taking B=E+mV. Carries remain <=B, there
are at most V-1 positive changes and at most V runs of zero changes,
each of length <=floor(log_p B). Thus

    a<=V(1+floor(log_p B)).                            (9)

This bounds q in the remaining region. The bounded-q argument then
bounds c,t0,g0,n. No numerical rank cutoff or unproved local
realizability test is involved.

## 4. Representation-theoretic consequences

For a finite p-group P, each complex irreducible representation rho has
dimension a power of p. Since every upper ramification subgroup is normal,
its fixed space on rho is either zero or the whole space. Thus rho has
one upper break u(rho), and its Swan conductor is

    Sw(rho)=u(rho) dim(rho), an integer.

Every upper jump of P is the break of at least one irreducible: otherwise
the regular representation could not distinguish the two ramification
groups on the sides of that jump. Therefore every jump denominator
divides the dimension of some irreducible representation. As these
dimensions are p-powers, all denominators divide their largest dimension.
The theorem applies if that dimension has any fixed bound.

If A is an abelian subgroup of P of index at most J, restrict an arbitrary
irreducible rho to A and choose a character chi occurring in it. Frobenius
reciprocity places rho in Ind_A^P chi, which has dimension [P:A]<=J.
Thus every irreducible dimension is <=J. Again the theorem gives a bound
depending only on p,h,J. Normality of A is not needed.

The Swan integrality input is the same one already used and proved
applicable in [file 13](13_PROOF_LOCAL_RAMIFICATION.md); the basic
ramification conventions and external reference are in the checked
integral-jump theorem. There is currently NO bound on these local
representation dimensions supplied by the original two etale legs.

## 5. Complete genus-nine sieve when the denominators divide five

For h=16,p=L=5, the necessary conditions are much sharper than the coarse
general bounds. If q=5 or 25 the wild group is abelian, so the checked
integral-jump theorem leaves only the single-jump q=5 cases with n<=2240.
Assume q>=125. Equation (3) reads c-q>=4q/25-2. Thus m>=t0 would give
q<=25(D+2)/4<=112.5, impossible. In the m<t0 case the decreasing ratio
(q+1)/(4q/25-2) is at most seven, giving m<=7D.

Use the exact carry tree with these smaller ranges, and the scaled jump
limits V=12,18,31,57,109 for D=1,2,4,8,16 respectively. A memoized
calculation merges equal states, recording all possible lengths of paths
to a terminal state as a bit mask; it does not truncate any rank. The
[complete standard-library certificate](DENOMINATOR_FIVE_LOCAL_SIGNATURE_CERTIFICATE.py)
finds just six reduced tuples (D,m,t0,q,c):

    (1,1,2,125,251), (1,3,4,125,167), (1,7,8,125,143),
    (8,1,3,125,383), (8,1,3,625,1883), (8,1,3,3125,9383).

All paths giving these endpoints are then reconstructed and checked
against three necessary local conditions. Write their lower breaks as
b_i, and the cumulative index exponents as a_i.

* Every b_i is an integer. Conversion is
  b_1=u_1 and b_(i+1)-b_i=(u_(i+1)-u_i)p^a_i.
* Every b_i is congruent to the last break modulo p, and this residue is
  nonzero. Indeed an order-p element in the last ramification group has
  break prime to p. If another break had a different residue, the exact
  leading-commutator lemma of file 13 would produce a break larger than
  the last one. This contradicts maximality.
* Apply the first-break Swan divisibility of file 13 to EVERY subgroup
  P_(b_i). With e_i=a_i-a_(i-1), its excess over its first constant
  ramification interval must be divisible by p^ceil(e_i/2). Also the
  tame order divides b_i(p^e_i-1) for each i.

These filters leave precisely

    q=125, lower indices/breaks ((2,1),(3,6)),  T=24,
    q=125, lower indices/breaks ((2,1),(3,66)), T=24,

where the tame order t divides T. Restoring g0 gives the same five
necessary tuples listed in the order-p-second-group theorem, and hence

    n<=336000.                                        (10)

This specialization needs no big-action classification: the bounded-
denominator carry search and the retained elementary local filters
already supply the full necessary list. The five entries are not
asserted realizable. Combining (10) with the cored signature reduction,
M>336000 for the fixed pair requires an upper-jump denominator at least
25 (all such denominators are p-powers). This last specialization, like
the general extension in this note, is not independently audited yet.
