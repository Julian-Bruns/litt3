# Proof: exact pole multiplicities force two quadratic factors

Version1,3 October2026. Whole scoped review PASS; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_ordinary_quintic_form.md). Both actual maps stay on their SAME source. [Independent audit](../../Research/audits/ACTUAL_Q0_TENSOR_ONE_TRIPLE_INFINITY_AUDIT_2026_10_03.md).

At degree SIX the actual cubic-index-THREE coarse B is the joint x-field, as proved in the high-genus one-triple-pole lemma. Put the two triple infinity poles at z=ZERO,infinity. The THREE distinct ordinary pole coordinates satisfy z³=ρ², hence J=z³−ρ². Write Y²=Φ(z), degree FIVE with a simple ZERO at ZERO. Exact even/odd pole bounds give
\[
x_1=A_1/(zJ)+bY/(z^2J),\qquad x_2=A_2/J+cY/J,
\]
with deg Ai≤FOUR and deg b,c≤TWO. The actual triple pole of x2 at infinity forces c2≠ZERO; absorb it into Y to make c monic. A possible common odd factor must be handled, rather than excluded by smoothness. If it has degree TWO, the residual b,c are constants and the THREE calibrated pole ratios a²c=ρb are impossible. If it has degree ONE, absorb it into Y as a SINGULAR degree-SEVEN auxiliary equation, retaining the same actual function field. Its residual b,c are linear. Calibration at all THREE coordinates gives z²c−ρb divisible by J, hence c=kz,b=kρ. The odd q0 identity then gives A1=zL,A2=ρL,deg L≤THREE. The exact finite part is Y/z², so its common value at all THREE poles forces L=λJ+ρξ0. The even q0 identity gives the auxiliary equation Y²=z[L²+(z³−ONE)J], z times a polynomial in z³. Its genuine normalization automorphism z↦ωz,Y↦ω²Y fixes BOTH xi, contradicting B=Bx. This argument uses the actual joint field, not an incorrect genus assignment to the auxiliary equation. Thus every common-factor boundary is excluded and the remaining b,c are coprime. The same quadratic presentation is retained as auxiliary when initial elliptic odd cubics have a common linear factor; any further common factor is treated by the same argument.

The odd q0 identity gives A2c=A1b, hence A1=cL,A2=bL with deg L≤TWO. At each actual ordinary pole the canceled conjugate sheet makes both even and odd residues nonzero. The calibrated leading ratio consequently gives zb−ρc=ZERO at its THREE coordinates. Its degree is at most THREE, so zb−ρc=kJ. With c monic, coefficient comparison yields
\[
c=z^2+\sigma z+\rho k,\qquad b=kz^2+\rho z+\rho\sigma.
\]
Direct multiplication now gives
\[
M=zc^2-b^2=JN,\qquad N=z^2+(2\sigma-k^2)z+\sigma^2,
\]
\[
M(\Phi-zL^2)=z(z^3-1)J^2.
\]
Every root of N lies among the cube roots of unity. This requires a local check at possible intersections with J. At a root a of J the actual canceled-sheet identity gives Φ(a)=aL(a)², so Φ−zL² has order at least ONE there. Comparing multiplicities in the last identity gives multiplicityN(a)≤multiplicity(z³−ONE)(a)≤ONE. Outside J the same comparison immediately bounds N's multiplicity by that of z³−ONE. Thus N divides z³−ONE EVEN when a pole coincides with a cube root. No such coincidence is excluded by an extra open.

Its monic quadratic is therefore (z³−ONE)/(z−r), r³=ONE. The intrinsic rotation z_new=αz,α³=ONE, with c_new=α²c(z_new/α),b_new=αb(z_new/α),L_new=α²L(z_new/α),Y_new=αY leaves BOTH original xi unchanged. It sends N to α²N(z_new/α), so choose αr=ONE. It keeps ρ and the ninth coefficients unchanged. Thus N=z²+z+ONE, forcing σ²=ONE and k²=TWO σ−ONE. The exact even identity gives Φ=z[L²+(z−ONE)J].

The exact finite part is
\[
\xi=x_2-\rho x_1=kL/z+Y(z+\sigma)/z^2.
\]
At a root of J the actual pole sheet has Y=ρL/a. Hence ξ(a)=L(a)b(a)/ρ²=L(a)c(a)/(ρa). In the centered/scaled copies the exact first jet gives ξ0=THREE Kp, so Lc=THREE ρKp z modulo J. Since c is nonzero at all THREE actual pole coordinates, it is invertible modulo J; L=pℓ is uniquely determined with degree at most TWO.

The sign of k introduces no lost case. Replacing (k,ρ,ε,L,b) by (−k,−ρ,−ε,−L,−b) leaves c,Y,J,K and Φ unchanged and changes ONLY the first centered coordinate's sign. The separate ε sign precisely records that change. Thus one chosen k for each σ, BOTH ε choices and all ρ cover every necessary model. Suitable choices over F25 are k=ONE for σ=ONE and k=FOUR ν+THREE for σ=−ONE, since the latter square is TWO.

All assertions are necessary consequences of the actual maps. Quintic smoothness is required only when B is genuinely genus TWO; singular shared-root elliptic presentations keep their original normalization and pole opens. No parameter value is asserted to produce maps or an original Y-leg.
