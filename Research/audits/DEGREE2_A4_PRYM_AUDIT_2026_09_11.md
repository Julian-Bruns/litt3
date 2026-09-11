# Scoped audit: degree2 A4 carrier and Prym reduction

Date: 2026-09-11. Auditor: `/root/audit_degree2_a4_prym`.

Verdict: **PASS for the amended necessary geometric reduction and exact
binary checker.** The required Frobenius/isogeny correction and input
citation repairs have been incorporated and independently checked.
The geometric Jacobian-factor test uses1533 carrier representatives
against fixed J(B). The three-target/4599 distinction is retained for
actual-map tests. No degree2 exclusion is proved or audited.

Audited material:

- [Integrated reduction](../../Solutions/Sol_backup_degree_two_prym_reduction.md), original amended-draft SHA256
  `f713837478aa8da91a96a28bdd2d81d4827ef7d4cd29677e72ad51ff4f766e10`.
  The initially reviewed version had SHA256
  `b2c08dfec73c7d929f64891a21865259eb46c2bfeecd73f9425de113e515e361`;
  Section5 records the correction from that version.
- [Binary checker](../../scripts/check_degree2_frobenius_orbits.py), SHA256
  `6c7e9f15fd9a564c4374d998630c5569d869393a70950e38f62fe5ca09660c4e`.

This is a bounded prose/code audit. The established fixed-X Frobenius
polynomial, fixed-X geometry, and backup simplicity/Hom-zero arithmetic
are inherited inputs, not new point counts or new arithmetic proofs.
Canonical `fixed_pair_arithmetic`, `backup_genus_two_curve`, `orbifolds`,
and the relevant recorded backup arithmetic were inspected.

## 1. The actual two maps survive

Work over k=bar(F5). Write S=P1(2,2,2,2,2,2) for the SAME effective
orbifold with the backup's six hyperelliptic branch points. The input
f:X->S must be a representable finite etale atlas of degree16; an
arbitrary separable degree16 map to the coarse P1 would not suffice.
B->S is the hyperelliptic C2-torsor. Thus the stack fiber product

    X'=X x_S B

is a smooth proper etale double over X and is finite etale of degree16
over B. Equivalently one takes the normalization of the coarse fiber
product; the raw coarse fiber product need not itself be smooth.

If X' is disconnected, its two components are copies of X. On each
component the map to B has degree8: degrees in the common coarse
P1 diagram give16=2*8. Such a map induces a nonzero Jacobian
homomorphism, contradicting the inherited Hom(JX,JB)=0. Hence X' is
connected and corresponds to a nonzero class L in Pic(X)[2]. Its genus
is17. These are actual maps, not Jacobian replacements for maps.

## 2. The A4 construction dominates that original double

For the cubic quotient q:X->P1_x, the norm identity is

    1+rho+rho^2=q^*q_*=0 on JX.

Thus rho has no nonzero fixed vector on JX[2] and the orbit of L spans
the rank2 subgroup A={0,L,rho L,rho^2 L}. The connected etale V4-cover
associated with these three nontrivial Kummer characters exists.

The specified pointed Abel construction is valid. For i(P)=[P-O],
the pullback of [2]:JX->JX is connected: i induces the usual
isomorphism on H1 with F2 coefficients, so the associated JX[2]
monodromy is surjective. Quotient its deck group by the annihilator
of A under the principal-polarization Weil pairing. The resulting
connected cover U->X has degree4 and character group A.

The quotient corresponding to the character L is isomorphic OVER X
to the actual X'. Choosing a point above O in that actual double
fixes an identification if desired. Composing through this
identification retains its original map to B. Thus U->X'->B is finite
etale of degree32, and U->X is finite etale of degree4.

For conventions, i(rho P)=rho_*i(P), while rho_*=(rho^{-1})^* on
Picard classes. Either inverse convention preserves A and yields the
same argument. The action on the [2]-pullback is

    (P,Q) |-> (rho P,rho_*Q).

It has actual order3, stabilizes the annihilator of A and descends
to U. Its conjugation action cycles the three nonidentity deck
elements. Therefore the generated group is V4 semidirect C3=A4,
of order12, and U->P1_x is Galois with exactly this group. No
simultaneous Galois closure of two unrelated legs is presumed.

The cover U->X is etale, so the eleven original tame inertia groups
remain of order3. On the four cosets of a C3-complement every such
inertia group acts as a3-cycle with one fixed point. Consequently
R=U/C3 is an actual degree4 cover with eleven complete fibers(3,1).
The genus checks are

    2g(U)-2=4*(2*9-2)=64,
    2g(R)-2=4*(-2)+11*(3-1)=14.

Hence g(U)=33 and g(R)=8. All C3-complements are V4-conjugate,
so their quotient curves are isomorphic over P1_x.

## 3. The Jacobian conclusion has the stated necessary strength

The V4 character projectors in End(JU) tensor Q give

    J(U) ~ J(X) x P_L x P_(rho L) x P_(rho^2 L).

Each nontrivial character component is the image of the Prym of its
actual double quotient, so its dimension is17-9=8. The lifted rho
permutes the three Pryms by isomorphisms with cyclic composite1.
Its fixed part on their product is isogenous to one Prym. Its fixed
part on J(X) is zero since X/C3=P1. The norm/pullback identities for
U->R identify the connected invariant part of JU with JR up to
isogeny. Therefore

    J(R) ~ Prym(X'/X).

Let h:X'->B be the actual degree16 map. Then h_*h^*=[16], so h^*
has finite kernel. The norm of h^* to JX is zero by
Hom(JB,JX)=0; this reverse Hom vanishing follows from the recorded
Hom vanishing and polarizations. The connected image of h^* lies
in the Prym. Poincare complete reducibility therefore puts JB as
an isogeny factor of the Prym and hence of JR.

This proves a necessary factor condition. It does not construct
R->B, and the reduction correctly refrains from making that claim.
A future arithmetic factor sieve must exclude GEOMETRIC isogeny
factors, not merely a factor over one chosen field of definition.

## 4. The finite algebra and orbit counts pass

The coefficient vector in the checker agrees with the recorded
P_X(T). Its reduction has exponents

    18,16,15,12,11,9,7,6,3,2,0.

The binary multiplication/remainder routines were inspected and the
script replayed successfully. Its irreducibility test is exactly the
degree18 Rabin test: T^(2^18)=T, with gcd tests at exponents2^9 and2^6,
corresponding to both prime divisors2,3 of18. The order tests are
complete because171=3^2*19: T^171=1, T^57!=1 and T^9!=1 force exact
order171.

Irreducibility identifies JX[2] with the one-dimensional module over
E=F_(2^18), with Frobenius25 acting by multiplication by T. Thus every
nonzero vector has period171. Its centralizer is E, and rho is a
nontrivial order3 scalar, necessarily T^57 or T^114. The rank2
rho-stable subgroups are precisely the F4-lines in E.

There are(2^18-1)/3=87381 such lines. Their Frobenius stabilizer
consists of exponents n with T^n in F4^*, whose least positive n
is57. Thus there are87381/57=1533 line orbits. The nonzero double
labels give(2^18-1)/171=1533 orbits as well.

In addition to script replay, the auditor exhaustively enumerated all
87381 F4-lines with the inspected binary arithmetic and partitioned
both actions. The complete histograms were

    Frobenius25:   {57:1533},
    Frobenius25^3: {19:4599}.

These are labels on the fixed X; they do not count nonisomorphic
abstract curves U or R or establish their exact moduli periods.

## 5. Incorporated correction: geometric factors versus actual maps

The original paragraph beginning "The backup curve is fixed by
Frob25^3" incorrectly makes the factor-of-three caution apply to
the geometric isogeny-factor test. For every abelian variety A/k,
relative Frobenius gives an isogeny A->A^(25). Its finiteness,
surjectivity and degree follow from
[Stacks, Section33.36, Lemma33.36.10](https://stacks.math.columbia.edu/tag/0CC6);
naturality with the group law makes it a group homomorphism. Hence

    J(B) ~ J(B^(25)) ~ J(B^(25^2)),
    J(R) ~ J(R^(25)).

The geometric JB-factor condition is constant on every carrier
Frobenius orbit even when B is held fixed. It therefore needs only
1533 carrier representatives. Testing the three target conjugates
gives no additional geometric isogeny obstruction.

The following replacement was requested and its mathematical content
has been verified in the author's amended note:

> For the geometric isogeny-factor test, the1533 Frobenius25 carrier
> representatives suffice even against fixed J(B): relative Frobenius
> makes J(B), J(B^(25)) and J(B^(25^2)) isogenous, and likewise makes
> J(R) isogenous to its Frobenius conjugates. Actual finite-etale-map
> or curve-isomorphism tests cannot replace their maps by these
> purely inseparable isogenies. For those tests, one must retain all
> three backup conjugates for each of1533 carrier representatives,
> or use the4599 Frobenius25^3 carrier orbits against fixed B. No
> complete Prym sieve or actual-map sieve has been executed.

The amended next-task sentence now asks for a geometric factor
obstruction against the fixed JB, without requiring three separate
isogeny tests. This correction strengthens the finite reduction; it
does not exclude any carrier.

The input citation has also been repaired. The initially linked
Sol_backup_hermitian_atlas_exclusion.md establishes the model/genus
and atlas arithmetic, but does not state the backup's absolute
simplicity or Hom-zero proof. The inherited latter assertions are in
[BACKUP_CANDIDATE.md, Arithmetic and portability](../BACKUP_CANDIDATE.md#arithmetic-and-portability)
and are recorded as inputs in canonical
`quadrangular_genus_two_hecke_obstruction`; the amended note now links
both appropriate sources. This audit does not upgrade the verification
status of those inherited calculations.

No other blocking mathematical objection was found in the audited
necessary reduction. The original common-cover problem and the
backup degree2 row remain open.
