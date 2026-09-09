# Focused audit: forced canonical Witt endpoint

Verdict: PASS, with two expository clarifications below; no mathematical blocker.
Auditor: /root/audit_forced_canonical_witt. Date: 2026-09-09.
Scope: NEW Version1 theorem and proof only. Accepted inherited W2 dictionary,
negative-H1 injectivity, ring theorem and refinement equivalence as inputs.
This is a mathematical prose audit, not formal verification.

The induction is on an EXISTING next curve diagram. The full previous
filtered data, unique maximal graded lift, and unique lifted Hodge section
supply the next inverse-Cartier input. Etale-local Frobenius lifting and
Taylor gluing commute with pullback. Hence the common obstruction is in
J1, vanishes there, and vanishes on both endpoints by individual
injectivity. This neither constructs a next diagram nor assumes source
ordinariness. Negative normal degree gives the required Hodge uniqueness.

[LSYZ Section5](https://arxiv.org/html/1404.0538#S5), Proposition5.2 and
Lemmas5.1/5.3/5.4, support the all-level variation and reconstruction.
For transparency, explicitly write the input immediately after Definition5.5:
the previous flat object is H_(n-1) tensor(kappa_(n-1),nabla_kappa),
with tensor filtration and induced graded identification. It is not the
untwisted previous H_(n-1). The proof's projective treatment legitimately
removes this distinction, while its SL2 presentation must retain it.

[Mochizuki III2.5--2.8 and3.3--3.4](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
printed pp107--114, support the ordinary canonical comparison. Make explicit
that the canonical indigenous MF object supplies a compatible projective
flow at every truncation, and compare it inductively with the constructed
flow: the base data agree, the Hodge lift and projective graded identification
are unique, and bijective Psi_Y singles out the next curve lift. This uses
the existing canonical tower as comparator; it does not apply an infinite
MF characterization directly to a truncated object.

The universal W/(5^e) diagram proves equality on all Artinian bases,
including ramified bases; testing Witt-valued points alone would not.
The snake sequence follows after Frobenius linearization. With d=tau_g-tau_f,
the connecting class is [rho_X]; after killing it the remaining mismatch
is ker(Psi_Z)/f*ker(Psi_X). The stable-image assertion is correct over the
perfect field. All conclusions preserve both original etale maps and leave
W3 existence, the exponent e, and the common-cover problem unresolved.
