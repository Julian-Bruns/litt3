# Proof of the original Gram-four quotient relation pencil

Version1, 3 October2026. Retain the exact original-source and EXTRA
SAME-sector integral GramFOUR relation hypotheses in the
[statement](../../../Theorems/quotient_geometry/local_actions/canonical_ten_full_psl_eight_gram_four_relation_pencil.md).
The [source/scalar](../../../Research/notes/oct03_ten_hour/eight_module_actual_gram_four_relation_source_audit.md)
and [coarse/mixed-flag](../../../Research/notes/oct03_ten_hour/eight_module_actual_gram_four_relation_coarse_flag_audit.md)
audits have scoped PASS and pin the unchanged
[author note](../../../Research/notes/oct03_ten_hour/eight_module_actual_gram_four_relation_pencil.md).
No computation or prior certificate replay is used.

## The ORIGINAL relation has the full corrected descent

Let \(H\) be the original labeled determinant lift, \(H_N\) the
inverse image of the actual kernel \(N\), and
\(\chi:H_N\to\mu_4\) its scalar matrix character. The registered
[source proof](canonical_ten_source_half_class_and_full_linear_kernel_constraints.md)
fixes this FULL character, the precise square-line correction and
the full original adjunction transport.

The scalar \(H_N\)-transport on \(W_8\) and its invariant kernel
\(\mathcal R\) is canceled by \(\chi^{-1}\).
The corrected \(M^2\)-transport is multiplied by \(\chi\);
its cube corrects \(M^6\) by \(\chi^3=\chi^{-1}\), which the
registered full adjunction comparison identifies with the SAME
original row correction. Thus the corrections on \(\mathcal R\)
and \(M^6\) agree for ALL of \(H_N\), not merely its central subgroup.
They cancel in the native ratio \(\mathcal R M^{-6}\).
That ratio retains exactly the canonical \(\omega_\Gamma^{-3}\)
transport. Conjugation preserves \(\chi\), so the corrected
inclusion descends compatibly with the full labeled action.

Effective descent along the existing étale \(\pi:\Gamma\to D\)
sends the constant source to \(W\mathcal O_D\), with the natural
\(H_0\)-action, and \(M^6\) to the accepted SAME \(P^3\).
It sends the canonical line to \(\omega_D\). Hence the ORIGINAL
relation descends to
\[
\mathcal R_D=P^3\omega_D^{-3}=P^{-9}
 \hookrightarrow W\mathcal O_D.
\]
The equality uses the specified SAME-action \(P^4=\omega_D\).
Both sides have central character \(\zeta\), since
\(P^{-9}\) has character \(\zeta^9=\zeta\).
The kernel of \(H\to H_0\) acts trivially after this descent;
there is no residual kernel character.

Tensoring with \(P^9\) gives the genuine ORIGINAL section \(\rho\)
of \(P^9W=E\omega^2\). Its coordinate row is base-point-free:
the original relation was a subbundle of the integral source, and
faithful finite étale descent preserves that property.
The literal \(\mathbf F_5\) convention and accepted exact
coefficient-Frobenius comparison are retained throughout.
An invariant section here is an intertwiner from \(W^*\) into
\(H^0(D,P^9)\); it is not the original adjoint intertwiner from
\(W\) into \(H^0(C,\phi_C^*P^3)\).

## Exact coarse modification, without wild exactness

The accepted
[natural-root flag theorem](actual_psl_eight_root_frobenius_flags_and_wild_constraints.md)
gives \(F=\pi_{0*}E=\mathcal O\oplus\mathcal O(-1)^7\), with
\(H^1(F)=0\). The genuine section \(t_2\) of \(\omega^2\)
has precisely reduced wild divisor \(D_5\).
We calculate the actual image of multiplication by \(t_2\) on
coarse invariant lattices, rather than asserting their exactness
for an arbitrary wild sequence.

Use \(g(t)=t/(1+t)\), \(u=t^5/(1-t^4)\), and invariant rational
\(r_0=(du)^{1/4}\). A rational chain basis of the exact natural
lattice has invariant vectors \(\exp(-t^{-1}N)e_j\), and its
coarse exponents for \(P\) are
\[
q_j=\lceil(j-2)/5\rceil.
\]
For \(P^9\), the corresponding exponents are
\(q'_j=\lceil(j-18)/5\rceil\).
Up to an invariant unit, \(t_2=(du)^2/u^3\).
Consequently the first basis is sent to coarse exponent \(q_j-3\)
relative to the invariant frame \(r_0^9\) of the target.
For the possible chain indices zero through four the arrays are
\[
(q_j)=(0,0,0,1,1),\qquad(q'_j)=(-3,-3,-3,-3,-2).
\]
Their sole difference is one unit of \(u\) at index THREE.
Each block of length at least FOUR therefore contributes exactly
one length-one coarse quotient. No other index contributes.
The genuine \(t_2\) is a unit at the tame and ordinary loci.
This proves the exact coarse sequence in the statement with
\(r=1\) or TWO.

Its coarse cohomology gives \(h^0(E\omega^2)=1+r\), since
\(H^1(F)=0\). In a regular scalar \(P^9\)-frame, the minimum
valuations of the five local basis vectors are respectively
\[
(3,2,1,0,4).
\]
Only chain index THREE has nonzero wild value, in its block socle.
Its value is the quotient coefficient just computed.
The global evaluation map is therefore onto the long socle in
the length-five case or the entire two-socle plane in the length-four
case, with kernel \(k t_2\sigma\).

A nonzero genuine section in this space gives an injective natural
intertwiner by irreducibility. Its common coordinate base divisor
is invariant of degree at most \(\deg P^9=9|Q|/40\).
If its wild value is nonzero, that divisor omits the only orbit
below this bound; every other orbit has size at least \(|Q|/2\).
It is empty. In particular the ORIGINAL base-point-free \(\rho\)
cannot lie in \(k t_2\sigma\).

## The mixed flag is exact

The two columns define the genuine map
\(\Psi:\mathcal O\oplus\omega^{-2}\to E\).
If they were generically dependent, the everywhere nonzero section
\(\sigma\) would force their scalar ratio to be a global regular
section of \(\omega^2\), hence a multiple of \(t_2\), a contradiction.
Let \(R_{\sigma\rho}\) be its saturation and \(Z\) its determinant
zero divisor. Its twist by \(P^{-1}\) is a subbundle of the
constant \(W\); the determinant degree bound gives
\[
\deg Z\le2\deg\omega+2\deg P=|Q|/4.
\]
The invariant divisor is consequently zero or one copy of \(D_5\).

For \(J_5\oplus J_3\), the relation's wild value is in the
rational long socle, whereas \(\sigma\)'s two socle coefficients
are nonzero. They are independent. Hence \(Z=0\), giving the
everywhere subbundle \(\mathcal O\oplus\omega^{-2}\).
For \(J_4\oplus J_4\), independent wild values give the same result.

If the latter values are proportional, choose compatible regular
scalar frames and write \(\rho(0)=c\sigma(0)\), \(c\ne0\).
The accepted natural lattice has first chain-level coefficient
\(-2\) times its socle coefficient. The relation's surviving
index-three basis has expansion
\[
t^{18}u^{-3}\exp(-t^{-1}N)e_3
=-e_0/6+t e_1/2-t^2e_2+t^3e_3+O(t^4).
\]
Its chain-one/value ratio is \(-3=2\) in characteristic five.
All other basis terms add only socle vectors to the linear coefficient.
Thus \(\rho-c\sigma\) has linear coefficient modulo socles
equal to \(4c\) times the nonzero chain-one direction, transverse
to its common value. The minimum two-minor order is exactly ONE.
The orbit bound now forces \(Z=D_5\), and the saturated determinant
is \(\omega^{-2}(D_5)=\mathcal O\).

The everywhere section \(\sigma\) is a subbundle of this saturation,
whose quotient is the genuine line \(\mathcal O\).
If that extension split, its injection into \(E\) would supply two
independent global sections. This contradicts the accepted \(h^0(E)=1\).
It is therefore genuinely nonsplit. No claim of horizontality follows.

The conclusions concern the original relation with its additional
source antecedents. They provide neither primitive source existence
nor native-kernel identity. BOTH original actual finite étale endpoint
maps remain on their SAME \(T\); neither descends in this argument.
