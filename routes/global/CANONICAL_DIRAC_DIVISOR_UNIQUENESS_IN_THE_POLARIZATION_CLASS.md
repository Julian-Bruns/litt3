# Canonical Dirac divisor: uniqueness across the polarization class

Date: 2026-09-05. Status: proved argument, with a fresh focused audit of
existence and the stronger uniqueness proof. Verdict: **PASS**.
Auditor: /root/dirac_ppav_construction_independent_audit (GPT-6 Astra,
medium), 2026-09-05.
[Audit record](audits/PPAV_VERSCHIEBUNG_DIRAC_EXISTENCE_AND_UNIQUENESS_AUDIT_2026_09_05.md).
Nonbreaking requirements: retain the relative dualizing line; inverse
Frobenius field twist is not a tensor root; principal theta reducedness
is needed in arbitrary characteristic. The proof below incorporates these.
The audit predates this transcription, but checks its argument.

## Theorem

Let \(k\) be algebraically closed of characteristic \(p>0\), and let
\((A,\lambda)\) be a principally polarized abelian variety of positive
dimension. Write \(A_1=A^{(p)}\), \(v=V_A:A_1\to A\), and \(K=\ker v\).
There is exactly one effective divisor \(D\) on \(A_1\) such that:

1. \([D]=(p-1)\lambda^{(p)}\) in the numerical divisor group;
2. its local equation on the full finite scheme \(K\) is zero on every
   nonidentity local component and a nonzero socle element at the identity.

For any principal line bundle \(M\) representing \(\lambda\), its line bundle is
\[
\mathcal T_M=(M^{(p)})^{-1}\otimes v^*M\otimes\omega_v. \tag{1}
\]
The divisor, and hence this isomorphism class, is independent of \(M\).
The line \(\omega_v\) is trivial, but its duality role is retained.
If the identity component of \(K\) is nonreduced, a nonzero socle restriction
can have value zero at the reduced origin.

## 1. Existence and the canonical morphism

We recall [the detailed existence construction](PPAV_VERSCHIEBUNG_DIRAC_SECTION_CONSTRUCTION.md).
Choose rigidifications and normalized Poincare Fourier functors.
Put \(L_1=M^{(p)}\), \(E=v_*L_1\), and \(Q=(\Phi_A M)^{-1}\).
The line bundle \(Q\) is principal ample. Fourier transform sends evaluation
\(e_M:M\to k(0)\) to its nonzero theta section
\(\theta:Q^{-1}\to\mathcal O_{\widehat A}\). It sends
\(d=v_*(e_M^{(p)}):E\to k(0)\) to
\[
F_{\widehat A}^*(\theta^{(p)})=\theta^p:Q^{-p}\to\mathcal O_{\widehat A}.
\]
These are natural identities of morphisms, not just numerical classes:
use isogeny and field-twist compatibility and \(\widehat v=F_{\widehat A}\).

Multiplication by \(\theta^{p-1}:Q^{-p}\to Q^{-1}\) corresponds under Fourier
equivalence to a unique morphism \(h:E\to M\) satisfying
\[
e_M\circ h=d. \tag{2}
\]
Finite flat duality identifies \(h\) with a section \(s_M\) of (1).
On \(K\), equation (2) makes its dualizing functional residue evaluation at
the identity. This is nonzero and annihilated by the maximal ideal in the
identity local dualizing module, and zero on every other local component.
The local rings are Artinian Gorenstein, so any trivialization transports
it to a nonzero socle element. Thus \(s_M\) is Dirac.

Finally \(v^*M\equiv(M^{(p)})^p\): pulling back by relative Frobenius gives
\([p]^*M\equiv M^{p^2}\) on both sides, and numerical pullback is injective.
This proves existence and the asserted numerical class.

## 2. Reduce any competitor to theta divisibility

Let \(s\in H^0(A_1,T)\) be any Dirac section with
\(T\equiv(p-1)L_1\). Define the actual line bundle
\[
R=v^*M\otimes\omega_v\otimes T^{-1}. \tag{3}
\]
It is numerically equivalent to \(L_1\), hence principal ample.
Inverse field twist gives a principal \(M'\equiv M\) on \(A\) such that
\[
R\simeq M'^{(p)}. \tag{4}
\]
This is inverse base-field twisting, not taking a \(p\)-th tensor root.

Finite duality sends \(s\) to \(h_s:v_*R\to M\).
On \(K\) its functional is a nonzero scalar times identity residue:
a socle element pairs with any element by that element's residue scalar.
After rigidifying \(R\) and rescaling \(s\), therefore,
\[
e_M\circ h_s=d_R,\qquad d_R=v_*(e_{M'}^{(p)}). \tag{5}
\]
Let \(Q'=(\Phi_A M')^{-1}\), and let \(\theta'\) be the transform of \(e_{M'}\).
The same natural identities give
\[
\Phi_A(v_*R)=Q'^{-p},\qquad \Phi_A(d_R)=\theta'^p.
\]
Thus (5) supplies a morphism \(a_s:Q'^{-p}\to Q^{-1}\) with
\[
\theta\circ a_s=\theta'^p,\qquad
\operatorname{div}(\theta)\le p\operatorname{div}(\theta'). \tag{6}
\]

## 3. Reduced principal theta divisors force equality

The principal line bundles \(Q,Q'\) have the same numerical class:
\(M'\) is a translate of \(M\), and Fourier translation compatibility
makes their transforms differ by a degree-zero twist.

Every principal theta divisor is reduced in arbitrary characteristic.
Jordan--Keeton--Poonen, *Unique Factorization of Principally Polarized
Abelian Varieties*, Theorem 3.1 proves over a separably closed field that
all component multiplicities are one and all components geometrically
reduced. Its proof explicitly treats positive characteristic.
[Primary theorem and proof](https://arxiv.org/html/1602.06811v1#S3).

Consequently (6) implies that every prime component of
\(\operatorname{div}(\theta)\) occurs with multiplicity one in
\(\operatorname{div}(\theta')\). Their difference is effective and numerically
trivial, so is zero: a nonzero effective divisor has positive intersection
with an ample class to power \(g-1\).

Thus \(Q'\simeq Q\), with the theta sections agreeing up to scalar.
Fourier equivalence gives \(M'\simeq M\), and (3)--(4) force
\(T\simeq\mathcal T_M\). In this bundle (6) uniquely determines \(a_s\)
as multiplication by \(\theta^{p-1}\), since multiplication by \(\theta\)
is injective. Hence \(s\) agrees with \(s_M\) up to scalar and their
divisors coincide. This proves the theorem.

## Consequences and limits

For a smooth proper connected curve, Tong's theorem gives the Dirac
property for the Raynaud determinant divisor, of class
\((p-1)\Theta_{\rm class}\). It is therefore exactly the divisor constructed
above from the principally polarized Jacobian, without ordinarity.

The uniqueness addresses the formulation of Tong's Question 1.3.7,
which asks for at most one Dirac divisor in this algebraic-equivalence
class. We make no claim that this question remains open in the literature
or that this proof is historically new.
[Tong, Sections 1.2.7 and 1.3](https://arxiv.org/pdf/0712.2046).

The construction is compatible with products: exterior products of factor
sections are Dirac on the product kernel and have the required class.
Uniqueness identifies the divisor with the sum of pulled-back factor
divisors. This requires an actual product of principally polarized abelian
varieties, not merely an isogeny decomposition.

This theorem does not imply that the divisor avoids an abelian subvariety,
a translate, or the image of two Jacobian pullbacks. It does not supply two
finite etale maps of curves. Those inputs in Litt3 remain unresolved.
