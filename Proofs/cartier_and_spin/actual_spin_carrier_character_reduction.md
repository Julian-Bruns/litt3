# Proof: general carrier obstructions, two character extractions and effective six

Version1. [Statement](../../Theorems/cartier_and_spin/actual_spin_carrier_character_reduction.md). [Independent whole-implication review: PASS](../../Research/audits/ACTUAL_SPIN_CARRIER_CHARACTER_REDUCTION_AUDIT_2026_10_03.md). Keep both original actual maps onT. Use the natural canonical Hurwitz section d of O_T(qP), the spin identification φ*N≅O_T(qP), and the transported genuine G-linearization. Write s for d viewed through that identification. Its coefficient in a rational N frame is the primitivea. For kernel order three the accepted theta recognition makesK act on that coefficient by a faithful cubic scalar character.

## The odd-degree and uniform-fiber proofs are carrier-level

The accepted [parity and mixed-fiber proof](actual_spin_ramified_parity_and_mixed_fibers.md) uses only the retained actual data. At z∈Γ, its stabilizerG_z acts freely on the φ fiber and preserves local indices, so |G_z| dividesκ. Ifκ is odd, every Γ→B inertia group and every higher ramification group has odd order. Its local different is therefore even. In the local towerT→Γ→B, the actual étale q identifies completed local fields ofT andY. Thus the Y→B different is odd atP (1+2 times an even integer) and even everywhere else, contradicting global Hurwitz parity. Henceκ is even, with no image-normalization hypothesis.

If the ramified target fibers were uniform of index two, the actual Galois closureZ→Γ would be étale overT: all local inertia is the same tame quadratic extension. Descending original infinity sections make the theta divisor invariant under every deck element ofZ→Γ. Actual theta recognition sends a branch inertia involution toC3 on the original X map and hence to the identity. It would then be a nonidentity automorphism over an actual étale X map with a fixed point, impossible. Transitivity ofqP makes all branch fibers have the same profile. Therefore every one is mixed.

The stabilizer of a ramified target point containsK and has at leastk elements. Its ramified points form a free orbit, so a mixed fiber contributes at least2k ramified multiplicity and at leastk unramified multiplicity. Thus κ≥3k. Combining this with evenκ and oddk gives κ/k an even integer at least FOUR.

## Every primitive even polynomial is excluded on these carriers

An even primitive polynomial gives an actual involutionτ overΓ sendinga to−a. Frame transition factors lie inΓ, soτ commutes withG. It preservesqP and all descending original infinity divisors. Actual theta recognition makes it act overX, since its order two has trivial image inC3. Thusτ acts freely.

Choose t∈q^−1(P) and writeτt=gt using the unique element of the free G orbit. Commutation gives g²=1. It is nontrivial, and cannot lie in the odd-order kernelK. The nontrivial involutionτg fixes t and acts onΓ asg, also a nontrivial involution fixingφ(t). Both tangent scalars are−1, whereas the index-two φ map requires the target scalar to be the square of the source scalar, namely+1. Contradiction. This argument uses only the stated carrier hypotheses.

## A trivial pulled character lowers degree inside the SAME source

For the selected tame source use the [Weierstrass-character reduction](tame_spin_weierstrass_different_reduction.md). Put U=T/K, H=G/K and S=[Γ/H]. The exact-order E lineχ has trivial actual pullback toY, since P is Weierstrass. Its connected cyclic finite étale root-stack coverC→S therefore admits an actual liftY→C after choosing a constant E-th root. In particular k(C)⊂k(Y).

The actual compositumΓY equalsU: any H deck element fixingΓ is trivial. Its two degrees [U:Γ]=[Y:B]=n imply linear disjointness ofΓ andY overB. HenceΓ1=ΓC⊂U has exact degreeE overΓ. It is the connected pullback ofC→S along the étale atlasΓ→S, and Γ1→Γ is étale. The induced G action fixesC⊂Y, so its kernel remainsK. The originalφ factors throughΓ1 with degreeκ/E, same differentqP, and M1=pullM. OldΓ(a)=T impliesΓ1(a)=T directly. Every infinity section still descends. Applying the general carrier obstructions just proved gives E|n and n/E even and at least four. No image-normalization theorem is used forΓ1.

It remains to treat k=3 andχ=1.

## The second section is canonical and has the same divisor

SinceP is Weierstrass, choose a nonzero ηY with divisor2P. Its actual pullback η=q*ηY has divisor2qP and is G-invariant. Canonical Hurwitz identifies ωT=φ*ωΓ⊗O_T(qP), equivariantly. Thus
\[
v=\eta/d
\]
is a G-invariant section of φ*ωΓ with divisorqP. In particular its rational coefficient in a Γ differential frame is fixed byK, and belongs toT^K. The spin section s has the same divisor. Their quotient is a nowhere-zero, G-invariant section of φ*ρ, whereρ=N⊗ωΓ^−1.

The hypothesisN³≅ωΓ³ is an identification of genuine linearized lines, soρ³≅OΓ equivariantly. Cubing s/v yields a nonzero constant after this trivialization, and rescaling by a constant makes it one. The nowhere-zero section therefore gives an actual liftT→Γ′ to the cyclic étale ρ-trivializer overΓ. This is a root inside the original field, not a hypothetical cover. Ifρ were geometrically trivial, s/v would have constant coefficient in a Γ frame. G-invariance would contradict the faithfulK action onρ, becauseK acts trivially onΓ andωΓ and nontrivially onN. Henceρ has exact geometric order three, Γ′ is connected, and its field embedsT with degree three overΓ.

The lift is G-equivariant. An element fixingΓ′ must fixΓ and hence lie inK. ButK acts faithfully on the three ρ-root sheets, so that element is the identity. Therefore the G action onΓ′ has trivial kernel.

## The canonical different and primitive field are retained

The mapΓ′→Γ is étale. With M'=pullM, the induced φ′:T→Γ′ retains L=φ′*M′ and its different EXACTLYqP. Its new discrepancy N' is pullN. The root trivialization makes N'≅ωΓ′, and under this identification the different section s becomes v up to a nonzero constant.

In rational frames, let r be the coefficient of s/v; thenΓ′=Γ(r), while a=rv. The original equalityΓ(a)=T therefore gives
\[
\Gamma'(v)=T.
\]
Thus v is the actual primitive canonical different coefficient overΓ′, of degreeκ/3. Original infinity sections and all original spin sections pull toΓ′, and both original endpoint maps stay on the SAME T. The projective section ratios still normalize toΓ; nothing here callsΓ′ a new normalized projective image.

## Degree six is excluded directly at the Weierstrass point

Suppose degφ′=6. Its primitive characteristic coefficients ej are genuine G-invariant sections of ωΓ′^j. The actual functions
\[
r_j=\phi'^*e_j/v^j
\]
descend toY and have no possible pole away fromP. Since v has simple zero atqP, their pole bound is jP. For j=1or3, the only positive odd pole orders are one and three, the two Weierstrass gaps. Their pole orders have the parity ofj because the actual target coefficient order pulls back with index two. Hence r1,r3 have no pole and are constants. A nonzero constant would force v^j∈Γ′, contrary to its degree-six primitivity for j<6. Thus e1=e3=0.

At every ramified target fiber the local quadratic of v has linear and constant coefficients in the target maximal ideal. In the characteristic degree-six product, e5 is the coefficient of the linear term. Every contributing product uses at least one such vanishing coefficient, whether the mixed fiber has one or two ramified pairs. Therefore e5 vanishes at every ramified target point to order at least one. Consequently r5 has pole at most3P, with odd parity. Again the Weierstrass gaps force it constant, and degree-six primitivity forces e5=0.

All odd coefficients vanish. The actual primitive degree-six polynomial is even, so v↦−v defines an actual involution ofT overΓ′. It commutes withG because v is the canonically invariant different section in a Γ′ frame. Original spin sections descend toΓ′; their theta divisors are invariant under this involution, so actual theta recognition identifies its action on each original X map with an automorphism inC3. Its order two forces that automorphism trivial. Thus the involution is over the actual finite étale X map and acts freely.

Finally choose t∈q^−1(P). This divisor is one free G orbit and is preserved by the involutionτ. Writeτt=gt for its unique g∈G. Commutation andτ²=1 give g²=1. The elementτg fixes t, is a nontrivial involution, and acts onΓ′ as the nontrivial involutiong (G acts faithfully there). Its tangent scalar at the fixed source point is−1, while the index-two φ′ map would square it to+1 on the target. The target involution has tangent scalar−1, a contradiction. This is precisely the actual canonical-minus tangent obstruction, applied to the retained carrier data.

The degree-six consequence is proved without substituting separable maps for either original endpoint map or assuming thatΓ′ is the projective spin normalization.

## Complete effective-six coverage

Now start with any selected originalκ=18,k=3,n=6 ramified spin normalization. The accepted tame classification gives exactly(2,2,2,3),(3,3,6),(2,6,6), including the possible distinguished-cone fibers. The character exponents in the Weierstrass theorem are respectively two, three and six. Thus its exact order E belongs to{1,2,3,6}.

The actual character-cover reduction requires6/E to be even and at least four. None of E=2,3,6 satisfies this. Therefore E=1 andχ is trivial. The cubic ρ extraction then supplies a faithful primitive degree-six carrier with P Weierstrass, which was just excluded directly. This proves the whole kernel-three effective-six branch impossible on BOTH endpoints.

No claim about other tame degrees or the étale image branch is made. The earlier independently reviewed individual weight-row exclusions remain useful special cases; the new coverage proof uses the actual character carriers instead of assuming their intermediate targets are normalized projective images.
