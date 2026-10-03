# Proof: the three fixed pure-odd forms have a three-dimensional Cartier image

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/fixed_pure_odd_large_wild_cartier_image.md). Pending independent review. This is an exact polynomial calculation on Y, with no computation replay or construction of a carrier.

## The polynomial-domain columns fill the dw sector

Since F³σ=Φ(w−a)³dw, multiplication by a polynomial u of degree≤3 gives a polynomial differential of degree≤11. Its Cartier image is therefore in ⟨dw,w dw⟩. The constant column vanishes because a³=4/q. For u=w and u=w² the fifth powers of the coefficient pairs are respectively
\[
(3a+4q,1),\qquad (2a^2+3qa,q+2a).
\]
Their determinant is 4(a+q)². If a=−q, the equation a³q=4 would give q⁴=1; all fourth roots of ONE are in F5, contrary to q∉F5. Thus these two columns span the entire polynomial-dw sector. The w³ column cannot enlarge it.

## The remaining column is a nonzero σ line

The formula C(Tσ)=C(TΦ²dw)/y gives
\[
C(yF^3\sigma)=\frac{C(\Phi^4(w-a)^3dw)}{y}.
\]
The characteristic-FIVE identity
\[
(w^4-1)^4=w^{16}+w^{12}+w^8+w^4+1
\]
reduces the four surviving coefficients to elementary products of (w+q)⁴(w−a)³. Extracting powers FOUR,NINE,FOURTEEN,NINETEEN gives exactly the displayed coefficient vector.

To see that it cannot vanish, set r=a/q. The vanishing of its first and last entries would imply
\[
r^2=2+2r,\qquad 1+3r+3r^2=0.
\]
Substituting the first into the second forces r=2, which does not satisfy the first. Thus at least one of these two entries is nonzero. This column belongs to the polynomial-σ sector, which has zero intersection with the polynomial-dw sector. The full image consequently has rank THREE.

## The actual leading interpolant can be chosen even

For the actual pure-odd low F, D=dF/σ is hyperelliptically invariant. The bounded primitive dH0=F³σ is also invariant: its differential is polynomial in w times dw, and its bounded fifth-power ambiguity is L(3P)⁵, which is invariant as well. Therefore the leading/fourth target jets at the five branch zeros and the paired zeros above w=a are invariant under the hyperelliptic involution. Averaging any interpolant in L(41P) preserves all those targets.

For an invariant interpolant R, the differential C(RF³σ) is invariant, while F is anti-invariant. Hence Ω=C(RF³σ)/F is anti-invariant, exactly the polynomial-σ sector of H0(ωY(5P)). The exact image computation then gives the stated proportionality criterion. It supplies no nonvanishing of the resulting obstruction, and all actual source maps are retained unchanged.
