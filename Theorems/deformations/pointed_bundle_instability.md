# Common slope rigidity and pointed Frobenius instability

Version8,3 October2026. The stronger common slope-rigidity foundation
replaces the separate finite-projective pointed proof. The pointed-oper and curve-deformation
assertions hold in every odd characteristic; the active-spectrum
application in Part4 remains in characteristic five.

## Common slope rigidity and pointed bundles

Over k=bar(F_p), let X<-Z->Y be a coreless finite etale span of smooth
projective connected curves of genus at least two.
Every nonzero compatible locally free quotient or saturated subbundle of
an ACTUAL common strongly semistable bundle has the same endpoint
slopes and is strongly semistable. The same holds for actual
morphism images as quotients, before saturation in their target.
This works in every rank and at every slope.

For matching nonzero sections of a positive strongly semistable
common bundle, their saturated image is a common line of that
slope. Its common zero divisors have degree $\mu(E_C)$;
in particular the slopes are integers and a clump is forced.
A nowhere-zero matching section is therefore impossible.

Let E_X,E_Y be positive-degree vector bundles with nowhere-zero sections, and let an
isomorphism of their actual pullbacks identify those sections. Then
neither bundle is strongly semistable. This holds in every rank; the
rank-one case is vacuous. It does not assert a clump in arbitrary rank.

## A transverse destabilizing line determines the oper

Let k be algebraically closed of odd characteristic p, and let P>0
be divisible by p. On an actual coreless bi-etale span with g(Y)=2,
suppose matching nonsplit pointed extensions

    0→O_i --e_i→E_i→omega_i^P→0

have matching regular connections with nabla(e_i)=0 and the canonical
determinant connection. If the bundles are unstable and their maximal
lines N_i are not horizontal, then

    N_i²≅omega_i^(P+1),    Q_i²≅omega_i^(P−1), Q_i=E_i/N_i.

Their second fundamental maps are isomorphisms. The projections of N_i
to omega_i^P have nonempty reduced divisors Delta_i, with equal actual
pullbacks and |Delta_i|=(P−1)(g(C_i)−1). Projection of e_i to Q_i and
squaring give matching tensors sigma_i with divisor 2Delta_i.

The induced projective connections are the intrinsic r_s of the
primitive shared tensor s. If sigma=c s^j, then
j divides gcd(2,P−1), and the primitive (weight,zero order) is
((P−1)/j,2/j). No dormancy assumption is needed for this calculation.

## Shared curve deformations in odd characteristic

Let k=bar(F_p), p odd, and let X<-f-Z-g->Y be an ACTUAL coreless finite etale
span of smooth projective connected curves of genus at least two. Set

    H^1(T)=f*H^1(X,T_X) intersect g*H^1(Y,T_Y) in H^1(Z,T_Z),
    T=Ω^(-1).

Use the [pointed extension conventions](../../Definitions/marked_curve_deformations.md).
Then:

1. H^1(T)!=0 implies that the span has a nonempty clump. In particular,
   a no-clump span is infinitesimally rigid: H^1(T)=0.

2. If g(Y)=2 and H^1(T)!=0, the two endpoints have regular dormant
   projective connections with equal ACTUAL pullbacks to Z. For each
   nonzero shared tangent class, its two extension bundles E_i are
   semistable but not strongly semistable. Their common first
   Frobenius-destabilization index n is finite and >=1. At that stage
   the maximal lines N_i have

       deg N_i=(p^n+1)(g(C_i)-1),
       N_i²=omega_i^(p^n+1).

   Their second fundamental maps for the canonical Frobenius connections
   are everywhere isomorphisms; these are the matched dormant opers.
   Projection N_i→omega_i^(p^n) has a nonempty REDUCED zero divisor Delta_i,
   with equal pullbacks. In particular |Delta_Y|=p^n-1 and
   |Delta_X|=(p^n-1)(g(X)-1); there is no additional multiplicity parameter.

3. Under the hypotheses of part2, the constructed dormant connection is
   the INTRINSIC r_s of the primitive common tensor s. The distinguished
   horizontal section projects to q_i in E_i^(n)/N_i; the second
   fundamental isomorphism gives q_i² a shared tensor of weightp^n-1.
   Its scalar expression u² yields r=u''/u=r_s.
   Since q_i has simple zeros, the primitive generator has precisely

       (weight, zero order) = ((p^n-1)/2,1) or (p^n-1,2).

4. In characteristic five, every span with a shared active nilpotent connection
   and a genus-two endpoint has H^1(T)=0. This includes all85 active
   choices on the current Y, even when both canonical doubles split:
   r_s is then the ACTIVE midpoint, not either dormant companion.
   A possibly nonrigid span must instead have a positive generator
   whose intrinsic connection is regular and dormant.

5. Under the hypotheses of part2, put P=p^n. Two distinct branches
   with equal tangent of an actual joint image preserving the pointed
   extensions have intersection order

       I=0 mod P away from Delta_X times Delta_Y;
       I=2 mod P over Delta_X times Delta_Y.

   In particular off-clump tangencies have order at least P.
   The same assertion applies to reduced unions of such preserving
   images and hence to the relation generated by the original span.
   Contact2 at the clump is NOT excluded, so this does not itself force
   a core by the existing contact-budget theorem.

For the stronger Witt-lifting consequences, see
[two_leg_negative_extensions](two_leg_negative_extensions.md).
These deformation restrictions do not exclude a span.

[Proof](../../Proofs/deformations/pointed_bundle_instability.md).
