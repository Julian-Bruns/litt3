# Audit: signed-orbit congruences and the repaired short-degree sieve

**Verdict:** **PASS.**  No breaking mathematical objection was found.

**Auditor and date:** /root/x_elliptic_quotient_maps, 2026-09-04.

## Checks performed

- Verified the orbit congruence by decomposing the sign-selection orbit
  under the pure coordinate \(r\)-cycle.  Its only fixed cube vertices
  are \(0\) and \(\mathbf1\), giving \(j\equiv1\) or \(2\pmod r\).
  Combining this with the independently established parity of every
  nontrivial geometric \(j\) gives exactly
  \(j\in\{1,2,r+1\}\) or \(j\ge2r+2\).
- Checked the distinction between signed-letter transitivity and the
  \(j=1\) case.  Transitivity is used in Theorem 82.3 only after
  \(j=r+1>1\); then Theorem 81.1 gives \(z\notin E\), so
  \([E':B]=2r\) and all \(2r\) signed roots are indeed one Galois orbit.
  Corollary 82.4 does not assume signed transitivity when \(j=1\); it
  uses the parity statement already proved in Theorem 81.1.
- Rechecked the cyclic Hadamard argument.  Transitivity of \(H\) on its
  cube orbit forces every nonzero translate of \(A\) to lie at distance
  \(|A|\) from \(A\).  Summing
  \(|A\cap(A+i)|=|A|/2\) gives
  \(|A|=(r+1)/2\), hence \(r\equiv3\pmod4\), and adjoining the initial
  \(+1\) coordinate gives mutually orthogonal rows.
- Verified Lemma 82.2.  For an affine involution \((a,\pi)\), the support
  of \(a\) is \(\pi\)-stable.  If no signed letter were fixed, all of
  the odd number of fixed coordinates of \(\pi\) would lie in that
  support, forcing its weight odd, contrary to the even Hadamard weight.
- Checked the inertia step.  Since \(L/E'\) is etale, inertia acts freely
  on the \(2r\) signed letters, so its order divides \(2r\).  The
  characteristic assumptions make it tame cyclic.  An even-order
  inertia group contains an involution, which Lemma 82.2 shows cannot
  act freely.  Hence only order \(r\) can ramify and \(E'/E\) is etale.
- Recomputed the genus calculation
  \(g(E)=drs/2+1\), the product-surface arithmetic genus
  \(rb+(r-1)(d-1)\), and the resulting lower bound
  \[
       b\ge ds/2-(r-1)d/r+1.
  \]
  Combining it with the birational plane bound
  \(b\le(d-1)(d-2)/2\) gives exactly \(d\ge s+2\).
- In the coprime case, verified
  \(v_r(|H|)=1\), \([K:L]\mid m\), the fixed-fiber argument excluding
  order-\(r\) inertia when \(r\nmid m\), and the resulting identities
  \(b=ds/2+1\) and \(d\ge s+3\).
- Rechecked Corollary 82.4 including the endpoint \(r=3\).
  From \(j\le N\le M<2r+2\), only \(1,2,r+1\) remain.  For
  \(j=r+1\), \(s\ge2\) gives \(N\ge2r+2\).  When \(s=1\), the first
  bound forces \(m=1\), and the coprime strengthening again gives
  \(N\ge2r+2\).  Thus \(j\in\{1,2\}\) throughout the claimed strict
  interval.  The final implication \(M<2r\Rightarrow m=1\) follows
  from \(M=mN\) and \(N\ge r\).

## Breaking objections

None.

## Non-breaking suggestions and objections

- In Theorem 82.3, explicitly insert the sentence
  \(j=r+1>1\Rightarrow z\notin E\Rightarrow[E':B]=2r\) before invoking
  transitivity on all signed letters.  The implication is already
  supplied by Theorem 81.1, so this is only a clarity improvement.
- In the coprime-inertia argument, one could say explicitly that
  \(V\to L\) is etale because \(K/L\) is intermediate in \(K/k(Y)\),
  and that conjugacy transfers freeness on \(L\) without requiring a
  lift of every element of \(H\) to \(K\).
- A one-line display of the \(s=1,r=3\) endpoint
  \(j=4,\ d\ge3,\ N\ge6,\ m=1,\ d\ge4,\ N\ge8\)
  would make the strict \(M<8\) boundary especially transparent.

## Audited revision hash

8b2f707bb018ac3a6fa4c0962b3c40383a481383f6bf8694f96e9c1476d6ada7
