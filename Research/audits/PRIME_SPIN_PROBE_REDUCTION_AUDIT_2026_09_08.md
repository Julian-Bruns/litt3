# Prime spin probe reduction audit

- Verdict: PASS.
- Auditor: /root/audit_prime_spin_probe.
- Date: 2026-09-08.
- Scope: complete version1 statement and proof of
  `prime_spin_probe_reduction`; fresh bounded prose audit, no computation
  or formal verification.
- Objections: none.

The odd-prime field probe is valid: finite ramification indices are odd,
so a ratio in k(x) would be a square polynomial and identify the two
spin lines. Three square-compatible double torsors suffice. The complete
section field contains the full embedded X field before any use of
etaleness of its image map. Intermediate-cover etaleness therefore closes
that step without circularity. The genus-two Galois fixed-divisor argument,
Riemann--Roch descent of the genuine image spin, Cartier recovery of Y,
and source-effectivity removal of the residual spin ambiguity preserve
both actual maps and the original reduced section.

The four named prior results were used as stated dependencies, not
re-audited. Mumford's primary paper was checked: the characteristic-not-two
scope and odd-theta count appear on pp181--182, with the count's proof
discussion on p190:
[Theta characteristics of an algebraic curve](https://www.dam.brown.edu/people/mumford/alg_geom/papers/1971a--ThetaChar-Numdam.pdf).
This is a structural reduction only; no nonexistence or bounded normal
closure degree follows.
