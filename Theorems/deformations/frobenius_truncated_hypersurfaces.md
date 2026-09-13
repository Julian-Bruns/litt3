# Lengths of hypersurfaces with Frobenius power relations

Let k be algebraically closed of odd characteristic p and f∈m² in
k[[x₁,…,x_d]], d≥2. All truncation exponents below are powers of p, including 1.

1. Suppose the x₁² coefficient is nonzero, Q≥q_i for i≥2, and

       Q−1 > Σ_(i=2)^d (q_i−1).

   Then the length of k[[x₁,…,x_d]]/(f,x₁^Q,x₂^q₂,…,x_d^q_d)
   is 2∏_(i=2)^d q_i. In particular the inequality holds for a
   unique largest exponent whenever d≤p+1.

2. In two variables, a nondegenerate quadratic part gives balanced
   length 2Q−1. If Q>P and the x² coefficient is nonzero, the length
   modulo (x^Q,y^P) is 2P.

3. In three variables with exponents (Q,Q,R), Q≥R, suppose the
   quadratic restriction to the x,y plane is nondegenerate. Eliminate
   its two critical coordinates with z fixed. If the residual series
   has order s≥2 prime to p, the length is

       L_s(Q,R)=R+2Σ_(j=1)^(Q−1) min(R,sj)
               =2QR−sm²−r(2m+1),   R=sm+r, 0≤r<s.

   The same formula holds in the balanced case Q=R whenever f has
   formal type xy+z^s, up to a unit and an invertible coordinate change.
   If instead the restricted quadratic has rank one and Q+3>4R,
   the length is 2QR, independently of higher terms. In particular
   this applies whenever p≥5 and Q>R.

For p=5 and s=2 or 4, R≡1 mod s, so

    L_s(Q,R)=2QR−(R²+s−1)/s.

At Q=R these are (3Q²−1)/2 and (7Q²−3)/4. The conclusions use
coordinate changes that preserve the displayed truncation ideal;
an unrestricted formal change need not preserve unequal powers.

Version 1, 2026-09-13. [Proof](../../Solutions/deformations/frobenius_truncated_hypersurfaces.md).
