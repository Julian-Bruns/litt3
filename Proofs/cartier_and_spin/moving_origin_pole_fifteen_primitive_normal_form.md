# Proof: an explicit odd primitive and its forced leading term

Version1,3 October2026. Whole independent review [PASS](../../Research/audits/MOVING_ORIGIN_POLE_FIFTEEN_AUDIT_2026_10_03.md); see the [exact statement](../../Theorems/cartier_and_spin/moving_origin_pole_fifteen_primitive_normal_form.md). No computation is used.

The [accepted moving-origin boundary calculation](moving_origin_exact_differential_primitive_bounds.md) gives the four-dimensional rationally exact subspace spanned by dz,z dz,z³σ,z²σ. Here d y=TWO c₄ z³σ. For a polynomial B, direct differentiation gives
\[
d(yB)=\bigl(\Phi B'+\Phi'B/2\bigr)\sigma.
\]
Since Φ′/TWO=TWO c₄z³, substituting A=z⁵+TWO c₄z⁴+c₄²z³+c₀ cancels the coefficients in degreesEIGHT,SEVEN,SIX andTHREE. The sole remaining term is THREE c₀c₄²z². This proves the asserted identity and the four primitive formulas. The pole orders of z,y,H at P are TWO,FIVE,FIFTEEN; their sum yields the claimed global bound without presuming a vanishing H¹ connecting obstruction.

## Minimality of pole fifteen

The coordinate ring away from P is k[z,y]/(y²−Φ), so every function regular away from P is uniquely U(z)+yB(z). A pole boundFOURTEEN forces degB≤FOUR. The hyperelliptic even derivative dU cannot contribute to the odd differentials z²σ or z³σ.

Write B=b₄z⁴+b₃z³+b₂z²+b₁z+b₀. In ΦB′+Φ′B/TWO the successive highest coefficients are FOUR b₄ at z⁸, then THREE b₃ at z⁷ after b₄=ZERO, then TWO b₂ at z⁶, and then b₁ at z⁵. To obtain only a linear combination of z³ and z² all these must vanish. Thus B=b₀ and its derivative contributes only TWO c₄b₀z³. No NONZERO z² coefficient is possible. The explicit H gives poleFIFTEEN, proving exact minimality. This also applies when even dz,z dz terms are added, since the hyperelliptic eigenspaces remain separate.

## The full coarse ramification ledger

The differential dH is a nonzero constant times z²σ. At P, ordσ=TWO and ordz=−TWO, so ord(dH)=−TWO. For a pole of orderFIFTEEN the local different is ord(dH)+TWO timesFIFTEEN=TWENTY EIGHT.

At the two points z=ZERO the coordinate z is a uniformizer, y≠ZERO, and dH has orderTWO. More precisely A=c₀+c₄²z³+O(z⁴) and y=y₀+O(z⁴), so H−H(point) begins with the NONZERO coefficient y₀c₄²z³. Hence the local index is THREE and the differentTWO. Their images are ±c₀√c₀, which are distinct and finite. The differential is regular and nonzero at every other finite point, including the Weierstrass points where σ is a unit. Therefore no other ramification occurs. The total different is TWENTY EIGHT plusTWO plusTWO=THIRTY TWO, agreeing with genusTWO Hurwitz for degreeFIFTEEN.

No actual X-map, uniform completed Galois extension, native spin relation or identity-row marking is inferred from this coarse map.
