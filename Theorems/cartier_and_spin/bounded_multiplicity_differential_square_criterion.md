# A complete differential square test below characteristic multiplicity

Version1, 27 September2026. Let k be algebraically closed of odd
characteristic p, and let R in k[x] have degree2d. Suppose every finite
root of R has multiplicity strictly less than p. Then R is a square
if and only if the linear map
\[
k[x]_{\le d}\longrightarrow k[x],\qquad B\longmapsto 2RB'-R'B
\]
has a nonzero kernel. The kernel is then one-dimensional and generated
by a square root of R.

More generally, if R=c product_a(x-a)^(m_a), set n_a to the least
nonnegative residue of m_a/2 modulo p and b=sum_a n_a. The kernel in
degree at most d has dimension max(0,1+floor((d-b)/p)). Its full
polynomial solution module is
\[
\left(\prod_a(x-a)^{n_a}\right)k[x^p].
\]
The square equivalence concerns geometric points, not equality of
the corresponding parameter ideals or nonreduced schemes. Without
the multiplicity bound a nonzero differential kernel need not certify
a square. For the degree140 characteristic-five family, exclusion of
every root of multiplicity at least five would make a209x71 linear
rank test geometrically sufficient.

[Proof and exceptional example](../../Proofs/cartier_and_spin/bounded_multiplicity_differential_square_criterion.md).
