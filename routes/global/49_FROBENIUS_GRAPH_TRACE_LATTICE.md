# Frobenius trace frames and the exact ramified endomorphism order

Version 2, 2026-09-08: combines the two independently audited proofs
and removes their obsolete unresolved-order plan. Evidence is separate:

- Graph tests, reconstruction and conditional coefficient conclusions:
  PASS, /root/frobenius_trace_lattice_audit, 2026-09-04;
  [record](audits/49_FROBENIUS_TRACE_LATTICE_AUDIT.md).
  The two nonbreaking presentation issues—companion-graph components and
  a dangling conjunction—are corrected below.
- Exact completed order and divided-ramification counterexample:
  PASS, /root/audit_exact_31adic_order, 2026-09-04;
  [record](audits/54_EXACT_31_ADIC_ENDOMORPHISM_ORDER_AUDIT.md).

No new whole-note audit is claimed. This is the OLD genus-three/genus-fifteen
auxiliary pair, not the current fixed pair. The later global lattice bound
is in [the cubic Rosati-gap proof](67_CUBIC_CROSS_ROSATI_GAP.md), with its
own author/certificate evidence. The 31-adic order is known; coefficientwise
integrality is false as an ambient-order assertion. The cubic gap recorded
in the original note has since been closed by that separate proof.

Let k=Fbar_5, Y:z²=1−t³¹, J=Jac(Y), K=Q(ζ_31),
E=K^〈5〉, and D=End^0_k(J). The
[Honda calculation](40_JACOBIAN_NORM_OBSTRUCTION_FOR_THE_SEVEN_DIAMOND.md)
gives absolute simplicity, D a degree-three division algebra over E,
and K a maximal subfield. Let F be covariant Frobenius of the F_5-model
and ρ the action of t↦ζ_31t, so

\[
 F xF^{-1}=\sigma(x),\quad\sigma(\zeta_{31})=\zeta_{31}^5,
 \quad F^\dagger F=5,\quad F^3=\pi\in E,\quad
 D=K\oplus KF\oplus KF^2.                               \tag{1}
\]

We use the Rosati trace pairing 〈x,y〉=Tr(x^†y|H¹(J,Q_ell)),
ell≠5. It is positive definite on D, rational, and integral on End(J).
Changing graph orientation replaces F by F^† and permutes the two
nontrivial graded summands.

For the diamond-specific assertions, retain ACTUAL finite etale maps
V→Y and V→C→X from the SAME source, with degrees 9,7,9, the middle
degree-seven map cyclic with generator β, and aβ≠a. Put

\[
 u_j=a_*\beta^{j*}a^*,\quad j=1,\ldots,6,\qquad
 u_0=9,\quad u_{7-j}=u_j^\dagger .
\]

Here Aut(Y)=C_31×C_2, as proved in the
[automorphism calculation](20_AUTOMORPHISMS_OF_THE_CYCLIC_ATLAS.md).

## 1. Ninety-three exact graph tests, without image birationality

Put q_(s,b)=F^sρ^b for 0≤s≤2 and b∈Z/31. Their graphs have
projection degrees (5^s,1); composition with the hyperelliptic involution
represents −q_(s,b). Every actual u_j satisfies

\[
 |t_{s,b}(u_j)|\le9(1+5^s),\qquad
 t_{s,b}(x):=\langle x,q_{s,b}\rangle ,
 \quad\text{bounds }18,54,234.                          \tag{2}
\]

Proof (Proposition 49.1). If Γ_j is the reduced cross image of generic
degree e_j, use the EFFECTIVE PUSHFORWARD CYCLE Z_j=e_jΓ_j, of
bidegree(9,9) and action u_j. Its graph intersection is

\[
 Z_j\cdot\operatorname{Graph}(q_{s,b})
       =9(1+5^s)-t_{s,b}(u_j).
\]

There is no common component, for either direct or hyperelliptic-companion
graph. For s>0 its unequal normalized degrees preclude the equal degrees
of Γ_j. For s=0 equality would say aβ^j=τa; iteration gives τ^7=1
in Aut(Y), hence τ=1, contradicting aβ^j≠a. Both effective intersections
are nonnegative; the companion changes the trace sign and gives (2).

Transpose graphs satisfy the same bounds. In isolation their families
lie, up to rotation indices, in (5/π)KF² and (25/π)KF, respectively.
For the actual six-tuple they add no new inequality, since

\[
 \langle u_j,q_{s,b}^\dagger\rangle
                    =\langle u_{7-j},q_{s,b}\rangle.   \tag{3}
\]

This follows from u_(7−j)=u_j^†, cyclicity of trace and invariance
under adjunction.

## 2. Tight frames, reconstruction and the finite trace box

The three graded summands in (1) are mutually orthogonal, and

\[
 \langle q_{s,b},q_{s,c}\rangle
       =5^s(31\delta_{bc}-1),\qquad
 \sum_bq_{s,b}=0.                                      \tag{4}
\]

Indeed reduced trace vanishes on KF and KF², whereas on K the
cohomological trace is Tr_(K/Q). The trace of ζ_31^d is 30 for d=0
and −1 otherwise; F^†F=5 supplies the weight. The Gram matrix
5^s(31I−𝟙𝟙^t) has rank 30 and acts by31·5^s on the sum-zero subspace.
Thus each family is a tight frame, and together they span all 90
rational dimensions. For EVERY x∈D,

\[
 \sum_b t_{s,b}(x)=0,\qquad
 x=\sum_{s=0}^2\frac1{31\cdot5^s}
                   \sum_b t_{s,b}(x)q_{s,b},           \tag{5}
\]
\[
 \langle x,x\rangle
   =\sum_{s=0}^2\frac1{31\cdot5^s}\sum_b t_{s,b}(x)^2. \tag{6}
\]

These are the reconstruction and Parseval identities of Proposition 49.3.
For every u_j the 93 traces are INTEGERS in the finite box (2), with
the three sum-zero relations. Equation (5) reconstructs at most one
rational element from each array. This is the finite reduction of
Corollary 49.4, not a claim that every array is an integral endomorphism
or effective correspondence. One must still impose membership in the
ACTUAL global End(J), u_(7−j)=u_j^†, positivity of the circulant
G=(u_(j−i)), and the available norm/rank/geometric restrictions.

## 3. Conditional coefficientwise conclusion—its hypothesis remains extra

Let R=O_K⊕O_KF⊕O_KF². If ALL six u_j belong to R, then each
lies in O_K and has the form

\[
 u_j=\sum_{i\in A_j}\zeta_{31}^i,\quad13\le|A_j|\le18,
\]
\[
 \operatorname{Tr}u_j\in\{-18,\ldots,-13\}\cup\{13,\ldots,18\},
 \quad I_j:=\deg(a,a\beta^j)^*\Delta_Y
               \in\{0,\ldots,5\}\cup\{31,\ldots,36\}.  \tag{7}
\]

Moreover G has D-rank 7: its cyclic orbit has one invariant and six
primitive copies of J. This is the CONDITIONAL Theorem 49.6.

For the coefficient argument, if x=∑_i c_iζ_31^i∈O_K, its coefficient
vector is unique up to a common integral shift, and the rotation traces
r_b=Tr_(K/Q)(x̄ζ_31^b) satisfy

\[
 r_b=31c_b-\sum_i c_i,\qquad r_b-r_c=31(c_b-c_c)         \tag{8}
\]

after reindexing. Therefore |r_b|≤10 (also≤9) forces x=0.
If |r_b|≤18 and x≠0, subtract the common minimum of the coefficients:
they are 0 or1, and their number m of ones must satisfy 13≤m≤18.
This is the complete coefficient-gap proof, including the nonzero case.

Now write u_j=∑_s x_sF^s with x_s∈O_K. Orthogonality gives

\[
 t_{s,b}(u_j)=5^s\operatorname{Tr}_{K/\mathbf Q}
       \bigl(\sigma^{-s}(\overline{x_s})\zeta_{31}^b\bigr)
\]

up to rotation reindexing. For s=1,2, (2) bounds the integer trace by
floor(54/5)=10 and floor(234/25)=9. Thus x_1=x_2=0. The
[low-degree effectivity theorem](45_EFFECTIVE_CORRESPONDENCE_AND_CONDUCTOR_FORMULAS.md)
gives u_j≠0, including nonbirational cross images. Formula (8) and
Tr u_j=18−I_j then give (7).

For the rank, put L=E(ζ_7). Coprime cyclotomic conductors give
K∩L=E. The [Honda splitting calculation](40_JACOBIAN_NORM_OBSTRUCTION_FOR_THE_SEVEN_DIAMOND.md#4-the-exact-limit-of-the-translate-counting-argument)
gives D⊗_E L=M_3(L): local degree 6 above 5 kills every denominator 3
Honda invariant. The Fourier blocks of G are

\[
 g_a=\sum_{j=0}^6u_j\zeta_7^{aj},\qquad0\le a\le6.
\]

Since u_j∈K, they lie in the FIELD KL, hence are zero or invertible.
The six primitive blocks are Galois-conjugate and cannot all vanish:
otherwise the primitive orbit would vanish, contrary to the actual
diamond's noninvariance. The invariant block is nonzero by the norm
argument in the same Honda proof. All blocks are therefore invertible.

## 4. Exact completed order and the divided-ramification counterexample

Write K_31=K⊗Q_31 and E_31=E⊗Q_31. The completed geometric order
(Theorem 54.1) is

\[
 D\otimes_EE_{31}=\operatorname{End}_{E_{31}}(K_{31})
                  \simeq M_3(E_{31}),
\]
\[
 \operatorname{End}_k(J)\otimes\mathbf Z_{31}
   =\operatorname{End}_{\mathcal O_{E,31}}(\mathcal O_{K,31})
                  \simeq M_3(\mathcal O_{E,31}),        \tag{9}
\]

under identification of the Tate module with a fractional O_(K,31)-ideal.
In particular it is maximal, NOT the coefficientwise crossed order.

Proof. T=T_31J is torsion-free of Z_31-rank 30 over the DVR
O_(K,31)=Z_31[ζ_31], also of rank 30. Thus T is rank-one free over
that DVR and T⊗Q_31=K_31. All geometric rational endomorphisms,
hence all integral ones, are defined over F_125: its Galois generator
acts by conjugation with the central F³=π. Tate's integral isogeny
theorem gives

\[
 \operatorname{End}_k(J)\otimes\mathbf Z_{31}
      =\operatorname{Cent}_{\operatorname{End}_{\mathbf Z_{31}}T}(\pi).
\]

The rational centralizer is D⊗_E E_31 by Tate. It is split since
the local Honda invariant at 31 is zero, and acts on the
three-dimensional E_31-space K_31. It is therefore the full
End_(E_31)(K_31). Intersecting with integral operators on T gives
End_(O_(E,31))(T), since O_(E,31)⊂O_(K,31) preserves T.
A fractional ideal of the DVR O_(K,31) is free; that DVR is free
of rank 3 over O_(E,31). This proves (9) without any crossed-order
generation assumption.

For explicit strictness (Proposition 54.2), put λ=1−ζ_31.
F acts on the rank-one Tate model as cσ with c∈O_(K,31)^×,
because it is a semilinear automorphism away from 5. Thus its
coefficientwise lattice differs from the σ-crossed lattice only by
units. But the operator

\[
 \partial=\lambda^{-1}(\sigma-1)                        \tag{10}
\]

preserves O_(K,31) and is O_(E,31)-linear: σ is inertia in the
tame totally ramified cubic extension, so σa−a∈λO_(K,31).
Its unique coefficients in K_31⊕K_31σ⊕K_31σ² are
−λ^(-1), λ^(-1),0, which are not integral. Hence

\[
 R\otimes\mathbf Z_{31}
       \subsetneq\operatorname{End}_k(J)\otimes\mathbf Z_{31}.
\]

Thus ambient endomorphism integrality cannot justify Section 3's
hypothesis. A geometric reason specific to the six u_j would still
be needed to put them in R; the maximal order supplies none.

## 5. The cubic K-component restriction and its later completion

The following independently audited special case is retained directly
(Proposition 49.7). If Γ⊂Y×Y is reduced irreducible of bidegree(3,3)
with BOTH normalization projections etale, and v is its action, then

\[
 v\in KF\oplus KF^2,\qquad \langle v,v\rangle\le102.     \tag{11}
\]

Intersect Γ with the rotation and hyperelliptic-companion graphs.
Their degree-one projections preclude a common component, so the 31
integer traces t_b=〈v,ρ^b〉 lie in[−6,6] and sum to zero.
For x the K-component of v^†, integrality of reduced traces
Trd_(D/E)(v^†y), y∈O_K, gives

\[
 x\in\mathfrak D_{K/E}^{-1}=\lambda^{-2}O_K.
\]

Here K/E is tame totally ramified cubic at 31 and unramified elsewhere.
Consequently x(ζ_31−1)³∈λO_K, whose absolute trace is in 31Z.
Thus Δ³t_b=0 mod 31. The resulting function on F_31 is a polynomial
of degree≤2. Its values lie in the 13 residues0,±1,…,±6, whereas
a nonconstant linear polynomial has 31 values and a quadratic has 16.
It must be constant. Reduction is injective on[−6,6]; the integral
traces are equal and sum to zero, so all vanish. The K-frame in (5)
is nondegenerate, proving the first part of (11).

For the second, the [actual adjunction formula](45_EFFECTIVE_CORRESPONDENCE_AND_CONDUCTOR_FORMULAS.md#1-audited-actual-image-intersection-class-and-conductor)
gives δ(Γ)=3²+14·3−〈v,v〉/2≥0. This uses the genus of the
ACTUAL etale normalization, not an arbitrary Jacobian homomorphism.

Direct and transposed F-graph tests put bounds 18 on frames in the two
remaining components. The interval[−18,18] represents EVERY residue
mod 31, so the same value-set argument cannot kill them.

The later [global coefficient-ideal calculation](67_CUBIC_CROSS_ROSATI_GAP.md)
instead retains BOTH the λ^(-2) allowance at 31 and the slope-dependent
denominators at 5. Its exact certificate gives norm≥106 for every nonzero
integral element in KF⊕KF²; the odd low-degree effectivity theorem
ensures v≠0. Thus 106>102 excludes cubic cross images and supplies the
birationality hypothesis in the separately audited conditional
[Gram-rank theorem](48_M9_CROSS_CORRESPONDENCE_RANK_OBSTRUCTION.md).
That completion has its own evidence; it does not retroactively make
coefficientwise integrality true or extend the original audit scopes.
The rank-five and rank-seven orbit alternatives are not themselves a
common-cover exclusion.
