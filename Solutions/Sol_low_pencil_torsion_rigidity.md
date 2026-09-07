# Proof: Galois pencil rigidity and mixed-primary Frobenius orbits

[Statement](../Theorems/Thm_low_pencil_torsion_rigidity.md).
Author /root,2026-09-07; no independent audit yet.

## 1. Effective representatives and a free-divisor calculation

If distinct effective degree-r divisors are equivalent, their ratio
function has degree at most r and therefore belongs to k(x). Every
nonconstant function in k(x) has degree a positive multiple of n.
Since r<=n, equality r=n is forced and both divisors are full fibers.
They are linearly equivalent to nO, so the class in W_r is zero.
The same argument compares any moving zero-class divisor with rO.

Take nonzero alpha=[D-rO] with (gamma-1)^2 alpha=0. Since gamma fixes O,
the divisor

       gamma^2 D-2gamma D+D

is principal. Its associated function has degree at most 2r, hence
belongs to k(x). Its divisor is invariant under every h in G. Since
gamma commutes with h,

       (gamma-1)^2(h-1)D=0

in the FREE abelian divisor group. The finitely many gamma translates
of (h-1)D span a rational vector space on which gamma has finite order.
Its minimal polynomial divides T^a-1 for some a and is squarefree in
characteristic zero. Thus (gamma-1)(h-1)D=0. This use of characteristic
zero is on the rationalized free divisor group, not on C.

Consequently gamma D-D is G-invariant. Its coefficients vanish at all
ramification points, since gamma fixes each such point. Any nonzero
positive or negative part is therefore a sum of unramified G-orbits,
each of cardinality n. Their degrees are at most r<=n. If r<n both
parts vanish. If r=n, a nonzero difference forces D and gamma D to be
disjoint full unramified fibers, which would make alpha zero. Thus
gamma D=D in all cases under consideration. The case alpha=0 is trivial.

This argument allows wild ramification and partial inertia: those
points were fixed individually, not counted as free orbits.

## 2. Isolate a primary component without changing the effective class

Put gamma=pi^N and write a torsion class alpha in W_r as sum alpha_ell.
On T_ell J the assumptions give gamma=I modulo ell, or modulo4 at2.
The gamma-orbit length d_ell of alpha_ell is consequently an ell-power.
If some alpha_ell moves, put m=product_(j!=ell)d_j and tau=gamma^m.
Then tau fixes every other primary component, and still moves alpha_ell
because m is prime to ell. Let Q=(tau-I)alpha_ell have exact order ell^s.

For a=ell^(s-1), expand

       tau^a-I=a(tau-I)E,
       E=I+sum_(j=2)^a [binomial(a,j)/a](tau-I)^(j-1).

The inequality v_ell(binomial(a,j)/a)>=-v_ell(j) shows E is integral
and congruent to I modulo ell. For odd ell use j-1-v_ell(j)>=1;
at2 use 2(j-1)-v_2(j)>=1 and the modulus4 hypothesis. Thus E is
invertible, commutes with tau, and acts on the ell-primary torsion.
The FULL class alpha now satisfies, for sigma=tau^a,

       (sigma-I)alpha=ell^(s-1)EQ!=0,
       (sigma-I)^2 alpha=0.

The first difference has order ell and is fixed by sigma, since gamma
fixes J[ell]. Every power of gamma still fixes the ramification points
and commutes with G. Section1 contradicts the two displayed assertions.
Hence all primary components are fixed and gamma alpha=alpha.

This is the elementary mixed-primary translation argument used in the
[audited cubic proof](Sol_cyclic_cubic_low_abel_torsion.md), Section5;
no effectiveness of any alpha_ell was assumed. The torsion classes lie
in the finite group J(F_(q^N)); its order gives a valid exponent bound.
Uniqueness of a nonzero class's representative then descends the divisor.
For r=n, zero-class full fibers may still move; no finite-divisor claim
is made for that class. An admissible N exists after a finite constant
extension because the indicated prime-to-characteristic torsion is finite.

## 3. The prime-degree trace-bundle bound

Suppose x has prime degree n invertible in k, and f is outside k(x),
of degree e. The extension k(C)/k(x) has no intermediate field, so
k(x,f)=k(C). Thus (x,f) is birational onto a curve Gamma in P1 x P1
of bidegree (e,n). Its first projection is finite flat of degree n.
Pushing forward its divisor sequence gives

       0 -> O_P1 -> x_*O_Gamma -> O_P1(-e)^(n-1) -> 0.

The trace splits the unit since n is invertible. Thus the trace-zero
part of x_*O_Gamma is O(-e)^(n-1). Normalization induces an injection
of trace-zero bundles, generically of full rank,

       O(-e)^(n-1) -> direct_sum_i O(-b_i).

If e<max_i b_i, every map to one of the maximal-b_i summands is zero,
so the injection is not generically full-rank, a contradiction.
For a hyperelliptic double cover the trace-zero line is O(-g-1),
which gives the final specialization.

This is a reusable low-divisor criterion, not a proof about arbitrary
degree divisors or arbitrary common covers. Its finite prime-support
bound may be too large to enumerate. No finite Galois envelope for a
two-leg span has been introduced.
