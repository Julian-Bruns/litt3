# A six-dimensional Cartier obstruction for the ordinary/tame large-wild carrier

Version1,3 October2026. Pending independent review. Retain BOTH actual finite étale endpoint maps from the SAME T and the canonical degree7000 carrier data of [the genus-two bounded incidence](large_wild_genus_two_small_packet_incidence.md). Assume P is ordinary or distinguished-tame. Write divF=A−7P with seven distinct wild points in A, divσ=2P, dH0=F³σ, D=dF/σ, and α=4cλ⁻⁵. This is a necessary global reduction, not a large-wild exclusion.

The first Hermitian leading and fourth-jet conditions prescribe at every R∈A the jets
\[
[\mathcal R]_{R,0}=\alpha D(R)^5,\quad
[\mathcal R]_{R,1}=[\mathcal R]_{R,2}=[\mathcal R]_{R,3}=0,
\quad [\mathcal R]_{R,4}^5=2cH_0(R)D(R)^5.
\]
Every such collection has an interpolant \(\mathcal R_*\)∈L(41P). All interpolants are exactly \(\mathcal R_*+F^5u\), u∈L(6P), a FIVE-dimensional affine space.

For any chosen interpolant define the meromorphic differential
\[
\Omega_*=\frac{C(\mathcal R_*F^3\sigma)}{F}
\in H^0(Y,\omega_Y(5P)),
\qquad
\mathscr I_F=C\bigl(F^3\sigma\,L(6P)\bigr).
\]
There exists an interpolant satisfying the indispensable exactness condition C(\(\mathcal R\)F³σ)=0 IF AND ONLY IF the class of Ω* in H0(ωY(5P))/\(\mathscr I_F\) vanishes. This class is independent of the interpolant. The target has dimension SIX and \(\mathscr I_F\) has dimension at most FOUR, since constants lie in the kernel. Thus this step has a concrete obstruction space of dimension at least TWO, expressed in bounded genus-two spaces rather than forty free coefficients.

More directly, write \(\mathcal R_*=\alpha D^5+F^4V\), where V∈L(22P). Then
\[
\Omega_*=C(F^2V\sigma),\qquad
V\longmapsto V+Fu\quad(u\in L(6P))
\]
is exactly the interpolant ambiguity. Let E=dD/(Fσ)∈L(5P) be the bounded oper coefficient. With δ=(1/D)(d/σ)=d/dF, so δD=FE/D, the image map has the explicit formula
\[
C(F^3u\sigma)=
\left[-D^5\delta^4\left(\frac{F^3u}{D}\right)\right]^{1/5}\sigma.
\]
It therefore has only the five columns u∈{1,z,z²,z³,y}; the first is zero. No full-rank assertion or endpoint exclusion is assumed. The separate distinguished-wild case has larger bounds and is not included in this obstruction count.

[Proof](../../Proofs/cartier_and_spin/large_wild_small_cartier_obstruction.md).
