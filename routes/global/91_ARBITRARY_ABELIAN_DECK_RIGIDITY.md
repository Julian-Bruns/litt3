# Arbitrary abelian deck rigidity and shared cover lemmas

Theorems91.1--91.4: independently checked PASS,2026-09-04,
[original audit](audits/91_ARBITRARY_ABELIAN_DECK_RIGIDITY_AUDIT.md).
The elementary lemmas and hyperelliptic lifting proof retained from the
earlier branch-rigidity note were covered by its
[PASS audit](audits/ODD_PRIME_DECK_NORMALITY_UNDER_RIGID_BRANCH_AUDIT.md).
Consolidated exposition2026-09-07; original scopes retained, not a new audit.

All curves are smooth projective connected over an algebraically closed
field. Jacobian simplicity is geometric. Cover degrees may be divisible
by the characteristic. The
[prime-power and branch-rigidity results](92_BRANCH_RIGID_ABELIAN_PRIME_POWER_COVERS.md)
allow nontrivial automorphisms of the base under different hypotheses.

## 1. Three common lemmas

**Normalizer injection (Lemma87.1).** If D->X is Galois with group H,

    N_Aut(D)(H)/H embeds in Aut(X).

Indeed a normalizing automorphism preserves k(D)^H=k(X); the kernel of
descent is exactly H. This lemma does not require etaleness.

**Simple-quotient lemma (Lemma87.2).** If g(X)>=2 and JX is simple,
every finite separable map X->Q of degree>1 has g(Q)=0. For otherwise
pullback JQ->JX has finite kernel (norm times pullback is multiplication
by the degree), and simplicity forces its image to be all of JX.
Thus g(Q)=g(X), contrary to effective-different Riemann--Hurwitz.

**Hyperelliptic lifting lemma.** In characteristic different from2, every
connected finite etale abelian Galois cover D->Y of a hyperelliptic curve
has a nontrivial involution fixing a point above each chosen Weierstrass
point y0. Indeed the Abel--Jacobi map based at y0 identifies
pi1(Y,y0)^ab with pi1(JY,0), including the etale characteristic-primary
part. As y+iota(y)~2y0, the involution acts by inversion. It preserves the
kernel of the abelian quotient defining D. The based lifting criterion
gives a unique lift fixing a chosen point above y0; its square is the
based lift of the identity, hence identity. It is nontrivial because it
descends to iota. This is the lifting argument used in former Theorem87.8.

## 2. Arbitrary abelian rigidity

### Theorem91.1

Let g(X)>=2, JX simple, and D->X connected finite etale Galois with
finite abelian deck group H. Put A=Aut(D). If N_A(H)=H, then A=H.
In particular Aut(X)=1 implies A=H.

**Proof.** The last assertion follows from the normalizer injection.
If H=1 the hypothesis is already A=1. Otherwise suppose A>H and choose
M minimal over H. Simplicity forces D/M=P1. Put

    N=Core_M(H), G=M/N, B=H/N.

The action on G/B is faithful and primitive, with nontrivial abelian
self-normalizing point stabilizer B. For g not in B, if
1!=c belongs to B intersect B^g, then abelianness gives

    <B,B^g> <= C_G(c).

Maximality and self-normalization make the left side G. A central element
fixing one point of a faithful transitive action fixes all points and is
identity, contradiction. Thus B intersect B^g=1, and this is a Frobenius
action. By the Frobenius-kernel theorem,

    G=K semidirect B,

where K consists of identity and the derangements. Let Ktilde be its
inverse image in M. Since N is contained in the free group H, each
geometric point stabilizer M_z injects into G. A nonidentity element
of its image cannot fix a coset: its lift would belong to a conjugate
of H and would fix z, although that conjugate acts freely. Thus all
point stabilizers lie in Ktilde. The quotient

    D/Ktilde -> D/M=P1

is a connected finite etale cover with nontrivial group B, impossible.
Hence A=H. QED.

The SAME proof works inside any finite subgroup A of Aut(D) containing H.
Equivalently, no subgroup M can have H maximal, H<M and N_M(H)=H.
This is the relative minimal-overgroup argument used in the
[composite-order reduction](94_COMPOSITE_ABELIAN_DECK_REDUCTION_AND_HECKE_BOTTLENECK.md),
not a claim about nonabelian H.

The external group input is precisely Frobenius' theorem that identity
and derangements in a finite Frobenius action form a normal subgroup.
See Paul Flavell, *A Note on Frobenius Groups*, J. Algebra228(2000),
367--376, [opening statement](https://web.mat.bham.ac.uk/P.J.Flavell/research/publications/frobenius.pdf).
No nilpotence theorem or classification of finite groups is used.

## 3. Consequences for the SAME actual source

Retain the hypotheses of Theorem91.1, INCLUDING N_A(H)=H.

**Corollary91.2.** If D->Y is any finite etale Galois map with
g(Y)=g(X), then its deck group H_Y equals H and Y is isomorphic to X.
Indeed H_Y<=Aut(D)=H, and the etale genus formulas make their orders equal.

**Corollary91.3.** The same conclusion holds without equal genus if
g(Y)>=2 and JY is simple. The inclusion H_Y<=H gives an actual finite
etale map Y=D/H_Y->D/H=X. Its degree is one by the simple-quotient lemma.

**Corollary91.4.** In characteristic different from2, D cannot also be a
finite etale Galois cover of a hyperelliptic Y of genus>=2. Its deck group
would be a subgroup of the abelian Aut(D)=H, hence abelian. The lifting
lemma would give a nontrivial automorphism of D with a fixed point,
contrary to freeness of H. No abelianness hypothesis on the SECOND group
is needed. This contains the former prime-power Theorem87.8.

Neither result permits replacing an arbitrary bi-etale span by a
simultaneously Galois one.

## 4. Why a normal-complement shortcut is insufficient

Let V=F5^2 be the irreducible reflection representation of S3 and
A=V semidirect S3. For a transposition t, let L be its +1 eigenspace.
Then H=L x<t> is C10, core-free and self-normalizing in A. A normalizer
must project into <t> and have translation part in L.

Yet H has no normal complement: such a subgroup would have order15.
Its unique Sylow5-subgroup would be characteristic in it, hence normal
in A, producing an S3-invariant line in V, contradiction. The full
arbitrary-abelian theorem therefore genuinely needs the minimal-overgroup
argument, not a presumed Hall/Sylow argument.

The [nonabelian geometric counterexample](93_NONABELIAN_DECK_RIGIDITY_BOUNDARY.md)
is retained separately with its exact certificate. Non-Galois first legs
and nonabelian Galois deck groups are outside this theorem.
