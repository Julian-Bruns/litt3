# A linear spin normal form for the first surviving root profile

Let k be algebraically closed of odd characteristic p, ell=p+2, and C/k
smooth projective of genus g>=2. Let L^2=omega_C be a spin line.

1. The twisted Cartier map H0(C,L^(p+2)) -> H0(C^(1),L_1^3) is
   SURJECTIVE. Its kernel K(C,L) has dimension (p-1)(g-1).
   No ordinarity hypothesis is required.

2. Nonzero tensors s in H0(C,omega_C^ell) with div(s)=2D, D reduced,
   are described, up to the usual scalar choices, by spin lines L and
   sections h in H0(C,L^ell) with div(h)=D, via s=h^2. The line is
   recovered as L=O(D)omega_C^(-(ell-1)/2). There are 2^(2g) spin-line
   isomorphism classes, not an additional positive-dimensional Picard
   parameter. Put r=(p+1)/2 and q=(p+3)/2, so r*ell=1+p*q.
   The eligible generalized map sends s^r in H0(omega^(1+pq)) by twisted
   Cartier to H0(C^(1),omega_(C^(1))^(q+1)). Vanishing of this image
   is equivalent to h belonging to K(C,L).

3. The spin root cover pi:A->C is connected and smooth, totally tamely
   ramified over D and unramified elsewhere. Its canonical one-form
   alpha satisfies alpha^ell=pi^*s and

       div(alpha)=(ell+1)R,  deg R=ell(g-1),
       g(A)=1+ell(ell+1)(g-1)/2.

   It is exact iff h is in K(C,L). This is the canonical ell-th root
   cover of s, not merely another cover with the same ramification.

4. This description is compatible with BOTH maps of an actual etale
   span X<-Z->Y. Equal pulled-back tensors supply the same pulled-back
   spin line and section after scalar normalization. Conversely that
   spin/section equality gives equal tensors. Taking their root covers
   gives two Cartesian, everywhere-etale upper maps from ONE connected
   source. The upper span is coreless iff the original span is coreless.

5. For a chosen root h, all Cartier blocks of A are explicit on C:

       H0(A,omega_A)=H0(C,omega_C)
                     + sum_(i=1)^(ell-1) H0(C,omega_C L^i).

   The i-th space is represented locally by a*eta_l/w^i. Let i' be the
   residue of p^(-1)i in {1,...,ell-1}, and n=(p*i'-i)/ell. Its Cartier
   block is a -> Cartier_(L_1^i')(a*h^n). The target is the i'-th space
   on the Frobenius twist. Each source has dimension (i+1)(g-1).
   The block i=p -> i'=1 is precisely the SURJECTIVE map in part1,
   independent of h. These blocks commute with the two actual etale
   pullbacks, not just with abstract identifications of vector spaces.

In characteristic5 there are16 possible spin lines on a genus2 endpoint,
and a four-dimensional linear kernel for each; on the fixed genus9
endpoint there are2^18 spin lines and32-dimensional kernels. Only their
REDUCED-section open loci are relevant; their nonemptiness for every spin
line is NOT asserted. They parametrize all weight7/divisor2D roots, but
not tensors of unbounded different primitive weight.

For p=5 the nontrivial Cartier block data (i,i',n,dimension/(g-1)) are

    (1,3,2,2), (2,6,4,3), (3,2,1,4),
    (4,5,3,5), (5,1,0,6), (6,4,2,7).

Consequently a(A)>=a(C)+7(g-1), and

    f_5(A)=f_5(C)+6b,   0<=b<=2(g-1),

where f_5 is the5-rank. In particular the genus29 root of an ordinary
genus2 curve has5-rank at most14 and a-number at least7. These dimension
bounds scale with the degree of an etale base change. They are necessary
constraints, NOT an exclusion of a common cover. A shared nonzero vector
in the two pulled-back K-spaces is still an unresolved global condition.

Version1,2026-09-08. Fresh medium prose audit PASS by
/root/audit_spin_cartier_normal_form for parts1-5 and the numerical
consequences; no Lean claim.
[Audit metadata](../../Research/audits/SPIN_CARTIER_ROOT_NORMAL_FORM_AUDIT_2026_09_08.md)
is reference-only.
[Definitions](../../Definitions/spin_cartier_roots.md) ·
[Proof](../../Proofs/cartier_and_spin/spin_cartier_root_normal_form.md).
