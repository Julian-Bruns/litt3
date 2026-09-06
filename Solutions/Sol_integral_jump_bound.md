# Proof record: Integral wild-subgroup jumps bound atlas degree

Canonical statement: [`integral_jump_bound`](../Theorems/Thm_integral_jump_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Integral wild jumps force a genus-dependent atlas degree bound

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/integral_jump_degree_bound_audit, 2026-09-06, including a separate
valuation-based enumeration of the complete search tree.
[Audit record](../routes/global/audits/INTEGRAL_WILD_JUMP_DEGREE_BOUND_AUDIT_2026_09_06.md).

## Theorem and scope

Let a smooth projective curve X, with h=2g(X)-2>0 in characteristic
p>=3, be a finite etale atlas of degree n of an effective proper
orbifold with coarse curve P1 and exactly two branch points, one wild
and one tame. At the wild point write

    e=q t,  q=|I_1| a power of p,  p does not divide t,
    c=delta-e,  0<c<e.

Assume that the upper jumps of the local P=I_1 extension are INTEGERS.
Here the extension is L/L^P, not L/L^I; confusing these two upper
numberings would change the hypothesis. Then n has an effectively
computable bound depending only on h and p.

For p=5,h=16 there cannot be more than one positive jump under this
hypothesis. Consequently q=5 and n<=2240, by the retained
[single-jump theorem](../routes/global/TWO_BRANCH_SINGLE_JUMP_ORBIFOLD_ATLASES_ARE_DEGREE_BOUNDED.md).

The hypothesis holds whenever P is abelian, by Hasse--Arf. No assumption
that the whole inertia group, the global monodromy, or the atlas itself
is abelian or Galois is made. In particular a jointly minimal CORED
common-cover candidate for the fixed genus9/genus25 pair with M>2240
must have a NONINTEGRAL upper jump of its wild-subgroup extension, and
thus nonabelian wild inertia. Coreless candidates are not addressed.

## 1. Ramification data without character assumptions

Use the notation of the single-jump theorem:

    t=g0 t0,  m=g0 m0,  gcd(t0,m0)=1,
    n=(h/D) q g0 t0 m0,  D|h,
    c m0-q t0=D,  t|(c+1).                            (1)

Here m is the inertia order at the other, tame branch point and
p does not divide g0 t0 m0. The congruence follows by linearizing a tame
complement on a local uniformizer and applying it to the leading term
of an invariant differential. In particular t0|(m0+D), by (1).

Let the positive upper jumps of P be

    1<=u_1<...<u_r,

and put [P:P^(u_i+)]=p^a_i, with 0=a_0<a_1<...<a_r=a and q=p^a.
The lower filtration of P is the positive lower filtration of I. The
different formula and the definition of the Herbrand function give

    c+1 = sum_i (p^a_i-p^a_(i-1)) u_i
        = q u_r-u_1-sum_(i<r) (u_(i+1)-u_i) p^a_i.    (2)

For clarity, a lower interval corresponding to the upper interval
(u_i,u_(i+1)] has length p^a_i (u_(i+1)-u_i), and its group has
order q/p^a_i. Thus its contribution to the positive different sum is
(q-p^a_i)(u_(i+1)-u_i). Adding (q-1)u_1 proves (2).
This calculation does NOT require P abelian or a character decomposition.

If r=1, (2) is exactly the already proved single-jump case. Assume r>=2.
Then q>=p^2 and, since the jumps are distinct positive integers,

    c >= (2-1/p)q-2.                                  (3)

More generally, putting U=u_r gives

    c+1 >= ((p-1)U+1)q/p-1.                           (4)

Indeed, if A is the last coefficient in (2)'s first expression, then
A>=q-q/p and all coefficients sum to q-1. Their weighted sum is at
least AU+(q-1-A)=q-1+A(U-1), which proves (4).

## 2. A bounded-q case and the finite small-side ranges

If m0>=t0, (1) and (3) imply

    D >= c-q >= (p-1)q/p-2,
    q <= p(D+2)/(p-1).                                (5)

Bounded q alone suffices to bound all variables. Namely c>=q-2 and
t0<=c+1 give

    m0<=q+(q+D)/(q-2).

Writing v=(c+1)/t0>=1 in (1) gives

    c=(q+vD)/(v m0-q),  v m0>q.

For fixed m0 the right side decreases with v; the least allowed integer
v is at most q+1. Hence c<=q+(q+1)D. Then t0 and g0 are bounded divisors
of c+1, completing this case.

Now suppose m0<t0. Put w=(m0+D)/t0, a positive integer. If w>=2 then
m0<D. If w=1, (1) gives

    (c-q)m0=D(q+1).

Using (3), q>=p^2, and the decreasing function
(q+1)/((p-1)q/p-2) gives the uniform bounds

    m0 <= M(D,p) := floor[D(p^2+1)/(p(p-1)-2)],
    t0 is a divisor of m0+D larger than m0.            (6)

In particular t0/m0<=1+D/m0. Combining this with (1), (4) and q>=p^2
yields

    U <= U(D,p)
      := floor[(p^2(D+1)-p+D+2)/(p(p-1))].             (7)

Explicitly ((p-1)U+1)<=p t0/m0+p(D+2m0)/(m0 q), and the right side
is at most p(D+1)+(D+2)/p. There is no bound on the rank a assumed here.

## 3. Exact carry recursion bounds the rank too

Fix D,m0,t0,u_1 in the finite ranges (6)--(7). Write
E=m0(u_1+1)+D. Substituting (2) in (1) gives

    p^a(u_r m0-t0)
       = E + m0 sum_(i<r) (u_(i+1)-u_i) p^a_i.        (8)

The following finite tree enumerates all solutions, without a rank cutoff.
Necessarily p|E. Start at rank n=1, current jump u=u_1, carry R=E/p.
At a state (n,u,R), one can end at total rank a=n precisely when
R=u m0-t0. Alternatively choose an integer Delta with

    0<=Delta<=U(D,p)-u,  p|(R+m0 Delta),

and pass to (n+1,u+Delta,(R+m0 Delta)/p). A positive Delta records a
jump change at cumulative rank n; Delta=0 records no change. For the
multi-jump branch keep only endpoints with at least one positive change.
Successive division of (8) by p proves completeness in both directions.

The tree is finite: carries are positive; a zero-change step divides
the carry by p; a positive change strictly increases the bounded u.
For an explicit uniform bound set B=2m0 U(D,p)+D. Every carry is <=B:
this holds initially and follows inductively from
(R+m0 Delta)/p<=(B+B)/p<=B. There are at most U(D,p)-1 positive changes,
and each run of zero changes has length at most floor(log_p B).
Therefore

    a <= U(D,p)(1+floor(log_p B)).                     (9)

Thus q is bounded in this case also. The bounds from Section 2 then
bound c,t0,g0,n. This proves the parameterized theorem.

## 4. The complete genus-nine calculation

For p=5,h=16, (5) would give q<=22.5, contradicting q>=25. Thus every
multi-jump candidate belongs to (6)--(8). The finite ranges are

    D:       1  2  4   8  16
    M(D,5):  1  2  5  11  23
    U(D,5):  2  3  6  11  21.

The [standard-library certificate](../routes/global/INTEGRAL_WILD_JUMP_CARRY_CERTIFICATE.py)
visits 1351 states, with no truncation in rank or jump count. It finds
exactly one multi-jump tuple (D,m0,t0,q; (a_i,u_i); c):

    (8,1,3,25; ((1,1),(2,4)); 83).                    (10)

This is only a necessary numerical tuple, and it is NOT locally realizable.
Its first upper jump is 1 and [P:P^(1+)]=5. Hence its first lower jump
is also 1, and |I_1/I_2|=5. Choose a local uniformizer z linearizing
the tame complement as z->zeta z, where zeta has order t. The map

    I_1/I_2 -> k,  gamma(z)=z+b_gamma z^2+O(z^3)
                         -> b_gamma

embeds it as a one-dimensional F_5 vector subspace. Conjugation by the
tame generator multiplies b_gamma by zeta or zeta^(-1), depending on
the conjugation convention. Stability of a nonzero one-dimensional
F_5 space implies zeta belongs to F_5^*, and so t|4. But t is a multiple
of t0=3 in (10), a contradiction. All multi-jump possibilities are excluded.

## References and boundary

For lower/upper numbering, subgroup compatibility, and the precise
generality of Hasse--Arf, see
[Kedlaya, Class field theory, Section 4.4, especially Remark 4.4.13](https://kskedlaya.org/cft/sec_filtration.html).
Only the integrality consequence of Hasse--Arf is external to the
elementary filtration calculations above.

Fractional upper jumps are genuinely possible: the wild group of a
Hermitian curve has jumps 1 and 1+1/Q, with order Q^3, Q a power of p.
Thus replacing the integral jumps by arbitrary positive rational numbers
would invalidate (3), (6), and the finite carry argument. No general
bound in that remaining case is claimed.
