# Proof: shift the self-duality weight before direct image

[Statement](../../Theorems/cartier_and_spin/centered_frobenius_common_bundle.md).
Use the actual common category, which is abelian under the no-clump
hypothesis. Write $q=p^r$. Riemann--Roch gives
$\operatorname{rk}T_r=q$ and $\deg T_r=0$. For the line
$L=\omega^{(1-q)/2}$, $L^2=\omega^{1-q}$, the relative dualizing
line of $F^{[r]}$. Multiplication followed by finite-duality trace
therefore gives a perfect symmetric pairing $T_r\otimes T_r\to\mathcal O$.
It commutes with the original étale maps.

The iterated diagonal filtration gives the displayed grades of
$F^{[r]*}T_r$. Its top line has positive degree for $r>0$, so $T_r$
is not strongly semistable. Individual stability follows by applying
the Frobenius direct-image theorem to a line and iterating. This
alone would not prove common simplicity.

The [scalar detector](common_atiyah_jet_obstruction.md) applies directly
to every $T_r$, since it is a Frobenius direct image of a common line.
Thus $\gamma_{T_r}\ne0$, without any induction hypothesis.

Projection formula gives the exact recursion
\[
T_{r+1}=F_*E_r,\qquad E_r=T_r\otimes\omega^{(1-p)/2},
\tag{1}
\]
on the appropriate twists. If $T_r$ is common-simple, so is $E_r$.
The bundle $E_r$ is self-dual with pairing valued in $\omega^{1-p}$,
and its scalar Atiyah class is still nonzero.

A nonzero common saturated $V\subset F_*E_r$ has consecutive full
canonical grades, exactly as in the one-step argument for the
[higher Cartier theorem](higher_cartier_common_filtration.md).
Thus $F^*V=J^{\ell-1}E_r$ for some $1\le\ell\le p$; the
identification carries a common Cartier connection. The general
self-duality-weight form of the block-sum identity gives
\[
\ell\bigl((1-p)+\ell-1\bigr)\gamma_{E_r}
=\ell(\ell-p)\gamma_{E_r}=0.
\tag{2}
\]
In characteristic $p$ this forces $p\mid\ell$, hence $\ell=p$ and
$V=F_*E_r$. Starting at the common line $T_0=\mathcal O$ proves
common simplicity of every $T_r$.

Since different canonical twists of $T_r$ are nonisomorphic common-simple
objects, both $\operatorname{Hom}(T_r,T_r\omega)$ and
$\operatorname{Hom}(T_r,T_r\omega^p)$ vanish. The first proves
uniqueness of a common connection; the second kills its $p$-curvature.
The covariant derivative of the symmetric pairing is likewise a
common map $T_r\to T_r^\vee\omega\simeq T_r\omega$, so is zero.
Cartier descent is fully faithful with the actual source identifications,
giving the stated antecedent criterion.

Finally the pairing has weight zero. The Atiyah identity is therefore
$a(T_r)+a(T_r)^\dagger=0$, not the weight-one identity that excluded
connections on $F_*^{[s]}B$. Nothing in (1)--(2) decides whether
$a(T_r)$ itself vanishes. The first such existence question is retained
explicitly as a gap, not counted as an additional nonexistence theorem.
