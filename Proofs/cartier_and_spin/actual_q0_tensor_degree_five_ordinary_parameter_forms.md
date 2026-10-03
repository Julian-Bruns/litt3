# Proof: exact residues replace arbitrary coefficient searches

Version1,3 October2026. New full surviving-configuration reduction, whole scoped review PASS. No computation is used. [Root audit](../../Research/audits/Q0_TENSOR_DEGREE_FIVE_WHOLE_RECOGNITION_AUDIT_2026_10_03.md).

By the [whole position reduction](actual_q0_tensor_degree_five_ordinary_pole_reduction.md), both simple poles are ordinary and have distinct z-coordinates. Keep both transformed fixed-X copies during necessary-condition normalizations. Centering leaves P9=2+4ν unchanged because degree TEN is ZERO in characteristic FIVE. The accepted [fixed kernel coefficients](fixed_x_kernel_wronskian.md) give q0=x²+TWO x+(4+4ν), so its centered version is X²+D with D=3+4ν. Common scaling X/√D gives p=P9/√D. In F25,
\[
(2+4\nu)^2=2+2\nu,\quad (3+4\nu)^{-1}=4+2\nu,
\quad p^2=(2+2\nu)(4+2\nu)=\nu.
\]
A separate first-coordinate sign changes its p9 coefficient to εp; this is why ε is retained instead of assuming identical transformed P copies.

At an ordinary shared pole z=a, the [general-copy first-jet formula](actual_q0_tensor_simple_infinity_first_jet.md) gives the x1 residue with local parameter z−a:
\[
l_1=\frac{a(\varepsilon\rho-1)p}{3\rho}.
\]
Use the actual even/odd pole form A1=cL,A2=bL. Its q-coefficient identity gives M=zc²−b², with M(a)=ZERO and Ψ(a)=aL(a)². The other point above a has its pole canceled. At the actual pole Y=b(a)L(a)/c(a), so
\[
l_1=2c(a)L(a)/(aJ'(a)).
\]
Both numerator coefficients are nonzero. Equating and using SIX=ONE gives
\[
L(a)=\frac{a^2J'(a)(\varepsilon\rho-1)p}{\rho c(a)}.
\]
The SAME formula holds at the other ordinary pole. In particular K=ερ−ONE≠ZERO, since its vanishing would make both actual residues ZERO. This implements the two actual first jets, not a freely chosen interpolation condition.

For the linear odd-numerator models use the [complete calibrated form](actual_q0_tensor_degree_five_calibrated_distinct_form.md). It gives s=v−ONE,J=z²+s²z+s4,b=vz+s²,c=z+vs and ρ=−s³. The two poles are a=ωs²,d=ω²s². Since c is invertible modulo J, the two residue equations determine L modulo J. Compute modulo J:
\[
z^3=s^6,\quad z^2J'/\rho=s(z-s^2).
\]
The unique linear solution of Hc=s(z−s²) modulo J is
\[
H=\frac{(2v-1)z+s^2(v-2)}{\Delta},\qquad\Delta=v^2-v+1.
\]
One can check this directly by multiplying by c and reducing z²=−s²z−s4. Δ is nonzero by the actual odd-numerator coprimeness. The full quadratic L is therefore p(λJ+KH), with arbitrary scalar λ, exactly as stated. No possible leading-degree drop of L is removed.

For elliptic B, the full ordinary pole bounds give deg b,c≤TWO, c monic of degree TWO, deg Ai≤THREE. If their gcd is linear, the auxiliary Y=h y gives the preceding linear model, retained as singular. A proportional pair would force equal pole coordinates by the q-leading identity, impossible. It remains to treat coprime quadratic b,c. Odd coefficients give A1=cL,A2=bL with deg L≤ONE. At both ordinary poles M=zc²−b² has a root. The even identity is
\[
M(\Phi-zL^2)=z(z^3-1)J^2.
\]
M has degree FIVE. At an ordinary pole the canceled-conjugate condition makes Φ−zL² vanish there. Consequently the pole's multiplicity in M is at most ONE plus its multiplicity in z³−ONE. All other M-roots lie in z³−ONE. Counting degrees forces
\[
M=(z^3-1)J.
\]
This includes pole coordinates at cube roots of unity and their double multiplicities. Calibration gives the two pole coordinates a=t²,d=ωt² after labeling. Define t=−b(a)/c(a), so t²=a and t³=−ρ. At d, the SAME calibrated residue ratio forces its chosen square root to be ω²t. Thus f(r)=r c(r²)+b(r²) has roots t,ω²t.

The exact product is
\[
f(r)f(-r)=-(r^6-1)J(r^2).
\]
Since b,c are coprime and b(0)≠ZERO, f cannot have both members of any opposite root pair. It contains ONE from each of the THREE µ6 pairs and ONE from each pole-coordinate pair, with coincident factors assigned to the SAME side. Its monic degree-FIVE factorization is therefore U(r)(r−t)(r−ω²t). There are eight µ6 transversals. Rotation by µ3 and complement by the separate centered x1 sign give TWO orbits: the alternating transversal {ONE,ω,ω²}, and the mixed transversal {ONE,ω,−ω²}. Their monic polynomials are U0,U1 in the statement. No orientation or proportional boundary is assumed away. At a pole coinciding with µ6, c(a)≠ZERO is exactly the opposite-side nonvanishing requirement, retaining valid extra multiplicity and discarding only a canceled pole.

The rotation normalization does not change either original coordinate or its ninth coefficient. Explicitly, replace z by z_new=ωz and put J_new=ω²J(z_new/ω),c_new=ω²c(z_new/ω),b_new=ωb(z_new/ω),L_new=ωL(z_new/ω),Y_new=Y. Both xi remain the SAME functions, and Φ_new=z_new[L_new²+J_new]=Φ(z_new/ω). Moreover f_new(r)=ωf_old(ωr), so its transversal rotates and t_new=ω²t while ρ and ε remain unchanged. Complement is the separately retained first-coordinate sign, not a presumed automorphism of the fixed X.

The coefficient extraction f=r c(r²)+b(r²) recovers all unknown odd coefficients as polynomials in t. The physical c(a)c(d)≠ZERO makes c invertible modulo J. Hence the two residue equations determine the linear L uniquely as pKH, where Hc=z²J′/ρ modulo J. There is no additional free coefficient. For U0 explicitly,
\[
c=z^2+\omega^2t^2z-\omega t,\quad
b=\omega t z^2-z-\omega^2t^2,\quad
H=(-z+\omega^2t^2)/(t^3+1).
\]
The denominator is physical here because c modulo J is−ωt(t³+ONE). For U1 the analogous interpolation uses the physical resultant of c,J. Both branches and both ε signs are retained. No assumption t6≠ONE is made; a pole may coincide with a µ6 point if the physical coefficient opens hold.

All final parameter equations have coefficients in F25 when quadratic norms use p²=ν. They are necessary forms of the actual SAME-source two-map alternative, not arbitrary separable substitutions. Full fixed-P cube and differential identities still constrain any solutions. No Y-map is produced by a parameter solution.
