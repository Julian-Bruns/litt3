# Proof: finite bad cosets and the full Frobenius kernel

[Canonical statement](../../../Theorems/jacobians/theta_divisors/ordinary_cyclic_triple_finite_bad_cosets.md).
Finiteness audited PASS by /root/ordinary_triple_finite_bad_fibers_check,
2026-09-05; grid bound checked by /root/elliptic_grid_divisor_bound.
[Audit scope](../../../routes/global/audits/ORDINARY_CYCLIC_TRIPLE_FINITE_BAD_FIBERS_AUDIT.md).
The [Version4 audit and Version5 addendum](../../../Research/audits/CYCLIC_TRIPLE_FULL_KERNEL_AUDIT_2026_09_16.md)
pass the extensions to nonordinary U and Y, the full-kernel coefficient
extraction, the supersingular case, and the characteristic-five Prym data.
Section 1 cites the Prym product theorem; its characteristic-five
applicability and explicit polarization matrix are explained there.

## 1. The Prym product and its polarization

For a cyclic étale cover of odd degree n of a hyperelliptic curve,
Ortega's product map ψ is an isomorphism:
[Ortega, *Variétés de Prym associées aux revêtements n-cycliques d'une
courbe hyperelliptique*, Proposition 2.5 and Lemma 2.1](https://arxiv.org/pdf/math/0307151#page=4).
In the equal-factor notation of
[Lange–Ortega, Theorem 2.1(a)](https://arxiv.org/pdf/1601.04082#page=3),

    ψ:J(U/⟨j⟩)²→P,       (x,y)↦i(x)+σi(y),

where j lifts the hyperelliptic involution and i is quotient pullback.
The odd-degree argument is algebraic when 2n is invertible: a point
in the intersection of the two factors is fixed by j and σ, is killed
by n on P, and descends through the cyclic cover. The hyperelliptic
involution then also kills it by 2. The intersection scheme is killed
by n and hence étale, so it is trivial. This verifies applicability
in characteristic 5 for n=3, without a complex lifting argument.

Now q:U→Y has degree 3 and g(Y)=2. The involution j fixes one point
above each of the six Weierstrass points, so E=U/⟨j⟩ is elliptic.
Its ramified degree-two quotient gives an injection i:E→J(U),
and ψ identifies P with E². Write Ξ for the restricted polarization,
as in Ortega §3. For b=i^†σi, one has i^†i=2, b=b^† from jσj=σ^−1,
and 2+b+b^†=0 from 1+σ+σ²=0 on P. Thus

    ψ^*Ξ ↔ H=[[2,−1],[−1,2]],             deg λ_Ξ=9.       (1)

Use the product principal identification (E²)^∨=E². For
A=q^*J(Y), Q=J(U)/A and ρ=π|P, complementarity gives

    P=E², Q=P^∨=E², ρ=H, deg ρ=9, ker ρ=C3²,
    L_P=Ξ↔H, L_Q↔H#=[[2,1],[1,2]],
    L_P²=L_Q²=6, ρ^*L_Q≡3L_P,
    σ_P↔S=[[0,−1],[1,−1]], σ_Q↔R=S^(-T)=[[-1,−1],[1,0]]. (2)

Both restricted polarization types are (1,3). With Y ordinary,
U is ordinary exactly when E is, since J(U)∼J(Y)×E².
For the Raynaud calculations below, take scalar Frobenius twists
of these identities.

## 2. The two grid counts needed

For a finite set S⊂E(k), |S|=n≥2, a Hermitian divisor class
[[a,b],[b^†,c]] meets horizontal/vertical fibers in degrees a/c.
An effective divisor without a vertical GRID fiber meets S² in≤nc
distinct points, including tangencies and inseparable projections.

For a=c=2 and b≠0 there is at most one vertical component, counted
with multiplicity: removing two would leave horizontal intersection0,
hence a union of horizontal fibers, impossible with off-diagonal b≠0.
Thus its grid support has size≤n+2(n−1)=3n−2, or≤2n if it has
no vertical grid fiber.

## 3. Extracting a Dirac section from a prime-to-p product isogeny

Here is the general coefficient argument. Suppose addition is a
prime-to-p isogeny nu:A times P->J, and nu^*L is the external
product L_A boxtimes L_P. Let sigma be a section of L whose
divisor has the full Dirac property. Then there is a section tau
of L_P whose divisor has the Dirac property on P.

Indeed nu identifies the entire Verschiebung kernel of A times P
with K_J, since its kernel has order prime to p. Trivialize the
lines on the finite kernel schemes. The restriction of nu^*sigma
is then a nonzero scalar times the tensor of the two Dirac
functions:
\[
(\nu^*\sigma)|_{K_A\times K_P}=t_A\otimes t_P.
\tag{3}
\]
Each t is zero on nonidentity local factors and spans the socle
at the identity. The tensor has exactly this property on the
product, whose identity local ring is the tensor of the two
Artinian complete-intersection rings. Thus (3) retains the
infinitesimal scheme structure, even when neither factor is ordinary.

Choose a linear functional ell on H^0(K_A,L_A|K_A) with ell(t_A)=1.
By the external-product description and the Kunneth isomorphism,
\[
\tau=(\ell\circ\operatorname{res}_{K_A}\otimes1)(\nu^*\sigma)
\in H^0(P,L_P),\qquad \tau|_{K_P}=t_P.
\tag{3a}
\]
It is nonzero and has the required property. Moreover, if nu^*sigma
is divisible by a section pulled back from P, then tau is divisible
by that same section: coefficient extraction commutes with this
multiplication. No surjectivity of a restriction map on global
sections is being asserted.

In our situation A and P are orthogonal for the Jacobian
polarization, their restricted polarization types are(1,3), and
addition nu has degree9. Thus its degree is prime to5, and the
Raynaud line pulls back to an external product, with the P-factor
of class4H. Orthogonality removes the mixed line-bundle class;
any degree-zero factor also splits as an external product. Apply
(3a) to obtain an effective Dirac divisor D_* on P of class4H.

If the base Y is ordinary, t_A can be evaluated at the identity
of its etale kernel. This recovers the former argument by actual
restriction to P. Coefficient extraction is what removes this
last ordinariness hypothesis. In general D_* need not equal
Theta_U|P, and that actual restriction is allowed to vanish
identically.

For pi:J->Q, let B be the locus of fibers entirely contained in
Theta_U. It is closed because pi is smooth and hence open.
Moreover0 is not in B: the C3 character decomposition restricts
the cohomology to a sum of three proper translated theta families
on J(Y). A finite union of proper closed sets is still proper.
No ordinariness is needed for this last observation.

## 4. The only possible numerical class of a curve of bad fibers

Suppose B contains a curve. Sum all its curve components with
their ACTUAL multiplicities as pullback components of Theta_U,
to obtain D_Q nonzero. This divisor is invariant under R and
inversion, and avoids0. The residual
\[
D_P=D_*-\rho^*D_Q
\tag{4}
\]
is effective by the divisibility clause of Section3: pi nu equals
rho composed with projection to P. Thus every coefficient retains
all the pulled-back bad components with their actual multiplicities.
This avoids any assumption that the original theta restricts
properly to P.

Write M for the Hermitian class of D_Q in the product principal
identification of Q with E squared. Invariance and effectivity
of D_Q and D_P give
\[
M=\begin{pmatrix}a&b\\b^\dagger&a\end{pmatrix},\qquad
b+b^\dagger=[a],\qquad
N=4H-HMH=
\begin{pmatrix}8-3a&3a-4-3b\\3a-4-3b^\dagger&8-3a\end{pmatrix}
\succeq0.
\tag{5}
\]
Here a is a positive integer, hence a=1 or2. These are numerical
polarization identities; arbitrary End(E), including a
quaternion order, is allowed.

If a=1, nefness forces b to be a unit of degree1, so M has rank
one. An effective divisor of this class on an abelian surface
is a sum of translates of its elliptic connected stabilizer.
Pulling one of these components back along pi would give a
translated abelian divisor component of Theta_U. This is excluded
by the [abelian-component theorem](raynaud_abelian_components.md).
Thus the a=1 possibility is impossible even when E is supersingular.

If a=2, write u=b-1. Then u+u^dagger=0 and nefness gives
\[
N=\begin{pmatrix}2&-1-3u\\-1-3u^\dagger&2\end{pmatrix},
\qquad 1+9\deg(u)\le4.
\tag{6}
\]
Integrality of endomorphism degree forces u=0. We conclude
\[
D_Q\equiv L_Q,\qquad D_P\equiv L_P,
\tag{7}
\]
with the two classes from (2).

## 5. The ordinary elliptic case

If E is ordinary, take
S=E[5](k), of size5. These are the relative Verschiebung-kernel
points on the scalar-twisted elliptic curve. The same grid S
squared is used in P and Q; rho=H permutes it since det(H)=3.
The Dirac property makes D_* contain its24 nonzero points.

The divisor D_Q has no vertical component: otherwise its pullback
would again be an abelian component of Theta_U. Its class has
vertical and horizontal degrees2, so the grid count of Section2
gives at most10 points on D_Q. The class of D_P also has these
two degrees and nonzero off-diagonal term; that same section gives
at most13 grid points, even if it has a vertical component.
Equation (4) would cover24 points with at most23, a contradiction.
This is the earlier audited grid argument, with the a=1 case
excluded by the more general component theorem.

## 6. The supersingular elliptic case

If E is supersingular, K_E is a local group scheme of length5.
In a formal parameter its ideal is (t^5). Thus, at the origin,
\[
\mathcal O_{K_P}=k[[u,v]]/(u^5,v^5),\qquad
\operatorname{Soc}(\mathcal O_{K_P})=k\,u^4v^4.
\tag{8}
\]
The support of K_Q is just0. Since D_Q avoids0, its pullback
equation is a unit on all of K_P. Dividing the Dirac equation
of D_* by this unit makes D_P a Dirac divisor on P.
In particular its equation restricts to a nonzero multiple of
the socle in (8), not just a function vanishing at the origin.

Restrict this equation to each of the coordinate elliptic curves
E times{0} and{0}times E. It vanishes on their full length-five
Verschiebung kernels: u^4v^4 restricts to zero on either axis.
But D_P has degree2 on each axis. A nonzero section of a
degree-two line on an elliptic curve cannot vanish on a
length-five subscheme. Both axes must therefore be components
of D_P.

After removing the two axes, the remaining effective divisor
has class
\[
\begin{pmatrix}1&-1\\-1&1\end{pmatrix}.
\tag{9}
\]
This is the pullback of a degree-one class by subtraction
E squared->E. Its effective representatives are single translates
of the diagonal. For example, quotient by the connected
stabilizer shows they are sums of fibers; intersection degree
one with an axis makes the sum a single fiber with multiplicity one.
Thus D_P is the two axes plus one translated diagonal.

If that diagonal misses0, a local equation has leading term a
nonzero multiple of uv. If it contains0, its leading term is a
nonzero multiple of uv(u-v). In either case this term survives
modulo (u^5,v^5) and has degree2 or3. It cannot equal the nonzero
socle term of degree8 required in (8). This is the contradiction
that the geometric point count could not supply.

There are no curve components of B in either case. It is a proper
closed subset of the projective surface Q and is therefore finite.
The proof permits every ordinariness type of both Y and U.
Only the characteristic-five numerical bound and the degree-three
etale cyclic covering structure enter.

## 7. Generic defects stabilize in unbounded abelian degree

The [low-genus theorem](low_genus_raynaud_cosets.md) strengthens
the possible generic defects: every bad translate of the
two-dimensional inherited Jacobian in this genus-four curve has
defect exactly one. This uses characteristic five but does not
use ordinariness, and neither does the finiteness argument above.
Thus the sums below count exceptional characters, each with
multiplicity one.

For α∈P(k), put δ_α=generic_L h⁰(B_{1,U}⊗α⊗q^(1)*L).
It is positive exactly when ρ(α)∈B, hence for finitely many α.
Let Λ_0 be the finite subgroup generated by exceptional α of
prime-to-five order.

For any finite prime-to-five character subgroup Λ⊂P(k), construct
its connected abelian etale character cover on U^(1), then untwist
to b_Λ:W_Λ→U. Character decomposition gives

    generic_L h⁰(B_{1,W_Λ}⊗(q b_Λ)^(1)*L)=∑_(α∈Λ) δ_α.          (10)

The generic open is a finite intersection for EACH Λ; no one point
is assumed good for infinitely many covers. The right side is uniformly
bounded and constant once Λ contains Λ_0. It may be positive.
If Λ avoids every nonzero exception it is zero, since δ_0=0.
No bound on degree or prime support is required.

This is NOT a uniform a-number bound, ordinarity of those covers,
or vanishing for every abelian cover. An existing second etale map
is preserved; none is constructed. The cofinal correspondence-tower
bridge and arbitrary monodromy remain outside the statement.
