# Shared negative extensions and the first Witt obstruction

Version6,2026-09-15. The extension and Witt-rigidity assertions
hold over bar(F_p) for every odd prime p.

Let k=bar(F_p), p odd and X<-f-Z-g->Y be an ACTUAL coreless finite etale span
of smooth projective connected hyperbolic curves. For every integer m>=1,
put J_m=H^1(Ω^(-m)) in the
[invariant-line notation](../../Definitions/canonical_tensors.md), equivalently

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
   for the selected characteristic-five main pair,5 is nilpotent in it.
   This gives no length bound and does not exclude a vertical positive-dimensional
   component or a lone projective tangent off the conic.

2. If the entire marked span lifts simultaneously to W2(k), with BOTH
   maps finite etale, then J_p contains a nonzero class. Consequently
   a no-clump span has NO simultaneous W2 lift. No indigenous connection,
   ordinariness, Hom-zero condition, or degree restriction is assumed.
   Together with etale_refinement_deformations this gives

                Def(f,g) represented by k

   for a no-clump span: J_1=0 gives R=W(k)/(p^e), and absence of W2
   forces e=1. This holds without using the chosen endpoints' separate
   full mixed-characteristic nonliftability theorem.

   More precisely, the canonical connection gives

       J_p^nabla=ker(nabla:J_p->J_(p-1)).

   With the scalar Frobenius twists retained, there is a canonical
   exact sequence at its first two terms

       0 -> F*J_1^(1) -> J_p^nabla --chi--> k.

   Fix chi so the Frobenius-lifting normalization is1. The fiber
   chi^(-1)(1) is exactly the simultaneous marked W2 lifting torsor,
   using the fixed Witt-Frobenius convention. Thus a simultaneous
   lift exists if and only if chi is nonzero. Mere nonvanishing
   of J_p does not supply that normalization.

3. Suppose additionally g(Y)=2 and a W2 lift exists. Its canonical dual
   Frobenius-lifting extensions are matching nonsplit pointed bundles

       0->O_i --e_i--> E_i --q_i--> omega_i^p->0.

   Let n>=0 be their common first Frobenius-instability index, finite
   by(1)'s projective-monodromy argument, and put P=p^(n+1).
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
   deformation ring is W(k)/(p^e), for e>=2 or e=infinity. For the
   selected characteristic-five main endpoints e is finite by their
   separate nonliftability theorem. Neither a uniform bound nor
   e=infinity is asserted.

5. Suppose g(Y)=2 and the positive clump has reduced endpoint divisors
   D_X,D_Y, with r=deg D_Y. A nonzero class in J_m has exactly one
   of the following behaviors.

   - Its pointed extensions are already unstable. Their maximal lines
     are omega_i^m(-a D_i), with an integer a>=1 satisfying ar<m.
   - They are initially stable. Their first Frobenius instability
     has index n>=1 satisfying the EXACT equation

                         m*p^n=r+1.

     The intrinsic common projective connection is then regular and
     dormant. Its primitive (weight,zero order) is ((r)/2,1) or(r,2),
     with the first possibility only when r is even.

   Consequently, for1<=m<=r, J_m has dimension at most1 and is zero
   unless m=(r+1)/p^n for some n>=1. If the intrinsic connection is
   active or not regular, every J_m in this range vanishes.

   More generally put q=floor((m-1)/r). If no n>=1 satisfies
   m*p^n=r+1, every class of J_m is represented UNIQUELY by matching
   principal parts on qD_X and qD_Y, for the line bundles omega_i^-m.
   Equivalently it lies in both kernels

       H1(omega_i^-m) -> H1(omega_i^-m(qD_i)),

   and the unique principal parts agree after the actual pullbacks
   to Z. Their restriction at ANY single point of the clump is
   injective. In particular

       dim J_m <= floor((m-1)/r)

   whenever the stable alternative is excluded, including every
   m>=r+1. This is a necessary support and dimension theorem,
   not an assertion that nonzero matching principal parts exist.

6. Write r+1=u*p^a with p not dividing u. The only possibly nonzero
   spaces J_m for1<=m<=r have weights u,u*p,...,u*p^(a-1).
   If a=0 there are none. If u>1, the Frobenius maps between all
   successive spaces in this list are isomorphisms (with scalar
   twists): they form either a zero string or one string of lines.

   If u=1, then J_(p-1)=0 and dim J_p<=1, including r=p-1.
   The exact first-Witt sequence becomes

       0 -> F*J_1^(1) -> J_p --chi--> k.

   Every further Frobenius map J_(p^i)^(1)->J_(p^(i+1)) within
   the displayed range, i>=1, is an isomorphism. Thus the nonzero
   string starting at J_p comes either from a joint tangent, or from
   the normalized first-Witt class, and these alternatives cannot
   coexist. This describes actual cohomology spaces and does not
   assert that either string is nonzero for a hypothetical span.

7. Suppose the primitive common tensor has zero multiplicity e=1 or2,
   and write r=deg D_Y. There is a canonical nonzero line in J_(r+1),
   obtained from the inverse leading jet of the common tensor

                 tau=s^(2/e),  weight r,  divisor 2D.

   In fact dim J_(r+1)=1. If r+1=u*p^a with a>=1, every Frobenius
   arrow in Part6 whose source weight is at least2 extends through
   the boundary weight r+1. If u>1, the entire string

                 J_u -> J_(up) -> ... -> J_(up^a)

   consists of lines and isomorphisms, with scalar twists. If u=1,
   then dim J_p=1 and exactly ONE of the following occurs:

   - dim J_1=1, chi=0, and there is no simultaneous W2 lift;
   - J_1=0, chi is an isomorphism, and there is exactly one marked
     simultaneous W2 lift, with both original maps on the same source.

   In both cases all further arrows from J_p to J_(p^a) are
   isomorphisms. The construction is not an assertion that such a
   clump or span exists.

8. Let R be the complete marked simultaneous deformation ring of
   the actual coreless genus-two span. Then

       R!=k  iff  its positive clump has r=p^a-1 for some a>=1
                  and primitive multiplicity e=1 or2.

   In this exceptional case the two alternatives in Part7 are
   exhaustive. Outside it, R=k, including positive clumps of all
   other sizes or primitive multiplicities. This is a criterion for
   the deformation ring of an existing span, not its nonexistence.

   Suppose every nonsplit extension of omega_Y by O_Y remains
   semistable through Frobenius index h>=1. For any exceptional
   clump with a<=h, the tangent alternative is impossible, so the
   span has its unique simultaneous W2 lift. A nonzero tangent
   requires a>=h+1 and hence r>=p^(h+1)-1.

Part2 applies to isolated spans.
It does NOT exclude no-clump spans existing only in characteristic p.
Nor does it lift the positive-clump branch to W3 or eliminate its possible
higher first-instability indices. Cored spans already have clumps from
the fibers of their actual core; thus the clump conclusion for W2-liftable
spans also holds without the word coreless.

[Proof](../../Proofs/deformations/two_leg_negative_extensions.md).
