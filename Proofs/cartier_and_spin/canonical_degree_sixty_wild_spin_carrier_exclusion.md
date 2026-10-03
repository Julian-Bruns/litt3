# Proof: six-torsion locates the wild point, and the quotient coordinate is a cube

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_degree_sixty_wild_spin_carrier_exclusion.md). Whole review pending. The target cubic cover is constructed inside the ORIGINAL source field.

Let D_w,D_t be the reduced branch stack divisors and U the coarse O_{P¹}(1). Then60D_w=6D_t=U and
\[
K_S=-2U+71D_w+5D_t=11D_w-D_t.
\]
The actual effective-line identities are
\[
6K_S=6D_w,\qquad11K_S=D_w+D_t.
\]
Choose the corresponding nonzero sections t6,t11 and normalize by s^6,s^11. Their ratios are actual Y functions F,H. The distinguished point cannot be wild, since n/e=1 contradicts the mixed-fiber requirement n/e≥3. The wild fiber onY therefore consists of one point R, disjoint fromP, and
\[
\operatorname{div}F=6R-6P.
\]
P is Weierstrass by the accepted wild reduction. Thus6[R−P]=0, and this order divides both24 and36. The selected-endpoint torsion bounds force R to be Weierstrass too. They are distinct. The hyperelliptic coordinate z with divisor2R−2P satisfies F=a z³ for some a∈k×.

The section quotient t11^6/t6^11 has divisor6D_t−60D_w, which is the pullback of a degree-one coarse divisor. It is therefore an actual coarse coordinate β, up to a nonzero constant. OnY it becomes
\[
\beta=H^6/F^{11}=a^{-11}(H^2/z^{11})^3.
\]
Since k is algebraically closed, there is b∈k(Y) with b³=β. It is nonconstant and k(b)/k(β) has degree THREE, prime to five.

Faithfulness and the actual free Y action give ΓY=T and linear disjointness of k(Γ) and k(Y) over the coarse field k(β): the Galois extension Γ/B and the source Galois extension T/Y have the same group and degree, and their compositum is T. Hence Γ₃=Γ(b) has degree THREE overΓ insideT. OnΓ the coarse coordinate β has pole order60 at every wild point and zero order6 at every tame point. Every valuation is divisible by three. The connected cubic Kummer cover Γ₃→Γ is therefore étale.

The actual G-action fixes b∈Y, so it extends faithfully toΓ₃. Its new quotient is the rational b-line. Dividing the inertia orders by three gives20 and2. In the tame local tower, the different transitivity formula gives the new wild different
\[
71-60+20=31.
\]
The carrier T→Γ₃ has degree20. Its canonical different is still exactly qP because Γ₃→Γ is étale. Pullback of the spin line and its genuine canonical discrepancy preserves L¹⁶=ω_T, all original infinity sections, and canonical coefficient primitivity; the initial coefficient remains primitive over the larger target field. Both original maps stay onT. Thus the resulting carrier is the profile excluded by the small wild degree20 theorem, once that input is accepted.
