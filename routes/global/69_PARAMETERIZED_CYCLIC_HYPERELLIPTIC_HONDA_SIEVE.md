# Cyclic-hyperelliptic Honda and full-order correspondence sieve

Version 2, 2026-09-08. The original claims were audited PASS by
/root/genus2_counterexample_variant, 2026-09-04, with no breaking objection:
[audit metadata](audits/69_72_PARAMETERIZED_HONDA_AND_DEGREE19_AUDIT.md).
This replaces the stale “audit pending” header. The common arguments
are shortened; the wider multiplicity corollary in Section 2 is explicitly
AUTHOR-ONLY. No new independent whole-note audit is claimed.

Work over k=Fbar_p, p odd. The arithmetic screen concerns
Y_ell:z²=1−t^ell for an odd PRIME ell≠p, with h=(ell−1)/2 and
J=Jac(Y_ell). Composite exponents require factor-by-factor arguments;
no screen here discards their old factors. The geometric statements
always retain BOTH actual finite etale maps from the SAME source.

## 1. Proposition 69.1: finite Honda screen and absolute simplicity

Put G=(Z/ell)^×, H=〈p〉, f=|H|=ord_ell(p), K=Q(ζ_ell),
E=K^H, and Φ={1,…,h}. For aH∈G/H let m(aH)=|aH∩Φ|.
Assume

\[
 \operatorname{Stab}_{G/H}(m)=1,\qquad
 \operatorname{lcm}_{aH}\frac{f}{\gcd(f,m(aH))}=f,       \tag{1}
\]

where a zero coset count contributes denominator 1. Then J is absolutely
simple, its geometric D=End^0_k(J) is a central division algebra of
degree f over E, and K is a maximal subfield. Covariant p-Frobenius F
satisfies

\[
 FxF^{-1}=\sigma(x),\quad\sigma(\zeta_\ell)=\zeta_\ell^p,
 \quad F^f=\pi\in E,\quad
 D=\bigoplus_{s=0}^{f-1}KF^s.                           \tag{2}
\]

Proof. The rotation embeds K in End^0(J); its differential eigencharacters
on t^(i−1)dt/z give CM type Φ. The Shimura–Taniyama slope formula gives
m(aH)/f. The prime-to-p rational Tate module is rank one over K, so
the centralizer of K is K. Hence F^f∈K, and commutation with F gives π∈E.

The prime p splits completely in E and is unramified of residue degree f
in K/E. The local Honda invariants are m(aH)/f modulo 1; the second
condition in (1) gives Schur index f. If an automorphism of E/Q fixed
π^N, it would preserve the valuation vector N m(aH), so the first
condition forces it to be trivial. Thus Q(π^N)=E for EVERY N≥1.
The simple Honda factor has dimension [E:Q]f/2=h and accounts for all J.
Normalized local invariants stay unchanged under finite constant
extension, so this factor remains simple over every such extension.
This proves absolute simplicity, degree f, and the decomposition (2).

Both tests in (1) are finite coset arithmetic. The stronger condition

\[
 \gcd(m(aH),f)=1\quad\text{whenever }0<m(aH)<f            \tag{3}
\]

will be needed at p in Section 4. It is automatic for prime f, and
implies the second condition in (1) if an intermediate count occurs.

## 2. Prime-ratio diamonds and primitive multiplicity

Let X have genus g≥2, let Y be hyperelliptic of genus h≥2, and let
r≠p be an odd prime, with h−1=r(g−1). An ACTUAL common finite etale
cover gives, by the [one-leg Sylow construction](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md#1-the-prime-ratio-diamond-theorem-681),

\[
 V\xrightarrow[\;M\;]{a}Y,\quad
 V\xrightarrow[\;r\;]{q}C\xrightarrow[\;M\;]{c}X,\quad
 q\text{ a }C_r\text{-torsor},\quad a\beta\ne a.         \tag{4}
\]

The [norm argument](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md#2-norm-obstruction-lemma-682-theorem-683-corollary-684)
gives η=q_*a^*≠0: otherwise the moving degree-r norm divisors yield a
basepoint-free degree-r pencil on Y. The odd r-pencil and the hyperelliptic
pencil would generate k(Y), forcing h≤r−1 by Castelnuovo–Severi.
If J(Y) is ALSO absolutely simple, then c_*η=0 by the genus inequality,
and dim im η=h≤(M−1)(g−1), so M≥r+2. The simplicity hypothesis
belongs to this dimension bound, not to norm nonvanishing.

For Y=Y_ell satisfying (1), the design equation is
ell=2r(g−1)+3. Assume r≠ell, and put

\[
                         m_0=\frac{r-1}{\gcd(r-1,f)}.  \tag{5}
\]

Theorem 69.4 in its ORIGINAL AUDITED scope assumes f<r−1:
the cyclic J-isotypic span of a^*J in J(V) has exactly one invariant
copy, and its primitive multiplicity m is a POSITIVE multiple of m_0.
Consequently

\[
                        m_0h\le(r-1)M(g-1).            \tag{6}
\]

AUTHOR-ONLY wider corollary: the SAME conclusion holds without f<r−1.
The following shorter proof covers both scopes. In the right D-space
Hom^0(J,J(V)), let e=a^* and T=β^*. If the primitive part of its
cyclic span were zero, then Te=e. Equality of Jacobian pullbacks for
maps to a genus≥2 curve implies equality of the maps, contradicting (4).
For completeness, Abel–Jacobi shows two such maps differ by a fixed
translation preserving the Abel–Jacobi curve; that translation induces
an automorphism acting trivially on its Jacobian. Faithfulness of
Aut(Y)→Aut(J(Y),λ_Y) makes it trivial (the original Lemma 69.3).

Since E⊂Q(ζ_ell) and r≠ell, Φ_r is irreducible over E. The primitive
action therefore embeds E(ζ_r) in M_m(D). A separable field embedded
in a central simple algebra has degree dividing its degree, so r−1|fm,
giving (5). The invariant projector sends every cyclic generator to
the SAME D-line, nonzero because q^*η≠0, so the invariant multiplicity
is exactly one. The primitive part lies in Prym(V/C), of dimension
(r−1)M(g−1), proving (6). The original f<r−1 theorem is retained
as an audited special case, not deleted in favor of this extension.

The cyclic span has at most r generators over D, so also m≤r−1.
Thus the possible primitive multiplicities are m_0,2m_0,…,r−1.
In particular gcd(f,r−1)=1 forces EXACTLY r−1 primitive copies
for EVERY M. This sharper stated corollary is author-only; it retains
the original audited endpoint specializations.

## 3. Uniform Rosati, conductor and actual image formulas

For the diagram (4), put e=a^*, T=β^*, N=1+T+⋯+T^(r−1)=q^*q_*,
s=η^†η=e^†Ne, and E_j=(a,aβ^j)^*Δ_Y, I_j=deg E_j for j≠0.
With canonical Rosati adjoints,

\[
 e^\dagger e=M,\quad N^\dagger=N,\quad N^2=rN,\quad
 \operatorname{Tr}s=2M(h+r-1)-\sum_{j=1}^{r-1}I_j,\quad
 I_j=I_{r-j}.                                         \tag{7}
\]

If J(Y) is simple, also 0<s<rM in the positive cone (Proposition 69.7).
Indeed N/r is an orthogonal projector; s≠0 by the norm argument.
Equality at the upper endpoint gives Te=e, forbidden by map rigidity.
A nonzero semipositive endomorphism of a simple abelian variety is
positive definite. For the trace formula, j=0 contributes 2hM and each
j≠0 contributes 2M−I_j by Lefschetz; the source substitution by β^j
gives I_j=I_(r−j), including multiplicities. The identities in (7)
do not themselves require simplicity.

The joint map (q,a) is birational onto its reduced image D: its generic
degree divides r, and degree r would make a factor through q.
Thus the ORIGINAL etale maps normalize D. Its class has fiber part
of bidegree(r,M) and correspondence square −Tr s, giving

\[
 D^2=\sum_jI_j-2M(h-1),\quad
 \mathfrak C_D=\sum_jE_j,\quad
 \delta(D)=\tfrac12\sum_jI_j,\quad
 p_a(D)=M(h-1)+1+\tfrac12\sum_jI_j.                     \tag{8}
\]

This is Proposition 69.8. Etale-locally on C, D is a union of smooth
graph branches. On each branch the conductor exponent is the sum
of its contacts with all others; summing over branches counts each
unordered contact twice. This proves the divisor, not merely a degree
bound; the last identity subtracts g(V)=M(h−1)+1.

For a reduced cross image Γ_j of generic degree e_j, its normalization
and the intermediate maps are finite etale, e_j|M, and both projection
degrees are d_j=M/e_j. If w_j is its action, adjunction gives

\[
 \delta(\Gamma_j)=d_j^2+(h-1)d_j-\tfrac12\langle w_j,w_j\rangle,
 \quad \langle w_j,w_j\rangle\le2d_j(d_j+h-1).           \tag{9}
\]

Its self-intersection is 2d_j²−〈w_j,w_j〉; subtracting the actual
normalization genus d_j(h−1)+1 from the adjunction genus proves (9).
This is Proposition 69.9, including NONBIRATIONAL original cross maps.

If d_j≤h is odd, w_j≠0. Here is the low-degree argument in arbitrary
odd characteristic, as needed in this parameterized statement. Zero
action gives O(Γ_j)=A⊠B with basepoint-free factors of degree d_j.
A basepoint-free pencil of degree d≤h on hyperelliptic Y factors
through its double pencil: extract its pth-power inseparability first;
otherwise Castelnuovo–Severi for the remaining separable pencil gives
h≤d−1. Its line bundle is therefore a power of the hyperelliptic
degree-two line, so d must be even, a contradiction.

## 4. Proposition 69.10: full-order coefficient ideals and Rosati minima

Return to Y_ell satisfying (1); assume f≥2 AND the local coprimality
condition (3). For each prime P of K over p let m_P=v_P(π), the
coset counts above. Put λ=1−ζ_ell and

\[
 \mathfrak D_{K/E}=(\lambda^{f-1}),\qquad
 \mathcal I_s=\mathfrak D_{K/E}^{-1}
   \prod_{P\mid p}P^{-\lfloor s m_P/f\rfloor},
                \quad0\le s<f.                        \tag{10}
\]

EVERY v=∑_s x_sF^s in the FULL geometric End(J), not merely a
coefficientwise crossed order, satisfies

\[
 x_s\in\mathcal I_s,\qquad
 \langle v,v\rangle
    =\sum_{s=0}^{f-1}p^s\operatorname{Tr}_{K/\mathbf Q}(x_s\bar x_s).
                                                               \tag{11}
\]

Proof away from p. A prime-to-p Tate lattice is rank one over the local
O_K. In a trivialization, F is a semilinear automorphism with unit
coefficient. If A=∑_s a_sσ^s preserves this lattice, then for every
integral u the matrix trace of uAσ^(−s) is Tr_(K/E)(u a_s).
Its integrality puts a_s in the inverse relative different. This works
in the FULL matrix order at the ramified prime ell; coefficientwise
integrality is not assumed there.

At p, if 0<m_P<f, condition (3) makes the local Honda algebra a
division algebra of degree f. The summands have distinct fractional
valuations v_P(x_s)+s m_P/f, so they cannot cancel. Integrality gives
v_P(x_s)≥−floor(s m_P/f). At m_P=0, the etale height-f factor has a
Tate lattice free of rank one over the unramified O_(K,P); the same
trace argument gives v_P(x_s)≥0. At m_P=f, use conjugation to its
m=0 prime, ππ̄=p^f, and integrality of the adjoint. For 1≤s<f,

\[
 (x_sF^s)^\dagger
   =p^s\pi^{-1}\sigma^{f-s}(\bar x_s)F^{f-s}.           \tag{12}
\]

The m=0 bound applied there gives v_P(x_s)≥−s; the s=0 term is simply
conjugated. These are precisely the remaining bounds in (10).
Finally F^†F=p, vanishing reduced trace on nontrivial graded summands
and ordinary field trace on K prove their orthogonality and (11).

Define positive-definite ideal-lattice minima

\[
 \mu_s=\min_{0\ne x\in\mathcal I_s}
      p^s\operatorname{Tr}_{K/\mathbf Q}(x\bar x),\quad
 \mu=\min_{1\le s<f}\mu_s .                             \tag{13}
\]

Their ranks are ell−1. Adjunction gives the weighted-lattice ISOMETRY

\[
 \mathcal I_s\xrightarrow{\sim}\mathcal I_{f-s},\quad
 x\longmapsto p^s\pi^{-1}\sigma^{f-s}(\bar x),           \tag{14}
\]

so μ_s=μ_(f−s) and only floor(f/2) lattices need enumeration.
Indeed m_(bar P)=f−m_P gives exactly the floor exponents in (10)
on both sides; ππ̄=p^f gives norm preservation. This retains the
adjoint-symmetry reduction, not an unweighted identification of ideals.

## 5. Finite-difference elimination and the exact exclusion test

Let Γ⊂Y_ell² be REDUCED IRREDUCIBLE effective of bidegree(d,d),
d≥2, with BOTH normalization projections etale, and action v.
If

\[
                    4d+1<\left\lceil\frac{\ell}{f-1}\right\rceil,
                                                               \tag{15}
\]

then its K-component is zero (Proposition 69.11).

Proof. The rotation and hyperelliptic-companion graphs have degree-one
projections and share no component with Γ. Their intersections give
integer traces t_b=〈v,ρ^b〉 in[−2d,2d]. If x is the K-component
of v^†, coefficient extraction gives x∈λ^(1−f)O_K and
t_b=Tr_(K/Q)(xζ_ell^b). Taking f forward differences introduces
(ζ_ell−1)^f. Its product with x lies in λO_K, whose absolute trace
lies in ell Z. Thus Δ^f t_b=0 mod ell; the resulting function on
F_ell is a polynomial of degree≤f−1. A nonconstant one has at least
ceil(ell/(f−1)) values, whereas the trace interval supplies at most 4d+1.
It is constant. Inequality (15) also gives 4d<ell, so reduction is
injective on the interval. The integer traces are equal and sum to
zero by ∑_bρ^b=0. Nondegeneracy of the cyclotomic trace frame gives x=0.

Theorem 69.12: under (1), f≥2 and (3), there is NO such correspondence
when d is odd and

\[
 2\le d\le h,\qquad
 4d+1<\left\lceil\frac{\ell}{f-1}\right\rceil,\qquad
 \mu>2d(d+h-1).                                        \tag{16}
\]

Indeed Section 3 gives v≠0, (15) kills its K-component, and (11)–(13)
force norm≥μ, contradicting the actual surface bound (9).
This also excludes every normalized cross degree d_j satisfying (16).
It excludes neither arbitrary d nor a whole common-cover diagram.

For the OLD numerical choice (p,ell,r,g)=(5,31,7,3), the coset counts
are 0,0,1,1,1,2,2,2,3,3; f=3 and m_0=2. The norm bound gives M≥9.
For d=3, (15) is 13<16, while the
[exact global lattice certificate](67_CUBIC_CROSS_ROSATI_GAP.md)
gives μ=106>102=2·3(3+14). Thus the special cubic exclusion is an
instance of the general test. The [degree-19 example](71_SCALAR_COMPRESSION_AT_THE_FIRST_DIAMOND_DEGREE.md#4-audited-degree-19-specialization-and-full-span-obstruction)
has a different cyclic exponent and retains lower-span and higher-degree
cases. These historical tests are not a pivot from the active fixed pair.
