# Gonality, orthogonal images and the actual full-orbit endpoint

Version 2, 2026-09-08: combines the endpoint and orthogonal-complement
proofs, retaining their different simplicity hypotheses. The original
norm-zero and actual-square arguments were within the PASS audit by
/root/c14_elliptic_translation, 2026-09-04:
[structural audit metadata](audits/73_75_STRUCTURAL_REFINEMENTS_AUDIT.md).
The later [field-intersection FAIL](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md)
by the same auditor, 2026-09-04, rejected the presumed quadratic core,
NOT those arguments for a supplied square. Accordingly the old case-B
application below is explicitly conditional. The wider endpoint application
to the actual full-orbit square is AUTHOR prose; no new independent audit.

Let k be algebraically closed, char(k)≠2,r, r an odd prime, and
g(X)=s+1, g(Y)=rs+1, s≥1. Assume Y hyperelliptic with absolutely
simple Jacobian and an ACTUAL finite etale diamond

\[
 V\xrightarrow[\;M\;]{a}Y,\qquad
 V\xrightarrow[\;r\;]{p}C\xrightarrow[\;M\;]{c}X,\qquad
 p\text{ cyclic},\quad a\beta\ne a.
\]

The SAME smooth projective source retains both original legs. The
[norm theorem](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md)
gives h=p_*a^*≠0, finite kernel, and c_*h=0.
Write γ=gon(X). Simplicity of J(X) will be imposed ONLY where used.

## 1. Norm zero gives a pencil; an isogeny endpoint needs no simple J(X)

The following general lemma retains Lemma 73.1 over ANY algebraically
closed field, without the ambient characteristic restrictions. If q:R→D
is finite separable of degree m and b:R→X is finite, then

\[
 q_*b^*=0\Longrightarrow
       X\text{ has a degree-}m\text{ morphism to }\mathbf P^1,
       \quad\operatorname{gon}(X)\le m.                \tag{1}
\]

Indeed the Rosati-dual norm family d↦O_X(b_*q^*d) becomes constant
in Pic^m(X). The effective divisors move nontrivially because b is
surjective. They have no common base point: for fixed x the parameters
whose divisor contains x form the finite set q(b^(-1)(x)).
Two suitable sections of that basepoint-free system give the pencil.
No primality or etaleness of q, or simplicity of either Jacobian, is
needed. The degree-m map need not itself be separable; the gonality bound
still holds.

Now suppose an ACTUAL compatible lower square supplies a finite separable
q_0:C→D of degree m_0 and

\[
 h=q_0^*h_0,\qquad h_0:J(Y)\to J(D)\text{ an ISOGENY}.  \tag{2}
\]

Since c_*q_0^*h_0=0, cancellation of this isogeny in Hom^0 gives
c_*q_0^*=0, hence (q_0)_*c^*=0 by adjunction. Hom groups are
torsion-free, so this is exact vanishing. Formula (1) yields

\[
                         \gamma\le m_0.               \tag{3}
\]

This is the common proof of Theorems 73.2–73.3 for their actual squares.
It requires NO simplicity of J(X); even simplicity of J(Y) can be
replaced by the explicit isogeny hypothesis in (2).

## 2. Orthogonal-complement lemma and the near-endpoint bound

More generally suppose h=q_0^*h_0 with h_0 having finite kernel,
and put v=(q_0)_*c^*:J(X)→J(D). If v=0, (1) gives γ≤m_0.
Otherwise

\[
 v^\dagger h_0=c_*q_0^*h_0=c_*h=0,
 \qquad g(D)\ge g(Y)+\dim\operatorname{im}v.            \tag{4}
\]

The second inequality follows because these two abelian images are
orthogonal for the principal polarization and have finite intersection.
If J(X) is ALSO simple, nonzero v has finite kernel. Thus Lemma 75.1 is

\[
            m_0\ge\gamma\quad\text{or}\quad
            g(D)\ge g(Y)+g(X)=(r+1)s+2.                \tag{5}
\]

In any such square with g(D)≤Ns+1, this becomes

\[
                         m_0\ge\gamma
                         \quad\text{or}\quad N\ge r+2, \tag{6}
\]

since (N−r−1)s≥1 forces the integral N≥r+2.
The extra simple-J(X) hypothesis in (5)–(6) cannot be suppressed.
It may instead be replaced by the precise condition that the nonzero
map v under consideration has finite kernel.

## 3. The old A/B applications, with their exact scope

Let F=k(C), K=k(V), k(Y)=k(t,z), E=k(B)(t), where B is the
normalized norm-coefficient image. Write e=[F:k(B)] and d_coeff=2M/e.

In case A, z∈E, the [coefficient theorem](68_PRIME_RATIO_DIAMOND_AND_ALL_DEGREE_COEFFICIENT_SIEVE.md)
supplies the ACTUAL normalized square over B with lower degree m_0=e,
Y-leg degree N=M/e, and g(B)≤Ns+1. Thus, with both Jacobians simple,

\[
                    e\ge\gamma\quad\text{or}\quad N\ge r+2
                                                               \tag{7}
\]

(Theorem 75.2). At N=r, the same theorem gives g(B)=g(Y), so h_0
is an isogeny and (3) proves e≥γ WITHOUT simple J(X).

In case B, z∉E, put E'=E(z). The asserted quadratic lower square
exists under the EXTRA hypothesis

\[
                    [F\cap E':k(B)]=2.                \tag{8}
\]

Under (8), the quadratic lower curve D with function field F∩E' has
m_0=e/2=M/d_coeff and N=d_coeff.
The actual square gives h=q_0^*h_0≠0 and g(D)≤Ns+1, so

\[
                   m_0\ge\gamma\quad\text{or}\quad N\ge r+2
                                                               \tag{9}
\]

with simple J(X) (Theorem 75.3). At N=r, (3) gives m_0≥γ
without that additional simplicity assumption. These retain the original
endpoint and near-endpoint statements; an unconditional two-choice
divisor list is NOT asserted.

For r=3 and γ≥3, the pairs (m_0,N)=(2,3) or (2,4), at M=6 or 8,
are excluded by these results in case A or in an ACTUAL case-B square.
The (2,3) endpoint needs no simple J(X); the (2,4) conclusion uses it.
In particular the old nonhyperelliptic M=6, coefficient e=4 statement
is valid under (8). Its unconditional repair is below.

## 4. Replacement by the full orbit—every sign choice retained

The [audited full-orbit construction, Theorems 81.1–81.2](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md)
uses the FULL interpolation polynomial Q(t_i)=z_i. Its coefficient
field D and E_*=D(t) supply an ACTUAL normalized square with

\[
 q_0:C\to D,\quad E_*\to D,\quad E_*\to Y,\qquad
 \deg q_0=m,\quad\deg(E_*/D)=r,\quad\deg(E_*/Y)=N,
\]
\[
 m\mid M,\quad M=mN,\quad e=mj,\quad
 j=[D:k(B)]\le2^r,\quad d_{\rm coeff}=2N/j .
\]

The maps V→E_*→Y are etale, q_0 is separable, and

\[
 h=q_0^*h_D,\quad h_D\ne0,\quad
 rs+1\le g(D)\le Ns+1,\quad N\ge r.
\]

This D is NOT presumed quadratic over B; j=1 corresponds to case A,
and otherwise j is even, possibly greater than 2. With simple J(X),
(6) is exactly the audited full-orbit conclusion

\[
                          m\ge\gamma\quad\text{or}\quad N\ge r+2.
\]

The separate author endpoint corollary removes the simple-J(X) hypothesis
at N=r. Indeed, N=r forces g(D)=g(Y), so h_D is an isogeny and (3)
gives

\[
 N=r\Longrightarrow m=M/r\ge\gamma
               \qquad\text{WITHOUT simple }J(X).      \tag{10}
\]

Thus M<rγ excludes this endpoint for EVERY number of sign choices,
not merely a supplied quadratic core. It does not exclude arbitrary
defect-zero squares with N>r.

As a concrete repair, take r=3, M=6 and X nonhyperelliptic, so γ≥3.
The full orbit has m|6 and N=6/m≥3, hence m=1 or 2. The latter
has N=3 and is excluded by (10). Thus m=1. The
[audited short-degree sieve](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md#corollary824)
has M=6<2r+2=8 and gives j∈{1,2}; therefore e=mj∈{1,2}.
In particular coefficient degree 4 is impossible WITHOUT (8) or
simple J(X). This repairs the old endpoint application by an actual
full-orbit argument; it does not relabel the failed intersection claim.

These are all-degree constraints, not an all-degree exclusion.
Non-endpoint choices, e∈{1,2} and large complementary factors remain.
The original common-cover problem is unsolved.
