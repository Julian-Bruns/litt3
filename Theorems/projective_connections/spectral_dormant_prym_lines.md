# Dormant secants as spectral five-torsion lines

Version4,2026-10-03. The intrinsic five-torsion line and the normalized
BNR line now include multiple zeros and split roots, with an exact
divisor correction.

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of characteristic five. Let r,s be distinct
regular dormant projective connections and q=r-s in H^0(C,omega_C^2).
Write F_C:C->C^(1) for relative Frobenius, and let
V_s=ker(F_(C*) Bol_s), with F_C^*V_s=J^1(omega_C^2), as in the tangent
bundle theorem. Superscript (1) below means the Frobenius twist of data.

1. det V_s is canonically omega_(C^(1)). There is a canonical regular
   Higgs field theta:V_s->V_s tensor omega_(C^(1)) satisfying

       trace(theta)=0,  theta^2=2q^(1) id.

   In coordinates (v,v') on J^1(omega_C^2), its Frobenius pullback is

       Phi=[[-q q',q^2],[2q^3-(q')^2,q q']].

   This assertion holds without any simple-zero assumption.

2. Let \(\pi:\Sigma\to C\) be the smooth projective normalization
   of the quadratic root \(a^2=2q\), allowing a split root. The
   intrinsic form \(\eta=a\,dt\) is nonzero on every component,
   holomorphic and Cartier-fixed. If q has a zero of order m, the
   orders of \(\eta\) above it are m/2 at each of two unramified
   points when m is even, and m+1 at the one ramified point when
   m is odd. If the root is connected, its genus is
   \(2g-1+B/2\), where B is the number of odd-order zeros of q.

   Cartier descent of \((\mathcal O_\Sigma,d+\eta)\) defines a
   unique line \(N\) on \(\Sigma^{(1)}\), of exact order five
   on every component, with
   \[
   F_\Sigma^*N\simeq\mathcal O_\Sigma,\qquad
   \operatorname{Nm}_{\pi_1}(N)\simeq\mathcal O,\qquad
   \tau^*N\simeq N^{-1}.
   \]
   The displayed trivialization has connection form \(\eta\).
   Reversing a replaces N by \(N^{-1}\); swapping r and s with
   \(a_{\rm new}=2a\) replaces it by \(N^2\). The unordered pair
   thus determines its cyclic order-five subgroup.

3. Write \(\operatorname{div}(q)=\sum_x m_xx\), and set
   \(T=\sum_x\lfloor m_x/5\rfloor x\). Regular dormancy forces
   every \(m_x\) to be 0 or 1 modulo five. Let \(\mathcal L\)
   be the BNR sheaf of \(\theta\) on the possibly singular
   spectral curve, and \(\nu\) its normalization. Then
   \[
   \widetilde L:=\nu^*\mathcal L/\text{torsion}
   =N\otimes\pi_1^*\bigl(\omega_{C^{(1)}}(-T^{(1)})\bigr).
   \]
   The natural injection \(V_s\hookrightarrow\pi_{1*}\widetilde L\)
   has a finite-length cokernel of length
   \(\sum_x\bigl(\lfloor m_x/2\rfloor-2\lfloor m_x/5\rfloor\bigr)\).
   Here BNR is used in the sense of
   [Groechenig, Theorem3.2](https://arxiv.org/pdf/1201.0741#page=9).

   If all zeros are simple, \(\Sigma\) is connected of genus
   \(4g-3\), \(\operatorname{div}(\eta)=2R\), and
   \(L=\mathcal L=\widetilde L=N\otimes\pi_1^*\omega_{C^{(1)}}\).
   In particular \(\deg L=4(g-1)\) and
   \(V_s=\pi_{1*}N\otimes\omega_{C^{(1)}}\).

4. The normalized root, its form and its line commute with actual
   finite etale pullback. For two specified dormant connections
   agreeing through BOTH maps of an actual span X<-Z->Y, each
   connected component of the common normalized root gives a span
   between the corresponding normalized endpoint components with
   BOTH legs finite etale, preserving N and \(\eta\). For a simple
   difference the root is connected and the endpoint root maps
   themselves are RAMIFIED doubles.

No existence of a common pair is asserted. A five-torsion line defines
a mu_5 Kummer torsor, not an etale cyclic five-cover. Neither this line
nor the common spectral differential alone forces a core.

## Genus-two quotients and their a-numbers

When g=2 the difference q automatically has four simple zeros. Choose
a Weierstrass point as infinity and write C:v²=F(u), deg F=5, and
q=A(u)(du/v)². Then A is a squarefree quadratic coprime to F. The
spectral double has an actual etale degree-two quotient

    E: w²=2A(u)F(u),       eta_E=2A(u) du/w,

of genus three. Its Cartier-fixed form has divisor type(2,2), and

    a(E)=dim T_dorm(C,r)+dim T_dorm(C,s).

In particular E is ordinary exactly when both dormant points are reduced.
For EVERY smooth member v²=u(u−1)(u−2)(u−3)(u−t), all ten quotients
are ordinary. For the cubic backup, the two coefficient-Frobenius
orbits of unordered pairs each have size five. These endpoint results
do not supply a compatible common pair.

Dependencies: [Cartier secants](cartier_dormant_secants.md) and
[tangent bundles](tangent_bundle_cyclic_refinements.md).
[Proof and symbolic check](../../Proofs/projective_connections/spectral_dormant_prym_lines.md).
