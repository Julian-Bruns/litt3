# Primary obstruction geometry of a defect-neutral degree-five cover

Version1,2026-09-11. Focused audit PASS /root/audit_n5_returned_partial,
2026-09-10, for the returned partial result and its canonical-bundle
identification. Prose and exact local checks, not Lean verification.

Let h:T→C be an ACTUAL connected finite etale map of degree five between
smooth projective hyperbolic curves over k=bar(F5). Let r_C be regular,
active and admissible nilpotent, and put r_T=h*r_C. Write

    psi_S:H1(S^(1),T_(S^(1)))→H1(S,T_S),
    K_S=ker(psi_S), O_S=coker(psi_S), S=C,T,

for the linearized Hodge-projection operator, retaining Frobenius twists.
Assume d_C=d_T=d>0, where d_S is the actual nilpotent tangent defect.

1. The canonical defect bundle E_(r_S), defined by the canonical dormant
   pair, has the alternative intrinsic description

       0→T_(S^(1)) --j_r→ F_*T_S → E_(r_S)→0.

   Here j_r is the normal projection of the horizontal p-curvature line.
   It is a subbundle inclusion. E_r has rank4, degree4(g(S)−1), and a
   perfect alternating pairing E_r tensor E_r→omega_(S^(1)), compatible
   with actual etale pullback. Thus H0(E_r)=K_S, H1(E_r)=O_S and
   O_S≅K_S^dual. This does NOT give an alternating scalar form on K_S.

2. Pullback h*:O_C→O_T is ZERO. On the quotient Hodge operator psi_Q,
   with Q=H1(T,T_T)/h*H1(C,T_C) and the corresponding twisted domain,

                       K_Q≅O_C, O_Q≅O_T.

   In particular its defect is exactly d, not zero. No Galoisness or
   neutrality of the individual Galois closure is assumed.

3. Let Z→C be that individual Galois closure, G its group and H the
   ORIGINAL point stabilizer, so T=Z/H. On any smooth proper descended
   W(k)-reference and its lifted finite etale G-cover,

         H1(Z_W,T_(Z_W/W))≅W(k)[G]^(3g(C)−3).

   This is a noncanonical regular-module isomorphism, also after Witt
   truncation. The pulled-back negative two-affine Cech complex admits
   integral G-linear cohomology sections and boundary primitives.
   The assertion concerns an arbitrary descended smooth reference; it
   does not assume or produce a compatible lower full periodic tower.

At a single higher Witt step with an already compatible descended
previous tuple, the lower primary obstruction can be killed upstairs
even if the lower obstruction is nonzero. If a compatible lower NEXT
lift exists, every compatible upper next lift descends along the
original h, since K_T=h*K_C. What remains open is whether a given full
upper compatible tower forces that lower next lift to exist.

The primitive S5 norm model survives both regularity and kernel/cokernel
duality. Neither this theorem nor that model decides(N5). The cyclic
even-defect restriction is already contained in the stronger
[section-growth theorem](Thm_symplectic_p_cover_section_growth.md).

[Proof](../Solutions/Sol_neutral_degree_five_obstruction_structure.md) ·
[Scoped audit](../Research/audits/N5_RETURNED_PARTIAL_AUDIT_2026_09_10.md).
