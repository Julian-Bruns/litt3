# Ordinary HN polygons of all symmetric powers of the Cartier bundle

Let C be a smooth projective connected curve of genus g≥2 over an
algebraically closed field of odd characteristic p. Put s=g−1 and
B=F_*O_C/O_(C^(1)). For every n≥0, the ranks and slopes divided by s
of the ordinary Harder–Narasimhan filtration of Sym^n(B) depend only
on n and p, including n≥p.

More precisely, put M=(p−1)n and

    W_n(z)=[u^n] ∏_(i=1)^(p−1) (1−uz^i)^(-1),
    E_n(z)=z^M                          if n≡0 (mod p),
           ∑_(j=0)^(p−2) z^(M−j)       if n≡1 (mod p),
           0                            otherwise,
    Q_n(z)=(W_n(z)−E_n(z))/(1+z+⋯+z^(p−1)).

Then Q_n is a polynomial with nonnegative integer coefficients. If
H_n(z)=∑_μ rank(gr_μ) z^(pμ/s), the HN polynomial is

    H_n(z)=p z^(p−1)Q_n(z^2)
           + z^(2M)                    if n≡0 (mod p),
           + (p−1)z^(2M−p+2)          if n≡1 (mod p),
           + 0                         otherwise.

Here exactly one of the last three terms is added, and equal slopes
are combined. The construction commutes with finite étale base change.
Universality also holds for divided powers of B and symmetric or
divided powers of B^∨, with canonical line twists.

This does not compute arbitrary Schur subquotients or extension
classes, produce a shared differential, or exclude a common cover.
The symmetric-power statement is independent of the full-tensor
formula; no direct-summand assertion is made when n≥p.

[Proof](../Solutions/Sol_all_symmetric_cartier_hn.md).
Audited prose: PASS, `/root/cartier_symmetric_power_hn_major_audit`,
2026-09-06, no breaking objection;
[audit record](../routes/global/audits/ALL_CARTIER_SYMMETRIC_HN_AUDIT_2026_09_06.md).
