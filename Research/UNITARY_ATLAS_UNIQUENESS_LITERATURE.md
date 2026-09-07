# Hermitian oper uniqueness — disproved by the completed positive test

Updated2026-09-07. The old missing uniqueness implication is now FALSE,
even when the correspondence has a core and both legs are Galois.

The canonical theorem
[hermitian_oper_noninvariance](../Theorems/Thm_hermitian_oper_noninvariance.md)
gives the short counterexample. The degree-nine etale quotient
H->C:v²=t⁶+3 induces r_+=4t⁴/(t⁶+3)²+t/(t⁶+3). The actual involution
(t,v)->(-t,v) replaces it by r_-=4t⁴/(t⁶+3)²-t/(t⁶+3).
They are distinct. A connected component of the two quotient maps'
fiber product gives an actual cored Galois etale selfspan of H on which
the natural oper has two different pullbacks. No rank-four numeric search
or a hypothetical coreless example is needed for this conclusion.

The surviving literature fact is narrower: Wakabayashi,
[Inseparable Gauss maps and dormant opers](https://www.math.okayama-u.ac.jp/mjou/mjou67/_01_Wakabayashi.pdf),
Remark4.2, proves PGU-invariance of the natural Hermitian Gauss oper and
descent through its etale quotients. This does not imply invariance under
automorphisms of an arbitrary quotient or compatibility under a cored
correspondence. The explicit example distinguishes those assertions.

For comparing two GIVEN separating pseudo-coordinates u,v in a function
field K, the reusable elementary test remains

    rank_(K^5){1,u,v,uv} <=3.

It is equivalent to a PGL2(K^5) transformation relating u and v: a linear
relation rearranges to the fractional-linear formula, and a zero
determinant would force u or v into K^5. The classification input is
Hoshi, [Frobenius-projective Structures on Curves](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1871revised.pdf),
Theorem4.13. It is a test for compatibility, not an automatic consequence
of either etale map. Rank(p−1) oper uniqueness atp5 concerns rank4 and
does not rescue the false rank-two statement.

Do not use the ambient rank-three finite unitary holonomy as finite
holonomy for its rank-two Gauss oper. Its Frobenius pullback is unstable;
the osculating subquotient does not preserve that finite-holonomy property.
