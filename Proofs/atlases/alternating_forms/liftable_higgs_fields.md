# Proof: the Serre hyperplane and elementary modification

[Statement](../../../Theorems/atlases/alternating_forms/liftable_higgs_fields.md).
Write π:E3→V and A=H⁰(Vω). Since det V=ω and H⁰(V)=0,
Riemann–Roch gives H¹(V)=0.

## 1. The liftable radical and its Pfaffian

The connecting map of the extension tensored with ω is its Serre
functional λ_α:A→H¹(ω)=k. Thus H_α=image H⁰(E3ω), and
λ_α(u)=1 gives A=ku⊕H_α. Each A_s kills u, so restriction yields

    rad A_s=ku⊕rad B_s,    ker M_s≅rad B_s.

For the second identification use the [scalar Higgs quotient](canonical_divisor_evaluation.md).
Explicitly, φ∈ker M_s gives v=(φ−rI)(u)/s for a global canonical r;
changing r changes v by a multiple of u. Its unique liftable
representative is v−λ_α(v)u.

For dim H_α=2r+1, the signed Pfaffians obtained by deleting one row
and column form a vector in H_α⊗det(H_α)⁻¹. The integral Pfaffian
identities put it in rad B_s, without division by r!. It is nonzero
exactly at rank2r, since an alternating matrix has a nonsingular
principal submatrix of its rank. Here r=2n−1, giving the degree and
the extra-kernel zero locus.

In the even presentation, the same vector is PfaffAdj(A_s)λ_α.
At corank2 the adjugate is a nonzero multiple of u∧v, where
rad A_s=ku⊕kv; contracting with λ_α gives the nonzero liftable
direction. At larger corank all its sub-Pfaffians vanish.

## 2. The parabolic Higgs description

Tensoring the extension by V^∨ω gives

    0 → V → Hom(V,E3)ω → End(V)ω → 0.

Acyclicity of V makes the induced H⁰ map an isomorphism. Composing
the unique lift with π therefore lifts every φ to a unique Z killing
e. Its trace equals that of φ in a frame beginning with e.

Since ω⁻¹u⊂V is a subbundle, over the full scheme D_s the condition
Z(K)⊂Kω is equivalent to φ(u)=r_D u for a unique
r_D∈H⁰(ω|D_s). The definition of M_s requires precisely that r_D
come from H⁰(ω). This proves the identification, including repeated
zeros. In an adapted frame the trace-free Z has matrix

    [0 a b; 0 c d; 0 f −c],

so the two conditions are f|D_s=0 and c|D_s∈image H⁰(ω).
The other entries are fixed by the unique global lift.

## 3. Replace the kernel condition by Hom(G_s,V)

Write G=G_s and i:G→V. Multiplication by s gives μ:V→Gω.
Send T:G→V to the trace-free part of (T⊗ω)μ. Its action on
ω⁻¹u over D_s is scalar, namely minus half its global trace;
hence it lies in ker M_s.

Conversely, for φ in that kernel choose r∈H⁰(ω) with
(φ−rI)(ω⁻¹u)|D_s=0. Then (φ−rI)/s is regular on G:
locally s=z^m and G=⟨u,z^m v⟩, so both images are regular.
Taking the trace-free part recovers φ. A kernel element is a rational
scalar times i; regularity on the subbundle ω⁻¹u forbids poles,
so the scalar is constant. This proves the exact sequence.
The evenness of Hom(G,V) follows from the oddness of rad B_s.

For a saturated N⊂G, det G=O gives
0→N→G→N⁻¹→0. Applying Hom(−,V) gives the two bounds.
Serre duality using V^∨ω=V and Riemann–Roch gives
h⁰(VN)−h⁰(VN⁻¹)=2deg N. If deg N=d>0, N⊂V supplies
h⁰(VN⁻¹)≥1; parity raises the lower Hom bound2d+1 to2d+2.
For N=O(−D), acyclicity gives h⁰(V(−D))=0 and
h⁰(V(D))=2deg D. The degree-zero assertion follows from the same
bounds and the unavoidable positive odd kernel dimension.

A surjection τ:E3→ω(x) killing e descends to V with kernel O(−x).
Killing K|D_s makes that kernel coincide with the osculating line
there, so it lies saturated in G_s. Finally,
H⁰(V(x))≅V(x)|x has dimension2. Regularity of
τ|ω⁻¹ pairs its principal part with the nonzero u(x), giving one
nonzero linear condition. Hence only one projective candidate
survives for each x. Since H⁰(ω(x))=H⁰(ω), factorization by s
indeed requires this regularity.

## 4. Dual lifts and Frobenius

The sequence 0→V→E3^∨ω→ω→0 identifies global covectors with
H⁰(ω), giving σ_s. For a basepoint-free pencil their wedge lies in
H⁰(E3ω). If its image in Vω vanished, then
σ_s1=(s1/s0)σ_s0 rationally. Basepoint-freeness would make
σ_s0/s0 a regular retraction of e, contradicting λ_α(u)=1.
Thus the image is nonzero in H_α, disjoint from the common radical ku.

The pencil covectors have rank2 away from finitely many points and
are not simultaneously zero anywhere. Each rank-one point rules out
one parameter, so a general σ_s is nowhere zero. Its kernel F_s has
rank2 and determinant O. Since H⁰(E3)=ke and σ_s(e)=s≠0,
H⁰(F_s)=0.

For the actual characteristic-five atlas, with F absolute Frobenius,
pull back and dualize F^*E3≅E3^∨ω² to get F^(2*)E3≅E3ω⁸.
Writing μ=deg E3/3, any subbundle S⊂E3 satisfies

    25^j μ(S) ≤ μ_max(E3)+(25^j−1)μ.

Divide by25^j and let j grow. The same argument applies to every
Frobenius pullback, proving strong semistability. At genus9,
coprime rank3 and degree16 give stability.

## Evidence

The [genus-two checker](../../../scripts/genus_two/alternating_kernel_genus_two_check.sage)
retains all original equations and its R-sensitive controls. At all33
known normalized atlas points and26 F25 pencil parameters, the
Pfaffian candidate is nonzero, liftable, and in the individual radical,
while failing the common-kernel equations. This supports the tensor
interface; generic nonvanishing for all actual atlases remains open.
