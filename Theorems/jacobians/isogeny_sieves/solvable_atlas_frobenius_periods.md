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

For a prime \(\ell\), put
\[
\mathcal A_\ell(b)=
\ell^{\lceil\log_\ell(b+1)\rceil}
\operatorname{lcm}_{1\le j\le b}(\ell^j-1),
\qquad
\mathcal M(R)=\operatorname{lcm}_{\varphi(n)\le R}n,
\]
where \(\varphi\) is Euler's function. The torsor has a model over
a degree \(d\mid\prod_i\mathcal A_{\ell_i}(b_i)\).
Once that model is fixed, the actual second map has a model after
an additional degree dividing \(\mathcal M(R)\), where
\(R=4(g-1)h+4g(D/G)\). Thus the entire equivariant diagram has a
model over a degree dividing
\(\mathcal M(R)\prod_i\mathcal A_{\ell_i}(b_i)\).
In particular every prime divisor of its minimal period belongs to

    S(G,g) union {prime L : L <= R+1},
    R = 4(g-1)h + 4g(D/G).                                    (2)

Consequently the Frobenius orbit length of any canonically assigned,
isomorphism-invariant algebraic datum of this diagram, whose assignment
is defined over F_q, has no other prime divisors. This conclusion concerns
the datum's minimal orbit length; the theorem does not bound all finite
extensions over which an arbitrary chosen presentation can be written.

The additional-map bound holds for ANY finite G, including nonsolvable
groups and groups with characteristic torsion.

## Stronger bound for prime-power groups, of arbitrary size

If \(G\) is a nontrivial \(\ell\)-group of order \(\ell^a\),
let \(D_\ell\) be the order of Frobenius on
\(H^1_{\mathrm{et}}(C_k,\mathbf F_\ell)\). Choose a series
\[
G=N_1\supset N_2=\Phi(G)\supset\cdots\supset N_{t+1}=1
\]
whose factors are elementary abelian and central in \(G/N_{i+1}\).
The geometric torsor has a model over a degree dividing
\(D_\ell\ell^{t-1}\). One can take
\(t-1\le a-\dim_{\mathbf F_\ell}(G/\Phi(G))\).
Thus an elementary abelian torsor needs only \(D_\ell\); an
exponent-\(\ell\), class-two torsor needs at most \(D_\ell\ell\).

For a nilpotent \(G=\prod_\ell G_\ell\), the torsor period divides
\(\operatorname{lcm}_\ell(D_\ell\ell^{t_\ell-1})\), for such
series in its nontrivial Sylow factors. The actual second map still
has the separate factor \(\mathcal M(R)\). In particular the
prime-to-\(\ell\) period for an \(\ell\)-group divides \(D_\ell\),
independently of the cover order.

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

Version4,2026-10-03. The affine-action and integral Hom-lattice arguments
now give full period divisibility. Elementary central factors sharpen
the prime-primary bound and give the nilpotent product bound. The
fixed-curve field and oper restrictions are unchanged.
[Proof and sources](../../../Proofs/jacobians/isogeny_sieves/solvable_atlas_frobenius_periods.md).
