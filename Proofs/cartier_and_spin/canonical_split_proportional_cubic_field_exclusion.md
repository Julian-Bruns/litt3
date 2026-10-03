# Proof: a common cubic zero contradicts the actual index-one field

Version1, 3 October2026. [Fresh independent whole audit PASS](../../Research/audits/CANONICAL_SPLIT_PROPORTIONAL_CUBIC_FIELD_EXCLUSION_AUDIT_2026_10_03.md). The local implication was independently checked by `/root/split_higher_cohomology`. See the [statement](../../Theorems/cartier_and_spin/canonical_split_proportional_cubic_field_exclusion.md). No computation or source replacement is used.

Suppose, to the contrary, that t¹⁰y₁=ηy₂ for a fixed η≠0. All functions below are the original pulled coordinates in K=k(C₀), not coordinates chosen on an auxiliary component.

## 1. Choose one actual cubic branch point

Take a point p∈C₀ with y₂(p)=0. Such points exist because P has ten simple roots and h₂ is finite surjective. Since h₂ is étale, w=y₂ is a uniformizer at p. The second coordinate x₂ is finite, with value β₂ a simple P-root. In particular p∉H₂ and q₀(β₂)≠0.

The function t has no pole at p, because its pole divisor is supported on H₂. If t vanished, p would belong to H₁ with t having a simple zero and y₁ a pole of exact order10. The product t¹⁰y₁ would then be a unit at p, contradicting its equality to ηy₂. Thus t is a unit. Write a=t(p)∈k×. The assumed scalar equality consequently gives y₁(p)=0. Its first coordinate x₁ has value β₁ a simple P-root, with q₀(β₁)≠0. The argument allows common infinity elsewhere; none is at p.

## 2. Solve the quadratic comparison in the cube of the uniformizer

For i=1,2, the nonzero derivative P′(βᵢ) supplies a unique formal series fᵢ(S)∈k[[S]] with
\[
f_i(0)=\beta_i,\qquad P(f_i(S))=S.
\]
These are ordinary formal implicit inverses, not a new curve or field extension. Put s=w³. Inside the actual completion k[[w]], the two ACTUAL cubic equations and the assumed scalar relation give
\[
x_2=f_2(w^3),\qquad
y_1=\eta t^{-10}w,\qquad
x_1=f_1(\eta^3t^{-30}w^3).
\tag{1}
\]
Consider the formal equation, near T=a,S=0,
\[
F(T,S)=T^6q_0\bigl(f_1(\eta^3T^{-30}S)\bigr)-q_0(f_2(S))=0.
\tag{2}
\]
The inverse T powers are regular formal series because a≠0. The original quadratic identity gives F(a,0)=0. Its T derivative at this point is
\[
\frac{\partial F}{\partial T}(a,0)=6a^5q_0(\beta_1)\ne0.
\tag{3}
\]
Indeed the differentiation of the inner argument has a factor S; additionally the coefficient30 vanishes in characteristic five. The coefficient6 equals1 and q₀(β₁) is a unit. Thus there is a unique solution T₀(S)∈k[[S]] with T₀(0)=a.

In k[[w]], both the ACTUAL t and T₀(w³) solve(2) with the same residue a, by(1) and the original quadratic comparison. The same unit derivative gives uniqueness after substitution S=w³. Hence
\[
t=T_0(w^3)\in k[[w^3]].
\]
Formula(1) now implies x₁,x₂∈k[[w³]] as well.

## 3. The original field identity gives the contradiction

The valuation at p gives an injective field homomorphism K→k((w)). Every rational function of t,x₁,x₂ has, by the preceding conclusion, Laurent expansion in the subfield k((w³)). This includes quotients whose denominators vanish at p; their nonzero denominators simply give negative powers divisible by three. The ACTUAL index-one equality therefore forces
\[
K=k(t,x_1,x_2)\subset k((w^3))
\]
inside its faithful local embedding. But K contains the original coordinate y₂=w, whose valuation is one. Every nonzero element of k((w³)) has valuation divisible by three. This contradiction proves the all-degree statement.

No equality between the abstract completed fields of unrelated curves is assumed. The contradiction uses only one faithful completion of the SAME actual source and its stated generator equality. Étaleness supplies the uniformizer and the exact infinity poles used in Section1.

## 4. The paired global corollary

If b=ηa as global extended sections, restriction to the actual integral image and then to its normalization gives
\[
t^{10}\rho y_1=\eta\rho y_2.
\]
The actual conductor section is nonzero in the function field of C₀, so it cancels. The already excluded scalar equality follows. This corollary does not use zero counterterms, surface smoothness of the image C, a simultaneous endpoint Galois closure or an endpoint map on the conductor divisor. In particular it deletes the globally proportional branch of the degree-fifteen paired-factor analysis while leaving its nonproportional mixed-section branch open.
