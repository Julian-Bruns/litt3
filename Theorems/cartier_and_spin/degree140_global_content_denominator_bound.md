# A fixed global denominator for every small critical-trace coefficient

Version1,30 September2026. Retain the constant degree140 family and its
original ratio chart, with H=h*w and q=w^3. Work first over the normal
Laurent parameter ring
\[
B=K[H,w,(Hw\Psi(H,w^3)a_0(w^3)(w^3-1)
                  (w^3-\langle15383\rangle))^{-1}].
\]
Let N(H,q) be the explicit endpoint-content norm polynomial of
[the content-jet theorem](degree140_endpoint_content_jet_factor.md), so
Norm(R)=q^-72*N. For an affine regular multiplier f in K[X-O], k>=0,
and m in{0,-1}, expand the actual generic trace as
\[
\operatorname{Tr}(t^k f\phi^m v)=\sum_n c_n\ell^n,
\qquad r=\max(0,1-k-3m).
\]
Then EVERY coefficient satisfies
\[
N(H,w^3)^r c_n\in B.
\]
In particular, the unweighted T coefficients have denominator dividing
N and the unweighted Q coefficients have denominator dividing N^4,
apart from the original chart units. The apparent denominators caused
by a vanishing type-A coordinate b cancel in the complete trace. This
is a uniform bound independent of n, not a claim about an isolated
uncorrected local residue. Existing homogeneous normalizations descend
the same assertion to the ring in H,q.

The coefficients extend as regular functions after multiplication by
N^r, including across the finite common-critical parameter set. At a
point of that already excluded set, the assertion is about the unique
coefficient extension; it does not identify it with a trace of a
degenerate specialized model.

As an intrinsic interpretation of the denominator, the endpoint
rescaling polynomial
\[
p(Z)=e_0Z^5+u_0b_0Z^2+u_0\chi_0Z+\kappa_0
\]
has fixed-degree discriminant
\[
\operatorname{Disc}(p)=3u_0^5R/e_0.
\]
Thus the denominator is the norm of these local quintic discriminants,
up to the explicitly invertible factors. This does not decide any
remaining scale locus or the unmarked common-cover problem.

[Proof and compact new calculation](../../Proofs/cartier_and_spin/degree140_global_content_denominator_bound.md).
