# Proof: mixed inverse blocks retain all cohomology and polar charts

[Statement](../Theorems/Thm_inverse_cup_atlas_system.md).
Version5,2026-09-08, /root; version2 by /root/library_generalization_cleanup_max. The
mixed-block and minor-patch arguments below are author proofs, not a new
audit of the existing Bezout, resultant-gradient or compact-atlas inputs.

## 1. The connecting map is an inverse block, without acyclicity

First use ordinary section coordinates and the Cech construction in
`cohomological_bezout`. For every admissible u, the determinant theorem
makes D(u) invertible. Given m in H0(M), solve uniquely

    D(u)(xi,v0)=(m,0).

The second row says a(u)xi=0. Thus, in the notation of that proof,

    v=h_V a_u i_T xi+v0

satisfies d_V v=a_u i_T xi. Then b_u v is closed, so the fixed projection
P_M does not change it; the first row says exactly b_u v=m. By the Cech
sign convention, the connecting class of m is xi. Consequently

    (D(u)^-1)_11=K(eta_u).                                  (4)

The long exact sequence is

    0 -> H0(V) --q--> H0(M) --K--> H1(T) --a--> H1(V) ->0.

Thus q is injective, a is surjective, and K has rank n-r, kernel im q
and image ker a. This proves the inverse-block lemma in arbitrary
characteristic under the existing Bezout hypotheses; r=0 recovers the
audited inverse-cup special case. Neither a symmetric choice of B nor
acyclicity is used for r>0.

These are identities over the coordinate ring of the admissible open,
not only at geometric points. The fixed Cech splittings extend by scalars,
and solving with D^-1 is regular there. In fixed-curve scalar coordinates
take the coefficient Frobenius twist of the ENTIRE mixed matrix and its
splittings. Formula(4) then gives K(eta_u)^[5] as the top-left block.
B remains quadratic and a,q remain linear in U; there is no substitution
of independent variables U^5 into D.

## 2. Uniform atlas equations and normalization

The cup map is injective on the full56-dimensional extension space:
products of L32 monomials span L64. Hence its fixed linear left inverse
recovers the normalized extension class from the block in(4), even when
that block has rank21. On det D!=0, imposing its equality with
Gamma=K(i^-1 beta)^[5] is the graph of the normalized class followed by
the Frobenius base change. It is exactly the Wronskian-one extension
condition, including the restriction eta in J. In any coefficient algebra
D G=I makes det D a unit and G the unique inverse. Thus introducing X,Y,Z
introduces no additional points, nilpotents, or choices.

The determinant of D is a nonzero constant times the SAME reduced
degree48 resultant Delta used in `resultant_gradient_atlas`. On this
extension graph that theorem gives

    i(R_U eta^[5])=-dDelta/Delta
                 =-(Tr(G partial_i D))_i.                    (5)

Consequently(1) is scheme-theoretically the compact atlas system. Its
finite reduced conclusion is inherited from that audited system, not
from an equation count. Expanding(5) gives the two extra trace terms
Tr(X partial_i a) and Tr(Y partial_i q); Z contributes none because
the bottom-right block of D is identically zero.

Let E0=diag(I_n,0_r). Mixed homogeneity, rather than a falsely quadratic
degree for every entry, gives

    sum_i U_i partial_i D = E0 D+D E0.

Since G D=D G=I, contraction of(5) with U gives

    U.beta=-Tr(G E0 D+G D E0)=-2n=-48=2 in characteristic5.

This keeps every projective direction and the exact scale normalization.
It also shows why the r>0 gradient cannot simply copy the acyclic trace.
Indeed a X=Y q=I_r, so the two linear blocks contribute2r to the radial
trace. Keeping only Gamma partial_i B would instead give
U.beta=-2(n-r)=3 when r=3, not the required2.

## 3. Small-minor patches, including all six exceptional representatives

At every admissible point q has rank r and a rank r, by the long exact
sequence above. Their r-square minors therefore cover that entire open.
Fix one invertible minor of each, permuting the selected rows and columns
last, independently in the target H0(M) and source H1(T). Write

    q=[q_top;q0],       a=[a_left,a0],       m=n-r.

Over the localization where det(q0)det(a0) is a unit, the matrix P in
the statement is an isomorphism from k^m onto ker a, while L identifies
the quotient by im q with k^m. Row elimination of q_top followed by
column elimination of a_left gives

    det D=+-det(q0)det(a0)det(L B P).                         (6)

The sign records fixed permutations and has zero derivative. The map
induced by B from ker a to H0(M)/im q is Bbar=L B P. Thus D is invertible
exactly when Bbar is, and its inverse block is P Bbar^-1 L.

For completeness the auxiliary-free equations do not assume the rank of
Gamma. The equations a Gamma=0 and Gamma q=0 imply uniquely

    Gamma=P Z0 L,

where Z0 is the unselected-row, unselected-column submatrix of Gamma
(source rows and target columns, in these reordered bases). Then
L B Gamma=L is equivalent to Bbar Z0=I_m because L has a right inverse.
A one-sided inverse of a square matrix over any commutative coefficient
ring is its inverse. Therefore these three equations enforce all of(2),
including admissibility. No extra kernel direction is discarded.

Differentiate(6). Since Z0=Bbar^-1 on these equations,

    Tr(G partial_i D)=Tr(Z0 partial_i Bbar)
      +partial_i det(q0)/det(q0)+partial_i det(a0)/det(a0).

This proves(3), with derivatives of P,L included when differentiating
Bbar. All denominators belong to the two stated minor opens. For r=3,
m=21; replacing the21-square block by the acyclic24-square inverse, or
forgetting either determinant term, would change the condition. The
explicit cover is not claimed to be a small number of patches.

For the fixed curve det V=omega yields a further duality simplification.
Pair H1(V) with H0(V) by (zeta,v)->Tr(zeta wedge v), and pair H1(T)
with H0(M) by Serre duality. Since (u xi) wedge v=xi b_u(v), choosing
dual bases gives a=q^T. The usual cup pairing K(eta) is symmetric because
it evaluates eta on products of two sections of M. These identities
persist under the coefficient Frobenius twist.

Choose the SAME row and column set I for q0 and a0=q0^T. Then L=P^T.
On the admissible part of this patch, the principal submatrix
Z0=(D^-1)_11,(I^c,I^c) is Bbar^-1 and symmetric. Thus Bbar is symmetric
there. Its entries are regular on the entire minor open, and the
admissible open is dense in every nonempty such patch; consequently
Bbar=P^T B P is symmetric everywhere on the patch, even if the original
splitting did not give a globally symmetric B. Equal row and column
permutations cancel their signs, giving

    det D=(-1)^r det(q0)^2 det(Bbar).

For the prescribed cup matrix Gamma symmetry is automatic. Thus
Gamma q=0 also gives a Gamma=q^T Gamma=0 and forces
Gamma=P Z0 P^T. The equation Bbar Z0=I then proves all the required
inverse-block conditions. Differentiating the last determinant identity
gives exactly(S). These are equations in U,beta alone on the minor
localization; they keep all32 quotient directions and all three extra
cohomology directions for r=3. Only the matching of dual bases is used,
not a generic rank assertion or an arbitrary deletion of three columns.

A bounded symbolic check over F5(x,y), for mixed homogeneous matrices
with(n,r)=(4,0),(4,1),(6,3), verifies the inverse-block ranks, all displayed
matrix identities, determinant factors, logarithmic derivatives and
weighted Euler identity. This checks the linear algebra only; it is not
an exceptional-oper tensor export, atlas search, or independent proof audit.

## 4. Exact boundary kernel and its cup rank

Write ell=deg L>2g as in the extension-space conventions. Stability of W
implies deg D<ell: the saturated subline L^-1(D) of W has negative degree.
For D>0 the saturated section gives

    0 -> L^-2(D) -> W L^-1 -> O(-D) ->0.

Since H0(O(-D))=0, the map H1(L^-2(D))->H1(W L^-1) is injective.
The original map factors through it, proving(Bdy). Also
H0(L^-2(D))=0, so(Bdy) has dimension deg D and is exactly the image of
principal parts on D. Under Serre duality it is the linear span of the
length-deg D subscheme D in the embedding defined by omega L^2.

Cup product with such a class factors through restriction of its argument
to D; a section vanishing on D kills the principal part. Its rank is
therefore at most deg D. For the fixed curve ell=24, so it is at most23.
This proves that matrix inversion removes EVERY invalid quotient on the
acyclic branch, not just a generic boundary divisor. Acyclicity is essential
to using a24x24 invertible cup matrix; it is not imposed on the55 r=3 opers.
For these opers the full27-square D, not rank21 of the cup block alone,
excludes every boundary stratum by the audited determinant theorem.

## 5. A large unavoidable boundary family from the third-order operator

Identify E with H0(O(64O))^vee by the residue pairing. The subspace
J=Ann ker Q has dimension32. At every point P choose regular local oper
and line frames. The scalar expression for Q in those frames has order3
with invertible leading coefficient. Evaluation of its scalar output
at P is a nonzero functional on length-four jets of O(64O). Denote its
class in E by eta_P. Global sections of O(64O) separate these jets,
since H1(O(64O-4P))=0, so eta_P is nonzero globally. Its defining
functional kills ker Q, so eta_P lies in J, and its support is4P.

This uses regular frames at P, including O; a pole of the chosen rational
delta frame at O does not make the intrinsic operator degenerate there.
The local horizontal description of Q in `dormant_differential_projection`
supplies the invertible third-derivative coefficient in every such frame.
Since the third-jet coefficient is nonzero, this class is not supported
on3P. Distinct P give distinct projective classes: length-eight evaluation
for O(64O) separates the two disjoint principal-part spans.

The sections of W(24O) vanishing on4P form a24-dimensional vector space.
Indeed their evaluation imposes eight independent conditions: the dual
H1 obstruction has stable slope -24+16+4=-4. For each such nonzero section
its zero divisor contains4P; equation(Bdy) therefore puts eta_P in its
N-kernel. This gives P23 over each P, hence a24-dimensional family in
the projective N/J incidence. Entrywise coefficient Frobenius transports
this statement to the U,eta coordinates without changing dimensions.
No member is admissible; the universal radial normalization prevents it
from becoming a solution of the actual compact atlas system. Its cup
rank is at most4 because eta_P is supported on4P. Thus the necessary
rank n-r already excludes this particular family for both r=0 and r=3;
the rank<=23 bound on arbitrary boundary classes does not exclude them
all on the nonacyclic branch, and does not replace its mixed inverse.

## 6. Exact trace and chart checks for the first oper

The complete quadratic tensor is saved in wronskian_quadratic_bezout.json.
`wronskian_trace_linearization.sage` contracts it with all32 canonical
cup matrices and checks every bilinear coefficient of

    -H(beta^[5])U - R_proj(U,beta^[5]) = C N(U,beta^[5])

for a saved constant32x64 matrix C. This particular all-strata polynomial
syzygy is computational evidence for the first oper; the scheme equivalence
above does not presume it for other opers.

For this acyclic case H is symmetric: it is the Hessian of the quadratic
function Tr(Gamma B(U)), with Gamma held fixed when differentiating.

`wronskian_polar_determinant_lines.sage` computes det H and det Gamma on
two deterministic projective lines, including their infinity points.
Both have full degrees32 and24 and gcd1. Both leading matrices are
invertible, so no infinity zero is omitted. A root of either det H is
therefore a cup-invertible point where H is singular. The polynomials,
factorizations and exact coefficients are saved in the matching JSON.
This rigorously rules out eliminating U by an unconditional inverse of H.
It does NOT imply that any such point meets the remaining atlas equations.

## 7. Exact failure of the rank-only shortcut

The12 acyclic representatives have exactly their old equations; this
extension alone does not shorten their unresolved elimination. The proposed
exceptional shortcut was tested by
[exceptional_inverse_cup_diagnostic.sage](../scripts/exceptional_inverse_cup_diagnostic.sage);
the frozen coefficients and kernels are in
[its exact receipt](../Research/computations/exceptional_inverse_cup_invariant0.json).
This polynomial-only calculation took0.313 seconds on one CPU core.

It reconstructs H0(V), the32-dimensional quotient-section space, the
third-order map Q and the cup and q tensors. Every computed kernel and
fifth-power reconstruction is replayed against its original matrix.
For invariant_0, the recorded sector-zero cup matrix Gamma has rank21,
but mu_Gamma:U->Gamma q(U) has rank29, not32. Its three kernel basis
directions have q ranks3,3,1. These exact matrices disprove uniform
full column rank on the rank21 cup stratum. They do not satisfy, or claim
to satisfy, the remaining inverse and gradient equations.

Consequently no rank-deficient stratum may be discarded, and repeating
the proposed rank-only diagnostic cannot exclude this oper. Any further
computation must retain the full system(S), including all minor opens,
coefficient Frobenius and normalization. The larger augmented inverse
is a correctness reference, not a predicted solver improvement. The full
exceptional B/minor-patch tensor was not exported; no representative was
excluded. An earlier optional duality sanity check was stopped under the
CPU cap and contributes no claimed evidence.

## 8. A reduced rooted inverse scheme, without weak-incidence equations

Use the coefficient roots in(R), and write z for all its auxiliary
inverse-block entries. Every entry of Dtilde(v)Gtilde(b,z) raised to
the fifth power is the corresponding entry of D(U)G(beta,Z), under
U=v^[5], beta=b, Z=z^[5]. The same holds for the trace defining t.
Thus(R) maps to(1), and unique fifth roots give a bijection on geometric
points. It is essential also to prove reducedness.

At a geometric point a tangent vector (dv,db,dz) to(R) has db=0.
Taking fifth powers of the linearized inverse equation gives the
linearized original inverse equation with dU=dv^[5], dZ=dz^[5].
Set d(beta)=dt^[5]. The original gradient equation is beta-t_original=0;
its differential is then zero too. Indeed t_original depends on beta
only through beta^[5], so this new choice of d(beta) changes neither
the inverse differential nor the differentiated trace. Coefficient
rooting commutes with both first and second derivatives here.

We have constructed a tangent vector to the original finite reduced
scheme(1). It is zero, hence dv=dz=0, and already db=0. The rooted
scheme consequently has zero tangent space at each of its finitely
many geometric points. It is finite reduced. The geometric-point
bijection is therefore an isomorphism of finite reduced schemes over
the perfect coefficient field. This argument does not assert that the
raw substitution ideal, before taking roots of its equations, is reduced.

Finally, mixed homogeneity gives
sum v_i partial_i Dtilde=E0 Dtilde+Dtilde E0. Since both products of
the inverse matrices equal I, v.t=-2n=2. Degrees follow directly from
the quadratic B and linear q,a, with linear Gammatilde and auxiliary
inverse entries. This proves(R) for both cohomology profiles, without
assuming an invertible exceptional cup block or a generic pencil rank.

For the first acyclic oper, check_rooted_inverse_cup.sage independently
replays twelve sparse cubic inverse equations against saved original
N/R provenance, including four diagonal equations with constant1.
Every coefficient passes. A60-second one-core diagnostic adding these
seeds to the weak normalized system did not finish; it did NOT test a
complete replacement by(R). Its raw evidence is external under
litt3-computation-data/atlas-normalized-rooted-cubic-20260908.

## 9. A multiplication-spanning set tests the entire inverse

Retain all hypotheses of cohomological_bezout, in particular global
generation of M and the exact description of D on every zero stratum.
Let S*H0(M)=H0(M²). Then S has no base point: otherwise every section
of the globally generated M² would vanish there. Moreover evaluation
A->A Q is injective on the fixed linear cup-matrix space im K, since
the associated functional vanishes on every product S*H0(M). This
linear injection is split over the coefficient field, hence stays
injective over every coefficient algebra.

At a geometric solution of(C), write xi,z for a column of its proposed
inverse. The lower equation a xi=0 makes
h_V a_u i_T xi+z a Cech0-cochain whose differential is a_u i_T xi.
It is a PAIR of regular local sections, not generally a global section
of V. Applying b_u makes it closed and therefore global; the upper
equation says its image is the selected section of S. If u has zero
divisor E, every such image lies in H0(M(-E)). Since S has no base
point, E is empty. The case u=0 contradicts Q!=0 as well.

Thus det D vanishes at no geometric point of the finite-type coordinate
ring defined by(C); it is a UNIT in that ring, without reducing it.
The inverse then gives [Gamma Q;Z]=D^-1[Q;0]. Its top-left block lies
in im K as a regular-function identity on the admissible open, by
Section1. Split injectivity of evaluation on Q gives Gamma=(D^-1)_11
over the whole coordinate ring, including nilpotents. The remaining
entries of the inverse and Z are uniquely recovered. This proves the
scheme-theoretic equivalence; the converse is immediate.

After coefficient rooting, the same argument identifies(C) with the
full rooted inverse incidence in Section8. On that incidence N=0 and
the extension is normalized. The FULL projected compact R equals the
full mixed logarithmic gradient, by Section2. Taking coefficient roots
therefore identifies b=s(v,b)^[5] with all the gradient equations in(R),
including the nonacyclic trace terms. Finiteness and reducedness follow
from Section8. No exceptional direction, field-extension point, or
normal-corank stratum is discarded.

For the fixed curve the exact multiplication matrix for S=<y,x^10,x^4y²>
has size56x72 and rank56. Its nonzero56-square minor is recorded in
the external pencil-bezout-first-20260908-v2/certificate.json and checked
by scripts/check_pencil_bezout.sage. This calculation depends only on
the fixed curve and its monomial basis, NOT on the oper or its field.
The geometric equations count as stated follows from dim S=3.

## 10. A compact acyclic construction from a rational pencil

For a finite degree-d map pi:C->P1 and acyclic rank2 V with det V=omega,
pi_*V=O(-1)^(2d): every summand in its splitting has H0=H1=0.
Dualizing trace of the wedge pairing makes it symplectic with values in
omega_P1. A frame of H0(V tensor pi*O(1)) therefore gives a CONSTANT
nondegenerate2d-square alternating matrix J, over the same field.
No change of the curve to a rational curve is asserted.

For pi=x of degree3, M=O(32O) pushes forward to O(10)+O(7)+O(4).
The map b_u is a3x6 polynomial matrix P(z), linear in u, with row
degrees<=11,8,5. The self-dual section complex implies pointwise
isotropy P(z)J^-1 P(z)^T=0. Consequently its divided-difference matrix
P(z)J^-1 P(w)^T/(z-w) is polynomial, symmetric on exchanging the two
arguments, of row/column degrees<=10,7,4. The usual two-affine-open
Cech splitting on P1 identifies its coefficient matrix, with the
fixed Cech sign, with B. Indeed multiplication of a principal part by
the adjoint P has a unique primitive in O(-1)^6; splitting its positive
and negative powers gives exactly the divided difference. This is
the same connecting-map calculation as Section1, after finite pushforward.

The first-oper implementation verifies the coordinate/sign comparison
against EVERY one of the528 existing quadratic matrices, not only at
sample sections. It uses six horizontal functions in L47 representing
H0(W11O),15 frame Wronskians and192 quotient/frame Wronskians. Each is
replayed as a fifth power in L22 or L35, respectively. The trace formula
Tr_x(h theta)=3*[y²]h dx gives J. In the script's explicit convention,
the kernel -P(z)J^-1 P(w)^T/(z-w) must be multiplied by4 to match the
old B tensor. All304128 coefficients agree. The check and multiplication
minor took1.56s on one core; this is NOT an atlas-solver timing.

The same construction is proved for every acyclic V, but has not yet
been implemented on all twelve coefficient fields. For r=3 the trivial
pushforward splitting is false; use the mixed construction instead.
