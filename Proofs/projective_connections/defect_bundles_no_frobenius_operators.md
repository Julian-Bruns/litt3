# Proof: a Frobenius slope band and the exact one-step obstruction

Author /root,2026-09-09. No independent audit or novelty claim.

## 1. A general two-bundle criterion

Work on a smooth projective curve D of genus>=2, with absolute Frobenius
F and canonical bundle omega. Suppose A,B satisfy, for every degree-zero T,

    Hom(omega^m tensor T,A)=Hom(omega^m tensor T,B)=0  (m>=1),
    Hom(A,omega^m tensor T)=Hom(B,omega^m tensor T)=0  (m<=0). (2)

Suppose F^*A and F^*B have filtrations by line bundles omega^a tensor T,
1<=a<=p-1, deg T=0. A common finite étale cover on which this holds
suffices: Frobenius base change and faithful pullback detect morphisms.
Apply the argument below on each connected component of that cover.

For e>=1 the graded exponents of F^(e*)A are p^(e-1)a>=1. Adjunction
and (2), applied successively to its filtration, give

    Hom(A tensor L,F^e_*(B tensor M))
      =Hom(F^(e*)(A tensor L),B tensor M)=0.

Finite Frobenius duality on a smooth curve gives

    F^(e!)(B tensor M)=F^(e*)(B tensor M) tensor omega^(1-p^e).

Its graded canonical exponents satisfy

    p^(e-1)a+1-p^e <= 1-p^(e-1) <=0.

Right adjunction and the second half of (2) therefore give

    Hom(F^e_*(A tensor L),B tensor M)
      =Hom(A tensor L,F^(e!)(B tensor M))=0.

This proves the criterion, including arbitrary degree-zero twists. The
duality formula follows from F^!omega=omega and the projection formula;
it is not the incorrect assertion that F_* is both left and right adjoint
to plain F^*. No stability of Frobenius pushforwards is required.

## 2. The Raynaud bundle

On D=C^(1), B_C may be written using absolute Frobenius as F_*O_D/O_D.
This is the usual relative sequence transported by the canonical base-
Frobenius isomorphism of underlying schemes; no k-linear identification
of C with C^(1) is asserted. Cartier gives B_C⊂F_*omega_D.

For m>=1, left adjunction gives

    Hom(omega^m tensor T,B_C)
      ⊂H0(omega^(1-pm) tensor T^(-p))=0.

For m<=0, the quotient F_*O→B_C and right adjunction give

    Hom(B_C,omega^m tensor T)
      ⊂H0(omega^(1-p+pm) tensor T^p)=0.

Both exponents are strictly negative, so (2) holds.

The algebra F^*F_*O has multiplication to O and the unit splitting.
Its augmentation ideal I is therefore isomorphic, as a bundle, to F^*B_C.
Locally it is (epsilon) in O[epsilon]/epsilon^p; changing the uniformizer
shows I^a/I^(a+1)=omega^a, 1<=a<=p-1. This proves the required filtration.
This is also the structure in
[Sun, Section2, Lemma2.1](https://arxiv.org/pdf/math/0611360), whose local
augmentation-ideal proof was checked. The argument here includes its
unit splitting specifically for W=O.

## 3. Dormant and active tangent bundles in characteristic five

The canonical tangent-bundle theorem proves V_r stable of slope g(D)-1
and gives F^*V_r=J^1(omega_D^2), with graded pieces omega_D^3 and
omega_D^2. These exponents belong to {1,2,3,4}. Stability and the strict
slope inequalities prove (2), also after degree-zero twists.

The active bundle E_r becomes V_(r+q)⊕V_(r-q) on its canonical étale
double, including the split case. For two active data use a connected
component of the fiber product of their doubles; it still surjects onto D.
The tangent-bundle theorem gives the same stability and jet description
after this étale pullback. Raynaud bundles pull back to Raynaud bundles.
Thus all cross-pairs in the statement satisfy Section1. No ordinariness
assumption is used, and a connection with a nonzero tangent space is allowed.

## 4. The actual joint image does not create new operators

If nu:D→Gamma is the normalization of an integral curve, pushforward is
fully faithful on torsion-free coherent O_D-modules. Locally write
R⊂S⊂K for an affine ring, its finite normalization and its function field.
Any R-linear map between torsion-free S-modules extends uniquely to a
K-linear map and hence commutes with every s∈S. It was already S-linear.

Factor a as nu followed by Gamma⊂A0. Closed-immersion pushforward is
fully faithful, and absolute Frobenius commutes with a. Therefore each
Hom on A0 in the statement equals the corresponding Hom on D, proving
its vanishing. For a jointly minimal actual span, the two Abel embeddings
give exactly such a finite birational a; neither map has been discarded.

## 5. The precise literature consequence, not a cover exclusion

[Baudin, Generic vanishing theory in positive characteristic,
v2,16June2026](https://arxiv.org/html/2507.00771v2) improves the
Hacon–Patakfalvi framework. Definition2.1.5 passes to crystals by killing
nilpotent modules; Theorem3.1.4 gives Fourier–Mukai vanishing up to
nilpotence; Theorem3.2.1 is an equivalence at that quotient level. Its
proof explicitly discards nilpotent kernels and cokernels. These statements
and that proof were read directly, not inferred from the abstract.

Our result is stronger than observing that the natural operator on the
trace kernel is zero: NO nonzero operator exists on the listed bundles
or their birational joint-image pushforwards. Hence merely applying those
theorems to the defect sheaf cannot prove its cohomology vanishes. The
finite-level trace sequence or another larger object must be retained.
This does not invalidate any generic-vanishing theorem and does not settle
the two-leg restricted-theta or indigenous-ordinariness problem.
