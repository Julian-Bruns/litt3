# Proof record: Frobenius localization and explicit stabilization

Canonical statement: [`frobenius_exception_sieve`](../Theorems/Thm_frobenius_exception_sieve.md).
Version 2, 2026-09-07: `/root/library_generalization_cleanup_max`.
Original proof: `/root`, 2026-09-06.
Status: author proof. The elliptic kernel calculation was independently
derived by `/root/frobenius_c6_exception_kernel_calculation`, 2026-09-06;
this is not a full theorem audit. No common-cover exclusion is claimed.

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

Suppose a determinant bad scheme has the budget

    sum_(z in B) w_r(delta_z)<=K,
    w_r(d)=binomial(r+d-1,r),

and Frobenius and Gamma preserve delta. Every orbit in a stratum
with delta>=d and orbit size>=s costs at least s w_r(d). Hence its
orbit count is at most floor(K/(s w_r(d))), and its point count is
at most floor(K/w_r(d)). This proves both candidate and field-degree
bounds. Grouping by Frobenius orbits instead gives the exact closed-
point budget sum_z [k(z):F_q]w_r(delta_z)<=K. In the general cover
case, the [intrinsic polarization theorem](Sol_polarization_bad_fiber_bound.md)
supplies K=floor(r!(p-1)^r kappa/n^h), provided the actual bad
scheme is finite. No extension defining every automorphism is needed
for the normalized-group version.

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

Choose an abelian complement P, let psi:P→Q have degree e, and put
N=(e M_K)_(p'). If alpha∈P(k) is exceptional, then M_K alpha lies
in ker(psi)(k), a finite group whose order divides e. Thus eM_K
kills alpha, and a prime-to-p alpha belongs to P[N]. Every finite
prime-to-p subgroup Lambda⊂P(k) gives an actual connected étale
character cover b_Lambda:W_Lambda→U, first on scalar twists and
then untwisted. The map f^(1)* is onto A, so the generic parameter
on J(Y^(1)) computes the same minimum as on its image coset.
Etale base change for B_U and character decomposition give

    generic_L h^0(W_Lambda^(1),B_(W_Lambda)⊗(f b_Lambda)^(1)*L)
       =sum_(alpha∈Lambda) delta_(psi(alpha)),               (1c)

where delta is zero off B. There are at most e_(p') elements of
Lambda in any fiber of psi: their pairwise differences belong to
the prime-to-p subgroup of ker(psi)(k). Since delta≤w_r(delta),
the sum in (1c) is at most e_(p')K. All exceptional prime-to-p
characters are already in P[N], so this bound has its stabilized
value for every Lambda containing P[N]. That group has N^(2r)
elements and gives the asserted degree of a level reaching that
value. A separate nonempty generic open is used for each Lambda.

For the principal-polarization complement, the principal duality
of J identifies A∩P with ker(lambda_(Theta_U|A)). Therefore
e=deg psi=chi(A,Theta_U|A)^2=(n^h/kappa)^2. Arbitrary inseparable
parts are retained in this identity. Only prime-to-p characters
are used to construct the refinements in (1c).

This is stabilization of a generic section dimension along one
specified parameter family, not the cofinal saturation or vanishing
of all Raynaud directions. Any actual second étale map from U
composes with b_Lambda on the same source; none is constructed here.
The retained [finite-character target-descent note](../routes/global/FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
assumes the stronger condition that the actual intersection
Theta_U∩Gamma is finite. Finite bad cosets do not give that condition;
ordinary relative Pryms and target descent do not follow here.

## 3. Application to ordinary cyclic triples

Let U/Y be a connected cyclic etale triple in characteristic five,
with Y ordinary of genus two and U ordinary. On scalar Frobenius
twists put J=J(U^(1)), A=im J(Y^(1)), Q=J/A. Let B be the set of
cosets of A entirely contained in the Raynaud divisor Theta_U.

The [finite-fiber theorem](Sol_ordinary_cyclic_triple_finite_bad_cosets.md)
and [polarization budget](Sol_polarization_bad_fiber_bound.md)
give Q=E^2, an ordinary elliptic E, and

    R=[[-1,-1],[1,0]],       R^2+R+1=0,
    sum_(z in B) delta_z(delta_z+1)/2 <=10,           0 not in B. (2)

Here delta_z is the generic dimension of sections along the coset.
Outside Q[2] and ker(R-1), every bad point has delta_z=1, its orbit
under Gamma=<R,-1>=C6 is free, and there is at most one such orbit.

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

## 5. The smaller cyclic-triple character level

On P=E^2 the isogeny psi:P→Q has matrix H=[[2,-1],[-1,2]], with
H# H=3I. If alpha is exceptional, then psi(alpha) belongs to B
and is killed by M=M(q,a). Therefore

    [3M]alpha=H# [M]psi(alpha)=0.

For a prime-to-five alpha this is equivalent to [N]alpha=0,
where N is the prime-to-five part of 3M. Thus the finite exceptional
character set is contained in P[N], not merely in an unspecified
finite subgroup. Since dim P=2 and 5 does not divide N, P[N](k)
has order N^4. It defines an actual connected abelian etale
character cover on U^(1), which untwists to a degree-N^4 cover of U.

For every finite prime-to-five character subgroup Lambda containing
P[N], character decomposition expresses the generic defect as the
sum of delta_(psi(alpha)) over alpha in Lambda. Every exceptional
character is already present. The sum is therefore independent of
Lambda and at most 90 by the polarization theorem. This is an
explicit bound on a level achieving the stabilized generic defect,
which may be positive. The equality concerns a nonempty generic
open for each Lambda; it does not select one point for infinitely
many covers or make any assertion about a-numbers.

## 6. Scope and the generic-field caveat

Equation (3) is valid for each actual finite-field model. Testing its
candidates still requires an actual nonvanishing witness on each
coset, or another geometric exclusion. The bound is not uniform as
the field of definition varies. The general mechanism applies to
arbitrary covers only after finite bad support has been established.

Do not infer a generic-moduli torsion statement from this argument:
over the function field of a moduli space, a finite exceptional locus
can consist of nontorsion points. Large Tate-module monodromy only
controls points already proved to be torsion. This additional
hypothesis must not be omitted in any proposed moduli extension.
