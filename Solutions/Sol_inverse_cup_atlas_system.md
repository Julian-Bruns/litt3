# Proof: matrix inversion without removing singular polar charts

[Statement](../Theorems/Thm_inverse_cup_atlas_system.md).

## 1. Equivalence of the inverse-cup equations

The determinant of B is a nonzero constant times the reduced resultant.
Hence B(U)Gamma=I itself makes U admissible, including at O. For such U,
the inverse-cup theorem identifies B(U)^-1 with the coefficient Frobenius
twist of its normalized extension cup matrix. The cup map is injective
here: products of L32 monomials span L64, so their residue-dual map is
injective. Consequently B(U)Gamma=I uniquely identifies eta^[5] with the
extension class giving N_U eta^[5]=0 and Wronskian1.

This is also scheme-theoretic. On the open set det B!=0, both systems
are the graph of the same rational E-valued function gamma(U), with
gamma=eta^[5] imposed afterwards by base change. A fixed linear left
inverse of the cup map recovers that graph from B^-1. Conversely a
matrix inverse in any coefficient algebra makes det B a unit. Thus no
nilpotent or boundary component is introduced by using the matrix equation.

On this graph the audited global gradient formula reads

    i(R_U eta^[5]) = -dDelta/Delta
                  = -(Tr(B(U)^-1 partial_i B(U)))_i.

The coefficient Frobenius convention is unchanged: B is quadratic in
U, and Gamma is linear in eta^[5]. Substituting Gamma=B^-1 gives exactly
the second group of equations in(1). These equalities are identities on
the graph, not empirical equalities at its geometric points. Therefore
(1) defines the same scheme as the compact atlas system. Its finiteness
and reducedness follow from that audited theorem.

Euler's identity for the quadratic matrix gives

    U.beta = -Tr(Gamma sum_i U_i partial_i B)
           = -2 Tr(Gamma B) = -2*24 = 2 in characteristic5.

Thus the quadratic normalization need not be imposed separately in(1).
Symmetry of H follows by taking the Hessian of the quadratic function
Tr(Gamma B(U)); differentiation here keeps Gamma fixed.

## 2. Exact boundary kernel and its cup rank

Write ell=deg L>2g as in the extension-space conventions. Stability of W
implies deg D<ell: the saturated subline L^-1(D) of W has negative degree.
For D>0 the saturated section gives

    0 -> L^-2(D) -> W L^-1 -> O(-D) ->0.

Since H0(O(-D))=0, the map H1(L^-2(D))->H1(W L^-1) is injective.
The original map factors through it, proving(2). Also
H0(L^-2(D))=0, so(2) has dimension deg D and is exactly the image of
principal parts on D. Under Serre duality it is the linear span of the
length-deg D subscheme D in the embedding defined by omega L^2.

Cup product with such a class factors through restriction of its argument
to D; a section vanishing on D kills the principal part. Its rank is
therefore at most deg D. For the fixed curve ell=24, so it is at most23.
This proves that matrix inversion removes EVERY invalid quotient on the
acyclic branch, not just a generic boundary divisor. Acyclicity is essential
to using a24x24 invertible cup matrix; it is not imposed on the55 r=3 opers.

## 3. A large unavoidable boundary family from the third-order operator

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
its zero divisor contains4P; equation(2) therefore puts eta_P in its
N-kernel. This gives P23 over each P, hence a24-dimensional family in
the projective N/J incidence. Entrywise coefficient Frobenius transports
this statement to the U,eta coordinates without changing dimensions.
No member is admissible; the universal radial normalization prevents it
from becoming a solution of the actual compact atlas system.

## 4. Exact trace and chart checks for the first oper

The complete quadratic tensor is saved in wronskian_quadratic_bezout.json.
`wronskian_trace_linearization.sage` contracts it with all32 canonical
cup matrices and checks every bilinear coefficient of

    -H(beta^[5])U - R_proj(U,beta^[5]) = C N(U,beta^[5])

for a saved constant32x64 matrix C. This particular all-strata polynomial
syzygy is computational evidence for the first oper; the scheme equivalence
above does not presume it for other opers.

`wronskian_polar_determinant_lines.sage` computes det H and det Gamma on
two deterministic projective lines, including their infinity points.
Both have full degrees32 and24 and gcd1. Both leading matrices are
invertible, so no infinity zero is omitted. A root of either det H is
therefore a cup-invertible point where H is singular. The polynomials,
factorizations and exact coefficients are saved in the matching JSON.
This rigorously rules out eliminating U by an unconditional inverse of H.
It does NOT imply that any such point meets the remaining atlas equations.
