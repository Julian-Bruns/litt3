# Proof: all ordinary cubic origins, preserving the actual completion

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/WILD140_ORDINARY_FOUR_PAIR_AUDIT_2026_10_03.md). [Statement](../../Theorems/cartier_and_spin/wild140_ordinary_cubic_even_part_exclusion.md).

The moving origin P=t is excluded by the accepted [moving-origin theorem](wild140_moving_origin_cubic_even_part_exclusion.md), for every shift of the odd part. At each of the other five origins, the [fixed-origin differential reduction](wild140_fixed_origin_cubic_ode_reduction.md) gives, with L≠0,−1,
\[
y^2=w^5+w^4+Lw+L,\quad F=w^3-L+yw,
\quad N=-w^7+2Lw^3-Lw^2+L^2,
\quad D=w^5+2Lw+L.
\]
The five-origin transport and all differential identities are proved there without a Gröbner computation; the family has seven simple F zeros, and its full Cartier gate vanishes. Thus the reduced-fiber gate alone does not exclude it.

For the actual ordinary carrier, the common-source identification forces the seven completed fields to be the SAME over the fixed quotient coordinate β=G⁷/F²⁰. The [weak local invariant](../quotient_geometry/weak_local_completed_extension_invariant.md) therefore gives D⁵/G² constant on those zeros. The fixed-origin primitive identity rewrites the fiber values, after scaling its nonzero derivative constant c to one, as
\[
G\equiv2D^2+a+bw^5+dw^{10}\pmod N.
\]
Its exact pole20 is equivalent to d≠3, because the original tenth-degree correction is d−3 and the primitive itself has pole18. No low-pole branch is declared impossible. The necessary completion condition is
\[
(2D^2+a+bw^5+dw^{10})^2-\lambda D^5\equiv0\pmod N,
\qquad\lambda\ne0.
\]
This congruence is exact in the squarefree norm algebra; its seven coefficients are the ORIGINAL completion rows h₀,…,h₆. The [row source](../../scripts/genus_two/oct03_wild140_fixed_origin_completion_rows.py) and [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/completion_rows.json) preserve their construction directly from N,D,G.

Make only invertible rescalings a=L²u,b=Lv,λ=M/L, so M≠0. Let rⱼ be hⱼ divided by L⁴ for j=0,…,4 and by L³ for j=5,6 after this substitution. Exact coefficient arithmetic gives
\[
r_1+r_2+r_4=L+d^2-2d+Lv(2d-1)+2u+3v-1,
\]
\[
r_5+r_6=L(3d^2-3d+1)-1+4vd+v^2-3ud-2u+2uv-3M.
\]
Since2 and3 are units, every completion solution has
\[
u=3[-L-d^2+2d-Lv(2d-1)-3v+1],
\]
\[
M=2[L(3d^2-3d+1)-1+4vd+v^2-3ud-2u+2uv].
\]
Substitute the first expression into the second, then both into all seven rows, obtaining polynomials s₀,…,s₆ in F₅[L,v,d]. Adjoin Z and the EXACT open condition
\[
ZL(L+1)M(L,v,d)(d-3)-1=0.
\]
The [analytically reduced source](../../scripts/genus_two/oct03_wild140_fixed_origin_completion_probe.py) checks both displayed linear combinations against the original rows before any Gröbner calculation. Its [receipt](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/completion_probe_receipt.json) records u,M, all seven substituted rows and the open generator. The resulting ideal is the unit ideal.

The stronger check is the [exact certificate source](../../scripts/genus_two/oct03_wild140_fixed_origin_completion_unit_certificate.py) and [saved certificate](../../../litt3-computation-data/oct03_wild140_fixed_origin_cubic_cartier/completion_unit_certificate.json). It records eight polynomial witnesses in F₅[L,v,d,Z] whose products with the seven ORIGINAL analytically reduced rows and the open generator sum to1. Generation verified that exact polynomial identity directly; the witnesses have117 terms in total. Run `sage -python scripts/genus_two/oct03_wild140_fixed_origin_completion_unit_certificate.py --verify-only` to check the saved unit identity without a Gröbner calculation. The new completion probe and certificate step took2.5 and2.9 seconds, each on one core with its separately authorized six-second bound.

Two preliminary handwritten rescaling errors were caught by exact assertions BEFORE the first Gröbner calculation: a missing L in the first linear combination and a missing −2d in the second. Both were corrected in the displayed identities. No outcome was claimed from either failed assertion, and neither is part of the certificate.

Every possible original completion solution would yield a point of this unit ideal, a contradiction. The five fixed-origin cubic cases are therefore excluded. Together with the accepted moving-origin cubic theorem, this excludes all six ordinary cubic origins on both endpoints, with their same actual source and both original étale maps retained. Neither distinguished cone is covered by the exact-pole assumptions used here.
