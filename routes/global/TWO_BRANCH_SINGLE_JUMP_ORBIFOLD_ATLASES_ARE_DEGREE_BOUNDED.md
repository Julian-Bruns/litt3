# A genus bound for two-branch atlases with one wild ramification jump

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/cored_single_jump_degree_bound_audit, 2026-09-06, including an
independent enumeration of all24 full tuples.
[Audit record](audits/CORED_SINGLE_JUMP_DEGREE_BOUND_AUDIT_2026_09_06.md).
This bounds an entire ramification
class, not the full common-cover problem.

## Theorem

Let X be a smooth projective curve of genus>=2 over an algebraically
closed field of characteristic p>=3. Suppose X is a finite etale atlas,
of degree n, of an effective proper orbifold with coarse curve P1 and
exactly two branch points: one wild, one tame. Put h=2g(X)-2.

At the wild point let the inertia order be e=q t, where q=|I_1| is a
power of p and t is prime to p, and put c=delta-e. Assume 0<c<e and

    c=j(q-1)-1 for some positive integer j.             (1)

In particular (1) holds if the positive lower ramification filtration
has only ONE jump: I_1=...=I_j and I_(j+1)=1.

Then q<=(h+2)^2. Moreover all possible n lie in an explicitly enumerable
finite set depending only on h and p. For p=5,h=16, the necessary
conditions below give

    q=5,        n<=2240.                               (2)

These are necessary numerical possibilities, not a claim that every
entry is realized by a global cover. No Galois assumption on X over
the orbifold is made.

## 1. Integral variables and the tame congruence

Let m be the tame inertia order at the other branch point. Uniform
ramification of an etale atlas gives e|n and m|n. Hurwitz is

    h=n(c/e-1/m)>0.                                    (3)

Let g0=gcd(t,m)=gcd(e,m), t=g0 t0, m=g0 m0. Thus
gcd(t0,m0)=1 and p does not divide g0 t0 m0. Write
n=N lcm(e,m). Then

    D=h/N=c m0-q t0>0,       D|h.                      (4)

There is also the local congruence

    t | delta+1, hence t | c+1=j(q-1).                 (5)

Indeed choose a tame complement of order t in the inertia group and a
uniformizer z which linearizes it as z->zeta z. The pullback of a base
uniformizer differential is invariant and has leading term a z^delta dz.
Its leading character is zeta^(delta+1), proving (5). Linearization is
obtained by averaging a uniformizer with its desired character; t is
invertible. This does NOT assume t|q-1: a tame subgroup can centralize
part of the wild group, so that stronger assertion would be false.

## 2. The quadratic-in-genus bound on q

Substitute(1) into(4), and put l=j m0-t0. Then

    q l=(j+1)m0+D,

so l is a positive integer. By (5), t0 divides j(q-1). Multiplying by
l and using j m0=t0+l shows

    t0 | l+jD.

Write R=(l+jD)/t0>=1. Substituting t0=j m0-l gives

    j(Rm0-D)=l(R+1),

so Rm0-D>=1 and

    j/l=(R+1)/(Rm0-D)<=D+2.                           (6)

For R<=D+1 the numerator is at most D+2. For R>=D+1 use
Rm0-D>=R-D and (R+1)/(R-D)<=D+2. This proves the inequality.

Also t0<=l+jD gives m0<=D+2l/j. Consequently

    q=((j+1)m0+D)/l
      <=D(j/l)+2D/l+2+2/j
      <=D(D+2)+2D+4=(D+2)^2<=(h+2)^2.                 (7)

No enumeration or classification of finite groups enters this bound.

## 3. Explicit finite bounds on every remaining variable

Since t0|c+1 and c>=q-2, equation(4) gives

    m0<=q+(q+D)/(q-2).                                (8)

Here and below a rational upper bound may be rounded down. To bound j,
write u=(c+1)/t0=j(q-1)/t0. Equation(4) becomes

    j(q-1)(u m0-q)=u(m0+D).

Thus u m0>q. The function u/(u m0-q) decreases on that range; its
largest integer-argument value is at u=floor(q/m0)+1 and is at most
q+1. Therefore

    j <= (m0+D)(q+1)/(q-1).                           (9)

After q,D,j are bounded, t0 ranges over divisors of c+1; equation(4)
determines m0. Finally g0 ranges over divisors of (c+1)/t0, by (5),
with p not dividing g0 and c<q g0 t0. The degree is exactly

    n=(h/D) q g0 t0 m0.                               (10)

This is a complete finite sieve of necessary conditions. Extra local
ramification constraints can only remove possibilities.

## 4. Exact genus-nine specialization

The [standard-library certificate](TWO_BRANCH_SINGLE_JUMP_SIGNATURE_CERTIFICATE.py)
enumerates precisely the finite ranges proved above. For h16,p5,
equation(7) leaves q=5,25,125. The latter two have no entries. The nine
reduced tuples (j,t0,m0,D), with maximum n over allowed g0, are

    (1,4,7,1):2240     (2,4,3,1):1920     (3,2,1,1):960
    (1,1,2,1):640      (2,1,1,2):320      (1,1,3,4):240
    (6,3,1,8):240      (1,1,7,16):140     (2,1,3,16):120.

The certificate permits every positive j in the proved range, even if
some further ramification theorem would exclude it. Thus it does not
silently rely on a conductor-primality hypothesis.

Combined with the [cored signature reduction](CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md),
a jointly minimal cored candidate for the fixed pair with M>2240 MUST
have a two-branch common orbifold whose wild different does NOT satisfy
(1). In particular it must have MORE THAN ONE positive ramification
jump. The coreless cases are unaffected by this assertion.

Multiple jumps are a genuine separate issue: (5) still holds, but (1)
can fail, and it is exactly (1) that allowed the positive-integer l and
the genus bound. A formal multi-jump proposal must also satisfy local
realizability constraints, such as Hasse--Arf in the abelian case;
arbitrary decreasing lists of p-group orders are not enough.
