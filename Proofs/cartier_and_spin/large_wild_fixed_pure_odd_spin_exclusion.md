# Proof: exact first-tier interpolation excludes the three fixed pure-odd forms

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_fixed_pure_odd_spin_exclusion.md). Independent root review PASS: [report](../../Research/audits/LARGE_WILD_FIXED_PURE_ODD_AUDIT_2026_10_03.md). Retain the actual large-wild packet and both original endpoint maps on the SAME T. The only new executed calculation is the bounded symbolic interpolation below.

## Normalize the scalar and remove both primitive gauges

Put B=w−a, σ=dw/y and D=dF/σ=Φ+BΦ′/2. The actual packet gives c≠0, α=4c/λ⁵≠0, H0∈L(18P) with dH0=F³σ, and R∈L(41P) satisfying
\[
C(RF^3\sigma)=0,\qquad R-\alpha D^5\in F^4L(22P),
\]
with fourth coefficients r4⁵=2cH0D⁵ at each simple F-zero. Scaling R and α by c⁻¹/⁵ sets c=ONE in this necessary system.

The full bounded primitive ambiguity is H0→H0+U⁵, U∈L(3P)=⟨1,w⟩. This is removable, rather than a new free obstruction parameter. Under this change set
\[
R\longmapsto R-(3F^4UD+F^5\partial U),\qquad \partial=d/\sigma.
\]
The change has pole≤40P, because D∈L(10P), U∈L(2P), and ∂U∈L(5P). It preserves the leading term and coefficients ONE,TWO,THREE at every F-zero. Its fourth coefficient changes by−3UD=2UD, whose fifth power is exactly the required change2U⁵D⁵. Its Cartier product changes by−d(F⁸U), hence remains exact. Therefore it suffices to choose the unique polynomial primitive H with ZERO constant and ZERO w⁵ coefficient.

Since F³σ=ΦB³dw is invariant, this H is polynomial and invariant. The jet targets are invariant under the hyperelliptic involution; averaging R preserves them and Cartier exactness. Thus R may be taken polynomial of degree≤20. Its leading and first-three jet conditions give
\[
R=\alpha D^5+\Phi^2B^4V,\qquad V\in k[w],\quad\deg V\le11.
\]
The fourth values are V(x)⁵=2H(x)D(x)⁵ at the five branch values x=1,2,3,4,−q and the paired value x=a. These six values are distinct: a∉F5 and a≠−q follow from a³q=4 and q∉F5.

## Twist the coefficient equations and interpolate exactly

For a polynomial f write f^[5](w)=Σfi⁵wi, raising its COEFFICIENTS, not its variable. Work over F5(a), with q=4/a³. Put
\[
Q=(\Phi^2B^4)^{[5]},\quad S=(\Phi B)^{[5]},\quad
T=(D^5)^{[5]},\quad P=(\Phi B^3)^{[5]}.
\]
There is a unique polynomial I of degree≤5 with
\[
I(x^5)=2H(x)D(x)^5\quad (x=1,2,3,4,-q,a).
\]
For v=V^[5], all fourth-value solutions have v=I+S U with degU≤5. The twisted polynomial is r=βT+Qv, where β=α⁵. Its degree≤20 forces the five highest coefficients to vanish. Since QS is monic of degree20, these successively determine the coefficients of U in degrees FIVE through ONE. Its constant t remains the only free interpolation coefficient.

Let r0 be the resulting polynomial for β=0,t=0, let r1 be the one for β=1,t=0, and let rt=QS. Thus every candidate is
\[
r=r_0+\beta(r_1-r_0)+t r_t.
\]
Cartier exactness of RΦB³dw is equivalent, after fifth powers, to the FIVE coefficients of rP in degrees FOUR,NINE,FOURTEEN,NINETEEN,TWENTY-FOUR being ZERO. Let C be the five-by-three matrix whose columns are these coefficients for r0,r1−r0,rt. A candidate therefore requires C(1,β,t)^tr=0.

## Exact certificate and its specialization scope

The new source [oct03_fixed_pure_odd_cartier_symbolic.sage](../../scripts/genus_two/oct03_fixed_pure_odd_cartier_symbolic.sage) constructs exactly these polynomials, asserts every interpolation value and high-coefficient cancellation, and computes all TEN three-by-three minors. It independently checks each determinant by its direct six-term formula. The exact receipt is [first_tier_minors.json](../../../litt3-computation-data/oct03_fixed_pure_odd_cartier/first_tier_minors.json), containing each numerator/denominator and polynomial Bezout coefficients.

Executed with one core via `OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 SAGE_NUM_THREADS=1 sage scripts/genus_two/oct03_fixed_pure_odd_cartier_symbolic.sage`. The symbolic arithmetic took only a bounded small calculation, with no Gröbner basis or endpoint replay. All assertions passed. The TEN minors are nonzero rational functions, their numerator degrees are at most312, denominator degrees at most212, and their monic numerator gcd is
\[
(a^4-1)^{11}.
\]
The source checks this identity and directly verifies the Bezout sum equaling the gcd. It also checks that every denominator has all factors supported on a(a¹²−1), by repeatedly dividing its gcd with that polynomial until a constant remains.

At an admissible geometric a, a≠0. If a¹²=1, then q⁴=4⁴/a¹²=1, forcing q∈F5, impossible. Thus every rational matrix entry and minor specializes honestly. If all minors vanished, their checked Bezout sum would give a⁴=1, again impossible. Hence C has rank THREE at every admissible a, and its kernel cannot contain the nonzero vector (1,β,t). This contradiction excludes all three pure-odd forms uniformly on both endpoints.

The actual cubic extraction from degree21000 preserves the same low F and original T, so it transfers this contradiction. The two fixed mixed forms remain open. The calculation recognizes only a necessary first-tier packet and does not build or presume a global Hermitian field.
