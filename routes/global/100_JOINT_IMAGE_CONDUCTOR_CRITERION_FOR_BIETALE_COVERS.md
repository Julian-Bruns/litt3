# Bi-etale joint images: conductor, collisions and adjunction

Version 2, 2026-09-08. Author proofs/self-checks from 2026-09-04 and
2026-09-05; independent audit pending. Consolidates the conductor criterion
and ordered-collision/normal-line proof. No common-cover exclusion or
global realization of the local counterexamples is claimed.
The ordered-collision proof is by /root/x_elliptic_quotient_maps.

Let X,Y be smooth projective connected curves over an algebraically closed
field k, with s_X=g(X)−1>0 and s_Y=g(Y)−1>0. Every common-cover assertion
retains BOTH actual finite etale maps from the SAME smooth projective source.
No Galois or characteristic-prime degree hypothesis is imposed.

## 1. The joint normalization retains both legs

Given actual finite etale maps f:W→X and g:W→Y, normalize their reduced
joint image C⊂X×Y. Its function field is the compositum of the two
specified subfields INSIDE k(W). Thus all extensions in
W→Z→X,Y are separable, and properness makes the maps finite. Different
transitivity gives

\[
 R_{W/X}=R_{W/Z}+\pi^*R_{Z/X}=0.
\]

Both terms are effective and therefore zero; the tower over Y gives
R_{Z/Y}=0 too. Consequently W→Z and BOTH maps Z→X,Y are finite etale.
We may require the joint map to be birational onto C without losing
any common cover. This is not a simultaneous Galois-closure assertion.

## 2. The exact conductor-different identities

More generally let C⊂S=X×Y be integral with finite generically separable
projections, ν:Z→C its normalization, and f:Z→X, g:Z→Y the induced maps.
Put d_X=deg f, d_Y=deg g and L=ν^*O_S(C). Write Δ for the conductor divisor:
the conductor ideal on Z is O_Z(−Δ). Since C is Cartier and Gorenstein,

\[
 \omega_Z=\nu^*\omega_C(-\Delta),\qquad
 \omega_C=(\omega_S\otimes O_S(C))|_C.                    \tag{1}
\]

The two components of the conormal derivative are intrinsic sections

\[
 s_X\in H^0(Z,L\otimes f^*\omega_X),\qquad
 s_Y\in H^0(Z,L\otimes g^*\omega_Y).
\]

They satisfy the CROSS-direction identities

\[
 \boxed{\operatorname{div}(s_X)=\Delta+R_g,\qquad
        \operatorname{div}(s_Y)=\Delta+R_f.}              \tag{2}
\]

Here R denotes the full different, not merely the sum of e−1.

Indeed, for a local equation F(x,y)=0, the dualizing generator is
η=dx/F_y=−dy/F_x. On a normalization branch with parameter t and conductor
exponent c, (1) gives ord_t(η)=−c, whence

\[
 \operatorname{ord}_t(F_y)=c+\operatorname{ord}_t(dx/dt),\quad
 \operatorname{ord}_t(F_x)=c+\operatorname{ord}_t(dy/dt).
\]

The differential orders are exactly the different exponents for separable
maps of smooth curves, including wild ramification. Equation changes by
units and coordinate changes give the stated line-bundle transformations.
For (1), finite duality identifies ν_*ω_Z with
Hom_C(ν_*O_Z,ω_C); because ω_C is invertible, the remaining Hom factor is
the conductor. See the general [Stacks duality background](https://stacks.math.columbia.edu/tag/0E31).

Thus BOTH maps are etale exactly when div(s_X)=div(s_Y)=Δ as DIVISORS
ON THE SAME Z. Equality only of abstract lengths would lose the condition.

## 3. Normal line and actual ordered collisions

Assume now both maps are etale and j=(f,g):Z→S is birational onto C.
The identifications df,dg give κ=(dg)^(−1)df:f^*ω_X→g^*ω_Y.
Differentiating F along Z gives
(1_L⊗κ)(s_X)+s_Y=0. In particular,

\[
 N_j=\operatorname{coker}(T_Z\to f^*T_X\oplus g^*T_Y)
       \simeq T_Z,\qquad L\simeq N_j(\Delta).             \tag{3}
\]

The first assertion follows by identifying both summands with T_Z and
taking the quotient by their diagonal. The second follows from (2).
Hence H^0(N_j)=0 and deg N_j=2−2g(Z)<0. This is a normal line of the
map, NOT a claim that j is a closed immersion or that C is smooth.

At P=(x_0,y_0), the completed branches are DISTINCT smooth graphs
y=φ_i(x), with φ_i'(0)≠0. There is no singular unibranch contribution.
Set m_ij=ord_x(φ_i−φ_j). The plane-curve product equation gives

\[
 \delta_P=\sum_{i<j}m_{ij},\qquad
 c_i=\sum_{j\ne i}m_{ij}.                                 \tag{4}
\]

For example F_y on branch i is ∏_{j≠i}(φ_i−φ_j), while
F_x=−φ_i'F_y, confirming both conductor exponents directly.
Writing δ(C)=p_a(C)−g(Z)=Σ_Pδ_P, one obtains

\[
 \deg\Delta=2\delta(C),\qquad
 C^2=2-2g(Z)+2\delta(C).                                  \tag{5}
\]

There is also an intrinsic ordered-pair description. The complement
R_X=(Z×_X Z)\setminus Δ_Z is a smooth projective, possibly disconnected
curve, finite etale over Z by either projection π_i. It can be empty.
No component is sent into Δ_Y by (gπ_1,gπ_2): otherwise two generic points
would have the same joint image, contradicting birationality. Therefore

\[
 E_X=(g\pi_1,g\pi_2)^*\Delta_Y,\qquad
 (\pi_1)_*E_X=\Delta,\qquad \deg E_X=2\delta(C).            \tag{6}
\]

The local multiplicity at the ordered pair (z_i,z_j) is precisely m_ij
in the common etale parameter x. Summing over j proves (6). Interchanging
X and Y gives the same conductor. This uses the actual two-leg diagram,
not independent point-pair or Jacobian data.

## 4. Self-intersection and the maximal-defect criterion

Let Φ=g_*f^*:J(X)→J(Y), with Rosati adjoint Φ†=f_*g^*. For ℓ≠char(k),
the product-surface intersection identity is

\[
 C^2=2d_Xd_Y-
       \operatorname{Tr}(\Phi\Phi^\dagger\mid V_\ell J(Y)).
                                                               \tag{7}
\]

The two fiber components contribute 2d_Xd_Y; the H^1⊗H^1 component
contributes minus the displayed trace. This also proves independence
of ℓ and integrality; see the full
[Rosati factorization proof, Section 1](../../Solutions/Sol_etale_rosati_factorization.md).
Combining (5) and (7) gives, for every actual bi-etale joint image,

\[
 \delta(C)=d_Xd_Y+g(Z)-1-\tfrac12
       \operatorname{Tr}(\Phi\Phi^\dagger).               \tag{8}
\]

Suppose Hom(J(X),J(Y))=0. With F_X={x}×Y, F_Y=X×{y},

\[
 C\equiv d_YF_X+d_XF_Y,\quad C^2=2d_Xd_Y,\quad
 p_a(C)=1+d_Xd_Y+s_Xd_X+s_Yd_Y.                           \tag{9}
\]

These formulas hold already for integral C with finite generically
separable projections. Riemann--Hurwitz then gives

\[
 \delta(C)\le d_Xd_Y+\min(s_Xd_X,s_Yd_Y).                  \tag{10}
\]

Consequently X,Y have an actual common finite etale cover IF AND ONLY IF
there are positive degrees and such an integral C satisfying

\[
 s_Xd_X=s_Yd_Y=:t,\qquad \delta(C)=d_Xd_Y+t.               \tag{11}
\]

For the forward direction use Section 1 and equality in both
Riemann--Hurwitz formulas. Conversely (9) and (11) give g(Z)−1=t,
so both effective different divisors have degree zero and vanish.
Thus the extremal singularity condition really preserves both etale legs.

For genera (9,25), under this Hom-zero hypothesis, N=d_Y gives

\[
 d_X=3N,\quad g(Z)=24N+1,\quad
 p_a(C)=3N^2+48N+1,\quad \delta(C)=3N^2+24N.              \tag{12}
\]

If J(Y) is simple and g(X)<g(Y), Hom-zero follows because any nonzero
homomorphism would surject onto J(Y), impossible by dimension. No
simplicity of J(X) is needed. This implication, not a new arithmetic
verification of a particular endpoint, is used here.

## 5. Counterexamples and the remaining boundary

The derivative ratios on two branches satisfy
φ_j'/φ_i'=1 at the closed point exactly when m_ij≥2, and

\[
 \operatorname{ord}(\phi_j'/\phi_i'-1)\ge m_{ij}-1,
\]

with equality if char(k) does not divide m_ij. The order can instead be
infinite when the contact order is divisible by the characteristic.
In characteristic five, the two graphs y=x and y=x+x^(5^a), a≥1, have
IDENTICAL slope one but contact 5^a, conductor 5^a on each branch and
δ=5^a. Their differential-ratio gluing order is one. This is a local
model, not a globally realized common cover. Counting nodes or derivative
ratios alone therefore cannot bound the conductor.

Nor can one replace the different by e−1: on the smooth branch
x=y^5+y^6, the x-projection has e=5 and different exponent 5 because
dx/dy=y^5; the y-projection is etale and the conductor is zero.

The negative normal line in (3) is compatible with positive C² because
the conductor contributes in (5). It does not constrain the global
Frobenius action on H^1(Z,N). For the two-leg map
α:J(X)^(1)×J(Y)^(1)→J(Z)^(1), (A,B)↦f^*A⊗g^*B, an everywhere-bad
restricted Raynaud locus would mean H^0(B_Z⊗α(A,B))≠0 for ALL pairs.
An ordinary Z has a good origin, but singularity rigidity proves no
such properness for a nonordinary Z. The precise local/global separation,
including prime-to-p labels, is in the
[conductor Frobenius proof](FROBENIUS_OF_THE_BIETALE_CONDUCTOR_QUOTIENT.md).

No unbounded-degree exclusion of (11), no generic theta properness and
no existence of compatible endpoint structures follows from this note.
