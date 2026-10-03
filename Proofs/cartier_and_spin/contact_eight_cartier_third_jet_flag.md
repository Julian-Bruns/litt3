# Proof: horizontal third jets and the actual contact-eight flag

Version1,2 October2026. Focused independent review PASS; [statement](../../Theorems/cartier_and_spin/contact_eight_cartier_third_jet_flag.md) and [review](../../Research/audits/CONTACT_EIGHT_JET_SPIN_REVIEW_2026_10_02.md). Retain both actual finite étale maps on the SAME source. Use the accepted [noncyclic branch-fiber theorem](contact_eight_noncyclic_branch_fiber.md), source net orders and simple old-radical adjunction divisor.

## The canonical O-linear horizontal Taylor map

Write F:Y→Y^(1), with B onY^(1) and jets on the sourceY. In a local Frobenius basis e_i ofB, its pullback is horizontal for the canonical connection. Map F*e_i to j³s_i, where s_i is its differential evaluation, and extend O-linearly. This is not the ordinary jet of a section multiplied by an arbitrary variable coefficient.

Horizontal frame transitions are fifth powers. On the third infinitesimal diagonal, f(t+ε)⁵=f(t)⁵ moduloε⁴, so j³(a⁵s)=a⁵j³s. The maps glue; coordinate and differential-frame changes are the usual principal-parts changes in the target. The primitive local basis[t],[t²],[t³],[t⁴] evaluates to dt,2t dt,3t²dt,4t³dt. Its Hasse-Taylor matrix through order three is triangular with units1,2,3,4, giving an isomorphism F*B≅J³ω. Both degrees are twenty on genus two, since detJ³ω=ω¹⁰. The same gluing does not extend to fifth-order thickenings.

Restriction to F*J and projection gives Φ_k of generic rankk+1. The target point uniformizer τ pulls back to t⁵. Thus multiplying a primitive column byτ adds five to its differential evaluation order. For differential orders a₀,…,a_k with distinct residues modulo five, the leading Taylor determinant has valuation Σa_i−k(k+1)/2, with a nonzero Vandermonde coefficient. In the following echelon bases the smallest k+1 orders give the minimum among all minors. These valuations measure RAW image lengths; saturation would erase them.

## The split-support shape

At defect(1,1)Q, every actual source sheet is a finite branch. The free original net fiber plane has primitive orders one and four. The missing primitive orders two and three are multiplied byτ. Thus F*J has differential orders(0,3,6,7), and its local image lengths are(0,2,6,10).

At the distinct simple pointP, the exact contact ledger gives contactzero for every actual map. Hence every saturated source U_i is integrally contained inJ. Its accepted differential orders are(0,1,2)or(0,1,3). The missing primitive direction is multiplied byτ, giving orders(0,1,2,8)or(0,1,3,7). These yield lengths(0,0,δ,5), δ=0or1. There are no other defects.

Consequently Φ₀ is surjective ontoω, Φ₁ has determinantω³(-2Q), and Φ₂ has determinantω⁶(-6Q-δP). Since degF*J=5, their kernel ranks/degrees are(3,3),(2,1),(1,-1+δ). Under F*B≅J³ω, the highest jet line isω⁴. Intersecting F*J with it subtracts the full-image length minus the second-jet-image length, giving
\[
K_2=\omega^4(-4Q-(5-\delta)P).
\]
If δ=1, the displayed divisor gives[ω(-Q-P)]⁴. No connection invariance follows.

## The singleton orientation uses the actual embedded radical

At defect(2,1)Q every source sheet is again a finite branch. Choose a primitive generator r of ONE actual old radical. Its accepted adjunction divisor has a SIMPLE branch zero, so its primitive fiber has order TWO, rather than three. The perfect Cartier pairing on primitive monomials pairs ordersi,j in the fiber precisely wheni+j=5, with nonzero coefficient. Its pairing row therefore has a unit in the order-three slot.

Let H=r⊥. It is a rank-three direct summand, with fiber echelon orders one,two,four. Choose an order-three complement b₃ with unit pairing against r. The exact radical zero order two says J⊂H⊕τ²Rb₃. The largest Smith exponent two saysτ²B⊂J, soτ²b₃∈J and
\[
J=(J\cap H)\oplus\tau^2Rb_3.
\]
Since B/J has lengththree, H/(J∩H) has lengthone. Its free fiber plane is the actual branch net plane of ordersone,four, so the omitted direction has ordertwo. A basis of J∩H has primitive ordersone,four,seven; together withτ²b₃ these are(1,4,7,13). Thus the differential orders are(0,3,6,12), giving image lengths(0,2,6,15). The alternative(0,3,7,11)would make the exponent-two radical have primitive orderthree, contrary to its actual simple adjunction zero.

The same highest-line intersection now subtracts15−6=9atQ, givingK₂=ω⁴(-9Q)of degree−1. The lower kernels remain(3,3),(2,1). None of these numerical values contradicts semistability by itself.

## Exact row/spin comparison, including the horizontal generator

Assume the positive-q0 trace equalsJ. On the actual spin refinement, q*J=L²⊗V and F*q*J=L¹⁰⊗V^[5]. The actual evaluation row isψ_i=ψ(v_i^[5])=q₀(x_i)u_i⁶. Its horizontal first-jet image is L¹⁰⊗P_ψ, orωT⊗(P_ψ L^-6). The exact Φ₁ defect2Q just proved gives row critical divisor2Q, so no additional simple divisorD′ occurs.

Equality of determinant divisors alone would not prove equality of embedded lattices. Use the common normalized Atiyah extension:6=16=1in characteristic five, so the logarithmic transition classes ofL,L⁶,ωT coincide after normalization. Away fromqQ both raw lattices are the full extension. At a point aboveQ, everyu_i is a unit andq₀(x_i)is a unit, because the original q₀ roots are disjoint fromR. A normalized row generator and normalized spin generator have vertical coefficients differing by
\[
d\log\psi_i-d\log u_i=d\log q_0(x_i).
\]
The actual cubic branch has ord(dx_i)=2, so this difference lies inωT(-2qQ). Both integral lattices have exactly that vertical kernel. Their quotient-one generators agree modulo this kernel, proving equality upstairs. The actual deck-compatible common ambient identification descends it toQ_ψ=Q_Y. No finite common coefficient or horizontal highest kernel is inferred.
