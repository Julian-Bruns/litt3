# Unadopted12-coordinate probe —2026-09-06

Not the active solver. No speed benchmark or handoff from current memory
was established. The user requested a pause before any further experiment.
The completed expanded checkpoint and probe code are retained recoverably
outside the active workspace with retired solvers; the short derivation
below is sufficient to reproduce it without consuming routine context.

In the monic cubic quotient use raw variables C=x^4+sum(c_i x^i),
A=x^10+sum(a_i x^i), B=sum(b_i x^i), Lambda. The third equation is

    F A''-F' A'-(2x^8+B)A+2FC^2=0.

Successively solve its coefficients of degrees17 through8 for

    c3,a8,c1,a6,a5,b2,a3,b0,a1,a0,

with constant respective pivots -1,-1,-1,-2,-2,-1,-1,-1,-2,-2 in F5.
Each substitution was checked exactly. Then the degree20 coefficient of
F(CF)''-[2F''F+2(F')^2+(2x^8+B)F]C-3Lambda*A^2 solves Lambda.
This leaves c0,c2,a2,a4,a7,a9,b1,b3,b4,b5,b6,b7. All eliminations have
constant nonzero pivots and preserve schemes, but the whole comparison
with original inputs was not independently audited or benchmarked.

Fully expanding the residuals yielded42 equations, maximum degree22,
242362 monomials. The current14-coordinate presentation has maximum
degree16 and39368 terms. Fewer variables alone is therefore not evidence
of a faster solver. A sparse straight-line/intermediate representation
would need to earn its advantage before another restart.
