# Proof: recover the linear variables over the projected algebra

[Statement](../Theorems/Thm_rooted_atlas_projection.md).

Work first over an algebraic closure. At an actual compact atlas point,
the swapped-pencil argument in `compact_etale_atlas_system`, proof
Section 3, identifies the kernel of U' -> N(U',b^[5]) with kU.
Taking coefficientwise fifth roots identifies the kernel of
v' -> n(v',b) with kv. This uses the actual extension whose middle
bundle is the fixed stable rank-two bundle: its endomorphism space is k.
It is not a statement about arbitrary points of the weak incidence.

The row s_j(-,b) has value 1 on v. Therefore adding this row kills
the one-dimensional homogeneous kernel. H_j has rank 32. In particular
two chart points with the same b have the same v, and their w's agree
because w=(v.s)^-1.

The rooted chart is finite reduced. After algebraic closure its
coordinate ring is a finite product of copies of k. The b-tuples of
these factors are distinct by the preceding paragraph. The evaluation
map from k[b] to this product is surjective by the Chinese remainder
theorem for the distinct maximal ideals of these tuples. Thus the
projection is a closed immersion. Surjectivity of this coordinate map
descends through a faithfully flat field extension. The quotient is
reduced, hence its kernel is radical. Every coordinate v_i and w belongs
to the image, proving polynomial reconstruction abstractly; no degree
bound or efficient interpolation is inferred from that existence.

Now let A=k[b]/J be finite reduced over the perfect coefficient field.
It is a product of finite separable field extensions. On a field factor,
linear algebra either proves inconsistency, gives a unique v, or gives
a positive-dimensional affine solution space. In the last case H_j has
rank less than 32, so the first paragraph proves that no geometric point
of that factor can be an actual atlas; discarding it is legitimate.
Matrix rank is unchanged by extending a field.

On a consistent full-rank factor the unique solution commutes with
every field extension, and every original low equation holds by direct
checking. The remaining chart equations are exactly the q Frobenius
residuals and c!=0. In a field, a nonzero residual cannot vanish after
any field embedding; likewise c is either zero or invertible. Hence
the factor is retained exactly when its graph satisfies the entire
original chart. All actual chart points lie over A because J consists
of necessary consequences. Conversely each retained graph is an actual
chart point by the original exact criterion. Equality holds as finite
reduced schemes, not only as an unexplained count.

Finally g^(5^e)=0 and g=0 have the same points in every field. If
g^(5^e) lies in the full chart ideal, reducedness of its coordinate ring
implies g lies in the ideal. For a displayed pure fifth power over a
perfect field, divide every exponent by five and take the unique fifth
root of every coefficient. This is not permission to replace an
arbitrary polynomial by a formal coefficient root.

## Exact computational route and its boundary

For degree B form all b-monomial multiples, up to degree B, of the
rows of H_j(b)v-d_j. Eliminate every column containing a v variable
before columns containing only b. Any remaining row is a pure-b
consequence with an explicit linear-combination certificate. Keeping
all such rows can matter even when their span does not contain 1.

For example f1=v2-b*v1, f2=b*v2, f3=v2-1 have the consequence
f2-b*f3=b. On b=0 the linear equations are inconsistent. There is no
identity 1=sum h_i(b) f_i: coefficients of v1 force h1=0, coefficients
of v2 then give h3=-b*h2, and the constant term would require b*h2=1.
Thus testing only for a b-only certificate 1 would miss an elementary
two-stage exclusion. This example has no role as an atlas model; it
tests the elimination algorithm's logical boundary.

The first genus-nine chart 23 has q=8. At B=4 the bounded matrix has
88*binomial(12,4)=43,560 rows, 32*binomial(13,5)=41,184 v-columns,
and binomial(12,4)=495 pure-b columns. These are counts, not a rank,
regularity, termination, or nonexistence theorem. Dependence between
rows must be measured or certified. If the resulting pure-b ideal is
positive-dimensional, part 2 cannot yet be applied.

This type of one-block multiplication is established in the y-XL and
y-MXL literature: [Baena--Cabarcas--Verbel](https://doi.org/10.3934/amc.2021047).
Their generic-system estimates are not applied to these special tensors.
The exact atlas-specific ingredients here are the rank theorem at every
actual point and the finite reduced chart, which justify reconstruction
and the rejection of rank-loss fibers.
