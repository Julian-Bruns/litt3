# Proof of the projective bound for actual second returns

Use the accepted [actual quotient atlas](second_return_actual_quotient_atlas.md)
and [extension geometry](rank_three_extension_return_geometry.md).
The returned [report](../../../litt3-computation-data/actual_frontier_trial_replies_20260925/extracted/stable_second_return/REPORT.md)
and exact certificates are retained. The new projective estimate is
theoretical; the finite-field point checks are separate bounded results.

Write z=xi^25. The complete matrix is
\[
\mathcal C(\xi)=
\begin{pmatrix}T(z)&0\\ W(\xi,z)&Q(z)\end{pmatrix},
\]
with row sizes80,43 and column sizes35,16. T,Q are linear in z and
W is bilinear in xi,z. The accepted recovery maps identify its kernel
with the full Hom(F^2R_xi,R_xi), including rank-jump points. Scaling
xi by lambda scales a morphism H by
diag(lambda,1,1) H diag(lambda^-25,1,1). The lower-map coordinates
therefore scale by lambda^-25 and the free upper coordinates by
lambda^-24. The row equations have weights0,1. This proves the
bundle map in the statement, with the coefficient Frobenius retained.

Let Y=P_lines(mathcal A), of dimension68, with tautological line S.
The projective kernel incidence is cut out by80 sections of S^vee
and43 sections of M=S^vee tensor O(1). Multiplying each of the80
sections by every base homogeneous coordinate gives the same common
zero scheme, now as a linear section for M. This line bundle is very
ample: in the quotient convention Y is the projective bundle of
O(26)^35 direct-sum O(25)^16. Ratios of its monomial sections give
all base and fiber affine coordinates and separate tangent directions.

At a stable return the Hom space is one-dimensional by stability and
the isomorphism. Thus exactly one projective point lies above it.
The nonzero-determinant and stable-source conditions are open. The
accepted finiteness of stable returns implies these are isolated
points of the whole projective kernel incidence: a positive-dimensional
component through one would meet that open locus in positive dimension.
Isolated points in any linear section number at most the degree of Y.
To see this even with excess components, cut successively by general
linear combinations of the defining hyperplanes; degrees do not
increase. Discard positive-dimensional components already in the common
zero locus, which cannot contain an isolated point of that locus.
Every isolated point is eventually charged at least one unit of degree.

If h is the base hyperplane class and v=c_1(M), the projective-bundle
relation is product(v-a_i h)=0, with35 entries a_i=26 and16 entries25.
Together with pi_*(v^50)=1 this gives
\[
\deg_M Y=\int_Yv^{68}=[t^{18}]\prod_i(1-a_it)^{-1}.
\]
This proves the displayed bound. Arithmetic Frobenius permutes the
finite set of source points; a point of residue degree d has d conjugates,
so d<=N. Its matrix has a one-dimensional kernel already over its
residue field, and the recovered nonzero vector is a scalar multiple
of the geometric isomorphism. No further coefficient extension is needed.
The bound does not mean all points lie in F_(25^B); the residue degrees
are bounded individually and need not divide B.

The sixteen point exclusions were checked by nonzero35- and16-minors
of T,Q, respectively, so their full fixed-target Hom is zero. Geometric
stability uses an exact unit-ideal certificate for all fiber minors of
the Serre-dual evaluation map, plus a separate infinity test. Both were
replayed. The stable pure-v regression has a four-dimensional Hom space;
all20 coefficients of its determinant cubic vanish in the actual Laurent
function ring. It is not a return. These examples and the finite count
bound do not decide the remaining geometric incidence.
