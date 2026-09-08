# A projective etale cover acquires Tango: the complete Hoshi twist certificate

Version 2, 2026-09-08. The counterexample retains its focused PASS audit,
/root/gluing_cohomology_rigidity, 2026-09-05, no breaking objection:
[audit record](audits/HOSHI_GENUS6_TWIST_WITH_NO_MAXIMAL_TANGO_AUDIT.md).
Its complete geometric zero calculation was independently rerun by that
auditor. The merged fifteen-class rank packet is separate AUTHOR/exact
computation, not an extension of the audit. Original proofs and arithmetic:
2026-09-05; new regression replays are not a fresh audit.

These are AUXILIARY curves. They disprove unrestricted maximal-Tango
descent, not Litt's conjecture, and do not replace the fixed genus-(9,25)
pair or inherit its Jacobian hypotheses.

## Theorem and both actual etale legs

Over k=algebraic closure of F_5, choose r²=3 and put

\[
 F=2t^6+2t^4+3t^2+4,\quad A=2t^8+4t^6+2,\quad
 B_0=t^2+4,\quad q=t^2+rt+1,\quad e=A+B_0v.
\]

The following equations mean smooth projective normalizations:

\[
\begin{aligned}
 B &:v^2=F,\\
 Y &:v^2=F,\quad h_Y^2=e,\\
 X &:v^2=F,\quad h_X^2=qe,\\
 Z &:v^2=F,\quad h_Y^2=e,\quad s^2=q .
\end{aligned}                                                   \tag{1}
\]

Then g(Y)=g(X)=6, g(Z)=11, and Z→Y and Z→X (h_X=sh_Y) are BOTH
connected finite etale doubles from the SAME source. Y has ten maximal
Tango structures, whereas X has NONE; hence Z has a Tango structure
that does not descend to X. The p-ranks are γ(Y)=4,γ(X)=5,γ(Z)=8,
so neither leg meets the equal-rank hypothesis of
[rank-preserving descent](115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT.md).

### 1. Exact geometry, connectedness and a global dormant origin

The [Hoshi geometry and quotient proof, Section 5](HOSHI_GENUS6_EXACT_TANGO_COUNT.md)
identifies Y with w^6=(x+3)y+4x²+4x+3 on y²=x³+3x+2.
Its reflection (Q,w)↦(P−Q,2/w), P=(1,1), has quotient B and exact
anti-invariant generator h_Y=t^5(w−2/w). The retained
[quotient certificate](HOSHI_GENUS6_GENUS2_QUOTIENT_MODEL_CERTIFICATE.py)
checks these identities in the original function field. For this
counterexample even one of its ten Tango structures suffices.

The quadratic q selects two distinct roots of the squarefree F.
For their Weierstrass points W_a,W_b and the two infinities I_+,I_-,

\[
 \operatorname{div}_B(q)=2W_a+2W_b-2I_+-2I_-.
\]

Thus B'=B(√q)→B is unramified. It is connected because neither q nor
q/F is a square in k(t), so q is not a square in k(B). The ramified
quadratic Y/B is linearly disjoint from B'/B. Hence Z=Y×_B B' is
connected, smooth and etale over Y; also Z=X×_B B' via h_X=sh_Y, so
it is etale over X. This is equivalently the free product-involution
construction of [the quadratic-twist theorem](120_TANGO_FIXED_STRUCTURES_UNDER_UNRAMIFIED_TWISTING.md).
Riemann--Hurwitz gives the asserted genera.

For Q_0=(0,2), the exact identity

\[
 \operatorname{Nm}(e)=A^2-B_0^2F
          =4t^{10}(t^6+4t^4+4t^2+2)
\]

gives

\[
 \operatorname{div}_B(e)=10Q_0+R_1+\cdots+R_6-8I_+-8I_- . \tag{2}
\]

Indeed the sextic is squarefree and coprime to F and B_0; e vanishes
at Q_0 but not (0,3), and has pole order eight at each infinity. The
six distinct R_i are disjoint from Q_0, all Weierstrass points and
infinity. X/B ramifies precisely at them.

On X the nonzero rational differential

\[
                         \xi=q^3\,dt/(vh_X)             \tag{3}
\]

has order +5 at each of the four points over W_a,W_b, order −5 at
each of the two over Q_0, and order zero elsewhere. At R_i the
ramification zero of dt/v cancels the simple zero of h_X; at W_a,W_b
the orders are 6−1; at Q_0 the pole is five; at infinity they are
−6+1−(−5)=0. Therefore declaring ξ horizontal gives a GLOBALLY regular
dormant canonical connection ∇_ξ, not just an origin regular at test
points: its horizontal divisor is five-divisible, and its rational
horizontal frame gives zero p-curvature.

### 2. A complete scalar Cartier calculation, reusable for all fifteen twists

The divisor argument works for ANY q selecting a pair of roots of F.
Every anti-invariant rational differential is (a+bv)dt/(vh_X).
It is holomorphic exactly when

\[
 \deg a\le6,\quad\deg b\le3,\quad q\mid a,\quad
 a+b(2+2t^2+2t^4)\equiv0\pmod{t^5}.                    \tag{4}
\]

The frame is a unit at R_i, has pole order five at Q_0, pole order one
at the chosen Weierstrass points, and zero order six at both infinities.
These give respectively the jet condition, q-divisibility and degree
bounds. Elsewhere the numerator is regular, hence lies in k[t,v].
Leading terms cannot cancel at BOTH infinities. Thus these conditions
are necessary and sufficient, not a bounded ansatz.

For the selected q, eleven coefficients satisfy seven independent
constraints. A full four-dimensional basis of pairs (a_i,b_i) is

\[
\begin{aligned}
 &(t^6+1,\ 3t^2+2),\\
 &(4rt^6+4t^5+t,\ 3t^3+2t),\\
 &(3t^6+2rt^5+t^4+t^2,\ 2t^2),\\
 &(4rt^6+3t^5+t^3,\ 2t^3).
\end{aligned}                                                   \tag{5}
\]

For a polynomial H set C_t(H)=∑H_(5j+4)^(1/5)t^j.
If (a+bv)(qe)²=A_1+B_1v, the exact Cartier formula is

\[
 C((a+bv)dt/(vh_X))
      =\bigl(C_t(F^2A_1)+vC_t(B_1)\bigr)dt/(vh_X).       \tag{6}
\]

Multiply the numerator by F²(qe)² to write the denominator as v^5h_X^5,
then use F²v=v^5 and Cartier's fifth-power linearity. Fifth roots in
F_25 equal fifth powers. In basis (5), columns are images and

\[
 M=\begin{pmatrix}
 1&0&0&3r\\
 2r&3&4r&4\\
 1&4r&4&3r\\
 0&0&3r&3
 \end{pmatrix}.                                          \tag{7}
\]

The [scalar p-rank certificate](HOSHI_GENUS6_SINGLE_TWIST_P_RANK_CERTIFICATE.py)
checks (4), reconstructs each image from (5), and computes semilinear
iterates N_0=I, N_(j+1)=M N_j^(5). Their six ranks are all four,
computed by scalar elimination. The invariant differential space is
pulled back from B, whose Cartier matrix on dt/v,t dt/v is diag(0,1).
Thus γ(X)=5, with invariant fixed form t dt/v.

### 3. The complete rank packet and why the old rank strategy failed

All fifteen nonzero J(B)[2] classes are represented by q_ij=(t−r_i)(t−r_j)
for the six roots of F in F_25. Each gives a connected unramified B'/B
by the same divisor/nonsquare argument. In its Klein-four presentation
over P¹_t, the other quadratic quotients have genera zero and one,
the latter e_ell²=R_ij for R_ij=F/(2q_ij). The character-idempotent
isogeny therefore gives

\[
 \gamma(B'_{ij})=\gamma(B)+\gamma(e_{\rm ell}^2=R_{ij}).
\]

A squarefree quartic has supersingular genus-one model exactly when
[t^4]R_ij²=0. The [fifteen-case Prym certificate](HOSHI_GENUS2_UNRAMIFIED_PRYM_FILTER_CERTIFICATE.py)
checks every scalar: only q_±=t²±rt+1 give γ(B')=1; all others give
two. For q_+, the complementary quartic is
R_+=t^4−rt³+3t²+3rt+2, with [t^4]R_+²=0. Frobenius exchanges q_±.

The [complete scalar twist scan](HOSHI_GENUS6_TWIST_PACKET_CARTIER_CERTIFICATE.py)
uses (4) and (6) for all fifteen q, reconstructing every Cartier image.
It gives γ(X)=3 exactly for q=t²+2t+4 and t²+3t+4, and γ(X)=5 for
the other thirteen, including q_±. These are AUTHOR/exact computations,
not additional claims of the focused zero audit.

For q_±, the exact rank identity for the ACTUAL Klein-four cover gives
γ(Z)=γ(Y)+γ(X)+γ(B')−2γ(B)=4+5+1−2=8. None of the fifteen twists
satisfies γ(X)=γ(B)=1, and none gives γ(Z)=γ(Y). Thus the entire
packet fails both historical rank criteria. That failure does not imply
Tango existence: the following direct certificate proves nonexistence.

### 4. All 3125 geometric dormant connections

Every regular dormant connection on ω_X is uniquely ∇_ξ+α with
Cα=α. The invariant part is generated by t dt/v. The anti-invariant
part in basis (5) is defined by

\[
                            z^5=M^{(5)}z.
\]

The [zero-Tango certificate](HOSHI_GENUS6_SINGLE_TWIST_TANGO_CERTIFICATE.py)
works over K=F_(5^120), recording its irreducible modulus and the
embedding of r as coefficient lists. It expands this into a
480-dimensional linear system over the PRIME field F_5. Its kernel
has dimension four; every returned vector is reconstructed in K^4
and verified against the original equation, with independent scalar
elimination checking independence. These four forms exhaust the
geometric anti-invariant fixed space because its dimension is already
known to be four. Together with t dt/v they give ALL 5^5=3125 dormant
regular connections over the algebraic closure, not a smaller-field sample.

### 5. Exact rejection of every connection

In parameter t a horizontal u dt satisfies u'=−au and
u^(4)=P_4(a)u, with P_4=a^4−a²a'+3(a')²+4aa''−a'''.
Thus one NONZERO evaluation rejects a Tango structure. This tests a
necessary local condition on the already complete set of global dormant
connections.

The final certificate computes exact Taylor jets through order four
by square-root Newton iteration in characteristic five. At every point
it checks v²=F, h_X²=qe and vh_Xqe≠0. Hence t is a local parameter
and all denominators are units. Its successive survivor counts are:

| Test point | Connections remaining |
|---|---:|
| (t,v,h_X)=(1,1,2+2r) | 3 |
| (1,4,2+2r) | 1 |
| Six further safe points over t=1,4 | 1 |
| (0,3,2) | 0 |

After the second point the sole survivor is ∇_ξ+t dt/v. At the final
point its coefficient is a=4t+O(t^4), with zero cubic term, giving
P_4(a)(0)=3≠0 directly. The code asserts an empty survivor list.
No interpolation, bound on zeros or inference from finite vanishing
to identical vanishing occurs: EVERY candidate has a nonzero witness.

### 6. Reliability and exact boundary

The [backend audit](audits/HOSHI_SAGE10_9_CUSTOM_GF25_MATRIX_BACKEND_AUDIT.md),
/root/x_elliptic_quotient_maps, 2026-09-05, confirmed a bug in the tested
Sage 10.9 custom-F_25 optimized matrix representation and found that
these certificates survive the scalar rechecks. The selected and
fifteen-twist Cartier scripts use no matrix constructor/kernel/rank/
solve/product backend: all operations
are explicit scalar elimination with coefficient reconstructions.
The zero test uses optimized matrices ONLY over F_5, then directly
checks the returned extension-field vectors and their independence.
This is not an unrestricted claim about all Sage finite-field routines.

All executable certificate logic is preserved. The selected zero test,
scalar p-rank input and both complete fifteen-case scans replayed PASS
2026-09-08; the zero test took about0.41 seconds after setup in that replay.
This is regression evidence, not a new independent audit.

Finally, Z has a Tango structure pulled back through its actual etale
Y-leg but X has none. Its actual etale X-leg therefore witnesses
failure of UNRESTRICTED descent while preserving BOTH original maps.
The genus-(9,25) fixed pair, arbitrary common-cover exclusion and Litt's
conjecture remain untouched.
