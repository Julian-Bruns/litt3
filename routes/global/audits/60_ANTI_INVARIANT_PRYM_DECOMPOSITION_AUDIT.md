# Audit: anti-invariant Prym decomposition at `M=9`

**Verdict:** **PASS.**  No breaking mathematical objection found.

**Auditor and date:** `/root/degree45_family_endpoint`, 2026-09-04.

## Checks performed

- The two sign calculations are correct.  Norm/pullback functoriality for
  \(p\gamma=\delta p\), together with
  \(a\gamma=\iota_Ya\), gives \(\delta^*h=-h\); similarly
  \(c\delta=\iota_Xc\) gives \(\delta^*c^*=-c^*\).  The hyperelliptic
  involutions act as \(-1\) on the respective Jacobians.  A connected
  anti-invariant image is killed by \(q_*\), since its image would be a
  connected subgroup of finite 2-torsion.
- The dimension contradiction for \(g(B)=2\) is sound.  Absolute
  simplicity of \(J(Y)\), nonvanishing of \(h\), and
  \(c_*c^*=[9]\) give subvarieties \(A,D\subset P\) of dimensions 15 and
  3.  Their intersection cannot have positive dimension, whereas the Prym
  has dimension only 17.
- For a tame double cover of a genus-\(b\) curve branched at \(r>0\)
  points, the restriction of the Jacobian polarization to the Prym has
  type \((1^{r/2-1},2^b)\).  Thus \((b,r)=(1,36)\) gives exactly
  \((1^{17},2)\).  The equality \(c_*h=0\) makes \(A\) and \(D\)
  orthogonal, and their dimensions fill this Prym.
- The kernel \(K_c\) is killed by nine.  Via prime-to-five Kummer theory,
  a character trivialized by the connected degree-nine cover factors
  through the quotient by the normal closure of its index-nine subgroup;
  that quotient has order dividing nine.  Hence
  \(|K_c|\in\{1,3,9\}\), with precisely the four abstract group cases
  listed.
- Pulling back the induced polarization on \(D\) gives
  \((c^*)^*\lambda_D=9\lambda_X\).  Therefore
  \(\ker\lambda_D=K_c^\perp/K_c\) in the six-dimensional symplectic
  \((\mathbf Z/9)\)-module.  Direct symplectic normal forms reproduce
  all and only the types
  \[
  (9,9,9),\quad(3,9,9),\quad(1,9,9),\quad
  (1,9,9)\text{ or }(3,3,9).
  \]
  In the \(C_3^2\) case, the two orbits are the nondegenerate and
  isotropic planes after division by three and reduction modulo three.
- At every odd prime the Prym polarization is unimodular.  Since the two
  orthogonal factors have complementary dimensions, each is the exact
  orthogonal complement of the other there; their full polarization
  kernels are anti-isometric and equal to the projections of the addition
  kernel.  At two, \(\lambda_D\) is principal and hence there is no
  2-primary gluing.  The single elementary divisor 2 of the Prym therefore
  belongs to \(\lambda_A\).  This verifies every full type and all degree
  and intersection formulas (60.16)--(60.18).
- From \(\varpi^*\lambda_A=\lambda_Js\), taking degrees gives
  \(\sqrt{\deg s}=2d\,3^{6-r}\).  For the degree-three division algebra over
  its degree-ten center, the reduced-characteristic-polynomial exponent is
  \(2\dim J/(3[E:\mathbf Q])=1\), so
  \(\deg s=N_{E/\mathbf Q}(\operatorname{Nrd}(s))\), exactly as used.
  Rosati symmetry puts the reduced norm in \(E^+\), and integrality puts it
  in \(\mathcal O_{E^+}\).
- Independently checked
  \[
  \langle-1,5\rangle=\{1,5,25,30,26,6\}\pmod {31}.
  \]
  The successive powers of 2 are \(2,4,8,16,1\), and those of 3 are
  \(3,9,27,19,26\); neither enters this subgroup before the fifth power.
  Thus 2 and 3 are inert in the cyclic degree-five field \(E^+\), so their
  norm valuations are multiples of five.  This gives exactly the two
  congruences (60.25).
- Every polarization type in (60.16) has exponent 18.  If the positive
  endomorphism \(s\) were scalar \([m]\), the quotient-polarization formula
  would make this exponent divide \(m\).  Hence \(m\ge18\), while the
  effective-correspondence trace bound gives \(30m\le378\), a contradiction.

## Non-breaking suggestions and objections

- There are two harmless TeX typos: ``,quad`` in (60.21) should be
  ``,\quad``, and ``/langle-1,5\rangle`` should be
  ``/\langle-1,5\rangle``.
- The order bound on \(K_c\) is correct, but explicitly mentioning the
  prime-to-five Kummer character and the normal closure of the index-nine
  subgroup would make the argument easier to verify.
- In the complementary-polarization paragraph, saying that
  \(D=A^\perp\) on every odd-adic Tate module explains immediately why the
  projected addition kernel is the **full** polarization kernel, rather
  than merely an isotropic subgroup of it.
- Before (60.28), one could state the exponent calculation
  \(2\dim J/(3[E:\mathbf Q])=1\); this makes clear why no power of the
  reduced norm is missing from the degree formula.

**Audited revision SHA-256:**
`1f8eed8dff784c1efe89e50a143bd9e3a7578dc7c15012e3b37c2b373e5ef4b6`.
