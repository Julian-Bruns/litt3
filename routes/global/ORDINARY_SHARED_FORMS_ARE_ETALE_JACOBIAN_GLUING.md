# Shared regular forms detect finite etale Jacobian gluing

Date: 2026-09-06. Status: AUTHOR PROOF, NOT INDEPENDENTLY AUDITED.

This gives an exact description for actual etale spans, followed by a
principally polarized abelian-variety countermodel to iterating degree
divisibility. The countermodel is **not** an etale span of curves.

## Theorem for actual spans

Let k be algebraically closed of characteristic p. Let X <-f- Z -g-> Y
be a finite etale span of smooth connected projective curves, assume
Hom(J_X,J_Y)=0, and assume J_Y ordinary. Put

    W = f^*H^0(X,Omega_X) intersect g^*H^0(Y,Omega_Y),
    phi: J_X x J_Y -> J_Z, (a,b) |-> f^*a + g^*b,
    K = ker(phi),
    I = im(f^*) intersect im(g^*)   (scheme-theoretic intersection).

Then K and I are finite. Their p-primary parts are products of
multiplicative and constant etale group schemes. Writing E=(K_p)_red,

    dim_k W = dim_Fp E[p](k)
            = dim_Fp (I_p)_red[p](k).

Moreover E embeds in each endpoint Jacobian, its exponent divides
gcd(deg f,deg g), and

    dim W <= min(p-rank J_X, p-rank J_Y).

In particular a nonzero shared form detects a nonzero finite etale
p-primary intersection. Cartier is bijective on W. Neither the theorem
nor its proof requires a nonminimal source.

### Proof

Write A=J_X, B=J_Y, T=J_Z. Positive-dimensional intersection of the two
images would, by Poincare complete reducibility, give a common nonzero
isogeny factor of A and B, contradicting Hom(A,B)=0. Thus K and I are
finite.

For an actual finite etale cover, its Picard pullback kernel is the
Cartier dual of the constant maximal abelian intermediate-cover group;
see ETALE_PICARD_PULLBACK_KERNELS_AND_TANGENT_BLINDNESS.md, Theorem 2.1.
In particular its p-primary kernel is multiplicative.

Project K_p to B. Its kernel is (ker f^*)_p, hence multiplicative; its
image is a finite subgroup of the ordinary B, hence a product of
multiplicative and etale groups. The connected part of K_p is therefore
multiplicative: extensions of multiplicative finite groups remain
multiplicative, by Cartier duality and closure of finite etale groups
under extensions. Over a perfect field a finite commutative group is
the product of its connected and reduced subgroups. Hence

    K_p = M x E,   M multiplicative, E constant etale.

Let P=im(phi), factor phi as the isogeny q:A x B -> P followed by the
closed immersion j:P -> T, and dualize. Under the canonical principal
polarizations of the Jacobians, phi^vee is (N_f,N_g). The dual j^vee is
a smooth quotient of abelian varieties. The dual q^vee has kernel
K^D, the Cartier dual of K. Consequently the rank defect of d(phi^vee)
is dim Lie(K^D). The individual norm maps have injective cotangent
pullbacks, namely the usual pullbacks of curve differentials. Thus

    dim W = dim ker((N_f,N_g)^* on invariant differentials)
          = dim Lie(K^D)
          = dim Lie(E^D)
          = dim_Fp E[p](k).

The map K -> I sending (a,b) to f^*a has kernel
ker(f^*) x ker(g^*). Its p-primary kernel is multiplicative. It
therefore induces an isomorphism of the reduced p-primary subgroups,
giving the formula with I.

The projections E -> A and E -> B have trivial kernels because the
individual p-primary pullback kernels are multiplicative. On K the
norm identities and Hom-vanishing give

    [deg f]a = -N_f g^*b = 0,
    [deg g]b = -N_g f^*a = 0.

This proves the exponent bound and the p-rank bound. Finally Cartier
preserves W by functoriality for separable pullback, and is injective
there because it is injective on H^0(Y,Omega_Y). Its restriction to the
finite-dimensional W is therefore bijective. QED.

## Exact obstruction to iterating p-divisibility

For every r>=1 there is a principally polarized abelian-variety model
with Hom-orthogonal ordinary endpoints, scalar norm identities of
degree p^r, smooth individual norms, and a one-dimensional shared
Cartier-bijective differential space.

Take nonisogenous ordinary elliptic curves A,B over k=Fbar_5. Their
p^r-torsion group schemes are both mu_(p^r) x Z/p^r. Choose an
anti-symplectic isomorphism theta:A[p^r] -> B[p^r] for their Weil
pairings, and let H be its graph in A x B. It is maximal isotropic for
the product polarization multiplied by p^r. Therefore

    q:A x B -> C=(A x B)/H

admits a principal polarization lambda_C with

    q^vee lambda_C q = p^r(lambda_A x lambda_B).

This is the usual polarization descent along a maximal isotropic
subgroup; degree counting gives deg(lambda_C)=1. Let i_A,i_B be the
restrictions of q, and let n_A,n_B be their polarized adjoints. The
graph meets each coordinate factor trivially, so both i_A and i_B are
closed immersions. Their duals n_A,n_B are smooth quotient maps. The
displayed polarization identity gives

    n_A i_A=[p^r],  n_B i_B=[p^r],
    n_A i_B=0,      n_B i_A=0.

But (n_A,n_B) is q^vee under the principal polarizations, so its kernel
is H^D, isomorphic to mu_(p^r) x Z/p^r. Its differential has rank
defect exactly one. Thus the individually nonzero pullbacks of the
one-dimensional spaces H^0(A,Omega_A) and H^0(B,Omega_B) coincide in
H^0(C,Omega_C). C is ordinary by isogeny invariance, so Cartier is
bijective on this shared line.

Already r=1 satisfies all these identities with degree divisible by p
but not p^2. Repeated Cartier operations stay in the same shared line;
they do not turn its finite etale gluing group Z/p into Z/p^2. Thus a
proof using only this polarized norm/intersection/p-divisible-group
package cannot iterate the trace divisibility argument. Realizing or
excluding these data through **etale maps of curves**, including the
minimal-source condition, is additional geometry not supplied by the
countermodel.

The prime-to-p degree ratio 3:1 does not remove the countermodel. For
p=5, add an ordinary elliptic factor D and start with the product
polarization of scalar types (3p^r,p^r,3) on A x B x D. Glue A[p^r]
to B[p^r] by an isomorphism with pairing multiplier -3, and glue
A[3] to D[3] by an isomorphism with pairing multiplier -p^r modulo 3.
The two graph subgroups have coprime orders and together are maximal
isotropic. Their quotient is principally polarized. The induced A
and B embeddings have scalar adjoint compositions [3p^r] and [p^r],
and their sum has precisely the p-primary graph as kernel. Hence the
same shared Cartier-bijective line occurs with norm scalars
3p^r,p^r. This still asserts only a principally polarized
abelian-variety model, not an etale curve span.

For the candidate with p-ranks 6 and 25 and degrees 3M,M, the exact
conclusion is that E has generator rank at most 6 and exponent dividing
M. A shared form forces 5|M; the same data do not force 25|M.

Dual-isogeny/Cartier-duality reference: Davide Lombardo, *Abelian
varieties*, Theorem 6.11,
https://math.uni.lu/nt/summerschool2018/Lombardo-AV-notes.pdf.
