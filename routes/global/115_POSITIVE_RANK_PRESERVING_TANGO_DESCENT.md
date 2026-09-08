# Rank-preserving Tango descent and the exact norm defect

Version 2, 2026-09-08. The all-degree Tango theorem and Frobenius-root
proof retain their PASS audit, /root/x_elliptic_quotient_maps, 2026-09-05,
with no breaking objections. Its exact required input chain is included,
not every example in those inputs; the auditor had contributed unused
prime-degree group examples. [Audit record](audits/115_POSITIVE_RANK_PRESERVING_TANGO_DESCENT_AUDIT.md).
Original proof: /root; separate author verification:
/root/gluing_cohomology_rigidity. The merged symmetric norm-defect formula
and connected AFFINE counterexample retain AUTHOR/exact-arithmetic scope,
not that audit. No unrestricted projective-descent claim is made.

Let k be algebraically closed, and curves smooth projective connected
unless explicitly affine. Use the
[embedded maximal Tango and connection conventions](111_P_RANK_ONE_TANGO_DESCENT.md).
Write γ(C) for p-rank; p is odd for the all-degree Tango theorem.
Section 1's prime-to-p root lemma allows p=2 and common rank zero.

## 1. The reusable Frobenius-root descent lemma

For a line bundle M on C, let Root_C(M) consist of isomorphism classes
L on C^(1) with F_C^*L≅M; a choice of isomorphism is not part of the set.
For an actual finite etale f:D→X of degree n prime to p and
γ(D)=γ(X), pullback gives a bijection for EVERY line bundle M on X:

\[
 \operatorname{Root}_X(M)\xrightarrow{\sim}
                       \operatorname{Root}_D(f^*M).      \tag{1}
\]

Proof. Relative Frobenius is Cartesian under etale base change, so
for any upstairs root L_D and N=Nm_(f^(1))(L_D),

\[
 F_X^*N\simeq\operatorname{Nm}_f(F_D^*L_D)
       \simeq\operatorname{Nm}_f(f^*M)\simeq M^n.
\]

Choose u,v∈Z with un+vp=1. Then
L_0=N^u⊗(M^(1))^v satisfies F_X^*L_0≅M, since F_X^*M^(1)≅M^p.
Thus an upstairs root supplies one downstairs. Negative exponents
mean dual powers.

The geometric Verschiebung kernel
K_C=ker(F_C^*:J(C^(1))(k)→J(C)(k)) is killed by p and has p^γ(C)
elements. Pullback K_X→K_D is injective: its kernel is killed by n
using norm and by p, hence zero. Equal p-ranks make it an isomorphism.
The two nonempty root sets are torsors under these groups, and pullback
respects their actions; this proves both directions of (1).

Apply (1) to M=ω_X, using f^*ω_X=ω_D. The resulting root class also
descends the SPECIFIED EMBEDDED Tango line. Choose F_X^*L_X≅ω_X
and use adjunction. Its pulled-back adjoint differs from the prescribed
one by a global scalar, since H^0(O_D)=k. Thus the embedded images
agree. Subbundle local freeness and maximality descend by faithful
flatness; Cartier commutes with etale pullback, so lying in its kernel
descends too. Consequently

\[
 \operatorname{Tan}(X)\xrightarrow{\sim}\operatorname{Tan}(D)
 \quad\text{if }p\nmid n,\ \gamma(D)=\gamma(X),            \tag{2}
\]

including common rank zero. No Galois assumption occurs.

## 2. The audited all-degree positive-rank theorem

For EVERY actual finite etale f:D→X in odd characteristic satisfying
γ(D)=γ(X)>0, pullback induces the same bijection (2), with NO degree,
monodromy or Galois-closure-rank restriction.

If the common rank r≥2, the
[non-Galois amplification theorem, Section 4](112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md)
forces p∤deg f, so Section 1 applies. If r=1, its original direct
[rank-one factorization, Section 3](112_P_RANK_ONE_NONGALOIS_FACTORIZATION.md)
gives D→E→X, where D/E has prime-to-p degree and E/X is cyclic Galois
of p-power degree. All three ranks are one. Section 1 descends through
D→E. The [rank-one p-group theorem](111_P_RANK_ONE_TANGO_DESCENT.md#3-descent-through-an-etale-p-group)
then descends through E→X: its at-most-p−1 embedded structures are
fixed individually by the p-group, and inherit actual descent data.
Composing proves the theorem, without ever taking the Galois closure
of the prime-to-p remainder or supposing it rank-preserving.

In particular, if γ(X)>0 and Tan(X)=∅, acquisition of a Tango structure
by an etale cover D requires γ(D)>γ(X): p-rank cannot decrease since
norm/pullback makes J(X) an isogeny factor of J(D), and equality is
excluded above. The premise Tan(X)=∅ is automatic when p∤(g(X)−1).
The theorem is not extended to arbitrary degree at common rank zero.

## 3. Normalized norm and the precise trace-zero obstruction

For f:D→X finite etale of degree n prime to p, a regular connection
on ω_D=f^*ω_X has coefficient a in a local base frame dx. Define

\[
 m=n^{-1}\operatorname{Tr}_f(a).
\]

It transforms as a canonical connection: under dt=q du, each conjugate
has coefficient q a_t−q'/q, and normalized trace gives the same law.
Trace preserves regularity. Intrinsically take the determinant norm
connection on Nm_f(ω_D)=ω_X^n, subtracting the connection on det(f_*O_D);
division by n gives its unique connection root on ω_X. Neither splitting
over X nor prime-to-p Galois closure is required.

If the original connection is dormant, so is its normalized norm. For
a separating x, D_x^p=0, and in a separable splitting field the coefficients
a_i satisfy a_i^p+D_x^(p−1)a_i=0. Since n^(−1)∈F_p,

\[
 m^p+D_x^{p-1}m
       =n^{-1}\sum_i\bigl(a_i^p+D_x^{p-1}a_i\bigr)=0.     \tag{3}
\]

For projective curves let V_C be their F_p-space of regular Cartier-fixed
differentials. Cartier commutes with trace and pullback, giving the exact
direct sum

\[
 V_D=f^*V_X\oplus\ker(\operatorname{Tr}_f:V_D\to V_X),
 \qquad\dim\ker\operatorname{Tr}_f=\gamma(D)-\gamma(X).    \tag{4}
\]

The difference δ=∇_D−f^*∇_m is Cartier-fixed with trace zero. Equal
ranks make δ=0 and recover the actual connection/Tango descent of (2).
Base rank one alone does not kill this kernel if upstairs rank grew.
This is a second proof of the audited prime-to-p mechanism, not an
argument that averaging by itself preserves the nonlinear Tango equation.

In characteristic five write
P_4(a)=a^4−a²a'+3(a')²+4aa''−a''' and use normalized trace brackets.
Put b_i=a_i−m, μ_j=〈b^j〉 and σ=〈(b')²〉. If every P_4(a_i)=0, then
the retained AUTHOR defect formula is

\[
 \boxed{P_4(m)=(m'-m^2)\mu_2+m\mu_2'+m\mu_3
             +2\mu_3'+3\mu_2''+\sigma-\mu_4.}            \tag{5}
\]

For verification, expand before eliminating mixed moments:

\[
\begin{aligned}
 \langle P_4(a)\rangle-P_4(m)
   ={}&(m^2-m')\mu_2+4m\mu_3+\mu_4
          -2m\langle bb'\rangle-\langle b^2b'\rangle\\
     &+3\sigma+4\langle bb''\rangle .
\end{aligned}
\]

Substitute μ_2'=2〈bb'〉, μ_3'=3〈b²b'〉 and
μ_2''=2σ+2〈bb''〉 to obtain (5). The combined expression has weight
four, although individual derivative moments need not be tensorial.
Trace zero of b does not kill its quadratic or quartic moments.

## 4. A connected affine etale counterexample, not a projective one

In characteristic five set N=x²+x+1 and

\[
 X_{\rm aff}=\operatorname{Spec}k[x,1/(xN)],\qquad
 D_{\rm aff}=X_{\rm aff}\times_{\mathbf A^1_x}\mathbf A^1_z,
 \qquad x=z^2.
\]

The map is finite etale of degree two: z and 2z are units. The source
is a localization of k[z], hence connected, with involution z↦−z.
The function u=1+z+z² is a unit since
u(z)u(−z)=N. The nowhere-zero differential

\[
 \xi=u\,dx=(2z+2z^2+2z^3)\,dz=d(z^2+4z^3+3z^4)
\]

is exact. Declaring ξ horizontal gives ONE regular dormant Tango
connection upstairs; both conjugate coefficients satisfy P_4=0.
They are not arbitrary choices on disconnected sheets. Its normalized
norm coefficient and a horizontal differential downstairs are

\[
 m=-\tfrac12N'/N=2N'/N,\qquad N^3dx.
\]

But N³=x^6+3x^5+x^4+2x^3+x²+3x+1, so

\[
 \operatorname{Car}(N^3dx)=dx\ne0,\qquad
                    P_4(m)=4/N^3\ne0.                  \tag{6}
\]

Fourth differentiation of N³ or substitution into P_4 proves the latter
identity; direct symbolic replay passed 2026-09-08. Thus even a
connected AFFINE etale double with a nowhere-zero exact horizontal
differential need not have Tango normalized norm. The projective
compactification is RAMIFIED and the connections need not extend
regularly at the omitted points. This does not refute (2), or supply a
projective rank-one counterexample to unrestricted descent.

## 5. Fixed-pair scope

The [optional rank-one genus-nine curve](P_RANK_ONE_GENUS9_ALTERNATIVE_SOURCE.md)
has no Tango structure, and neither does any rank-preserving etale cover
of it, of arbitrary degree. It is not the fixed X. In the unchanged
genus-(9,25) pair, γ(X)=6 and γ(Y)=25, so a common etale Z has rank
at least25 and its X-leg is NOT rank-preserving. Both endpoint
genus-minus-one values 8,24 are prime to5, so neither endpoint has
a maximal Tango structure to pull back directly.

The theorem needs actual rank preservation. A new common-cover obstruction
would have to control rank growth while retaining BOTH actual finite
etale maps from the SAME smooth projective source; neither (5) nor the
affine counterexample supplies that control.
