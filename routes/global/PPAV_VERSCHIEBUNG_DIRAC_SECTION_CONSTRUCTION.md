# A Dirac section on every principally polarized abelian variety

Status: new author proof, 2026-09-05; standard Fourier–Mukai ingredients source-checked, but this construction has not received an independent audit. This is an existence theorem in a specified line bundle of numerical class `(p−1)Theta`, not an attribution of a universal existence theorem to Tong.

## Statement with the actual line bundle

Let `k` be algebraically closed of characteristic `p>0`. Let `A/k` be an abelian variety, let `M` define a principal polarization, and set

\[
A_1=A^{(p)},\qquad v=V_A:A_1\longrightarrow A,
\qquad L_1=M^{(p)},\qquad K=\ker(v).
\]

Write `omega_v` for the relative dualizing line bundle. There is a section

\[
s\in H^0(A_1,T),\qquad
T=L_1^{-1}\otimes v^*M\otimes\omega_v,
\tag{1}
\]

whose restriction to `K` is zero on every nonidentity local component and is a nonzero element of the socle at the identity, after any local trivialization of `T`.

Here `omega_v` is trivial as a line bundle, and

\[
T\equiv L_1^{\otimes(p-1)}.
\tag{2}
\]

Thus every ppav has an effective divisor of the required numerical class satisfying the full scheme-theoretic Dirac property. No ordinarity or Jacobian hypothesis occurs.

The actual line bundle in (1) must not silently be replaced by an arbitrarily prescribed representative of its numerical class.

## Fourier construction, including the evaluation maps

Rigidify `M` at zero, and use the induced rigidification of `L_1`. Write `Phi_A` and `Phi_{A_1}` for normalized Poincare Fourier–Mukai functors. Since `M` is ample and principal, its transform is a line bundle in degree zero. Put

\[
Q=(\Phi_A M)^{-1}.
\]

The usual formula for the transform of a principal line bundle shows that `Q` is ample and principal on `hat A`. Let

\[
e:M\longrightarrow k(0)
\]

be the quotient to the fiber at zero. Under `Phi_A(k(0))=O_{hat A}`, its Fourier transform is a nonzero morphism

\[
\theta:Q^{-1}\longrightarrow O_{\widehat A},
\]

or equivalently a nonzero section of `Q`. Nonvanishing here follows from full faithfulness; it does not require that the global theta section of `M` be nonzero at the origin.

Formation of the normalized Poincare functor commutes with the base field automorphism defining the Frobenius twist. Consequently the transform of

\[
e_1=e^{(p)}:L_1\longrightarrow k(0)
\]

is precisely the twisted morphism

\[
\theta^{(p)}:(Q^{(p)})^{-1}\longrightarrow O_{\widehat A_1}.
\]

Set `E=v_*L_1`. This is IT0: for each degree-zero `alpha` on `A`, the higher cohomology of `E tensor alpha` is that of the ample line bundle `L_1 tensor v^*alpha` and vanishes. Isogeny compatibility, as a natural isomorphism of functors, gives

\[
\Phi_A E\simeq \widehat v^{,*}\Phi_{A_1}L_1.
\]

The dual isogeny `hat v` is the relative Frobenius

\[
F_{\widehat A}:\widehat A\longrightarrow\widehat A^{(p)}=\widehat A_1.
\]

Hence

\[
\Phi_A E\simeq F_{\widehat A}^*(Q^{(p)})^{-1}
\simeq Q^{-p}.
\tag{3}
\]

Naturality also computes the transform of the specific map

\[
d=v_*e_1:E\longrightarrow k(0):
\]

it is `F_{hat A}^*(theta^{(p)})=theta^p`, as a map `Q^{-p}->O`. This is equality of the evaluation morphisms, not merely a numerical identification of their line bundles.

Consider now the multiplication morphism

\[
u=\theta^{p-1}:Q^{-p}\longrightarrow Q^{-1}.
\]

Its composition with `theta` is `theta^p`. Fourier full faithfulness therefore supplies a unique morphism

\[
h:E\longrightarrow M\quad\text{such that}\quad e\circ h=d.
\tag{4}
\]

Existence follows by taking the inverse Fourier image of `u`. The displayed uniqueness is uniqueness subject to the exact equality in (4): multiplication by the nonzero section `theta` is injective on morphisms between these line bundles.

## Why finite duality gives the full Dirac condition

The isogeny `v` is finite flat and Gorenstein. Finite duality identifies

\[
\operatorname{Hom}_A(v_*L_1,M)
\simeq \operatorname{Hom}_{A_1}(L_1,v^!M)
\simeq H^0(A_1,L_1^{-1}\otimes v^*M\otimes\omega_v).
\tag{5}
\]

Let `s` correspond to `h`. Base change of finite duality to the origin identifies `h_0` with the section `s|K` through the perfect dualizing pairing on `K`. Equation (4) says exactly that the linear functional

\[
h_0:H^0(K,L_1|_K)\longrightarrow M_0=k
\]

is residue evaluation at the identity of `K`.

For completeness this last condition has the claimed local algebra meaning. Trivialize the relevant invertible modules on each local component and put

\[
R=H^0(K,O_K)=\prod_x R_x.
\]

The dualizing module is `R^vee=Hom_k(R,k)`, with action `(a f)(b)=f(ab)`. Residue evaluation at zero vanishes on every `R_x` for `x != 0`. In `R_0^vee`, it is nonzero and is annihilated by the maximal ideal `m_0`, since `f(ab)=0` for `a in m_0`. As `R_0` is Artinian Gorenstein, an invertible-module trivialization `R_0^vee ~= R_0` therefore sends this functional to a nonzero element of `Ann(m_0)`, the one-dimensional socle. Changing trivializations multiplies by a unit and preserves the assertion. This proves the complete scheme-theoretic condition, including nonreduced kernels.

The nonzero restriction implies that `s` is nonzero, so its zero scheme is an effective Cartier divisor.

## Numerical class and the importance of the twist

Both source and target are smooth of dimension `g`, so

\[
\omega_v\simeq\omega_{A_1}\otimes v^*\omega_A^{-1}\simeq O_{A_1}.
\]

To compute the numerical class, let `F:A->A_1` be relative Frobenius. Then `vF=[p]`, and

\[
F^*L_1\simeq M^p,\qquad
F^*v^*M=[p]^*M\equiv M^{p^2}.
\]

Pullback by the finite surjective map `F` is injective on numerical divisor classes, giving `v^*M equiv L_1^p`, and thus (2).

It would be false to conclude existence in every fixed line bundle of this numerical class. Already for an ordinary elliptic curve in characteristic two, `K={0,a}` and the required degree-one divisor is `[a]`. The unique divisor in `|O([0])|` does not have the Dirac property. Formula (1) produces `O([a])`, as it should.

## Primary-source boundary

- Mukai, *Duality between D(X) and D(hat X) with its application to Picard sheaves*, Nagoya Math. J. 81 (1981), Theorem 2.2, Example 2.6, formula (3.4), Proposition 3.11: Fourier full faithfulness, skyscraper transform, natural isogeny compatibility, and the transform of a principal line bundle. The base-field-twist compatibility used above follows directly from the normalized Poincare integral-transform construction and flat base change. [Primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BDBEBAC584BE15236C2D62C383A34245/S002776300001922Xa.pdf/duality-between-d-x-and-with-its-application-to-picard-sheaves.pdf).
- Finite dualizing modules and arbitrary base change for finite locally free algebras: [Stacks Project, Lemma 49.2.10, tag 0BVF](https://stacks.math.columbia.edu/tag/0BVF). The residue-functional/socle argument above is supplied explicitly.
- Tong, *Diviseur theta et formes differentielles*, Section 1.2.7, defines the full Dirac property and Theorem 1.2.7.7 proves it for the Raynaud divisor of a semistable curve. That theorem itself has Jacobian scope. Question 1.3.7 asks uniqueness in the numerical class for ppavs. The construction above is an author deduction from the Fourier formalism, not a claim that Tong stated universal ppav existence. [Author's published-version PDF](https://www.math.u-bordeaux.fr/~jtong/Recherche/Theta.pdf).

No uniqueness across different representatives of the numerical class is claimed in this note.
