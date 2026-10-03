# Proof: the moving-pencil Cartier matrix has exactly the claimed rank

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/moving_large_wild_cartier_obstruction_rank.md). Pending independent review. This is a symbolic coefficient calculation on the actual genus-two curve; it introduces no global carrier or auxiliary source.

## The six-dimensional target and the exact columns

Since divσ=2P, the target H0(ωY(5P)) consists of L(7P)σ and has basis σ,wσ,w²σ,w³σ,yσ,wyσ. Cartier on a polynomial differential keeps precisely powers congruent to FOUR modulo FIVE:
\[
C\left(\sum b_jw^j,dw\right)=\sum b_{5i+4}^{1/5}w^i,dw.
\]
For a polynomial T one also has C(Tσ)=C(TΦ²dw)/y, because σ=Φ²dw/y⁵. Both formulas use actual functions on Y and the usual Frobenius rule.

Expand
\[
F^3\sigma=(a^3+3a\Phi)w^3\sigma+(3a^2+\Phi)w^3dw.
\]
The first part of the column for w^j is therefore obtained from (a³Φ²+3aΦ³)w^(3+j)dw and divided by y; the second comes from (3a²+Φ)w^(3+j)dw. Applying the displayed coefficient rule for j=1,2,3 gives the first three columns of the stated matrix. For the y column the first sector has no surviving exponent, and the second gives
\[
C(yF^3\sigma)=q^{4/5}w^3\sigma.
\]
Indeed its coefficient polynomial is (3a²Φ³+Φ⁴)w³, and among exponents congruent to FOUR its only nonzero coefficient is q⁴w¹⁹. For j=0 neither sector has a surviving coefficient, so C(F³σ)=0 and the constant column vanishes. Thus the matrix itself is exact, rather than a bound obtained by discarding terms.

## Rank at the pure-odd member

For a=0 the w and w² columns are (h^(1/5)+w)dw and q^(1/5)w dw. They are independent because qh≠0. The y column is nonzero and belongs to the polynomial-σ sector, whereas these first two columns belong to the polynomial-dw sector. The w³ column vanishes. Hence the rank is exactly THREE.

## Rank at every other reduced member

Suppose a≠0 and a²≠h. The w³ and y columns span the two rows w²σ,w³σ: their determinant after fifth powers is q⁶a(a²−h), which is nonzero. Quotient these two rows out. If h+3a²≠0, the w and w² columns are independent in the remaining yσ,wyσ rows, with determinant q(h+3a²)≠0.

If h+3a²=0, then a²=3h. The constant-σ entry of the w column becomes a h³≠0, while that of the w² column is zero and its wyσ entry is q≠0. These two columns are again independent modulo the previous two. There are only FOUR nonzero domain columns, so the rank is exactly FOUR in either case.

The obstruction quotient therefore has dimension 6−rank as asserted. This calculation supplies no nonvanishing argument for the obstruction class of a hypothetical actual carrier, and all original maps stay on the same source.
