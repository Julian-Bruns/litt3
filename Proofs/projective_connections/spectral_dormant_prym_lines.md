# Proof: spectral line attached to a dormant pair

[Statement](../../Theorems/projective_connections/spectral_dormant_prym_lines.md).
Author /root, 2026-09-08; global proof and exact symbolic checks, not an
independent audit. The BNR correspondence is cited below; the explicit
Frobenius-trivial five-torsion line is the additional construction here.
Version4 improvement,2026-10-03: construct that line first by Cartier
descent, so its existence no longer depends on smoothness of the
unnormalized spectral curve.

## 1. A horizontal matrix with no denominators

In a local separating coordinate t put J=J^1(omega_C^2) and
M_s=[[0,1],[s,0]], so horizontal columns satisfy w'=M_s w. Subtracting
the two dormant equations gives

    q''=s q+3q^2,  q=r-s.

Set Phi as in the statement. Direct multiplication and differentiation
give

    Phi'=M_s Phi-Phi M_s,  Phi^2=2q^5 I,  trace(Phi)=0.        (1)

For x=x(t), u=x', quadratic jets transform by

    T=[[u^2,0],[2uu',u^3]],
    q_t=u^2 q_x,  (q_t)'=u^3(q_x)'+2uu' q_x.

Substitution in the polynomial matrix gives

    Phi_t=u^5 T Phi_x T^(-1).                              (2)

Thus Phi is a regular global morphism J->J tensor omega_C^5. Its
horizontality in (1) is with respect to the canonical connection on
omega_C^5, whose coordinate frame (dt)^5 is horizontal. Cartier descent
of (1)--(2) gives theta:V_s->V_s tensor omega_(C^(1)). Its characteristic
identity descends to theta^2=2q^(1)I: F_C^*q^(1) has coefficient q^5.
This is a twist identity, not an unlabelled coefficientwise fifth root.

The determinant of J is omega_C^5, and the trace of M_s is zero.
The determinant connection is therefore precisely this canonical
connection, not an arbitrary connection on the same line. Cartier
descent proves det V_s=omega_(C^(1)), not just equality of degrees.

## 2. The intrinsic line on every normalized root

Normalize the quadratic root \(a^2=2q\), allowing two components if
the root splits. The form \(\eta=a\,dt\) is coordinate independent.
Above a zero of q of order m, an even m gives two unramified points
and \(\operatorname{ord}(\eta)=m/2\). An odd m gives one ramified
point: a has order m and dt order one, so eta has order m+1.
Thus eta is holomorphic and nonzero on every component. The connected
case has genus \(2g-1+B/2\) by Riemann–Hurwitz, with B the number
of odd-order zeros.

The [Cartier-secant identity](cartier_dormant_secants.md#1-intrinsic-potentials-and-exact-cartier-identities)
gives \(C_1(\sigma^3)=\sigma\) for \(\sigma=q/2\), including
rational roots on each split component. Since \(2q=4\sigma\) and
4 is fixed by Cartier semilinearity, it also gives
\(C_1((2q)^3)=2q\). The root-form identity in that proof is
\(C_1((2q)^3)=aC(\eta)\,dt\); hence \(C(\eta)=\eta\).

The rank-one Cartier criterion and Cartier descent now define N
from \((\mathcal O_\Sigma,d+\eta)\), with
\(F_\Sigma^*N\simeq\mathcal O_\Sigma\) carrying that connection.
Descent respects tensor products, and the fifth tensor power has
connection \(d+5\eta=d\). Therefore \(N^5\simeq\mathcal O\).
On each projective connected component, triviality of N would supply
a nowhere-zero horizontal function. It would be a nonzero constant,
contradicting eta nonzero. Thus N has exact order five on each component.
Cartier descent also proves uniqueness of the line with this specified
connection and trivialization.

The deck involution sends eta to -eta, so \(\tau^*N=N^{-1}\).
For the finite flat degree-two normalization map,
\(\pi_1^*\operatorname{Nm}(N)=N\otimes\tau^*N=\mathcal O\).
Its pullback kernel is killed by two, whereas \(\operatorname{Nm}(N)\)
is killed by five. Hence the norm is trivial, including in the split
case. Reversing a sends N to its inverse. Swapping r and s identifies
the new root by \(a_{\rm new}=2a\), since \(2^2=-1\) in
characteristic five; it sends eta to 2eta and N to \(N^2\).

## 3. The normalized BNR line and its exact correction

Apply [Groechenig, Theorem3.2, pp.9–10](https://arxiv.org/pdf/1201.0741#page=9)
to \((V_s,\theta)\) on \(C^{(1)}\). It gives a sheaf
\(\mathcal L\) on the spectral curve with pushforward V_s.
The curve is reduced and its generic Higgs eigenvalues are distinct,
so this sheaf has rank one on each component and no zero-dimensional
torsion. Its pullback modulo torsion is a line \(\widetilde L\)
on the normalization.

The eigen-quotient and its two identities are
\[
\ell=(2a^3-q',q),\qquad \ell\Phi=a^5\ell,                 \tag{3}
\]
\[
\ell_t=u^5\ell_xT^{-1},\qquad \ell'+\ell M_s=-a\ell.     \tag{6}
\]
These follow from \(a'=q'/a\) and the secant equation. The
[regularity criterion](cartier_dormant_secants.md#2-regularity-is-an-exact-condition-not-an-omitted-infinity-test)
forces each zero order m to be 0 or 1 modulo five. At a point of the
normalization with ramification index e, the row's vanishing order is
e m if m is 0 modulo five, and e(m-1) if m is 1 modulo five. Indeed,
q is the second entry; in the latter case q' has strictly lower order
than either q or \(a^3\), while in the former neither first-entry
term has lower order than q. Thus the common vanishing divisor is
\(D=5\pi^*T\), with \(T=\sum_x\lfloor m_x/5\rfloor x\).
Saturating the row gives an everywhere surjective horizontal map
\[
\pi^*J\longrightarrow\pi^*\omega_C^5(-D),
\]
where the target has its canonical connection plus eta. Locally D
has a fifth-power equation, whose logarithmic derivative vanishes,
so saturation preserves the connection identity. Section2 identifies
the target with the Cartier pullback of
\(N\otimes\pi_1^*(\omega_{C^{(1)}}(-T^{(1)}))\).
Cartier descent gives a surjection onto this line from
\(\pi_1^*V_s\). It and the normalized BNR evaluation onto
\(\widetilde L\) have the same generic eigen-quotient on each
component. Their kernels are saturated subbundles of the same bundle
on a smooth curve, hence equal. Consequently
\[
\widetilde L=N\otimes\pi_1^*(\omega_{C^{(1)}}(-T^{(1)})).
\]

The adjunction map embeds V_s in \(\pi_{1*}\widetilde L\): it
is a generic isomorphism and V_s is torsion free. The cokernel is
finite length. Since
\(\deg\widetilde L=4g-4-2\deg T\),
\(\chi(\mathcal O_\Sigma)=2(1-g)-B/2\), and \(\chi(V_s)=0\),
its length is
\[
2g-2-B/2-2\deg T
=\sum_x\bigl(\lfloor m_x/2\rfloor-2\lfloor m_x/5\rfloor\bigr).
\]
This Euler-characteristic calculation also covers a split root.
If q has simple zeros, T=0 and the cokernel vanishes; the root is
connected and smooth already before normalization. Then
\(g(\Sigma)=4g-3\), \(\operatorname{div}(\eta)=2R\), and the
old smooth spectral-line assertion follows immediately.

## 4. Both actual legs, and the remaining boundary

Normalization of the root commutes with etale base change: the base
change of the smooth normalization is smooth and is the normalization
of the pulled-back root. Its form and Cartier line therefore pull back,
including along covers of degree divisible by five or non-Galois covers.
The zero multiplicities, correction divisor T and saturated
eigen-quotient pull back as well, giving the normalized BNR line.

If r_X,s_X and r_Y,s_Y actually agree through X<-Z->Y, their differences
are the same quadratic on Z. Its normalized root is simultaneously
Z times_X Sigma_X and Z times_Y Sigma_Y. Both projections are finite
etale base changes of the ORIGINAL maps. Each connected component is
a single actual common source for its two endpoint components, and
both preserve the form and line. In the simple-zero case the roots
are connected and the spectral endpoint maps to X,Y are ramified
doubles.

The exact identities (1), (2), (3), and (6), including the quotient
transition formula, are checked by the augmented existing
[Cartier secant checker](../../scripts/connections/check_cartier_dormant_secants.sage).
No new point-enumeration algorithm is needed.

## 5. Two failed universal shortcuts

The existing [genus-seventeen Hecke counterexample](../examples/igusa_hecke_correspondences.md)
also tests the present, stronger construction. In its notation the
ramified double P->C has a deck-anti-invariant Cartier-fixed form alpha
with div(alpha)=2D. Its square descends to a quadratic s on the genus-five
C. At each branch point the pullback order is 4=2 ord(s)+2, so s has
a simple zero. The Cartier-secant dictionary therefore gives two distinct
REGULAR dormant connections on C. The actual coreless Hecke spans in
that construction preserve both connections. Thus adding a compatible
second dormant connection and its spectral five-torsion line does not
repair a universal core criterion. The obstruction sought here must use
additional endpoint information. This corollary is an author deduction
from the retained audited construction, not an extension of its audit.

There is also an elementary obstruction to using only affine relative
Sym^3 invariants. In cubic-moment coordinates the jet comparison is

    Q_r=[[1,0,0,0],[0,3,0,0],[3r,0,1,0],[3r',r,0,1]],
    Q_s^(-1)Q_r=I+3q E20+3q' E30+q E31.

The latter is symplectic for J03=1,J12=2. Conjugation by
diag(z^(-3),z^(-1),z,z^3), a cocharacter of Sym^3(SL2), multiplies
its three off-diagonal entries by z^4,z^6,z^4. It therefore tends to
I at z=0. Every REGULAR left/right Sym^3(SL2)-invariant function has
the same value here as at I. This proves neither equality of actual
double orbits nor constancy of rational invariants with poles at I.
All displayed matrix identities are checked in the existing secant script.

## 6. Genus-two ordinarity from dormant tangents

Put a=(r−s)/2 and r0=(r+s)/2. The
[Cartier-secant dictionary](cartier_dormant_secants.md) gives
C_1(a³)=a and zero orders congruent to0 or1 modulo5. In genus two
deg div(a)=4, so all four zeros are simple. Choose a Weierstrass point
as infinity and write a=P(u)(du/v)², v²=F(u), deg F=5. Its order at
infinity is4−2deg P, which is even and at most one, hence zero.
Thus deg P=2; simple zeros also force P squarefree and coprime to F.

The [hyperelliptic root quotient](../cartier_and_spin/hyperelliptic_root_quotients.md)
now gives an etale double onto E0:z²=FP and the descended form P du/z.
The spectral convention uses q=r−s=2a and b²=2q=4a, so E:w²=2AF,
A=2P, is E0 under w=2z. Its form is eta_E=2A du/w, of divisor type(2,2).
This supplies the geometry and marked form without pairwise tests.

For a regular quadratic xi, the
[linearized-curvature factorization](etale_double_dormant_pairs.md) gives

    T_nil(r0)=ker(xi↦D^4(a²xi))=ker(xi↦C_1(a²xi)),
    T_nil(r0)=T_dorm(r) direct-sum T_dorm(s).

On the root double, division of the pulled-back xi by the root form
identifies regular quadratics with the E0-character space of regular
one-forms. Explicitly, xi=Q(u)(du/v)² maps to Q(u)du/z, deg Q<=2.
Cartier's projection formula identifies the displayed kernel with
ker Cartier on E0, as in the root-quotient proof. Hence

    a(E)=dim T_dorm(r)+dim T_dorm(s).

The [genus-two dormant scheme](genus_two_dormant_quintic.md) has length
five, so a point is reduced exactly when its tangent is zero. Its
family resultant Res(Psi,Psi')=−[t(t−1)(t−2)(t−3)]² is nonzero at every
smooth parameter. All ten quotients in that family are therefore ordinary.
The tangent/Cartier identification received a bounded independent check
by /root/audit_secant_cartier_dimension,2026-09-13; this is not an audit
of the general spectral-line construction.

For the cubic backup, the quintic roots are z_i=z^(125^i), i modulo5.
Its explicit models use

    A_ij=(z_i−z_j)u²+(W(z_i)−W(z_j))u+V(z_i)−V(z_j), i<j,

with W,V from the quintic theorem. The
[original packet](../../../litt3-computation-data/legacy_workspace_computations/backup_genus_two_secant_curves.json)
and [generator](../../scripts/genus_two/backup_genus_two_secant_curves.sage)
retain the field moduli, all ten models and marked Cartier matrices.
They independently verify the forms and ordinarity now proved uniformly.
F125-Frobenius has two orbits on unordered pairs, represented by(0,1)
and(0,2). Reversal negates A; w↦2w identifies the curves and scales the
marked form by2. This describes coefficient symmetry, not all genus-three
isomorphisms.
