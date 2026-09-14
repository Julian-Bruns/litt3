# Proof: a smooth theta equation and faithful spin series

[Statement](../../Theorems/cartier_and_spin/abelian_cover_section_growth.md).

## 1. A smooth theta equation on the character scheme

Let G=(Z/N)^g. The maximal abelian pro-p quotient of pi_1(C) is Z_p^g;
q_n is the pullback of iterated etale Verschiebung along the Abel map.
The Abel map induces an isomorphism on Frobenius-fixed H1(O), so every
degree-p character remains nontrivial. Every proper subgroup of G lies
in an index-p subgroup; hence the full torsor is connected. Etale Hurwitz
gives the stated genus.

Set R=k[G]=k[z_1,...,z_g]/(z_1^N,...,z_g^N), z_i=g_i-1, with
augmentation ideal m. The regular representation makes q_*O_T an
invertible O_C tensor R-module, with transitions given by group elements.
It is a line-bundle family reducing to O_C. Its first-order classes c_i
are the coordinate Artin--Schreier characters. Since C is ordinary,
they form an Fp-basis of H1_et(C,Fp) and a k-basis of H1(C,O_C).

The perfect cohomology complex of M tensor q_*O_T has Euler characteristic
zero. Since h0(M)=h1(M)=1, cancelling its invertible blocks leaves

    R --d--> R,       d in m,
    h0(T,q^*M)=dim_k ker(d)=length R/(d).                  (1)

For generators e of H0(M) and s of H0(omega_C tensor M^(-1)), the linear
part of d is, up to a nonzero scalar,

    sum_i <c_i,es> z_i.                                   (2)

Indeed c_i e is the obstruction to lifting e, and Serre duality pairs it
with s. Since es!=0 and the c_i span H1(O_C), (2) is nonzero. This is the
smooth-point case of the theta equation, with its tangent calculation
explicit.

A lift of d is therefore a formal coordinate. Every formal coordinate
change preserves (z_1^N,...,z_g^N): the N-th power of any series without
constant term belongs to this ideal in characteristic p, and the same
holds for the inverse change. Taking d as the first coordinate yields

    R/(d) = k[z_2,...,z_g]/(z_2^N,...,z_g^N),
    h0(T,q^*M)=N^(g-1).                                   (3)

Bounded audit: PASS, /root/audit_finite_rank_condensation, 2026-09-14,
medium reasoning, for the character-family tangent space, cohomology
complex, coordinate ideal and all-genus section formula.

## 2. Genus-two quotients and projective faithfulness

Now M=A is the effective spin of the statement, so s=e and es=eta=e^2.
The same scalar complex applies to any abelian p-cover of C. For a
quotient G=(Z/p^a)x(Z/p^b), a,b>=1, its linear equation is
ell_1 z_1+ell_2 z_2, with ell_i=<c_i,eta>.

No nonzero Fp-linear combination of the c_i pairs to zero with eta.
Otherwise eta has Fp-ratio in the Serre-dual basis, exactly the condition
that it be a Cartier eigenform: Cartier takes those coordinates to their
p-th roots. Hence both ell_i are nonzero in every Fp-changed basis.
For G_n=(Z/N)^2, (3) gives h0=N.

For an order-p subgroup H of G_n, a Z/N basis change puts G_n/H in
the form (Z/(N/p))x(Z/N). If n>=2 its group ring is

           R_H=k[z_1,z_2]/(z_1^(N/p),z_2^N).

Both linear coefficients are nonzero. In the formal equation d=0,
solve z_1=psi(z_2), where psi has nonzero linear coefficient. Then
psi(z_2)^(N/p) is z_2^(N/p) times a unit. Hence

                   dim R_H/(d)=N/p.                 (4)

For n=1 the quotient is cyclic of order p. Its ring is k[z]/(z^p),
and its nonzero Artin--Schreier direction has nonzero pairing with eta.
Thus d has nonzero linear coefficient and the quotient length is1,
again (4). This also justifies the rank-one family calculation for all
degree-p quotients without asserting that invariants are exact.

Let E=H0(T_n,q_n^*A). Etale descent gives E^H=H0(T_n/H,A|_(T_n/H)).
Equations (3)--(4) show that no order-p subgroup acts trivially on E.
Every nontrivial subgroup of a finite p-group contains such a subgroup,
so the action of G_n on E is faithful. It is also projectively faithful:
an element acting scalarly has a p-power root of unity as scalar, hence
acts identically in characteristic p.

## 3. The complete section map is separable

Put L=q_n^*A and r=N≥5. Since deg A=1 and r≥2, the
[degree-one and separability lemmas](complete_section_quotients.md#2-global-generation-and-separability)
make L base-point-free with separable complete section map.

Let phi:T_n->S be its factorization through the smooth normalization of
the image, and M the pulled-back hyperplane line. Then phi^*M=L and
H0(S,M)=E by completeness. Write e_phi=deg(phi) and d_M=deg(M).
We have e_phi*d_M=N^2, so d_M is odd. The G_n action on E gives an
action on S, faithful by the
[projective-kernel lemma](complete_section_quotients.md#1-normal-closure-and-the-projective-kernel)
and the preceding projective faithfulness.

## 4. Faithfulness, different parity, and recovery of C

The different divisor R_phi is G_n-invariant, so it descends to an
effective integral divisor on C. Riemann--Hurwitz gives the integer

    deg(R_phi)/N^2 = 2-(2g(S)-2)/d_M >=0.             (5)

If S is rational, completeness gives d_M=r-1=N-1; the right side is
2+2/(N-1), not an integer for N>=5. Thus S is not rational.
If S is elliptic, its finite p-subgroups of automorphisms are cyclic
for p>=5: their linear parts have order prime to p, and the p-primary
group of geometric torsion translations on an elliptic curve is cyclic.
The faithful action of (Z/N)^2 is impossible. Thus g(S)>=2.

The integer in (5) is now0 or1. The value1 would give d_M=2g(S)-2,
contradicting its oddness. Hence R_phi=0, and phi is finite etale.

The [complete-section descent lemma](complete_section_quotients.md#3-descent-determined-by-complete-sections)
makes M a spin compatibly with L. Its hypotheses hold because φ is
étale and H0(S,M)=H0(T_n,L).

The pulled-back section e of A consequently descends to M, and eta=e^2
descends as a regular form on S. Cartier(eta) also descends by naturality.
The two span H0(C,omega_C). Canonical ratios and a descended differential
recover the FULL field k(C), by cartier_endpoint_recovery. Thus

                   k(C) subset k(S) subset k(T_n).

Now T_n/S is Galois, and its group is the kernel of the G_n action on S.
Faithfulness makes that kernel trivial. Hence phi is an isomorphism:
the complete spin map is birational.

For C_t the six non-eigenline identities are recorded in
family_small_torsion_specialization; ordinarity holds on t^5-t!=0.

Background inputs: [Artin--Schreier and Frobenius-fixed cohomology](https://stacks.math.columbia.edu/tag/0A3J);
[ordinary abelian varieties and etale Verschiebung](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort).

The genus-two spin argument has a separate
[medium audit, PASS, 2026-09-08](../../Research/audits/ABELIAN_SPIN_BIRATIONAL_TOWERS_AUDIT_2026_09_08.md).
