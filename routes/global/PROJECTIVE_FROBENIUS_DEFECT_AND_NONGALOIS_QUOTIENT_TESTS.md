# Frobenius defect at finite and stable depth

Author proofs2026-09-05, consolidated2026-09-07. Stable projectivity,
Cartan–Leray and multiplicities were checked in discussion by
/root/canonical_trace_algebra; no separate whole-note audit is attached.
The finite-depth boundary is /root/x_elliptic_quotient_maps's author proof.
Stable projectivity is classical: compare
[Köck, Corollary2.3](https://arxiv.org/pdf/math/0207124) and
[Borne, Lemmas2.1/2.11](https://arxiv.org/pdf/math/0204088), whose proofs
were source-checked by /root/gluing_cohomology_rigidity and root.
No novelty or projectivity of finite Frobenius kernels is claimed.

## 1. Every actual intermediate, at every Frobenius depth

Let k be algebraically closed of characteristic p>0 and q:W→Y an
actual connected finite etale Galois cover of smooth projective curves,
with group G. Put V=H¹(W,O_W), F absolute semilinear Frobenius, and

    K_r=ker F^r, r≥1,   N=⋃_r K_r,
    d_r(C)=dim ker(F^r|H¹(C,O_C)),   Δ(C)=g(C)−f_C=dim N_C.

Thus d_1(C)=a(C), by Cartier–Frobenius duality, whereas Δ is the
stable defect. For EVERY subgroup H≤G, pullback gives

    ker(F^r|H¹(W/H,O)) ≅ K_r^H,
    H¹(W/H,O)_nil ≅ N^H.                                 (1)

This includes non-Galois intermediates and p-divisible group orders.

To prove it, the free H-action gives Frobenius-compatible coherent
Cartan–Leray with rows H^a(H,k) and H^a(H,V). Since a curve has no
coherent cohomology in degrees≥2, it yields

    0→H¹(H,k)→H¹(W/H,O)→V^H→H²(H,k)→0,                  (2)
    d_2:H^a(H,V)≅H^(a+2)(H,k),  a≥1.                     (3)

The latter kernel/cokernel are the only potential surviving terms in
those degrees; there are no other rows or differentials.
Frobenius is bijective on every H^a(H,k), since it is the scalar
extension of H^a(H,F_p).

A vector in ker(F^r|V^H) maps to zero in H²(H,k), so lifts to b
in H¹(W/H,O). Its F^r-image lies in H¹(H,k). Subtract the UNIQUE
element of H¹(H,k) with that F^r-image to obtain a killed lift.
Bijectivity also proves injectivity on killed vectors. This proves
the finite-depth assertion; stabilization gives its nilpotent version.
In particular, at EVERY depth,

    d_r(W/H)=dim K_r^H=dim Hom_kG(k[G/H],K_r).             (4)

No projectivity is needed for(1) or(4).

## 2. Only the stable module is projective

The semilinear Fitting decomposition over perfect k is
V=N⊕V_bij, G-stable and functorial. Group cohomology preserves this
sum, with nilpotent/bijective induced Frobenius on the two parts.
Equations(3) and bijectivity on group cohomology of k therefore give

    H^a(H,N)=0 for every H≤G and a≥1.                      (5)

For a Sylow p-subgroup P, this says Ext¹_kP(k,N)=0.
The trivial module is the only simple kP-module; induction on a
composition series gives Ext¹_kP(M,N)=0 for every finite module M.
Thus N|P is injective, hence projective over the self-injective group
algebra (and free over local kP). Induce back to G: the usual
induction–restriction counit splits by averaging over the [G:P]
cosets, an INVERTIBLE integer. Hence N is projective over kG.
There is no averaging by |P| or |G|.

Write N=⊕_S P(S)^(m_S) with P(S) the indecomposable projective cover
of simple S. The symmetric algebra kG has soc(P(S))≅S once, and
P(S) is injective. Thus Hom_kG(−,P(S)) is exact and has dimension1
on S and0 on other simples. For every finite module M,

    dim Hom_kG(M,P(S))=[M:S].

Taking M=k[G/H] in(1), Frobenius reciprocity proves

    Δ(W/H)=∑_S m_S [k[G/H]:S],   m_k=Δ(Y).                 (6)

Brackets mean Jordan–Hölder multiplicities, not direct summands.
Formula(6) does NOT follow for K_r, which may be nonprojective.

## 3. Same-source comparison tests

If every simple of k[G/H] occurs in one of k[G/H_j] and all actual
curves W/H_j are ordinary, then W/H is ordinary by(6).
More generally, if
[k[G/H]:S]≤c∑_j[k[G/H_j]:S] for every S, c≥1, then

    Δ(W/H)≤c∑_j Δ(W/H_j).                                 (7)

No normality/comparability of subgroups is needed, and W itself
need not be ordinary. For a p-group G, (6) becomes
Δ(W/H)=[G:H]Δ(Y), recovering Deuring–Shafarevich with etale Hurwitz.

For actual Z→X,Y, take the Galois closure W→Y of the SPECIFIED
Y-leg and write Z=W/H. The composite W→Z→X is still etale; it
need not be Galois. Applying(1) to a Galois closure of the X-leg
shows that pullback injects its finite and stable Frobenius kernels,
already before the closure. In particular Δ(Z)≥Δ(X).
Thus(7) requires Δ(X)≤c∑_j Δ(W/H_j); ordinary comparison curves
would exclude a nonordinary X.

The missing input is which ACTUAL quotients have those defects.
Unrelated numerical profiles, a presumed simultaneous Galois closure,
or an unproved character-only support do not satisfy the hypotheses.

## 4. Actual etale counterexample to finite-depth projectivity

[Cais–Ulmer, Example8.10](https://arxiv.org/abs/2307.16346) gives
unramified C5-covers W→Y in characteristic5 with g(Y)=3,f_Y=2
and a(W)=2,4,5. In the a(W)=2 example, dim K_1=2.
But every projective kC5=k[δ]/(δ^5)-module is free and has dimension
divisible by5. Hence K_1 is NOT projective.
The printed Artin–Schreier header z³−z is a typographical error;
the prose and construction specify a Z/5Z-cover.

By etale Hurwitz and Deuring–Shafarevich, g(W)=11,f_W=6, so dim N=5
and the stable module IS free of rank1, exactly as Section2 predicts.
Finite-depth formula(4) remains correct, but can depend on module
extension data rather than just composition-factor multiplicities.
This is not a counterexample to stable projectivity.

## 5. The richer de Rham structure, with its different scope

For an unramified C_p-cover W→Y, Cais–Ulmer Proposition8.1 proves
that M=H¹_dR(W)_ll is free over kC_p of rank2(g(Y)−f_Y), and

    im F=ker V,   im V=ker F

inside M are free of rank g(Y)−f_Y. Their Theorem1.2 gives the full
augmentation-ideal filtration with successive Dieudonné quotients
H¹_dR(Y)_ll. These are kernels in the local-local de Rham BT_1 module,
NOT ker(F^r|H¹(W,O_W)); the a=2 example forbids that identification.

For a general G, apply this only after restriction to an order-p
subgroup P via the ACTUAL cover W→W/P. Such subgroupwise freeness
does not establish kG-projectivity without controlling larger
elementary-abelian subgroups and the Hodge filtration.

Etaleness is essential throughout: it supplies the torsor spectral
sequence and smooth curve quotients. Do not import this proof unchanged
into a ramified action. All comparison curves belong to one specified W.

## 6. Normal-p quotient retains all projective multiplicities

Sections6–8 retain the separate author proof/bounded algebraic checks
of /root/canonical_trace_algebra2026-09-05, without a new audit.
Let P be ANY normal p-subgroup of G, Q=G/P and B=W/P.
P need not be Sylow or complemented. For a finite projective kG-module M,

    M_P ≅ M^P,   [m]↦∑_(x∈P)xm.                           (8)

Indeed M|P is free; on kP this norm identifies its one-dimensional
coinvariants/invariants, hence does so on every free module.
Normality makes it Q-equivariant. Coinvariants of a summand of
(kG)^a are a summand of(kQ)^a, so M^P is projective over kQ.

Every simple kG-module is inflated from Q, since its nonzero
P-invariants are G-stable. Thus I=ker(kG→kQ) lies in the radical.
Quotienting P_G(S) by I leaves a projective kQ-module with simple
top S, hence P_Q(S). Therefore

    P_G(S)^P≅P_Q(S),
    N_W=⊕_S P_G(S)^(m_S),   N_B=N_W^P=⊕_S P_Q(S)^(m_S).   (9)

Taking P-invariants is a BIJECTION on isomorphism classes of finite
projective modules, retaining all multiplicities. It does not
reconstruct the semilinear operator: on kC_p both zero and
F(m)=(g−1)m^[p] (coefficientwise power) vanish on invariants but
have different ranks. Both are nilpotent and commute with C_p.
This is a formal module example, not a curve-realization claim.
For modular background compare MacQuarrie–Symonds,
[§7, Lemmas7.1–7.3](https://arxiv.org/pdf/1301.5625).

## 7. Positive reconstruction when the extension splits

Suppose G=P⋊Q_0, with Q_0≅Q, allowing p to divide |Q_0|.
For H≤G and representatives x∈Q_0\G/H set K_x=Q_0∩xHx^(-1).
Restriction to Q_0 identifies the corresponding simple modules and
preserves composition multiplicities. The permutation-set decomposition

    Res_Q0 k[G/H]=⊕_(x∈Q0\G/H) k[Q_0/K_x]

and(6),(9) give the POSITIVE exact formula

    Δ(W/H)=∑_(x∈Q0\G/H) Δ(B/K_x).                          (10)

All these actual test curves have degree≤|Q| over Y, independent
of |P|. They are all ordinary iff W/H is ordinary. The P-action
on G/H need not be free. A complement and the relevant ordinarity
are hypotheses, not consequences of normality.

## 8. Rational reconstruction without a complement

Let C,D index Q-conjugacy classes of cyclic p'-subgroups, including1.
Put A_CD=|(Q/D)^C|. Ordering by decreasing subgroup size makes A
triangular, with diagonal |N_Q(C):C|>0; thus it is invertible over Q.

Choose Ctilde≤G mapping isomorphically to C. Schur–Zassenhaus in its
inverse image gives existence and P-conjugacy, so
u_C=|(G/H)^Ctilde| is well defined. Set(a_D)=A^(-1)(u_C). Then

    Δ(W/H)=∑_D a_D Δ(B/D).                                 (11)

To prove this, the Brauer permutation character of k[G/H] at a
generator of C is u_C. Lifts of a cyclic p'-subgroup are P-conjugate,
and fixed-point counts are constant on its generators.
The corresponding character of k[Q/D] is A_CD. Thus the matrix
identity holds on EVERY p-regular element. Independence of irreducible
Brauer characters gives in the rationalized Grothendieck group

    [k[G/H]]=∑_D a_D[Inf_Q^G k[Q/D]].

Pair with the unchanged projective multiplicities(9) to obtain(11).
Denominators may be cleared; positivity is NOT asserted.
It suffices for ordinarity that the actual B/D with a_D>0 be ordinary:
the remaining right side is nonpositive, while Δ(W/H)≥0.
This support may include D=1, requiring B itself ordinary.

The projection G/H→Q/(PH/P) consists of P-orbits of size
[P:P∩H], but that size alone does NOT determine u_C. For each
C-fixed base coset choose xH fixed by Ctilde; existence follows
by conjugacy of complements in the relevant subgroup above C.
Put R_x=P∩xHx^(-1). The coprime fixed-coset lemma gives

    |(P/R_x)^Ctilde|=|C_P(Ctilde):C_Rx(Ctilde)|,
    u_C=∑_(fixed base cosets) |C_P(Ctilde):C_Rx(Ctilde)|.    (12)

Indeed a fixed coset defines a cocycle in R_x, trivial by
Schur–Zassenhaus/H¹(Ctilde,R_x)=1, so it has a centralizing
representative. Actual stabilizer actions, not just orbit sizes,
therefore enter the coefficients.

The following retained exact tests distinguish the claims:

- G=S4,p=2,P=V4, complement Q_0=S3 fixing a letter. For H=C4,
  P∩H has order2 and Q_0 acts freely transitively on six cosets;
  (10) gives Δ(W/H)=Δ(B). For H=C3, orbit sizes2,6 give
  Δ(W/H)=Δ(B/C3)+Δ(B). Enumeration of all24 permutations checked
  these nonsylow, nonfree-P cases.
- G=S3,p=3,P=C3,H=C2. The three-point permutation module has
  factors2[1]+[sgn]: the constant line lies in the augmentation
  plane, whose quotient is sign, and the final quotient is trivial.
  Complement orbits1,2 give Δ(W/H)=Δ(Y)+Δ(B), NOT3Δ(Y).
- In Q=S3, characteristic3, the genuinely negative formula is
  [1]=[k[Q/C2]]−(1/3)[kQ], since [kQ]=3[1]+3[sgn].
  Thus a rational reconstruction is not automatically a positive
  Mackey sum.

These are conditional identities for ACTUAL covers, not realizations.
For fixed Q the quotient library B/D has bounded degree, while its
coefficients retain the specific G/H-action. No automatic ordinarity,
replacement common source or reconstruction of full Frobenius dynamics
is supplied.
