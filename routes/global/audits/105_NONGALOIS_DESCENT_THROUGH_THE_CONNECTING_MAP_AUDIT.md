# Audit: non-Galois descent through the connecting map

**Date:** 2026-09-05.  
**Auditor:** Codex subagent `/root/gluing_cohomology_rigidity`.  
**Verdict:** **PASS.** No breaking issues found.

Audited [file 105](../105_NONGALOIS_DESCENT_THROUGH_THE_CONNECTING_MAP.md)
independently as a bounded proof check. Theorems 103.1 and 103.2 were
accepted as inputs; this is not an independent audit of the auditor's
own file 103. No further research branches were pursued.

## Scope and checks

- The descended tensor has exactly the claimed extension space. Pullback
  and tensoring by Q give the stated kernel and quotient. The original
  connecting class makes the lifted section nowhere zero, with injectivity
  of the connecting map supplied by H^0(X,P^{-1})=0.
- Every E_{0,d} has a nowhere-zero section and negative-degree determinant.
  Its space of global sections is consequently one-dimensional. Constant
  h^0 and Riemann--Roch give the required cohomology and base change;
  evaluation is a line subbundle. The resulting section of q^*T tensor Q
  is a unit, proving the line-bundle descent and the exact equation descent.
- Finite faithful flatness of 1 x q makes integrality descend from Gamma
  to Gamma_0. The generic algebra K_0 tensor_E L is a field of degree
  deg(q) over K_0. The intermediate maps in the etale map Z -> X are
  etale. Field-differential base change then proves separability of both
  q and Z_0 -> D. The normalized fiber product retains the original Y
  and both degree statements are correct.
- The absolute-simplicity consequence follows from the finite kernel of
  Jacobian pullback and Riemann--Hurwitz. The canonical substitutions and
  the birational divisor-family consequence are correct.
- The hyperelliptic lower bound h+2 is correct. Independently, for a
  hypothetical basepoint-free birational line bundle H of degree at most
  h+1, h^0(H)>=3 implies h^1(H)>0. For the hyperelliptic map v, write
  v_*H=O(a) direct-sum O(b), with a>=b. Specialness forces b<=-2, so all
  global sections come from O(a). Their adjunction map v^*O(a)->H has
  no zeros because H is globally generated. Thus H and every such series
  factor through v, contradicting birationality. This argument is valid
  in positive characteristic as well.

## Non-breaking observations

The assertion that Z_0 x_D Y is integral implicitly uses finite flatness
over the smooth curve Y: its coordinate algebra injects into its generic
algebra, which is a field. This rules out nilpotents or additional
components supported at closed fibers. Stating this explicitly could
clarify the normalization paragraph but is not needed to repair it.

The final boundary is essential and correctly retained: descent to D
does not supply a map from Z_0 to the fixed Y, and the case deg(q)=1
does not decrease the source degree. No all-degree exclusion follows.
