# Proof: exactness excludes the trivial-Cartier nonzero-q1 source

Version1, 3 October2026. [Fresh independent six-check whole source audit](../../Research/audits/CANONICAL_TEN_CONSTANT_DZERO_TRIVIAL_CARTIER_NONZERO_Q1_WHOLE_AUDIT_2026_10_03.md): PASS, no repairs or missing antecedents within the stated ORIGINAL source scope. Original reviewed input pins are preserved in the report.

We write q^{(1)}:T1→Y1 for the relative-Frobenius twist of the original q. Divisors D_J and Q live on Y1; the adjunction divisor R_Q lives on Y. Their supports are compared through the universal homeomorphism F_Y. All divisor pullbacks involving ordinary differentials below use the original q:T→Y and h:T→X.

## The target intersection consists of infinity alone

Suppose ℓ(q1)≠0. The accepted actual infinity-support ledger gives the two distinct wild points R_+^{(1)},R_-^{(1)} in the degree-three net determinant defect D_J. The trivial inherited class gives Q=O_{Y1}(−P1) exactly, not merely after pullback by F_Y. The net section has line ω_{Y1}Q^{-1}=O(3P1), and the wild pair is canonical. Consequently
\[
D_J=R_+^{(1)}+R_-^{(1)}+P_1.
\tag{1}
\]
Indeed its remaining effective point S satisfies O(S)=O(P1); degree-one effective divisors on a genus-two curve with the same line class are equal.

In the residual trivial families, the first coordinate of the original Q-adjunction is
\[
j_0=x_Y^3-vt x_Y^2+t w_Y,
\qquad v^2=B,\quad t\ne0.
\tag{2}
\]
At the wild points x_Y=0 one has w_Y²=−1 and j0=t w_Y≠0. The audited d-zero adjunction divisor is P plus its affine zero divisor, so it contains P and avoids both wild points. Therefore, on underlying geometric supports,
\[
\operatorname{supp}(D_J)\cap\operatorname{supp}(R_Q)=\{P\}.
\tag{3}
\]
Only this support statement, not simplicity of the affine zeros, will be used.

## At most two cubic branches are exceptional for the actual kernel plane

Let W=kerℓ in the ORIGINAL constant three-section space on X. Since ℓ(q0)=0 and ℓ(q1)≠0, it has a basis q0,q2−κq1 for a constant κ. Its actual raw image on T lies in q^{(1)*}K. At infinity its primitive orders are11 and2, because q2 has the uniquely lowest order2. Dividing the q0 direction by the square of the Frobenius-target parameter gives primitive order1, independent of the other direction of order2. Thus saturating this plane gains exactly two determinant units at infinity.

Let z be the number of finite cubic branch points on X where its raw fiber rank is at most one. Each such point gains at least one determinant unit on saturation. The raw plane is O_X², and all other saturation contributions are nonnegative. The complete fixed-plane bound degSat(W)≤4 therefore gives
\[
2+z\le4,\qquad z\le2.
\tag{4}
\]
Equivalently the exact fixed-plane formula is degSat(W)=3+z−a(ℓ)=2+z, because a(ℓ)=1 for ℓ0=0,ℓ1≠0. The fifth-power transport of ℓ in the fixed-X loss-vector equation preserves its zero coordinates. No choice of a generic plane or prescribed exception pair is made here.

## Each nonexceptional original branch maps into the target intersection

At a nonexceptional finite cubic branch, the raw W fiber has rank two. The full original raw net also has rank two and primitive orders(1,4,7); hence the two fiber images agree and contain the intrinsic order-four line F4. After actual étale pullback by h, this line is contained in the fiber image of q^{(1)*}K.

For completeness, choose a local étale source parameter s and target Frobenius parameter s⁵. Write a local generator of Q in primitive classes as a=Σ_{i=1}^4 a_i(s⁵)[s^i]. The original alternating Cartier form pairs orders whose sum is five. Pairing [s⁴] with a is a1(0)d(s⁵), whereas the Q-adjunction evaluates to a1(0)ds. Saturation makes K the genuine orthogonal fiber hyperplane, so F4⊂K forces vanishing of this adjunction. The q-target is therefore in R_Q.

Choose an ORIGINAL constant direction outside W, for instance q1. Its raw B_T fiber is a linear combination of the two raw W images. Subtract that combination in the actual q^{(1)*}J fiber. The resulting vector maps to zero in B_T, but its value in q^{(1)*}(J/K) remains the nonzero constant ℓ(q1). Thus it is a nonzero kernel vector of the fiber map J→B_Y and witnesses a determinant defect. The q^{(1)}-target lies in D_J. This is the same local source argument as in the accepted incidence proof, now for W=kerℓ; that theorem's zero-q1 exception count is not imported into this branch.

By(3), every source point over a nonexceptional finite cubic branch lies in q^{-1}(P). The actual étale h-pullback of the ten reduced branches has10d distinct points. If z≤1, at least9d of these would lie in one q-fiber, which has exactly8d points. Hence z=2. Let its two exceptional points be r,s. The other eight h-fibers have8d distinct points and fill q^{-1}(P), giving the equality of REDUCED divisors on the SAME T:
\[
\boxed{q^*P=h^*(R_X-r-s).}
\tag{5}
\]
Here R_X is the sum of all ten finite cubic branch points. The points r,s are distinct; their x_X-coordinates, also denoted r,s in polynomials below, are distinct. Neither multiplicities of the affine Q-adjunction nor an exact finite-field enumeration of this pair is needed.

## The actual differential normalization forces exactness

On X put θ_X=dx_X/y². The cubic degree-ten model has
\[
\operatorname{div}\theta_X=16O,
\qquad\operatorname{div}y=R_X-10O,
\qquad\operatorname{div}(x_X-r)=3r-3O.
\tag{6}
\]
On Y, divη=2P. Since BOTH q and h are étale, their differential pullbacks have these pulled divisors. Define actual rational functions on T by
\[
f=\frac{q^*\eta}{h^*\theta_X},
\qquad g=\frac{f}{h^*(y^2)}.
\tag{7}
\]
The y² division is essential. Equations(5)–(7) give
\[
\operatorname{div}g
=2h^*(R_X-r-s)-16h^*O-2h^*(R_X-10O)
=h^*(4O-2r-2s).
\tag{8}
\]
Let S(x_X)=(x_X-r)(x_X-s). Its divisor is3r+3s−6O. Thus div(g³ h*S²)=0, and connected projectivity of T gives a nonzero constant C∈k with
\[
g^3=C\,h^*S^{-2}.
\tag{9}
\]
Differentiate the actual function-field identity(9). In characteristic five,−2/3=1, so
\[
3\frac{dg}{g}=-2\frac{d(h^*S)}{h^*S},
\qquad\frac{dg}{g}=\frac{d(h^*S)}{h^*S},
\qquad d\!\left(\frac{g}{h^*S}\right)=0.
\tag{10}
\]
The quadratic polynomial S has a rational polynomial primitive, since2 and3 are units:
\[
F(x_X)=\frac{x_X^3}{3}-\frac{(r+s)x_X^2}{2}+rsx_X,
\qquad dF=S\,dx_X.
\tag{11}
\]
By the ACTUAL normalization(7), q*η=g h*dx_X. Equations(10),(11) now show
\[
q^*\eta
=\frac{g}{h^*S}\,h^*(S\,dx_X)
=d\!\left(\frac{g}{h^*S}\,h^*F\right).
\tag{12}
\]
This is exactness of the original pulled differential in k(T). No inference that g itself is flat, no descent of q to an abstract quotient, and no coprimality condition on either original covering degree is used.

## Cartier gives the contradiction

Cartier annihilates exact rational differentials and commutes with pullback along the actual finite separable q. For the sparse genus-two model, η=w_Y⁴dx_Y/w_Y⁵; extracting the x⁴ and x⁹ coefficients of H² gives
\[
C_Y\eta=(3B)^{1/5}\eta+(2AB)^{1/5}x_Y\eta\ne0.
\tag{13}
\]
Both A and B are nonzero in the fixed field. Thus(12),(13) imply
\[
0=C_T(q^*\eta)=q^*(C_Y\eta)\ne0,
\]
because a finite separable pullback is injective on rational differentials. This contradiction excludes ℓ(q1)≠0 for every t≠0 and both roots v²=B.

## Provenance and six focused whole-review tasks

The reused inputs are the [scalar-zero reduction](canonical_ten_constant_dzero_scalar_zero_cartier_alternatives.md), [actual saturated-net incidence](canonical_ten_unmarked_saturated_net_annihilator_incidence.md), and [complete fixed-plane bound](first_section_contact_strictness.md), in their existing reviewed scopes. This proof uses the last result as a theorem and performs no certificate replay or new arithmetic. The preparatory exceptional-row/C3 note is not needed: neither its forty-five-pair readback nor its field-descent extension is an antecedent of this exclusion.

An independent whole review should check:

1. Exact residual Q=O(−P1), j0 normalization and wild avoidance; the degree-one argument proving(1), and the relative support intersection(3).
2. The SAME original W=kerℓ plane, its infinity gain2 and degree≤4 bound; z≤2 without importing the zero-q1 gain3 or silently dropping geometric coefficient transport.
3. The generalized local F4/alternating-pairing incidence and ORIGINAL nonzero quotient direction witnessing D_J; saturation and both original map antecedents.
4. The reduced8d/9d count, exactly two DISTINCT cubic exceptions, and equality(5) on the ORIGINAL source, with no quotient-orbit degree substitution.
5. The y² normalization, all divisors(6)–(9), the characteristic-five logarithmic identity, actual primitive(11), and exactness(12).
6. Cartier formula(13), actual separable pullback contradiction, and the narrow nonzero-q1 scope; no zero-q1, d_fam≠0, lattice-loss or unmarked-source conclusion.

The parent checked the exactness shortcut independently before canonical authoring. This is not a substitute for the fresh whole review requested above. Both original finite étale maps remain on their SAME T throughout.
