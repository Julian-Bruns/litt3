# Shared negative extensions and the first Witt obstruction

Version3,2026-09-13.

Let k=bar(F5) and X<-f-Z-g->Y be an ACTUAL coreless finite etale span
of smooth projective connected hyperbolic curves. For every integer m>=1,
put

    J_m=f*H^1(X,omega_X^(-m)) intersect g*H^1(Y,omega_Y^(-m))
          inside H^1(Z,omega_Z^(-m)).

1. If J_m!=0 for any m>=1, the span has a nonempty clump. Hence
   no-clump spans have J_m=0 for every m>=1.

   For either endpoint C of genus g, if every nonzero
   common extension of omega_C^m by O_C is semistable, then

       dim J_m<=g-1.

   This hypothesis holds automatically when the reduced endpoint clump
   has r>=m(g-1) points. In genus two it gives dim J_m<=1 for1<=m<=r.

   For g(Y)=2, the projective joint tangent P J_1 always avoids the
   smooth bicanonical conic in P H1(Y,T_Y)=P^2, and dim J_1<=1.
   The joint marked deformation ring is a quotient of W(k)[[z]];
   for the selected main pair,5 is nilpotent in it. This gives no
   length bound and does not exclude a vertical positive-dimensional
   component or a lone projective tangent off the conic.

2. If the entire marked span lifts simultaneously to W2(k), with BOTH
   maps finite etale, then J_5 contains a nonzero class. Consequently
   a no-clump span has NO simultaneous W2 lift. No indigenous connection,
   ordinariness, Hom-zero condition, or degree restriction is assumed.
   Together with etale_refinement_deformations this gives

                Def(f,g) represented by k

   for a no-clump span: J_1=0 gives R=W(k)/(5^e), and absence of W2
   forces e=1. This holds without using the chosen endpoints' separate
   full mixed-characteristic nonliftability theorem.

3. Suppose additionally g(Y)=2 and a W2 lift exists. Its canonical dual
   Frobenius-lifting extensions are matching nonsplit pointed bundles

       0->O_i --e_i--> E_i --q_i--> omega_i^5->0.

   Let n>=0 be their common first Frobenius-instability index, finite
   by(1)'s projective-monodromy argument, and put P=5^(n+1).
   At this stage the maximal line N_i has degree(P+1)(g(C_i)-1),
   and its second fundamental map is an everywhere isomorphism.
   Projection N_i->omega_i^P has nonempty REDUCED divisor Delta_i,
   whose actual pullbacks agree. In particular |Delta_Y|=P-1.

   If n=0 use the original FL connection: it gives a matched admissible
   ACTIVE regular nilpotent connection. If n>=1 use the canonical
   Frobenius connection: it gives a matched DORMANT regular connection.
   In either case this is the intrinsic r_s of the primitive common
   tensor. Its(weight,zero order) is exactly((P-1)/2,1) or(P-1,2).

4. With g(Y)=2, a simultaneous W2 lift forces J_1=0. Therefore EVERY
   W2-liftable coreless genus-two span is jointly infinitesimally rigid,
   including those with an intrinsic dormant match. Its full marked
   deformation ring is W(k)/(5^e), for e>=2 or e=infinity. For the
   selected main endpoints e is finite by their separate nonliftability
   theorem. Neither a uniform bound nor e=infinity is asserted.

Part2 applies to isolated spans.
It does NOT exclude no-clump spans existing only in characteristic five.
Nor does it lift the positive-clump branch to W3 or eliminate its possible
higher first-instability indices. Cored spans already have clumps from
the fibers of their actual core; thus the clump conclusion for W2-liftable
spans also holds without the word coreless.

[Proof](../../Solutions/common_covers/two_leg_negative_extensions.md) ·
[Witt-lifting audits](../../Research/audits/TWO_LEG_FIRST_WITT_CLUMP_AUDIT_2026_09_09.md) ·
[Conic audit](../../Research/audits/JOINT_TANGENT_CONIC_AUDIT_2026_09_09.md) ·
[General secant audit](../../Research/audits/EXTENSION_SECANT_DIMENSION_AUDIT_2026_09_13.md).
