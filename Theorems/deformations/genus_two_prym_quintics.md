# Prym reconstruction of the actual genus-two Frobenius map

Version5, 19 September2026. The general reconstruction and corrected
cubic dictionary are independently audited. The inverse dictionary
uses the compatible dual theta node; the former lowercase node
described a Richelot neighbor and has been replaced.

Let C be an ordinary smooth projective genus-two curve over an
algebraically closed field of characteristic five. Choose actual
theta coordinates on
\(SU_C(2,\mathcal O_C)=\mathbf P^3\), in which its Kummer boundary is
\[
K(x)=\sum_{i=0}^3x_i^4+2a x_0x_1x_2x_3
 +b(x_0^2x_1^2+x_2^2x_3^2)
 +c(x_0^2x_2^2+x_1^2x_3^2)
 +d(x_0^2x_3^2+x_1^2x_2^2).
\]
The source coordinates are the coefficient Frobenius twist of these
coordinates, so its Kummer equation is \(K^{(5)}\). The parameters
satisfy \(a^2-b^2-c^2-d^2+bcd+4=0\) and the smooth Hudson-chart
inequalities. Put \((u_1,u_2,u_3)=(b,c,d)\), and define
\[
\begin{split}
V_0={}&x_0^5+
 \sum_{i=1}^3\bigl(u_i(u_i^2+2)x_0^3x_i^2
                        +(u_i^2+2)x_0x_i^4\bigr)\\
 &+\sum_{\{i,j,\ell\}=\{1,2,3\},\ i<j}
 \bigl(3u_\ell(a^2+u_\ell^2)+u_i u_j(1-u_\ell^2)\bigr)
 x_0x_i^2x_j^2\\
 &+a(2a^2+2-bcd)x_0^2x_1x_2x_3
 +a\sum_{\{i,j,\ell\}=\{1,2,3\},\ j<\ell}
 (u_i+3u_j u_\ell)x_i^3x_jx_\ell.
\end{split}
\]
For \(i\in(\mathbf Z/2)^2=\{0,1,2,3\}\), put
\(V_i(x)=V_0((x_{j+i})_{j=0}^3)\), with binary addition of labels.
Then
\[
[V_0:V_1:V_2:V_3]:SU_{C^{(1)}}(2,\mathcal O)
 \dashrightarrow SU_C(2,\mathcal O)
\]
is the actual relative Frobenius pullback map. No unspecified
generality condition on C remains, and no ordinariness assumption
on its elliptic Pryms is needed. The tuple is primitive; its
common zero set is exactly the locus of bundles with unstable
Frobenius pullback.

For EVERY ordinary smooth C in this statement, there is also a
nonzero octic H, unique up to sign after normalization, such that
\[
K(V_0,V_1,V_2,V_3)=K^{(5)}(x)H(x)^2.
\]
At every stable base point of V, H vanishes to order at least two.
On the stable locus where V is defined, H=0 is precisely the
condition that the first pullback is strictly semistable. No
irreducibility or reducedness of this octic is asserted at special
ordinary curves. Its projective class varies regularly with C.

The reconstruction uses only the thirty actual Prym lines. Every
quintic is determined by its restrictions to those lines, their
intersection graph is connected, and each restriction is a nonzero
scalar multiple of the actual elliptic Verschiebung. This also gives
an independent finite certificate for a proposed quintic presentation.

Both chosen endpoints are ordinary. The corrected dual-node
construction supplies an actual frame for the cubic backup
\(\alpha^3+\alpha+1=0\), verified independently by reconstructing
the six branch points from a trope conic. Its Hudson coefficients
lie in F125; its displayed theta frame lies in F_(5^12).
No large-field coordinate computation for the main endpoint is asserted.

Successive absolute pullbacks require the coefficient twists:
\[
x\longmapsto V_K\circ V_K^{(5)}\circ\cdots\circ
 V_K^{(5^{h-1})}(x^{[5^h]}).
\]
The intermediate maps must all be defined. This theorem identifies
the map; it does not establish a fourth-height or all-height
semistability result, or exclude a common cover.
