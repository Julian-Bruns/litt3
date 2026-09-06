# Proof record: Frobenius localization of finite theta exceptions

Canonical statement: [`frobenius_exception_sieve`](../Theorems/Thm_frobenius_exception_sieve.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Frobenius and symmetry locate finite theta exceptions

Date: 2026-09-06. Author: `/root`.
Status: author proof. The elliptic kernel calculation was independently
derived by `/root/frobenius_c6_exception_kernel_calculation` on this date;
this is not a full theorem audit. No common-cover exclusion is claimed.

## 1. Finite exceptions and symmetry orbits

Let Q be an abelian variety over F_q, F its q-power Frobenius
endomorphism, and Gamma a finite group of F_q-defined group
automorphisms. Let B be a finite Frobenius- and Gamma-stable set of
geometric points. Suppose a Gamma- and Frobenius-stable stratum of B
has at most t Gamma-orbits. Then every point z of that stratum satisfies

    F^m(z)=gamma(z)     for some 1<=m<=t and gamma in Gamma.       (1)

Indeed, Frobenius permutes its Gamma-orbits; the orbit containing z
returns to itself after some m<=t. This is exactly (1). Each
F^m-gamma is an isogeny with finite etale kernel: its differential is
-d gamma, an isomorphism, so its image has full dimension and its
kernel is finite and etale. Thus (1) gives an explicit finite union
of finite groups containing the stratum.

If t=1 and Gamma acts freely, the field degree of z is exactly the
order of the particular gamma in (1). This follows from
F^n(z)=gamma^n(z), since F commutes with Gamma.

This elementary mechanism adds arithmetic to a geometric orbit budget.
It requires a common field of definition for the automorphisms. A finite
extension arranging this is allowed, but changes the arithmetic bounds.

## 2. Application to ordinary cyclic triples

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

## 3. Explicit elliptic arithmetic

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

## 4. Scope and an important generic-field caveat

Equation (3) is valid for each actual finite-field model. Testing its
candidates still requires an actual nonvanishing witness on each
coset, or another geometric exclusion. The bound is not uniform as
the field of definition varies, and it is not an all-degree theorem
for arbitrary covers.

Do not infer a generic-moduli torsion statement from this argument:
over the function field of a moduli space, a finite exceptional locus
can consist of nontorsion points. Large Tate-module monodromy only
controls points already proved to be torsion. This additional
hypothesis must not be omitted in any proposed moduli extension.
