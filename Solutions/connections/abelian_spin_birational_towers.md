# Proof: one scalar deformation, faithful group action, and parity of the different

[Statement](../../Theorems/connections/abelian_spin_birational_towers.md).
Author /root,2026-09-08. No computation or formal lifting to characteristic
zero is used. The Artinian rings below live entirely in characteristic p.

## 1. The abelian covers and their first-order directions

The maximal abelian pro-p quotient of the geometric fundamental group of
an ordinary genus-two curve is Z_p^2. Concretely the covers are pullbacks
of iterated etale Verschiebung on its ordinary Jacobian along an Abel map.
Their degree-p characters give all of

    H1_et(C,Fp)=H1(C,O_C)^(F=1).

This Fp-space has dimension2 and spans H1(C,O_C) over k. The Abel map
identifies H1(O) of the Jacobian with H1(O) of the curve, so every nonzero
degree-p quotient of the pulled-back torsor is connected. Since a proper
subgroup of (Z/N)^2 is contained in an index-p subgroup, the whole torsor
is connected. Riemann--Hurwitz gives g(T_n)-1=N^2.

We use also quotients with group G=(Z/p^a)x(Z/p^b), a,b>=1, obtained
by choosing a basis of the two abelian directions. Let q:T->C be such
a quotient. Put R=k[G] and let m be its augmentation ideal. Since G is
abelian, q_*O_T is an invertible module over O_C tensor R: locally on
a trivialization of the torsor it is the regular module k[G], and
changes of trivialization are multiplication by group elements.
It is thus a family of line bundles over Spec R, reducing to O_C.
Its first-order deformation classes, in a basis of m/m^2, are the two
independent Artin--Schreier classes c_1,c_2 in H1(C,O_C).

Set A_R=A tensor q_*O_T, viewed as that R-family. Choose a sufficiently
large effective divisor B on C. The divisor sequence for A_R(B) gives
a two-term finite free R-complex computing H0 and H1 of A_R. Indeed
H1(A(B))=0, and induction through powers of m gives vanishing and base
change for the family; the section and residue modules are free.
Both free modules have the same rank, since chi(A)=0.
Modulo m, H0(A) and H1(A) each have dimension1. Gaussian elimination
of unit matrix entries therefore reduces the complex to

                         R --d--> R,                (1)

with d in m. In particular

                 h0(T,q^*A)=dim_k R/(d).             (2)

This uses equality of kernel and cokernel dimensions of the square
k-linear multiplication map by d; it does not assume flatness of H0.

The linear term of d is, up to a nonzero scalar,

       ell_1 z_1+ell_2 z_2,   ell_i=<c_i,e^2>,        (3)

where z_i=g_i-1. To see (3), lift e through the line-family modulo m^2.
The Cech obstruction is c_i e in H1(A); spin Serre duality pairs it
with e as <c_i,e^2>. This is exactly the linear differential in (1).

None of these pairings vanishes on a nonzero Fp-linear combination of
c_1,c_2. Otherwise the coordinates of eta in the Serre-dual basis would
have Fp-ratio (including infinity). Cartier sends those coordinates to
their p-th roots, because the c_i are Frobenius fixed. Such a ratio
is equivalent to eta being a Cartier eigenform, contrary to hypothesis.
Thus in every Fp-changed basis both ell_i are nonzero.

## 2. Exact lengths, not asymptotic estimates

For G=(Z/N)^2 the ring is R=k[z_1,z_2]/(z_1^N,z_2^N).
A series with nonzero linear term, such as d, can be taken as a formal
coordinate. Every formal coordinate change preserves (z_1^N,z_2^N):
N-th powers are sums of N-th powers in characteristic p, and the same
argument applies to the inverse change. Therefore

                   dim R/(d)=N.                     (4)

For an order-p subgroup H of G_n, a Z/N basis change puts G_n/H in
the form (Z/(N/p))x(Z/N). If n>=2 its group ring is

           R_H=k[z_1,z_2]/(z_1^(N/p),z_2^N).

Both coefficients in (3) are nonzero. In the formal equation d=0,
solve z_1=psi(z_2), where psi has nonzero linear coefficient. Then
psi(z_2)^(N/p) is z_2^(N/p) times a unit. Hence

                   dim R_H/(d)=N/p.                 (5)

For n=1 the quotient is cyclic of order p. Its ring is k[z]/(z^p),
and its nonzero Artin--Schreier direction has nonzero pairing with eta.
Thus d has nonzero linear coefficient and the quotient length is1,
again (5). This also justifies the rank-one family calculation for all
degree-p quotients without asserting that invariants are exact.

Let E=H0(T_n,q_n^*A). Etale descent gives E^H=H0(T_n/H,A|_(T_n/H)).
Equations (4)--(5) show that no order-p subgroup acts trivially on E.
Every nontrivial subgroup of a finite p-group contains such a subgroup,
so the action of G_n on E is faithful. It is also projectively faithful:
an element acting scalarly has a p-power root of unity as scalar, hence
acts identically in characteristic p.

## 3. The complete section map is separable

Put L=q_n^*A and r=N>=5. Its fixed divisor is G_n-invariant, hence
is the pullback of an effective divisor on C. A nonzero such divisor
would consume the entire degree1 of A, leaving a line of degree at
most zero and at most one section. Since r>=2, L is base-point-free.

If all complete-section ratios were p-th powers, declare every global
section of L horizontal. Base-point-freeness makes this a well-defined
regular connection: local nonvanishing sections have p-th-power
transition ratios. It has zero p-curvature and is G_n-invariant, since
G_n acts k-linearly on the whole section space. Etale descent gives a
zero-p-curvature connection on A. Cartier descent then makes deg(A)
divisible by p, contradicting deg(A)=1. Thus the ratio map is separable.

Let phi:T_n->S be its factorization through the smooth normalization of
the image, and M the pulled-back hyperplane line. Then phi^*M=L and
H0(S,M)=E by completeness. Write e_phi=deg(phi) and d_M=deg(M).
We have e_phi*d_M=N^2, so d_M is odd. The G_n action on E gives an
action on S, which is faithful by the equal-ratio/scalar argument in
normal_closure_section_field and the preceding projective faithfulness.

## 4. Faithfulness, different parity, and recovery of C

The different divisor R_phi is G_n-invariant, so it descends to an
effective integral divisor on C. Riemann--Hurwitz gives the integer

    deg(R_phi)/N^2 = 2-(2g(S)-2)/d_M >=0.             (6)

If S is rational, completeness gives d_M=r-1=N-1; the right side is
2+2/(N-1), not an integer for N>=5. Thus S is not rational.
If S is elliptic, its finite p-subgroups of automorphisms are cyclic
for p>=5: their linear parts have order prime to p, and the p-primary
group of geometric torsion translations on an elliptic curve is cyclic.
The faithful action of (Z/N)^2 is impossible. Thus g(S)>=2.

The integer in (6) is now0 or1. The value1 would give d_M=2g(S)-2,
contradicting its oddness. Hence R_phi=0, and phi is finite etale.

We must identify M as a genuine spin before descending eta as a form.
Put M'=omega_S tensor M^(-1). Etaleness gives phi^*M'=L, and
deg(M)=g(S)-1. Riemann--Roch gives h0(M')=h0(M)=r. Therefore both
section spaces pull back onto the same full E. Matching one nonzero
section gives a rational isomorphism M->M' whose pullback is the fixed
global isomorphism upstairs. It has no zero or pole, so M^2=omega_S,
compatibly with the spin isomorphism upstairs.

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
This result supplies no second endpoint and no invariant shared h.
It is an exact boundary test for the current two-leg strategy.

Background inputs: [Artin--Schreier and Frobenius-fixed cohomology](https://stacks.math.columbia.edu/tag/0A3J);
[ordinary abelian varieties and etale Verschiebung](https://math.nyu.edu/~tschinke/books/finite-fields/submitted/oort).
The one-scalar complex and its deformation differential are constructed
above, rather than assumed from a theta-divisor multiplicity formula.
