# Power-label coarsening and the spectral conductor

Version 2, 2026-09-08. The statements numbered 55.1–55.4 retain their
original hypotheses and PASS audit by /root/audit_square_labels,
2026-09-04: [audit metadata](audits/55_SQUARE_LABEL_COLLISIONS_AND_SPECTRAL_CONDUCTOR_AUDIT.md).
Their proofs are compressed below, including an explicit characteristic-five
Castelnuovo check. The parameterized power-section and nongalois
conductor extensions are AUTHOR prose, not additions to that audit.

For the audited applications work over k=Fbar5 with the ACTUAL etale
seven-diamond and [norm data](44_NORMED_HYPERELLIPTIC_BRANCH_PENCIL.md):

\[
 V\xrightarrow[\;M\;]{a}Y,\qquad
 V\xrightarrow[\;7\;]{p}C\xrightarrow[\;M\;]{c}X,\qquad
 Y:z^2=1-t^{31},\quad X:v^2=q^7-q+1,
\]

p cyclic with generator β, aβ≠a, and g(C)=2M+1, g(V)=14M+1.
Put \(\mathcal A=\mu_{31}\cup\{\infty\}\). The norm polynomial P has
basepoint-free coefficient span W⊂H^0(C,L), deg L=2M,
k(V)=k(C)(t), and

\[
 \operatorname{div}_L P(\alpha)=2D_\alpha,\quad
 \deg D_\alpha=M,\quad
 \epsilon_\alpha=\mathcal O_C(D_\alpha-D_\infty)
       =h([P_\alpha-P_\infty])\in J(C)[2],\quad h=p_*a^* .
\]

Both original etale legs remain on the SAME source. No reducedness of
D_α or injectivity of the labels is assumed.

## 1. Power sections and a field coarsening

**Author parameterized statement.** Over any algebraically closed field,
let L have a basepoint-free subspace W on a smooth projective curve C,
deg L>0. Suppose a nondegenerate
ν:P1→P(W) has ν^*O(1)=O(d), d≥1, and A^q≃L with q≥2. If the sections
at d+1 DISTINCT PARAMETERS belong to

\[
 U_{A,q}=\operatorname{im}(\operatorname{Sym}^qH^0(C,A)\to H^0(C,L)),
\]

then W⊂U_(A,q), A is basepoint-free, and the W-map factors through
the complete A-map by degree-q forms on its image. If e,e_A denote
their respective generic degrees, then

\[
                    e_A\mid e,\qquad e_A\mid\deg A.   \tag{55.11}
\]

This requires no characteristic restriction on q.

**Proof.** If the d+1 values failed to span W, a hyperplane containing
them but not the nondegenerate ν-image would pull back to a nonzero
degree-d section with d+1 zeros. Thus they span W. A base point of A
would be a base point of U_(A,q) and hence of W, impossible. The
degree-q expressions now give the factorization, so the coefficient
fields satisfy k(B)⊂k(B_A)⊂k(C), proving e_A|e. Finally
A=ψ_A^*O_(B_A)(1), so deg A=e_A deg O_(B_A)(1). QED.

**Theorem 55.1, audited square-label specialization.** If eight distinct
α∈𝒜 have the same ε_α=ε_0, then

\[
 A=\mathcal O_C(D_\infty)\otimes\epsilon_0,\quad
 \deg A=M,\quad A^2=L,\quad
 W\subseteq U_{A,2},\quad e_A\mid\gcd(e,M).
\]

Here A is basepoint-free, and the coefficient map factors through its
complete map by quadrics. Indeed the canonical sections of O(D_α),
identified with A, square up to nonzero scalars to P(α). The evaluation
identity ν^*O(1)=O(7) gives exactly the eight-section proof above.
This is the original audited argument, not a presumed injection on J(C)[2].

## 2. Five labels at M=9 and full span (Corollary 55.2)

If M=9 and dim W=8, no ε-label occurs eight times. Thus

\[
 \#\{\epsilon_\alpha\}\ge5,\qquad
 \dim_{\mathbf F_2}h(J(Y)[2])\ge3.                    \tag{55.16}
\]

**Proof.** Eight equal labels give A as above. The audited
[coefficient theorem 47.3](47_COEFFICIENT_FIELD_COARSENING.md)
gives e=2, so e_A divides both 2 and 9 and is one. Also
binom(h^0(A)+1,2)≥dim W=8, hence h^0(A)≥4.
The complete A-map is therefore a birational nondegenerate degree-nine
model of the genus-19 curve C in dimension at least three.

It is nonstrange in characteristic five: otherwise projecting from
the strange point and taking fifth roots gives at least three independent
sections of a line bundle of degree at most floor(9/5)=1, impossible.
Castelnuovo applies and is largest in dimension three, where
π(9,3)=12<19. Contradiction. The 32 parameters now give at least
ceil(32/7)=5 labels; all lie in h(J(Y)[2]), proving the rank bound. QED.

## 3. Exact conductor, including a nongalois extension

**Author parameterized statement.** Over any algebraically closed field,
let p:V→C be ANY finite etale map of degree r≥1 between smooth projective connected curves, and let
t:V→P1 be nonconstant of degree d with k(V)=k(C)(t). No Galois
group is required, and t need not be separable. For the integral image
Σ⊂C×P1, V is its normalization and

\[
 \delta(\Sigma)=(r-1)d,\qquad
 \deg\mathfrak C_\Sigma=2(r-1)d.                     \tag{1}
\]

There is an exact divisor formula. Let
I=(V×_C V)\setminusΔ_V, with projections π_1,π_2. Then

\[
 D_I=(t\pi_1,t\pi_2)^*\Delta_{\mathbf P^1},\qquad
 \mathfrak C_\Sigma=(\pi_1)_*D_I.                    \tag{2}
\]

Primitivity is ESSENTIAL: it makes the two t-values different on every
generic off-diagonal component, so D_I is an effective Cartier divisor.

**Proof.** The image is birational to V by primitivity. Its divisor
class has bidegrees (r,d), so adjunction and etaleness of p give

\[
 p_a(\Sigma)=r(g(C)-1)+(r-1)d+1,\quad
 g(V)=r(g(C)-1)+1,
\]

proving the delta formula. Etale-locally on C all r branches are smooth
graphs of the distinct conjugates of t. On one normalized branch the
conductor exponent is the sum of its intersections with the other
branches: locally its conductor ideal is generated by the product of
their graph differences. Ordered pairs are exactly I, giving (2),
also at poles by using the reciprocal target coordinate. Finally both
π_i have degree r−1 and O(Δ_P1)=O(1,1); hence
deg D_I=2(r−1)d, proving (1). QED.

**Theorem 55.3, audited seven-diamond specialization.** Define

\[
 E_j^t=(t,t\beta^j)^*\Delta_{\mathbf P^1},\quad 1\le j\le6.
\]

These are effective, each of degree 4M. The spectral image and conductor
satisfy the original identities

\[
 p_a(\Sigma)=26M+1,\quad \delta(\Sigma)=12M,\quad
 \mathfrak C_\Sigma=\sum_{j=1}^6E_j^t,\quad
 \deg\mathfrak C_\Sigma=24M.                         \tag{55.21}
\]

Indeed Σ²=28M and Σ·K_(C×P1)=24M; adjunction gives the arithmetic
genus, and g(V)=14M+1 gives δ. The same smooth-graph proof identifies
the six cyclic coincidence divisors with the conductor, while each
has degree deg t+deg(tβ^j)=4M. This retains the original audited
calculation directly; the wider nongalois assertion is separately author.

## 4. Special-fiber collisions versus equal line-bundle labels

For the audited setup put n_(α,x)=mult_x D_α and
s_α=|Supp D_α|. Corollary 55.4 is

\[
 \sum_{\alpha,x}n_{\alpha,x}(n_{\alpha,x}-1)\le12M,
 \qquad \sum_\alpha s_\alpha\ge26M.                  \tag{55.26}
\]

**Proof.** The reduced R_α=a^*P_α supplies n_(α,x) DISTINCT local
branches over (x,α). On each, a target parameter t−α (or 1/t at
infinity) has order two. Each pair therefore has intersection at least
two. Ordered pairs contribute at least 2n_(α,x)(n_(α,x)−1) to the
conductor, whose degree is 24M. This gives the first bound. For n≥1,
n(n−1)≥2(n−1), so Σ_α(M−s_α)≤6M; there are 32 α, proving the
second. Sums of n−1 are over the SUPPORT, not all points of C. QED.

The same local proof gives an **author extension** for any ACTUAL pair
V→C of etale degree r and V→Y of etale degree M, with Y hyperelliptic
of genus g in characteristic ≠2 and its coordinate t primitive over
k(C). There are 2g+2 branch divisors D_α, and d=2M. Formula (1) yields

\[
 \sum_{\alpha,x}n_{\alpha,x}(n_{\alpha,x}-1)\le2(r-1)M,\qquad
 \sum_\alpha s_\alpha\ge(2g+3-r)M.
\]

No cyclicity of V/C, special equation, or injectivity on two-torsion
is needed for this extension.

Linear-equivalence collisions ε_α=ε_β and geometric root collisions
are different data. All D_α can be reduced and consume none of the
special-fiber conductor budget, while their line-bundle labels may
still coincide. Neither the power coarsening nor the conductor bounds
supply the missing relation between these phenomena or an arbitrary
common-cover exclusion.
