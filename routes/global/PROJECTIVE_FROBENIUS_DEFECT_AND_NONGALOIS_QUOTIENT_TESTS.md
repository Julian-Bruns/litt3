# Projective Frobenius defect and non-Galois quotient tests

**Status:** author proof, 2026-09-05. Author: `/root`.
The Cartan--Leray, projectivity, and modular multiplicity arguments were
separately checked in discussion by `/root/canonical_trace_algebra`;
a separate audit record is not yet attached.
**Prior-art verdict, 2026-09-05:** projectivity is a classical consequence
of [Köck, Corollary 2.3](https://arxiv.org/pdf/math/0207124) (logarithmic
cohomology projectivity and the zero residues of nilpotent forms), and also
of [Borne, Lemmas 2.1 and 2.11](https://arxiv.org/pdf/math/0204088).
The relevant proofs were checked by `/root/gluing_cohomology_rigidity`
and read by `/root`. The arbitrary-subgroup formula below is a deduction
and application; no claim of novelty for the general projectivity result.

This theorem keeps one actual finite etale Galois cover and all of its
actual intermediate curves. The group order may be divisible by the
characteristic. No common orbifold or simultaneous Galois closure of two
unrelated maps is assumed.

## 1. The module and the exact formula

Let `k` be algebraically closed of characteristic `p>0`, and let

\[
                      W\longrightarrow Y
\]

be a connected finite etale Galois cover of smooth projective curves,
with finite group `G`. Write `F` for absolute Frobenius on coherent
cohomology, and set

\[
 V=H^1(W,\mathcal O_W),\qquad
 \mathcal N=V_{\rm nil}=\bigcup_{r\ge0}\ker F^r.
\]

For a smooth projective curve `C`, put

\[
                  \Delta(C)=g(C)-f_C,
\]

where `f_C` is its `p`-rank. Thus
`Delta(C)=dim H^1(C,O_C)_nil`, and `C` is ordinary exactly when
`Delta(C)=0`.

### Theorem 1

The `kG`-module `N` is projective. For every subgroup `H<=G`, pullback
induces a natural isomorphism

\[
 H^1(W/H,\mathcal O_{W/H})_{\rm nil}
                    \xrightarrow{\sim}\mathcal N^H.       \tag{1}
\]

Let `S` run through the simple `kG`-modules, and let `P(S)` be the
indecomposable projective cover of `S`. Write uniquely

\[
                     \mathcal N\simeq\bigoplus_S P(S)^{m_S}.
\]

Then the exact non-Galois formula is

\[
 \boxed{\displaystyle
       \Delta(W/H)=\sum_S m_S\,[k[G/H]:S].}               \tag{2}
\]

Here the brackets mean Jordan--Hölder multiplicity, not multiplicity
as a direct summand. In particular

\[
                           m_k=\Delta(Y).                \tag{3}
\]

### Proof of (1) and projectivity

Fix any subgroup `H`. The action on `W` is free, so `W -> W/H` is an
etale torsor, even if `p` divides `|H|`. Coherent Cartan--Leray gives
the Frobenius-compatible spectral sequence

\[
 E_2^{a,b}=H^a\bigl(H,H^b(W,\mathcal O_W)\bigr)
             \Longrightarrow H^{a+b}(W/H,\mathcal O_{W/H}).
                                                               \tag{4}
\]

There are only the rows `b=0,1`, and `H^0(W,O_W)=k` with trivial
`H`-action. Since the quotient is a curve, its coherent cohomology
vanishes in degrees at least two. Thus (4) gives an exact sequence

\[
 0\longrightarrow H^1(H,k)
 \longrightarrow H^1(W/H,\mathcal O)
 \longrightarrow V^H
 \xrightarrow{d_2} H^2(H,k)\longrightarrow0,              \tag{5}
\]

and, for every `a>=1`, an isomorphism

\[
       d_2:H^a(H,V)\xrightarrow{\sim}H^{a+2}(H,k).        \tag{6}
\]

Indeed, the kernel and cokernel of this `d_2` are exactly the two
potential surviving terms in total degree at least two. There are no
other rows or differentials that could remove them.

For every `a`, coefficientwise Frobenius on `H^a(H,k)` is bijective:

\[
              H^a(H,k)=H^a(H,\mathbf F_p)
                              \otimes_{\mathbf F_p}k.
                                                               \tag{7}
\]

We use the elementary Fitting decomposition for finite-dimensional
vector spaces with a Frobenius-semilinear endomorphism over a perfect
field: there is a functorial direct sum of its nilpotent part and its
bijective part. Taking either part is exact. One way to see exactness
on nilpotent parts is to lift a nilpotent vector in a quotient, then
subtract the unique inverse-Frobenius correction in the bijective part
of the kernel; a sufficiently high iterate kills the corrected lift.

Apply this to (5). Its two group-cohomology terms have zero nilpotent
part by (7), and `(V^H)_nil=N^H`. This proves (1).

Write `V=N direct_sum V_bij`. The decomposition is `H`-stable and
commutes with group cohomology. The induced Frobenius on
`H^a(H,N)` is nilpotent, while on `H^a(H,V_bij)` it is bijective.
By (6)--(7), `H^a(H,V)` has bijective Frobenius. Consequently

\[
                     H^a(H,\mathcal N)=0\quad(a\ge1)    \tag{8}
\]

for every subgroup `H<=G`.

Let `P` be a Sylow `p`-subgroup of `G`. Equation (8) gives
`Ext^1_{kP}(k,N)=0`. The trivial module is the only simple `kP`-module.
Induction on a composition series, using the long exact Ext sequence,
therefore gives `Ext^1_{kP}(M,N)=0` for every finite-dimensional
`kP`-module `M`. Thus `N` restricted to `P` is injective. A finite
group algebra is self-injective, so this restriction is also projective
(and is free over the local algebra `kP`). Projectivity on a Sylow
subgroup implies projectivity over `kG`: induce the restriction, and
split the usual induction--restriction counit by averaging over the
`[G:P]` cosets, an integer invertible in `k`.

This proves projectivity of `N`.

### Proof of the modular multiplicity formula

The algebra `kG` is symmetric. Consequently the socle of `P(S)` is
isomorphic to `S`, with multiplicity one, and `P(S)` is injective.
Since `k` is algebraically closed,

\[
 \dim_k\operatorname{Hom}_{kG}(T,P(S))
                         =\begin{cases}1&T\simeq S,\\0&T\not\simeq S
                           \end{cases}
\]

for simple `T`. Exactness of `Hom_{kG}(-,P(S))`, applied to a
composition series, yields

\[
                 \dim\operatorname{Hom}_{kG}(M,P(S))=[M:S]
                                                               \tag{9}
\]

for every finite-dimensional `M`. Frobenius reciprocity gives

\[
 \dim P(S)^H
 =\dim\operatorname{Hom}_{kG}(k[G/H],P(S))
 =[k[G/H]:S].                                             \tag{10}
\]

Now take dimensions in (1), use the projective decomposition of `N`,
and apply (10). This gives (2). For `H=G`, the permutation module is
the simple trivial module, proving (3). \(\square\)

## 2. Comparison tests on the same cover

### Corollary 2

Let `H,K_1,...,K_s` be subgroups of `G`. Suppose every simple
composition factor of `k[G/H]` occurs in at least one `k[G/K_j]`.
If every actual curve `W/K_j` is ordinary, then `W/H` is ordinary.

More quantitatively, if an integer `r>=1` satisfies

\[
 [k[G/H]:S]\le r\sum_j[k[G/K_j]:S]\qquad\hbox{for every simple }S,
\]

then

\[
                    \Delta(W/H)\le r\sum_j\Delta(W/K_j).
                                                               \tag{11}
\]

Both assertions follow immediately from (2), since every `m_S` is
nonnegative. No normality or comparability of these subgroups is
required. In particular, the Galois cover `W` itself need not be
ordinary for the comparison to force an intermediate curve ordinary.

If `G` is a `p`-group, there is only the trivial simple module and its
projective cover is `kG`. Formula (2) specializes to

\[
                   \Delta(W/H)=[G:H]\Delta(Y).           \tag{12}
\]

Together with etale Riemann--Hurwitz, this recovers the
Deuring--Shafarevich formula for the `p`-group cover `W -> Y`.

## 3. The actual common-cover obstruction

Suppose `Z` has actual finite etale maps to curves `X,Y`, and let
`W -> Y` be the Galois closure of the specified map `Z -> Y`.
Then `Z=W/H` for a subgroup `H` of its group `G`, and the composite
`W -> Z -> X` is still finite etale. This construction does not make
the map to `X` Galois and does not assume a core.

If `X` is nonordinary, then `Z` is nonordinary. For example, a nonzero
Cartier-killed holomorphic differential on `X` pulls back to a nonzero
one on `Z`; differential pullback is injective under a separable map.
More quantitatively,

\[
                           \Delta(Z)\ge\Delta(X).        \tag{13}
\]

To verify (13) in possibly `p`-divisible degree, take a Galois closure
of `Z -> X`. Formula (1) shows that pullback from `X` is injective on
Frobenius-nilpotent coherent cohomology after this closure, and hence
already injective on that part in `H^1(Z,O_Z)`.

Thus any collection of the actual intermediate curves `W/K_j` satisfying
the support condition in Corollary 2 and known to be ordinary excludes
this common cover. In numerical form (11)--(13) require

\[
                    \Delta(X)\le r\sum_j\Delta(W/K_j).   \tag{14}
\]

The unresolved geometric input is precisely which of those intermediate
curves one can prove ordinary or bound in defect. The module calculation
does not supply such curves, does not assert that all representations
are controlled by one-dimensional characters, and does not turn a
coreless correspondence into a common finite orbifold.

## Why etaleness matters

The free action gives both the torsor spectral sequence (4) and a smooth
projective quotient with coherent cohomology concentrated in degrees zero
and one. These ingredients justify projectivity and all intermediate
identifications. They may not be imported unchanged into a ramified
group action. Every comparison above takes place among quotients of one
specified cover `W`; numerical profiles on unrelated curves do not
satisfy the hypotheses.
