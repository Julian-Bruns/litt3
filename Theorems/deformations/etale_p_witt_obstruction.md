# Free deck summands control higher-Hodge and actual BT repair

Version2,3 October2026. Let $h:T\to C$ be an ACTUAL connected finite
etale Galois cover of smooth proper hyperbolic curves over
$k=\overline{\mathbf F}_5$, with five-group $P$ of order $q$.
Pull back the admissible active oper and its ENTIRE specified
previous-flow datum. At any reached level use the
[intrinsic higher-Hodge obstruction](../../Definitions/witt_hodge_obstruction.md).
Put
\[
R=k[P],\quad D_C=\operatorname{coker}\Psi_C,\quad
D_T=\operatorname{coker}\Psi_T,\quad
d_C=\dim D_C,\quad d_T=\dim D_T,
\]
retaining relative Frobenius twists when linearizing $\Psi$.

$D_T$ needs exactly $d_C$ generators over $R$, and
\[
\operatorname{rank}_k(h^*:D_C\to D_T)
=\#\{\text{free }R\text{-summands of }D_T\}.
\tag{1}
\]
Thus $d_C\le d_T\le qd_C$, and
\[
h^*\text{ injective}
\quad\Longleftrightarrow\quad
D_T\simeq R^{d_C}
\quad\Longleftrightarrow\quad d_T=qd_C.
\tag{2}
\]
For cyclic $P$, writing $R=k[\varepsilon]/(\varepsilon^q)$ gives
$D_T=\bigoplus_{i=1}^{d_C}R/(\varepsilon^{l_i})$, with
$1\le l_i\le q$, $d_T=\sum_i l_i$ and pullback rank
$\#\{i:l_i=q\}$.

When $d_C=1$ and the reached-level obstruction $\epsilon_C\ne0$,
\[
h^*\epsilon_C\ne0\ \Longleftrightarrow\ d_T=q,\qquad
h^*\epsilon_C=0\ \Longleftrightarrow\ d_T<q.
\tag{3}
\]
For larger $d_C$, submaximal growth kills SOME classes; it need
not kill a particular supplied class.

For paired actual BT$_N$/periodic data, the
[all-height dictionary](all_height_bt_hodge_dictionary.md) transfers
these statements to the actual NEXT-level existence obstruction.
Here $d_C,d_T$ are the corresponding Cartier defects. It preserves
the paired predecessor and does not equate arbitrary upper objects.

## Six minimal repairs of the explicit genus-two example

Take the exact $\mathbf F_{625}$ pair $(C,r,t)$ of
[the nonzero higher-Witt example](explicit_genus_two_witt_obstruction.md),
with $t^4+4t^3+t^2+4t+3=0$. It has ordinary Jacobian, indigenous
defect one and a nonsplit canonical double. There are exactly SIX
geometric connected cyclic-five covers $T\to C$. Each has genus six,
$d_T=2$ and $\epsilon_T=0$. Its canonical $T_2$ therefore has a
$W_3$ lift with the original Hodge line. NO repaired lift extends
the original map $T_2\to C_2$ to any marked $C_3$ above that
canonical $C_2$.

Choose ANY of the $4^4=256$ actual BT1 realizations $H/C$ of this
oper, retaining its corrected first periodic datum. Then:

- $H$ has NO BT2 extension, even without determinant normalization.
- EVERY one of the six covers has an actual BT2 extending $h^*H$.
  Its normalized marked extension classes form a torsor under a
  two-dimensional Cartier space.
- No prime-to-five etale cover repairs this missing level. The
  smallest possible repair degree is five.
- For ANY finite-field model of $h^*H$ over $\mathbf F_Q$, its
  normalized marked BT2 classes already exist over that SAME field
  and number exactly $Q^2$.

For the base certificate's $\phi$ and normalized comparison $J$,
\[
\langle J(e(H)),\phi\rangle
=2(4+4t)^{-1}=1+3t+3t^2+t^3\ne0.
\]
All these conclusions hold for the $256$ realizations; their finite
characters lift by Teichmuller transport. The exact covers and
coefficients remain certified. No full group on these six curves,
second endpoint map or common-cover counterexample is asserted.
The unmarked common-cover problem remains unsolved.

[Proof and exact certificates](../../Proofs/deformations/etale_p_witt_obstruction.md).
