# Proof: a generic Raynaud section cannot transform by a character

[Statement](../../../Theorems/jacobians/theta_divisors/galois_raynaud_rank_gap.md).
Fix a finite height \(e\). Write \(F=k(J(X^{(e)}))\), let \(L\)
be the generic Poincaré line on \(X^{(e)}_F\), and put
\[
V=H^0(Z^{(e)}_F,B_{e,Z}\otimes q^{(e)*}L).
\]
The deck action and the étale identity
\(B_{e,Z}=q^{(e)*}B_{e,X}\) make \(V\) a finite-dimensional
\(F[G]\)-module. The parameter \(L\) is fixed by this action.

Suppose \(V\) contains a one-dimensional subrepresentation of
character \(\chi:G\to F^*\). Its values have finite order, so
they belong to \(k^*\); p-power torsion in \(F^*\) is trivial.
Descent on the actual \(G\)-torsor associates to \(\chi\) a
degree-zero line bundle \(E_\chi\) on \(X^{(e)}\). Twisting the
equivariant section by the inverse character and descending gives
a nonzero section of
\[
B_{e,X}\otimes L\otimes E_\chi^{\pm1}.
\tag{1}
\]
The sign depends only on the convention for the associated line
and is immaterial here. Full-Jacobian finite-height Raynaud
properness excludes (1) for generic \(L\). This properness also
follows directly from the
[quotient a-number theorem](../../../Theorems/jacobians/theta_divisors/restricted_raynaud_complement_rank.md)
with \(A=J(X)\), whose quotient is zero. Translating by the fixed
line \(E_\chi\) preserves generic vanishing. This proves that
\(V\) has no one-dimensional submodule.

If \(V\ne0\), its socle contains a simple module. The field \(k\)
is algebraically closed, so scalar extension from \(k\) to \(F\)
does not change the dimensions of simple modules of the finite
algebra \(k[G]\): its semisimple quotient is a product of matrix
algebras over \(k\), and its radical stays nilpotent after extension.
The simple submodule therefore has dimension at least \(d_p(G)\).
The quotient a-number theorem applied to \(\operatorname{im}q^*\)
gives the upper bound \(\dim_FV\le a_e(Q)\). Pullback from
\(J(X^{(e)})\) to its image preserves generic rank even when its
finite kernel is inseparable. This proves the displayed gap.

If \(P\triangleleft G\) is a p-group and \(G/P\) is abelian,
every nonzero \(F[G]\)-module has a one-dimensional submodule:
its \(P\)-invariants are nonzero, are \(G\)-stable, and have an
eigenline for the finite commuting action of \(G/P\). The roots
of the relevant finite-order eigenvalues already lie in \(k\).
This contradicts the preceding paragraph, so \(V=0\).

Finally, if the inherited family has generic defect zero, its
vanishing open contains a closed parameter \(L\). At the mixed
parameter \((L,\mathcal O_Y)\) the same cohomology vanishes.
Upper semicontinuity then makes it vanish on a nonempty open of
the irreducible mixed parameter product, proving its generic
vanishing. Both original maps stay on \(Z\).

For \(p\nmid\deg q\), the norm/pullback identities give a
prime-to-p isogeny decomposition into \(J(X)\) and a complement,
so \(a(Q)=a(Z)-a(X)\). If this difference is at most one, the
representation gap forces \(\delta_1=0\), as asserted.

## The precise non-Galois representation

Assume now that the actual first-leg Galois closure has group \(G\)
of order prime to \(p\), and \(Z=\widetilde Z/H\). The associated
permutation bundle splits by Maschke's theorem:
\[
q^{(1)}_*\mathcal O_{Z^{(1)}}
\simeq\bigoplus_S E_S^{\oplus t_S},\qquad t_S=\dim S^H.
\tag{2}
\]
One may choose either consistent dual convention for associated
bundles; the multiplicity of \(S\) equals that of \(S^\vee\) in
this self-dual permutation representation. The trivial summand
occurs once because the cover is connected. Étale pullback of
\(B_X\), projection formula and (2) give both stated sums. Upper
semicontinuity gives \(r_S\le b_S\); the trivial summand has
generic cohomology zero by full-Jacobian Raynaud properness.

For every \(S\), self-duality \(B_X^\vee\otimes\omega_{X^{(1)}}
\simeq B_X\), Serre duality and Euler characteristic zero imply
\[
b_S=b_{S^\vee},\qquad r_S=r_{S^\vee}.
\tag{3}
\]
For the generic assertion inversion of the parameter line changes
\(L\) to \(L^{-1}\), preserving generic rank.

If the mixed generic defect is positive, every mixed parameter
has a section by upper semicontinuity. Hence the inherited first
axis has positive generic defect. When \(a(Z)-a(X)=1\), the sums
force a unique contributing \(S\) with \(t_S=b_S=r_S=1\).
Any one-dimensional \(S\) has \(r_S=0\), since its associated
bundle is a fixed degree-zero line. Thus \(\dim S\ge2\).
Equations (3) and \(t_S=t_{S^\vee}\) force \(S\simeq S^\vee\).
Finally generic \(r_S=1\) implies nonvanishing at every twist.

In odd characteristic, this self-dual \(S\) must be of orthogonal
type. We prove the parity fact which excludes symplectic type in
the next paragraph. For a simple self-dual representation the
invariant nondegenerate form is symmetric or alternating by Schur's
lemma; its associated bundle has the same kind of form.

## A direct parity lemma for symplectic coefficients

Let \(E\) be any vector bundle on \(X^{(1)}\) with a nondegenerate
alternating \(\mathcal O_{X^{(1)}}\)-valued pairing, and assume
\(p\ne2\). Choose a Lagrangian subspace at the function field and
saturate it to a subbundle \(F\subset E\). On a smooth curve
saturation is locally free with locally free quotient. The form
vanishes on \(F\) generically and hence everywhere, so \(F\) is
Lagrangian in every fiber and \(E/F\simeq F^\vee\).

Put \(A=B_X\otimes F\). Tensoring the symplectic form on \(E\)
with the alternating canonical form on \(B_X\) gives a symmetric
\(\omega_{X^{(1)}}\)-valued form on \(B_X\otimes E\). Thus
\[
0\longrightarrow A\longrightarrow B_X\otimes E
\longrightarrow A^\vee\otimes\omega_{X^{(1)}}\longrightarrow0
\tag{P1}
\]
is an orthogonal extension with Lagrangian subbundle \(A\). Its
connecting map
\(H^0(A^\vee\otimes\omega)\to H^1(A)
=H^0(A^\vee\otimes\omega)^\vee\) is alternating. To see the
sign directly, choose local isotropic splittings of (P1). Relative
to the symmetric block form with off-diagonal identity matrices,
differences of these splittings are skew-transpose maps. Their
Čech class lies in \(H^1(\bigwedge^2 A\otimes\omega^{-1})\);
cup product and the Serre trace give the stated alternating map.
Its rank is even.

The cohomology sequence of (P1) consequently gives
\[
h^0(B_X\otimes E)\equiv h^0(A)+h^1(A)
\equiv\chi(A)=(p-1)\deg F\equiv0\pmod2.
\tag{P2}
\]
Here \(\deg B_X=(p-1)(g(X)-1)\) cancels the rank term in
Riemann--Roch. This proves the parity lemma, and excludes a
symplectic \(E_S\) from the case \(b_S=1\).

## Odd-order closure groups

Suppose \(p\ne2\) and \(|G|\) is odd and prime to \(p\). No
nontrivial simple \(k[G]\)-module is self-dual. Here is an elementary
verification in the stated characteristic. For such a module \(S\),
averaging over \(G\) on \(S\otimes S\), and composing with the
factor-swap operator, gives trace
\[
\frac1{|G|}\sum_{g\in G}\operatorname{Tr}(g^2\mid S)=0.
\tag{4}
\]
Squaring permutes the elements of an odd-order group, and the sum
of the traces of \(g\) is zero because \(S^G=0\). If \(S\) were
self-dual, \((S\otimes S)^G\) would be a line by Schur's lemma.
The factor swap acts on that line by \(+1\) or \(-1\), since
\(p\ne2\), contradicting (4). Therefore nontrivial representations
in the excess sum occur in distinct dual pairs with equal
contributions. Their sum is even.
