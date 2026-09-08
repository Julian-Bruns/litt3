# Normed branch sections and the nonpencil theorem

Version 2, 2026-09-08: combines the two proofs, with separate evidence:

- Propositions 44.1, 44.3 and Theorem 44.2: PASS with a minor divisor
  wording correction, /root/norm_polarization_refinement, 2026-09-04,
  [audit metadata](audits/44_NORMED_BRANCH_PENCIL_AUDIT.md).
- The nonpencil theorem in §4: PASS, /root/norm_pencil_dimension_audit,
  2026-09-04, [audit metadata](audits/46_NORM_PENCIL_DIMENSION_AUDIT.md).

The original proofs and hypotheses are retained. The corrected factor two
in (44.27) is explicit below. The final birational-evaluation corollary is
author prose; this consolidation has no new independent audit.

Over k=Fbar5 all curves are smooth projective connected. Keep the ACTUAL
finite etale diamond

\[
 V\xrightarrow[\;M\;]{a}Y,\qquad
 V\xrightarrow[\;7\;]{p}C\xrightarrow[\;M\;]{c}X,\qquad
 Y:z^2=1-t^{31},\quad X:v^2=q^7-q+1,
\]

where p is a cyclic torsor, β generates its group, and aβ≠a.
Thus g(Y)=15, g(X)=3, g(C)=2M+1 and g(V)=14M+1.
The [Jacobian input](40_JACOBIAN_NORM_OBSTRUCTION_FOR_THE_SEVEN_DIAMOND.md)
is that J(Y) is absolutely simple and h=p_*a^*≠0.
Both original etale legs remain on the SAME source.

## 1. Doubled branch divisors (Proposition 44.1)

Let \(\mathcal A=\mu_{31}\cup\{\infty\}\), and let P_α be the
Weierstrass point of Y over α. Set

\[
 R_\alpha=a^*P_\alpha,\quad D_\alpha=p_*R_\alpha,\quad
 L=\mathcal O_C(2D_\infty),\quad
 \epsilon_\alpha=\mathcal O_C(D_\alpha-D_\infty).
\]

Every R_α is reduced of degree M; D_α is effective of degree M and
need NOT be reduced. Since div_Y(t−α)=2P_α−2P_∞, the norm-divisor
identity gives

\[
 \operatorname{div}_C\operatorname{Nm}_{V/C}(t-\alpha)
       =2D_\alpha-2D_\infty,\quad
 \epsilon_\alpha=h([P_\alpha-P_\infty])\in J(C)[2].   \tag{44.6}
\]

Hence L has a section with zero divisor 2D_α for every α∈𝒜;
at infinity it is represented by the rational function 1.
The 31 finite Weierstrass differences generate J(Y)[2] with their sum
as the unique relation, because

\[
 \operatorname{div}_Y(z)=\sum_{\alpha^{31}=1}P_\alpha-31P_\infty .
\]

Their images can collide according to ker(h|J(Y)[2]); injectivity is
NOT assumed. This proves all branch-section assertions directly.

## 2. The translated pencil (Theorem 44.2)

Let H_Y=O_Y(2P_∞), H_X=O_X(2Q_∞), and Q_X=O_X(Q_∞). Then

\[
 \begin{gathered}
 L^{14}\simeq\omega_C^7,\qquad
 \delta=L\otimes(c^*H_X)^{-1}\in J(C)[14],\\
 \tau=L^2\otimes\omega_C^{-1}=\delta^2\in J(C)[7],\\
 \varepsilon=\mathcal O_C(D_\infty)\otimes(c^*Q_X)^{-1}
                 \in J(C)[28],\\
 \mathcal O_C(D_\alpha)\simeq
       c^*Q_X\otimes\varepsilon\otimes\epsilon_\alpha .
 \end{gathered}                                      \tag{44.19}
\]

**Proof.** Put A_V=a^*H_Y. Etaleness gives
A_V^14=a^*ω_Y=ω_V=p^*ω_C. Norm through p has degree seven and sends
A_V to L; thus L^14=ω_C^7. Also ω_C=c^*ω_X=(c^*H_X)^2.
The formulas for δ,τ follow, while ε²=δ gives ε^28=1.
The last identity is the definition of ε_α. QED.

Since deg L=g(C)−1=2M, Riemann–Roch also gives the symmetry

\[
 h^0(C,L)=h^0(C,L\otimes\tau^{-1}),                    \tag{44.22}
\]

because ω_C⊗L^(-1)=L⊗τ^(-1). In particular all 32 D_α are
28-torsion translates of the pulled degree-one divisor, and their
relative differences lie in the particular subgroup h(J(Y)[2]).

## 3. The norm polynomial and evaluation curve (Proposition 44.3)

Put F=k(C), K=k(V) and

\[
 P(T)=\operatorname{Nm}_{K/F}(T-t)
        =\prod_{i=0}^6(T-\beta^i t).
\]

The t-orbit has size seven. Otherwise β fixes t; its action on z differs
by a constant sign, and odd order forces that sign to be positive,
contrary to aβ≠a. Thus P is the separable minimal polynomial and K=F(t).

Every coefficient is a section of L: above x∈C split the etale p-cover
over a strict henselian neighborhood. If m_x sheets lie over P_∞,
exactly those conjugates have poles of order two. Each elementary
symmetric polynomial has pole order at most 2m_x, the multiplicity of
2D_∞. Thus the coefficient span W satisfies dim W≤8.

For α∈𝒜, evaluation at α, including the homogeneous leading coefficient at
infinity, has zero divisor 2D_α. These sections have no common zero:
at x, choose a finite branch value among the 31 values avoiding the
at most seven t-values on the sheets over x. Its norm section is
nonzero at x, including when some sheets lie over infinity. Hence W
is basepoint-free.

No evaluation P(α) is the zero section, since a constant α cannot be
a root of the irreducible P (and the leading coefficient is nonzero).
Consequently evaluation is an everywhere-defined projected Veronese map

\[
 \nu:\mathbf P^1_t\to\mathbf P(W),\qquad
 \nu^*\mathcal O(1)=\mathcal O_{\mathbf P^1}(7).        \tag{46.11}
\]

The homogeneous norm equation defines an integral divisor Σ in
C×P1_t, of bidegree (7,2M), whose normalization is V via (p,t).
Integrality follows from minimality and the absence of a vertical
component by basepoint-freeness.

The exact product identity is

\[
 \prod_{\alpha^{31}=1}\operatorname{Nm}_{V/C}(t-\alpha)
      =-\operatorname{Nm}_{V/C}(z)^2.                 \tag{44.27}
\]

Its rational-function divisor is
\(2\sum_{\alpha^{31}=1}D_\alpha-62D_\infty\), namely TWICE
p_*a^*div_Y(z). This corrects the old prose omission of a factor
two; the displayed identity is unchanged. It records the unique
Weierstrass relation before possible additional collisions under h.

## 4. The audited nonpencil theorem

One has 3≤dim W≤8. This proof retains the ramification/parity
argument, not just its dimension conclusion.

A one-dimensional basepoint-free space would trivialize L of positive
degree. If dim W=2, choose a basis u_0,u_1 and write

\[
 \mathscr P(T)=A(T)u_0+B(T)u_1 .
\]

The binary forms A,B have degree seven and no common zero by (46.11).
They give R=[−B:A]:P1_t→P1_b of exact degree seven. The coefficient
pencil gives f:C→P1_b of degree 2M, with

\[
                      f p=R t .
\]

The curve V is the normalization of C×_(P1_b)P1_t. R is separable
since its degree is prime to five; t is separable by the actual etale
Y-leg, so f is separable too.

For b∈P1_b write R^*b=Σr_ξ[ξ]. At EVERY c∈f^(-1)(b), the
multiset {t(v):v∈p^(-1)(c)} contains each ξ exactly r_ξ times.
Indeed, after splitting p locally, the specialized binary norm form is
the product of its seven root factors. The L-twist turns a pole of t
into the root at infinity. It is the same binary form as R^*b, including
multiplicities. This supplies every root in the ramification comparison.

Put B_0=R(𝒜), m=|B_0|. For b∈B_0 let k_b count its roots in 𝒜 and
ℓ_b its other roots. Since e_p=1, e_t=2 over 𝒜 and e_t=1 elsewhere,
the equality f p=R t forces, for some integer r_b,

\[
 r_\xi=r_b\ (\xi\in\mathcal A),\quad r_\xi=2r_b\ (\xi\notin\mathcal A),\quad
 e_f(c)=2r_b,\quad 7=r_b(k_b+2\ell_b).                \tag{46.23}
\]

Thus r_b∈{1,7} and k_b is odd; for r_b=7, (k_b,ℓ_b)=(1,0).
There are M/r_b points of C over b, so their different contribution
is at least (M/r_b)(2r_b−1)≥M. This uses only d_x≥e_x−1 and
allows wild ramification elsewhere. Riemann–Hurwitz gives

\[
 \deg\operatorname{Diff}(f)=8M,\quad m\le8 .
\]

On the other hand 32 distinct branch parameters require m≥ceil(32/7)=5, and
32=Σk_b with each k_b odd forces m even. Hence m∈{6,8}. More
precisely, as reduced divisors on the projective lines,

\[
                  R^*B_0\equiv\mathcal A\pmod2.              \tag{46.30}
\]

Let Y_(B_0)→P1_b be the double cover branched at B_0. It has genus
(m−2)/2∈{2,3}. Congruence (46.30) produces a lift
Y→Y_(B_0): choose rational branch functions F_A,F_B; then
F_B(R(t))/F_A(t) has even divisor, so is a square because
Pic^0(P1)=0 and k is algebraically closed. The degree-seven extension
k(t)/k(R(t)) cannot contain the quadratic target extension. Their
quadratic base change therefore has degree seven.

The resulting pullback J(Y_(B_0))→J(Y) has finite kernel, since its
norm composite is [7]. It is a nonzero proper abelian subvariety of
the simple 15-dimensional J(Y), contradiction. This proves the bound.
Only the degree/genus identities, the cyclic etale cover with primitive t,
the 32 tame hyperelliptic branch points and simple J(Y) were used here.
The explicit X equation and §2's torsion relations are not needed for
this argument. No injectivity of h on two-torsion is used; it survives
all label collisions.

## 5. A consequence and the boundary

**Author corollary.** The evaluation map ν is birational onto a rational
curve of degree SEVEN. Indeed its degree times the degree of its image
is seven by (46.11), while dim W≥3 makes the nondegenerate image
nonlinear. Primality forces degree one. At dim W=8 it is the complete
degree-seven Veronese embedding. No injectivity for dim W<8 or for
the two-torsion labels is inferred.

Thus one retains a torsion-translated pulled pencil, all 32 actual
doubled divisors, their relative Weierstrass labels, and the integral
spectral equation—not merely a rank or degree. These data alone do
not force a common quotient. The [coefficient-field theorem](47_COEFFICIENT_FIELD_COARSENING.md)
and [label/conductor bounds](55_SQUARE_LABEL_COLLISIONS_AND_SPECTRAL_CONDUCTOR.md)
are distinct subsequent restrictions. No arbitrary common-cover
exclusion is proved here.
