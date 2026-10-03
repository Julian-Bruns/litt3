# Two ordinary endpoints isolate the full-group comparison obstruction

Version2,3 October2026. Work over $k=\overline{\mathbf F}_5$.
Let $X\xleftarrow f Z\xrightarrow gY$ be two actual finite etale
maps of smooth proper hyperbolic curves. Supply actual generically
ordinary, everywhere-versal height-two,
dimension-one BT1s $H_X,H_Y$ with an actual specified comparison on Z
and reduced supersingular divisors. Normalize higher determinants to
the Teichmuller lifts of their finite characters. All subsequent
comparisons retain the supplied first marking and determinant.
Put $S_Z=f^*S_X=g^*S_Y$, where each reduced supersingular divisor
has degree $4g(C)-4$, and put $V_C=H^0(C,\mathcal O_C(S_C))$.

On the character cover $\pi_C:P_C\to C$, write $\Omega_C$ for
the logarithmic differential with $C\Omega_C=\Omega_C$ and
$\operatorname{div}\Omega_C=2R_C=\pi_C^*S_C$.
Weighted Cartier defines a $5^{-1}$-semilinear endomorphism
\[
\pi_C^*(\mathcal T_Ca)\Omega_C=C_{P_C}(\pi_C^*a\Omega_C),
\qquad\ker\mathcal T_C=K_{H_C},\quad\mathcal T_C(1)=1.
\]
Assume BOTH endpoints are indigenous-ordinary:
$K_{H_X}=K_{H_Y}=0$. No source ordinariness is assumed. The later
[absolute torsor](versal_bt_extension_torsor.md) supplies UNIQUE
normalized full extensions $G_X,G_Y$ on the ORIGINAL endpoints;
these need not be provided as additional data. For
$U=f^*V_X+g^*V_Y$ and $Q=V_Z/U$,
\[
K_{H_Z}\cap U=0,\qquad
\boxed{K_{H_Z}\simeq\ker(\overline{\mathcal T}_Z:Q\to Q).}
\tag{1}
\]
Corelessness is unnecessary for (1). If it holds and $g(Y)=2$,
writing $n=\deg f$, one has
\[
\dim U=3g(X)-1,\qquad
\dim Q=3(n-1)(g(X)-1)-2.
\]

At any already reached comparison $\eta_N$, the next actual
difference $h_N\in K_{H_Z}$ vanishes if and only if its image
in Q vanishes. Both endpoint traces vanish for EVERY member of
$K_{H_Z}$ and therefore impose no further condition on $h_N$.

There is an affirmative case with no restriction on the other leg:
if either leg has a Galois closure with a five-group Galois group,
then $K_{H_Z}=0$ and the specified BT1 comparison extends uniquely
to these unique full groups. This uses a Galois closure of ONE
leg, never a simultaneous closure.

For general covering groups, neither $h_N\in U$ nor the vanishing
of the particular quotient class is proved. Singleton endpoint
extension torsors do not identify their two images on Z. No actual
coreless counterexample has been constructed.
[Proof](../../Proofs/deformations/two_ordinary_bt_comparison.md).
Returned Pro result with focused local integration, not a solution
of the full comparison or original common-cover problems.
