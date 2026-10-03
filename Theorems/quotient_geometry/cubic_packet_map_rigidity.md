# A missing cubic eigenspace forces actual equivariance

Version2,3 October2026. The general three-graph theorem now supplies
the common trace-budget argument. Let X be a smooth proper curve of genus g>4,
with geometrically simple Jacobian and number-field endomorphism
algebra K. Suppose gamma is an automorphism of order three whose
quotient is rational. Let T be smooth proper, sigma an automorphism
of order three, and h:T->X nonconstant separable of degree M.

The X-isotypic part of J(T) is a K-space up to isogeny. Write zeta
for gamma^* in K. If the actual pullback h^* has zero projection to
at least one of the three sigma-eigenspaces 1,zeta,zeta^2, then
\[
\boxed{h\circ\sigma=\gamma^j\circ h\quad\text{for some }j\in\{0,1,2\}.}
\tag{1}
\]
No etaleness of h or freeness of sigma is needed for this criterion.

More quantitatively, if (1) fails, let v_i be the three orthogonal
components of h^*, and put
\[
s_i=\frac{\operatorname{Tr}(v_i^\dagger v_i\mid H^1(J(X),\mathbf Q_\ell))}{2M}.
\]
Then
\[
\frac{g-4}{3}\le s_i\le\frac{g+2}{3},\qquad
\sum_i s_i=g.\tag{2}
\]
These constraints use intersection with the three ACTUAL graphs
of gamma, rather than a character-dimension count alone.

## The fixed degree-three consequence

For the fixed genus-nine X, every connected cyclic etale cover
pi:T->X of degree THREE has the following rigidity:
\[
\boxed{v:T\to X\text{ nonconstant separable}
\quad\Longrightarrow\quad v=\alpha\pi,\quad\alpha\in\operatorname{Aut}(X).}
\tag{3}
\]
The exact additional finite input is that the UNWEIGHTED eleven-point
branch set of x:X->P1 has trivial geometric PGL2 stabilizer. This is
stronger than Aut(X)=C3 and was checked separately.

Consequently the original C3 deck group is normal in Aut(T), whose
order is three or nine. Every etale Galois quotient of T has genus
nine or twenty-five. A non-Galois genus-two quotient, higher cyclic
three-powers and unrestricted common covers are NOT excluded here.

[Proof and exact branch-set certificate](../../Proofs/quotient_geometry/cubic_packet_map_rigidity.md).
