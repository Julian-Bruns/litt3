# Proof: one digit at a time in the actual crystalline comparison

[Statement](../../Theorems/deformations/versal_bt_valuative_comparison.md).
The level-two proof was supplied in the latest Pro reply. Only its
all-level induction and global consequence are new here.

## The local matrix lemma

Use the lift $S_N=W_N(k)[[T]]$ with $\sigma(T)=T^5$ and Witt
Frobenius on coefficients. Evaluate the actual contravariant crystals
on this lift. A basis adapted to the common Hodge line gives
\[
F_0=\begin{pmatrix}a&0\\c&0\end{pmatrix},\qquad
V_0=\begin{pmatrix}0&0\\d&e\end{pmatrix},\qquad ad+ce=0.
\]
At the supersingular closed point $c,d$ are units. Simple Hasse
vanishing gives $v_t(a)=v_t(e)=1$. Write $\nabla_0=d+C\,dt$;
the Kodaira--Spencer hypothesis is precisely $C_{12}\in R^*$.

Suppose $N=\left(\begin{smallmatrix}x&y\\z&w\end{smallmatrix}\right)$
has entries in $K$ and satisfies
\[
NF_0-F_0N^{(5)}\in M_2(R),\quad
N^{(5)}V_0-V_0N\in M_2(R),\quad
N'+[C,N]\in M_2(R).
\tag{3}
\]
The two Frobenius matrices in (3) are
\[
\begin{pmatrix}
a(x-x^5)+cy&-ay^5\\
az+c(w-x^5)&-cy^5
\end{pmatrix},\qquad
\begin{pmatrix}
dy^5&ey^5\\
dw^5-dx-ez&e(w^5-w)-dy
\end{pmatrix}.
\]
Their indicated diagonal entries first give $y\in R$, then $x,w\in R$.
Indeed a pole of $x$ would give valuation $1+5v_t(x)<0$ in
$a(x-x^5)$, and similarly for $w$. Finally the upper-left connection
entry is $x'+C_{12}z-yC_{21}$. Its other terms are regular, and
$C_{12}$ is a unit, so $z\in R$. This proves $N\in M_2(R)$.

At an ordinary point $a,e$ are units. The upper-right Frobenius entry
controls $y$, then the same diagonal entries control $x,w$, and
$az+c(w-x^5)$ controls $z$ without using Kodaira--Spencer.

## Integral comparison at every level

At level two the marking makes the generic crystalline comparison
$U=1+5N$. Dividing its exact $F,V$ and connection identities by five
and reducing modulo five gives (3). Therefore $U$ is integral.

For $N>2$, the restriction of a supplied generic comparison to the
$(N-1)$st truncation extends by induction. Lift its integral matrix
to an invertible matrix over $S_N$, and use it as a change of basis.
The generic comparison then has the form
\[
U=1+5^{N-1}N_0,\qquad N_0\in M_2(K).
\]
The integral endpoint matrices agree modulo $5^{N-1}$. The comparison
identities, divided by $5^{N-1}$ and reduced modulo five, again give
(3) for $N_0$. The common reduced connection and Hasse data have not
changed. Thus the last digit is integral, completing induction.

Horizontal $F,V$ maps here are morphisms of the actual crystals.
The finite-flat full-faithfulness statement is
[de Jong, Remark2.4.10](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf),
with the module-with-connection description in Corollary2.2.3 and
Remark2.2.4. Its formal-smoothness and finite-p-basis hypotheses apply
to $\operatorname{Spf}k[[t]]$. Thus the integral matrices and their
inverses yield group isomorphisms. Taking inverse limits of the finite
free Hopf algebras algebraizes these formal morphisms over the complete
ring $R$. No effectiveness assertion for arbitrary truncated matrices
is used.

Markings, determinant conditions and uniqueness are checked generically
on torsion-free Hopf coordinate modules.

## Globalization and the extension quotient

Apply the local result at the completions of all closed points of a
smooth curve. A rational map of finite locally free Hopf algebras whose
entries are regular in every completed local ring is regular on the
curve. This extends a supplied generic comparison globally.

For normalized marked BT2 groups, $\Delta_C=0$ gives the actual
comparison on the ordinary open by the
[Kummer invariant theorem](versal_bt2_extension_quotient.md).
The result just proved extends it over the remaining points.
Therefore $\Delta_C$ is injective on $Q_C$. Nonzero objects may
still differ generically; this proof does not manufacture an isomorphism.
