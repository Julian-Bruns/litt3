# Frobenius-period sieve for solvable atlas monodromy

Let C,D be smooth projective geometrically connected curves over F_q,
with genera g,h>=2. Let G be a finite constant group acting on D over
F_q. Consider a geometric connected G-torsor W -> C_k together with an
actual G-equivariant finite etale map f:W -> D_k, where k=bar(F_q).
The quotient W/G=C_k and BOTH etale maps are part of the data.

Suppose G is solvable; its order MAY be divisible by the characteristic p.
Choose a chief
series of G with elementary abelian factors F_(ell_i)^(r_i), and define

    b_i = 2g r_i if ell_i != p, and b_i = g r_i if ell_i = p,
    S(G,g) = union_i ({ell_i} union
      {prime L != ell_i : ord_L(ell_i) <= b_i}).                 (1)

Then there is a finite field F_(q^n) over which the entire equivariant
diagram has a model, and every prime divisor of n belongs to

    S(G,g) union {prime L : L <= R+1},
    R = 4(g-1)h + 4g(D/G).                                    (2)

Consequently the Frobenius orbit length of any canonically assigned,
isomorphism-invariant algebraic datum of this diagram, whose assignment
is defined over F_q, has no other prime divisors. This conclusion concerns
the datum's minimal orbit length; the theorem does not bound all finite
extensions over which an arbitrary chosen presentation can be written.

Two independent mechanisms underlie (2):

- The geometric G-torsor itself has a model over a degree whose prime
  divisors lie in S(G,g).
- Once this torsor is defined, the additional degree needed for f has
  prime divisors at most R+1. This second assertion holds for ANY finite
  G, including nonsolvable groups and groups with characteristic torsion.

## Stronger bound for prime-power groups, of arbitrary size

If G is an ell-group of order ell^a, let D_ell be the order of Frobenius
on H1(C_k,F_ell). The geometric G-torsor has a model over an extension
of degree dividing D_ell*ell^a. Thus its prime-to-ell period divides
D_ell, independent of the size, exponent, or nilpotency class of G.
This is a TORSOR bound; the second map still requires its separate bound.

For the fixed X/F25, D_3 divides36. Consequently EVERY finite3-group
etale torsor of X has a model over a degree of the form4*3^b, and

    Pic(X_k)[3] = Pic(X_k)[3](F_(25^36)).                       (4)

The exponent36 is a sufficient field bound, not asserted minimal.
There are still3^18 geometric torsion lines; (4) does not identify them
or make the nontrivial twists equivalent to the untwisted case.

## Fixed-X consequence, for every cubic torsion line

For the fixed genus-nine X/F25 and the genus-ten Hermitian H/F25, suppose
an actual atlas X -> [H/PGU_3(5)] has geometric monodromy contained in
either of the two maximal subgroups of order216. Its canonically induced
normalized dormant-oper point cannot be orbit_0010 or orbit_0011.
Their F25 residue degrees are718=2*359 and7324=4*1831, respectively.
This restriction is valid for EVERY tau in Pic(X)[3], not only tau=0.

Indeed each chief factor of such a monodromy group has ell in{2,3} and
r<=3, so2gr<=54. An actual map W->H forces9 to divide|G|, and hence
g(H/G)<=2 and R<=328. But

    ord_359(2)=179,   ord_359(3)=179,   359>329;
    ord_1831(2)=305,  ord_1831(3)=1830, 1831>329.               (3)

Thus both primes are forbidden by (1)-(2).

Combining with `hermitian_monodromy_genus_sieve`, a NONLIFTABLE PGU atlas
in either of these two oper orbits would have full PGU monodromy. Under
the explicit axiom A18, every remaining atlas is nonliftable, so this
applies to any remaining atlas in those two orbits. A18 is NOT proved.

This is NOT an exclusion of either whole oper orbit, the other sixteen
representatives, the nontrivial-tau problem, or arbitrary common covers.
It supplies no bound of the form (1) for a nonsolvable torsor.

Version3, author proof,2026-09-07; no independent audit claimed.
Version2 allowed p-torsion; version3 adds the uniform prime-power-torsor
bound and the explicit field containing every cubic torsion line on X.
[Proof and sources](../Solutions/Sol_solvable_atlas_frobenius_periods.md).
