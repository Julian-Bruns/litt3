# Proof: primitive source generation by an actual étale target

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_ten_joint_etale_target_field.md). The complete argument passed [root whole review](../../Research/audits/CANONICAL_TEN_GROUP_AND_JOINT_TARGET_AUDIT_2026_10_03.md). The actual source is unchanged and retains both original maps.

The accepted S10 closure has T=Z/S9 over Γ=Z/S10. The point stabilizer S9 is maximal in S10. Hence T/Γ has NO proper intermediate field. Apply this to
\[
k(\Gamma)\subset k(\Gamma)k(D)\subset k(T).
\]
If the middle field were k(Γ), then k(D)⊂k(Γ). The actual finite morphism T→D would factor through T→Γ→D. An intermediate morphism of an étale curve cover is étale: at each point the local ramification indices multiply, and all are positive integers. Here T→Γ has an actual index-TWO ramification point, so its composition to D could not be étale. This contradiction excludes the smaller alternative. Therefore ΓD=T.

This argument uses only primitive actual T/Γ and its nonzero ramification together with an actual étale T/D. Its application to the coefficient row does not use the eighth-power tensor-field result, individual q₀ scalars, or inferred X-field recognition.

## The actual coefficient curve is D joined with the coarse coordinate

First the accepted commuting normal closure gives
\[
\operatorname{Aut}(T/B)=G.
\]
Indeed Z/B has group G×S10 and T=Z/(1×S9). The normalizer of the point stabilizer S9 in S10 is S9 itself. The usual normalizer description of automorphisms of an intermediate field therefore gives Aut(T/B)=(G×S9)/(1×S9)=G. This is an actual field statement about the proved normal closure; it is not a simultaneous étale closure of the original X- and Y-maps.

Put F=k(D)k(B). Since Γ/B is ACTUALLY Galois and ΓD=T, the extension T/F is Galois: it is the actual base change of Γ/B to F. Every member of its Galois group fixes B and so lies in the just-computed Aut(T/B)=G. Conversely a member of G fixes F exactly when it fixes D. In the actual coefficient row, the latter condition is exactly membership in N=ker(G→R), because the entire projective image R acts faithfully on the nondegenerate normalized row D. Hence
\[
\operatorname{Gal}(T/F)=N,
\qquad F=k(T)^N=k(C).
\]
The resulting maps C→D and C→B are genuine maps inside the same source field. C→D is étale by the separate row theorem, whereas C→B need not be étale. No further endpoint descent is supplied.
