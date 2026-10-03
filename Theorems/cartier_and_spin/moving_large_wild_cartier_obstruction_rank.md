# Exact Cartier obstruction rank on the moving large-wild pencil

Version1,3 October2026. Pending independent review. Let k be algebraically closed of characteristic FIVE, let Y be the smooth genus-two curve y²=Φ(w)=w⁵+qw⁴+h with qh≠0, let P be its unique point at infinity, and put σ=dw/y. For a∈k with a²≠h, take the reduced pole-seven function F=w(y+a). These are precisely the moving-origin low functions retained by the [selected-origin inventory](selected_genus_two_cubic_cartier_pencil_inventory.md).

The inverse-Frobenius semilinear map
\[
\mathcal C_F:L(6P)=\langle1,w,w^2,w^3,y\rangle\longrightarrow H^0(Y,\omega_Y(5P)),\qquad u\longmapsto C(uF^3\sigma)
\]
has rank THREE if a=0 and rank FOUR if a≠0. Consequently the global small-Cartier obstruction space has dimension THREE at the pure-odd member and dimension TWO at every other admissible member. Its class need not be nonzero: this theorem determines the image, not the value of the actual carrier's obstruction.

More explicitly, use the target basis σ,wσ,w²σ,w³σ,yσ,wyσ. Raise all matrix entries to their fifth powers, which preserves rank. The constant column is ZERO, and the remaining columns, in order w,w²,w³,y, are
\[
\begin{pmatrix}
a h^2(a^2+3h)&0&0&0\\
a h(2a^2+4h)&q a h(2a^2+4h)&0&0\\
a(a^2+4h)&qa(2a^2+3h)&q^2a(a^2+4h)&0\\
3a&4aq&4aq^2&q^4\\
h+3a^2&0&0&0\\
1&q&0&0
\end{pmatrix}.
\]
This supplies an explicit test for the obstruction class from [the small Cartier reduction](large_wild_small_cartier_obstruction.md). In an actual degree7000 or degree21000 carrier both original finite étale maps remain on the SAME T. No carrier existence, moving-pencil exclusion, or solution of the common-cover problem is inferred.

[Proof](../../Proofs/cartier_and_spin/moving_large_wild_cartier_obstruction_rank.md).
