# Proof: canonical exact-root lifts and free character kernel

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/actual_q0_tensor_exact_stabilizer_root_quotient.md). [Focused whole review PASS](../../Research/audits/Q0_ROOT_STABILIZER_AND_PETRI_RECOGNITION_AUDIT_2026_10_03.md). All groups act on the specified actual smooth normalization; no simultaneous Galois closure is assumed.

Write a=h*q0 and θT=h*θ. On T one has div(a)=D−6H and div(θT)=16H, where H is the reduced original infinity fiber. Thus div(τT)=8D. Since S0 fixes τT exactly, it preserves D. The G action is free, hence so is S0 on D. Its quotient has degree
\[
\deg(D/S_0)=6d/|S_0|=3m_0/4.
\]
This proves4|m0. The connected Kummer extension T′=T(w),w³=a, is ramified with index THREE precisely at the simple D zeros. Its poles have order SIX and are unramified. Hurwitz gives
\[
2g(T')-2=3(16d)+2(6d)=60d.
\]
The accepted actual root base-change construction makes T′→X′ étale of degree d. Pulling θT as a differential to T′ adds the different2D′; multiplying by w⁸ then gives div(ηT′)=10D′. Its cube is the pulled CANONICAL tensor τT, with the differential pullback convention, not merely a coefficient function.

We construct the lifts explicitly. For g∈S0, set a_g=g*a and θ_g=g*θT. Ratios of nonzero differential forms are genuine functions on T. Put R=a_g/a and s=θT/θ_g. Exact invariance of τT gives R⁸=s³. Then
\[
b_g=s^2/R^5,\qquad b_g^3=R,\qquad b_g^8=s.
\]
The second identity follows from s³=R⁸; for the third use s¹⁵=R⁴⁰. Hence the field automorphism extending g by w↦b_gw fixes ηT′=w⁸θT exactly. It is unique among the THREE lifts, because deck multiplication w↦ζw multiplies ηT′ byζ⁸=ζ², a faithful deck character. Uniqueness implies that composition of two chosen lifts is the chosen lift of their composite. The lifts form an actual subgroup J≅S0 on the field and hence on its smooth projective normalization. The formulas also show that J commutes with the deck C3. Thus the full lifted group is C3×J, not a merely asserted split extension.

The quotient T′/(C3×J) is the ACTUAL smooth curve Z0=T/S0. Every inertia subgroup of T′→Z0 is contained in deck C3: any stabilizing automorphism must project to an automorphism of T fixing its image point, but S0 acts freely on T. At D′ its inertia is all C3, and there is no other inertia. Therefore J has no nonidentity point stabilizers. Its actual quotient T′→C=T′/J is finite étale and Galois, of degree|S0|=8d/m0.

The remaining quotient C→Z0 has degree THREE and exactly the D/S0 branch points, all with index THREE. Since Z0→Y is étale of degree m0, g(Z0)=m0+1. Hurwitz then gives
\[
2g(C)-2=3(2m_0)+2(3m_0/4)=15m_0/2,
\qquad g(C)=15m_0/4+1.
\]
The η-fixing J action and étale descent give a genuine regular form ηC with div(ηC)=10D_C. Its pullback to T′ is ηT′. The original exact-root primitive is explicit on X′, so Cartier(ηT′)=0. Cartier naturality and injectivity of pullback along T′→C imply Cartier(ηC)=0. The Cartier kernel criterion on the actual function field therefore makes ηC exact; no trace division by the possibly characteristic-divisible group order is used.

For the projective stabilizer, g*τT may be a nontrivial scalar times τT. The canonical η-fixing lift above then fails unless this scalar is ONE. Accordingly all formulas use S0, the kernel of that scalar character. This is a necessary restriction, not a presumed trivial character.

Finally T′→T is ramified at D, so composition with the original étale Y map is ramified. The construction retains the original T and its original two maps; it supplies a normalized auxiliary η carrier and two actual étale root-source maps, not an original common-cover solution or a proof of elliptic field recognition.
