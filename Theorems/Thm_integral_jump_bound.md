# Integral wild-subgroup jumps and numerical single-jump atlas bounds

Version2 (2026-09-07) also incorporates the separately audited numerical
single-jump criterion; the integral-jump hypothesis and conclusion are unchanged.

Let k be algebraically closed of characteristic p≥3. Let a smooth
projective connected X, with h=2g(X)−2>0, be a degree-n finite étale
atlas of an effective proper orbifold with coarse P¹ and exactly two
branch points, one wild and one tame. At the wild point put e=qt,
q=|I_1|, p∤t, c=δ−e, and assume0<c<e.

Either of the following hypotheses gives an effectively computable
atlas-degree bound depending only on p,h:

1. All upper jumps of L/L^(I_1) are integers. This is the numbering
   for the wild subgroup, not for the full inertia extension.
2. Numerically c=j(q−1)−1 for some positive integer j. In this case
   q≤(h+2)². This includes a single positive lower jump, but does not
   require that interpretation of the numerical hypothesis.

For p=5,h=16, either hypothesis forces q=5 and n≤2240.
Under hypothesis1 there is at most one positive jump.
The complete numerical sieve under hypothesis2 has24 full tuples;
these are necessary possibilities, not assertions of local or global
realizability.

Hasse–Arf gives hypothesis1 when I_1 is abelian, but not for arbitrary
nonabelian wild inertia. No Galois hypothesis on X over the orbifold,
or abelian hypothesis on the full inertia or monodromy, is imposed.
The theorem concerns the displayed actual atlas, not coreless covers.

[Proof](../Solutions/Sol_integral_jump_bound.md).
Hypothesis1: PASS, /root/integral_jump_degree_bound_audit, 2026-09-06,
including independent exact enumeration
([record](../routes/global/audits/INTEGRAL_WILD_JUMP_DEGREE_BOUND_AUDIT_2026_09_06.md)).
Hypothesis2: PASS, /root/cored_single_jump_degree_bound_audit, 2026-09-06,
including all24 tuples
([record](../routes/global/audits/CORED_SINGLE_JUMP_DEGREE_BOUND_AUDIT_2026_09_06.md)).
Version2 merges these audited scopes; it is not a fresh independent audit.
