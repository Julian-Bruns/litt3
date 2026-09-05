# Audit: full-orbit interpolation and cubic sign monodromy

**Verdict:** **PASS.**  The full-orbit construction correctly avoids the
false one-sign compositum/intersection equality identified in the audit of
files 66 and 68.  The normalized square, norm/genus bounds, signed-root
group analysis, and recovery of the \(M=6\) exclusion all check.

**Auditor and date:** /root/c14_elliptic_translation, 2026-09-04.

## Checks performed

- The interpolation polynomial \(Q\) exists uniquely because the
  \(t_i\) are distinct.  Applying the cyclic deck transformation merely
  permutes its interpolation conditions, so its coefficients are in
  \(F\).
- Irreducibility of \(P\) over \(F\) implies irreducibility over
  \(D\subset F\).  Since \(Q(t)=z\), one has
  \(E_*=D(t)=D(t,z)\), \(FE_*=F(t)=K\), and
  \[
                  [E_*:D]=[K:F]=r.
  \]
  This degree equality genuinely proves linear disjointness over \(D\);
  it does not repeat the invalid inference in files 66 and 68.
  Consequently \([K:E_*]=[F:D]=m\) and the normalized fiber product is
  integral with normalization \(V\).
- The square-root scheme in the rank-\(r\) etale algebra
  \(B[T]/(P)\) has degree \(2^r\): after separable splitting it is the
  product of \(r\) two-point schemes.  The interpolation point has
  residue field \(D\), proving \(j=[D:B]\leq2^r\) and separability.
  The equivalence \(j=1\Longleftrightarrow z\in E\) and the evenness of
  every other \(j\) are correct.
- The norm map \(J(Y)\to J(D)\) is nonzero by the moving-divisor lemma.
  A degree-\(r\) pencil on the hyperelliptic \(Y\) would violate
  Castelnuovo--Severi.  Simplicity then gives
  \(g(D)\geq rs+1\); Riemann--Hurwitz gives
  \(g(D)\leq Ns+1\), \(N\geq r\), and both exact different formulas.
- The orthogonal-complement refinement is valid.  If
  \((C/D)_*c^*\) vanishes, it gives a degree-\(m\) pencil on \(X\).
  Otherwise simplicity supplies a full \(g(X)\)-dimensional image,
  orthogonal to the \(g(Y)\)-dimensional norm image because
  \(c_*p_*a^*=0\).  The resulting dimension inequality forces
  \(N\geq r+2\).
- The field \(L\) is Galois over \(B\): a \(B\)-embedding permutes the
  roots \(t_i\) and sends \(z_i\) to one of \(\pm z_j\), all of which
  lie in \(L\).  An automorphism fixes the coefficients of \(Q\) exactly
  when it stabilizes the selected signed orbit, so \(D=L^{H_0}\).
- For \(r=3\), both the unsigned permutation image and the faithful
  action of \(H_0\) contain a three-cycle and have 3-part exactly three.
  Hence \(j=[H:H_0]\) is a power of two, and the degree-\(8\)
  sign-choice scheme leaves exactly \(j=1,2,4,8\).
- In the \(j=4\) case, the four-point orbit cannot be the origin plus
  the weight-one vertices because that tetrahedron is not
  distance-transitive.  It is the even-parity tetrahedron, whose signed
  permutation stabilizer is \(S_4\).  Its transitive subgroups
  containing a three-cycle are precisely \(A_4,S_4\).
- Etaleness over the signed-root stabilizer makes inertia semiregular on
  all six signed roots.  Every involution in the even-parity signed
  permutation group fixes a signed root, so tame cyclic inertia has
  order three.  This makes \(E'\to E\) etale and yields
  \(g(E)=3ds/2+1\).  Comparison with the cubic incidence arithmetic
  genus gives (81.12), and the plane genus bound gives \(d\geq s+2\).
- If \(3\nmid m\), a fixed point of the deck three-cycle on \(L\)
  would force a free order-three action on a fiber of size
  \([K:L]\mid m\), impossible.  Since all order-three subgroups of
  \(A_4\) or \(S_4\) are conjugate, \(L/B\) is etale.  The resulting
  genus identity and stronger inequality \(d\geq s+3\) are correct.
- At \(M=6,r=3,s=8\), the enumeration by \(j\) is exhaustive.
  The \(N=3,m=2\) rows violate the pencil/orthogonality alternative;
  the formal \(e=6,d=2\) row violates \(N\geq3\); and the sole
  \(j=4\) row has \(d=3<s+2\).  Only \(e=1,2\) remain, exactly the two
  rows eliminated independently in file 78.
- The accompanying Sage certificate was run successfully.  It
  exhausts the ten subgroups of the signed permutation group containing
  the chosen three-cycle, confirms \(j\in\{1,2,4,8\}\), and confirms
  that the \(j=4\) groups are \(A_4,S_4\) with only order-three
  semiregular cyclic subgroups.

## Non-breaking suggestions and objections

- The proof could state explicitly near Theorem 81.1 that
  \(E\cap F=B\); it follows from
  \([EF:F]=[E:B]=r\) and makes the calculation
  \([E_*:E]=j\) behind the parity statement immediate.
- One sentence proving normality of \(L/B\) by the
  \(t_i\mapsto t_j,\ z_i\mapsto\pm z_j\) argument would make Section 2
  more self-contained.
- The notation \(E'\) in Theorem 81.3 is the original one-sign field
  \(B(t,z)\), whereas \(E_*\) is the repaired field.  This is correct,
  but a reminder would reduce the chance of conflating them.

**Audited revision SHA-256:**

- theorem:
  \(c3f418aaa77270fd86f90c9a767ba90efa905f6f84246544af035adea882a3c1\)
- certificate:
  \(9687334e905b8804ef09f91a5d3abd1373ad578223ee9fa0f4b18012f84993d0\)

