# Exact b-linear cancellation test with normalization

For the first oper in the cached genus-nine atlas tensor, the ansatz

\[
 \sum_{i,r}\lambda_{i,r}b_iT_r(U,b^5)
   +\left(\sum_jh_jb_j^5\right)(U\cdot b)=0,
 \qquad T=[N;R],
\]

has only the zero coefficient solution. This includes the normalization
term omitted by the earlier U-linear multiplier test.

Flatten the coefficient rows of T into a 96 by 1024 matrix, with column
32k+j corresponding to U_k b_j^5. Its rank is 96. Since the monomials
b_i b_j^5 are distinct for ordered pairs (i,j), the displayed identity is
equivalent to e_i tensor h lying in its row span for each i, with the
negative of that row representation giving lambda_i.

The saved certificate gives 32 vectors w annihilating all original tensor
rows. For each saved index i, their restrictions w[32i:32i+32] impose a
linear equation on h. The resulting 32 by 32 matrix has determinant
2a+2 in F5[a]/(a^2+4a+2). Thus h=0, and tensor row independence then gives
lambda=0. These assertions remain true after extending the coefficient
field. All annihilator identities were checked against the original
tensor, and the certificate stores the original source SHA256.

Substituting the original generators N, R-b, U.b-2 into a hypothetical
identity of this form would give the degree-at-most-five consequence

\[
 -\sum_{i,j}\lambda_{i,64+j}b_i b_j-2\sum_j h_jb_j^5.
\]

The test therefore produces no nonzero consequence. It does not exclude
other multiplier forms, all consequences of degree at most five, any
atlas solution, or any whole oper. No Groebner basis was computed.

Reproduce with `sage scripts/atlas_normalization_cancellation.sage`.
The complete rank certificate is in
`computations/atlas_normalization_cancellation.json`; runtime was about
0.47 seconds with peak process RSS about 279 MB.
