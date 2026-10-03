# Proof record: Frobenius localization and explicit stabilization

Canonical statement: [`frobenius_exception_sieve`](../../../Theorems/jacobians/theta_divisors/frobenius_exception_sieve.md).
## 1. Finite exceptions and symmetry orbits

Let Q/F_q have Frobenius F. A finite group Gamma of geometric group
automorphisms is Frobenius-normalized if F gamma=alpha(gamma)F
for an automorphism alpha of Gamma. This permits automorphisms
defined over extensions of F_q. For a finite Frobenius- and
Gamma-stable set B, Frobenius permutes the Gamma-orbits. If a stable
stratum has at most t orbits, every point in it therefore satisfies

    F^m(z)=gamma(z)     for some 1<=m<=t and gamma in Gamma.       (1)

Each F^m-gamma has differential -d gamma, an isomorphism. It is
therefore an isogeny with finite etale kernel, even without commutation.
Thus (1) gives a finite union of finite groups containing the stratum.

Take m minimal for return of Gamma z, and write H_z=Stab_Gamma(z).
Iteration gives

    F^(km)z=alpha^((k-1)m)(gamma)...alpha^m(gamma)gamma z.      (1a)

The field degree of z is m times the least k for which the product
in (1a) belongs to H_z. Any return of z must be a multiple of m,
which proves the assertion, including its minimality. For alpha=1
and H_z=1 this becomes m ord(gamma). In general the return time
of a point is at most the size of its finite Frobenius-stable
stratum. One must use the twisted product in (1a) when alpha≠1.

For any invariant weight w with sum_B w<=K, an orbit of size>=s
in the stratum w>=c costs at least sc. Thus there are at most
floor(K/(sc)) such orbits and floor(K/c) points. Grouping by
Frobenius orbits gives sum_z [k(z):F_q]w(z)<=K.
The [polarization theorem](polarization_bad_fiber_bound.md) supplies
w(z)=delta_z^r and K=floor(r!(p-1)^r kappa/n^h) for an actual
degree-n étale cover with finite bad scheme.

## 2. An explicit character level for any finite bad locus

For an actual degree-n étale cover f:U→Y with h=g(Y)≥2, suppose
the bad-fiber scheme is finite. Put r=(n−1)(h−1), let kappa be
the scheme degree of ker(f^(1)*), and take
K=floor(r!(p−1)^r kappa/n^h), as in the polarization theorem.
Choose an actual F_q-model of the quotient and determinant family.
Every bad geometric point has field degree at most K, so it belongs
to some Q(F_(q^j)) with 1≤j≤K and is killed by

    M_K=lcm_(1≤j≤K) |Q(F_(q^j))|.                            (1b)

When K=0 the bad locus is empty and take M_K=1. This is a finite
integer determined by the quotient's Frobenius polynomial; it need
not be a practical small search. The normalized symmetry version
of Section 1 can make the candidate set much smaller.

Choose an abelian complement P and ρ:P→Q, with e=deg ρ.
If c kills ker ρ(k), then [M_K]ρ(α)=0 implies [c M_K]α=0.
Thus every exceptional prime-to-p character lies in P[N], where
N=(c M_K)_(p'). The norm complement has c=n scheme-theoretically,
by the [norm identity](polarization_bad_fiber_bound.md), Section3;
its degree is e=(n^h/kappa)^2. An arbitrary complement admits c=e.
For K=0 there are no exceptions and choose N=1.

Every finite
prime-to-p subgroup Lambda⊂P(k) gives an actual connected étale
character cover b_Lambda:W_Lambda→U, first on scalar twists and
then untwisted. The map f^(1)* is onto A, so the generic parameter
on J(Y^(1)) computes the same minimum as on its image coset.
Etale base change for B_{1,U} and character decomposition give

    generic_L h^0(W_Lambda^(1),B_{1,W_Lambda}⊗(f b_Lambda)^(1)*L)
       =sum_(alpha∈Lambda) delta_(rho(alpha)),               (1c)

where delta is zero off B. There are at most e_(p') elements of
Lambda in any fiber of rho: their pairwise differences belong to
the prime-to-p subgroup of ker(rho)(k). Since delta≤delta^r,
the sum in (1c) is at most e_(p')K. All exceptional prime-to-p
characters are already in P[N], so this bound has its stabilized
value for every Lambda containing P[N]. In fact this value is exact.
All points of the finite F_q-defined bad set are torsion. Every
lift of a torsion point is torsion: a multiple lies in finite ker rho.
For a prime-to-p target, discard that lift's p-primary component:
its image is zero, so the remaining prime-to-p component still lifts
the target. Differences are exactly the prime-to-p part of ker rho,
which has e_(p') points even for an inseparable p-primary kernel.
Every prime-to-p bad point therefore has exactly e_(p') exceptional
prime-to-p lifts, all already in P[N]. A bad point with nonzero
p-primary part has none. Thus (1c) gives
\[
d_\infty=e_{(p')}\sum_{z\in B_{(p')}}\delta_z.
\]
That group P[N] has N^(2r) elements and gives the asserted degree.
A separate nonempty generic open is used for each Lambda.


## 3. Application to cyclic triples

Let U/Y be a connected cyclic etale triple in characteristic five,
with Y of genus two and no ordinariness hypotheses. On scalar Frobenius
twists put J=J(U^(1)), A=im J(Y^(1)), Q=J/A. Let B be the set of
cosets of A entirely contained in the Raynaud divisor Theta_U.

The [finite-fiber theorem](ordinary_cyclic_triple_finite_bad_cosets.md),
the later [all-defect theorem](low_genus_raynaud_cosets.md), and
the [polarization budget](polarization_bad_fiber_bound.md)
give Q=E^2, an elliptic E of either ordinariness type, and
\[
R=\begin{pmatrix}-1&-1\\1&0\end{pmatrix},\quad R^2+R+1=0,\qquad
\delta_z=1\ (z\in B),\quad |B|\le10,\quad0\notin B.\tag{2}
\]
Here delta_z is the generic dimension of sections along the coset.
Outside Q[2] and ker(R-1), every orbit under Gamma=<R,-1>=C6
is free; (2) permits at most one such bad orbit.

Choose a finite field F_q over which the cover, E, and this product
identification are defined. Frobenius preserves B and delta. Hence

 B subset Q[2] union ker(R-1)
          union_(s=+/-1, j=0,1,2) ker(F-s R^j).                (3)

The right side is finite. In particular, the order of the residual
defect-one points is now bounded explicitly in terms of this field
of definition and E. This does not establish that any candidate is
actually bad or actually good.

## 4. Explicit elliptic arithmetic

Write pi=Frob_q on E and pi^2-a pi+q=0. Define

    N_s=q+1-s a,
    D_s=q^2-q+1+a^2+s a(q+1),
    d_s=gcd(q-1,a+s),          s=+/-1.                          (4)

The kernels in (3) have the following descriptions:

| Operator | Kernel parametrization | Order | Integer annihilator |
| --- | --- | ---: | ---: |
| F-s I | ker_E(pi-s)^2 | N_s^2 | N_s |
| F-s R | (s pi(t),t), where (pi^2+s pi+1)t=0 | D_s | D_s/d_s |
| F-s R^2 | (t,s pi(t)), where (pi^2+s pi+1)t=0 | D_s | D_s/d_s |

For the second and third rows, solve the two linear equations using
the displayed matrix R. The elliptic endomorphism in question is

    u=pi^2+s pi+1=(a+s)pi-(q-1).

Its degree, computed from pi+dual(pi)=a and pi dual(pi)=q, is D_s.
Writing u=d_s v with v an integral endomorphism gives

    dual(v) u = [d_s deg(v)] = [D_s/d_s],

which proves the annihilator. In the first row, the elliptic kernel
has order N_s and hence is killed by N_s. All these kernels are
etale, even if an order is divisible by five. In fact 5 does not
divide D_s: modulo five it is a^2+s a+1, whose discriminant is 2,
a nonsquare. Scalar kernels can have etale five-torsion.

The group ker(R-1) is the diagonal E[3]. Consequently all points in
(3), including the small symmetry orbits, are killed by

    M(q,a)=lcm(6,N_+,N_-,D_+/d_+,D_-/d_-).                    (5)

The more selective union (3) is usually much smaller than Q[M].
For a free orbit its field degree is 1,2,3, or6, according as the
Frobenius permutation is I,-I,R^(+/-1), or -R^(+/-1).

For q=5 the ordinary positive traces give the following values;
negating a exchanges the plus and minus columns.

| a | N_+, N_- | D_+/d_+, D_-/d_- | M(5,a) |
| ---: | --- | --- | ---: |
| 1 | 5,7 | 14,4 | 420 |
| 2 | 4,8 | 37,13 | 11544 |
| 3 | 3,9 | 12,6 | 36 |
| 4 | 2,10 | 61,13 | 23790 |

## 5. Character refinement and scope

For the norm complement P≅E², e=9 and n=3. Apply Section2 with
the sharper annihilator M(q,a) from (5): all exceptional prime-to-five
characters lie in P[N], N=(3M(q,a))_(5'). The degree-N^4 refinement
therefore reaches the exact defect9|B_(5')|≤90 by Section2 and
delta_z=1. No nonzero point is fixed by both R and−1: such a point
would be killed by both3 and2. Thus every orbit in B_(5') has at
least two points; a nonzero defect is at least18. Vanishing is
equivalent to B_(5') being empty. This uses the norm kernel directly,
without a separate matrix calculation of rho.

The argument requires a finite bad locus over an actual finite field.
Candidate membership does not establish badness, and the result is
stabilization rather than vanishing. Over a moduli function field,
finite exceptional support can contain nontorsion points, so this
finite-field torsion argument gives no generic-moduli conclusion.

The elliptic kernels were independently derived by
/root/frobenius_c6_exception_kernel_calculation,2026-09-06. The
[norm-complement audit](../../../Research/audits/NORM_COMPLEMENT_ANNIHILATOR_AUDIT_2026_09_13.md)
covers only the new kernel annihilator and character level.
