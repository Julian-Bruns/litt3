# Defect-neutral descent across the first non-Galois wild degree

Settle the degree-five descent theorem (N5) below. The opportunity is to extend the completed cyclic descent machinery to primitive covers. The first new degree already contains A5 and S5 monodromy, and an explicit integral norm mode identifies where genuine geometry must enter.

This is one theorem about an actual finite etale map and a GIVEN compatible Witt tower, uniform in genus, positive defect and tower length. A proof would also give defect-neutral descent for arbitrary finite Galois covers. An actual counterexample would identify a fundamental limit of that strategy. Resolve the geometric question using the concrete module calculation below as a test.

## 1. Actual data and target

Work over k=overline(F5), W=W(k), W_j=W/(5^j). Let h:T→C be a connected finite etale map of DEGREE FIVE between smooth projective curves of genus at least two. No Galois assumption is made.

Fix a regular active admissible nilpotent projective connection r_C and its specified weight-one maximal-Higgs periodic tuple. Active means nonzero nilpotent p-curvature; admissible means nowhere-zero p-curvature. These conditions do not mean indigenous ordinariness. Let r_T=h*r_C with the actual pulled-back tuple.

The tuple includes the preceding filtered flat object, its Hodge line, the prescribed projective graded identification, and its actual flat square-trivial periodicity line. A compatible W_j curve carries this full tuple through W_(j-1), with all truncations agreeing. Use the higher inverse-Cartier construction for this full input.

For S=C,T put

    V_S=H^1(S,T_S),
    d_S=dim ker Psi_S=dim T_(r_S) N(S),

where Psi_S is the Frobenius-semilinear Hodge-projection operator and N(S) is the fixed-curve nilpotent-oper scheme. Retain all relative Frobenius twists. The obstruction convention is

    rho(S_(n+1)+xi)=rho(S_(n+1))-Psi_S(xi).

Assume the cover is DEFECT-NEUTRAL:

                         d_T=d_C=d>0.                 (D)

The nilpotent Fitting part of Psi_C can have long strings; its dimension need not equal d. No condition on the Galois closure's defect is imposed.

Fix the canonical marked W2 data C_2,T_2 and the original h_2. A GIVEN full compatible tower (T_j)_(j>=2), with this marking and the specified previous tuple at every level, is supplied.

**(N5).** There is a unique compatible tower (C_j)_(j>=2) extending C_2 and finite etale maps

                         h_j:T_j→C_j,

extending the ORIGINAL h_2, compatible under truncation, such that the GIVEN upper tuples are their actual pullbacks. The source at every precision is the GIVEN T_j. The formal maps algebraize to a finite etale map over W with the same special-fiber marking.

Lower compatible lifts beyond W2 are a conclusion. The target descends an existing upper tower; it does not assert that every nonordinary connection has such a tower.

If (N5) is false, construct an actual smooth projective example with the stated connection, defect equality and full compatible upper tower, and prove that the original map cannot descend. A failure of a finite lift with no compatible continuation does not refute this full-tower statement. A finite geometric construction together with a proved continuation mechanism would suffice.

## 2. Established inputs

### Prime-to-five neutral descent

For an arbitrary connected finite etale cover of degree prime to five, equality (D) identifies the entire completed fixed-curve nilpotent germs and descends EVERY given compatible W_j lift along the original map at the same precision. Full towers algebraize. Galoisness and endpoint ordinariness are unnecessary.

The proof splits pulled-back and trace-zero directions using normalized trace. The latter block of the actual Hodge operator is bijective by defect equality. This proof cannot simply divide the degree-five trace by five.

### Uniform cyclic descent with one additional defect

For EVERY cyclic cover of degree 5^a, full original-map descent is proved under these different hypotheses: Psi_C has a bijective part and one ZERO line, d_T=2, and the specified compatible initial lower reference is available. In regular deck coordinates its nonordinary block is

    e^2 Phi on R=k[e]/e^(5^a), e=sigma-1.

All early and later Witt stages and all nonlinear displacement degrees have been handled. Coefficient Frobenius fixes the abstract deck generator. The proof recovers given truncations through finite look-ahead, retaining the actual lower norm error and both Frobenius twists. Use this whole result directly: the new task is (D), including primitive degree-five monodromy.

### Available integral geometric calculus

On a genuine descended reference, extend the actual preceding object as a GLOBAL filtered oper, retaining grading and the flat periodicity line without imposing its next periodicity equation. Such extensions exist because H^1(C,omega_C^2)=0.

Use genuine global input opers as independent variables. Introduce LOCAL output Hodge graphs only after inverse Cartier; impose boundary, global scalar and bijective cohomology equations before the remaining obstruction. Thus an unglued output graph is never an input filtered object.

In oper coordinates the corrected construction has

    tilde J=epsilon_flat [[lambda,5lambda'/f'],[0,lambda^(-1)]],
    tilde nabla=5partial+[[0,25r],[1,0]].

The diagonal uses the NEW prescribed graded transition; the upper entry uses the PREVIOUS filtered transition. The actual flat line is retained and cancels only in the normal coefficient line.

Put P_5=diag(5,1), C_r=[[0,r],[1,0]], L_0=I,
L_(j+1)=partial L_j+C_r L_j. The Taylor matrices satisfy

    K_j=P_5 5^j L_j P_5^(-1),    v_5(K_j)>=j-1,
    (K_5)_21=5^4(r^2+3r'').

With ell changed displacement factors the denominator is ell!(j-ell)!. The bound

    j-1-v_5(ell!)-v_5((j-ell)!)>=0

gives integral ordered additive presentations at ALL degrees, including degrees at least five without polarization by their factorials. For a curve displacement 5X, expand the Frobenius numerator before dividing. In particular

    delta(5^(m+1)x)=5^m Phi(x)-5^(5m+4)x^5.

After scaling displacements by 5^m and normalizing the leading obstruction, degree-j nonlinear terms have valuation at least m(j-1). Finite additive elimination preserves the bound by the composition-tree identity sum(j_i-1)=j-1. Scalar feedback gains two factors of five. These integrality facts are already established.

For an actual cyclic-five-power etale Galois reference, negative tangent and normal cohomology are free regular deck lattices. Their pulled-back two-affine Cech complexes admit integral equivariant sections and normal primitives. Establish the needed module and splitting statements for the other groups as part of the new comparison. A closure of h may be used as a genuine cover of T; the numerical defect hypothesis remains only (D).

### Markings, uniqueness and effectivity

Finite etale covers and their morphisms lift uniquely across nilpotent thickenings once the target is fixed. Pullback on H^1(Tangent) is injective for any individual etale map: pass to its individual Galois closure and use H^0(Tangent)=0 in Cartan–Leray.

Compatible Hodge lines and projective graded identifications, when they exist, are unique. Compatible proper curve towers and finite etale algebras algebraize. These facts handle bookkeeping once actual descent is proved.

## 3. Minimal primitive case and exact norm-mode test

Transitive monodromy in degree five is C5, D10, F20=C5 semidirect C4, A5, or S5. In the S5 case let Z be the individual Galois closure and H=S4 a point stabilizer:

    T=Z/H,    C=Z/S5,    [Z:T]=24.

The GIVEN T tower lifts the actual etale H-cover uniquely, and its tuple pulls back. Its H action is available. The problem is to recover the original S5 descent datum.

The following exact model detects an essential obstruction to a purely linear proof.

On M=W^5 let G=S5 permute coordinates and H fix the first coordinate. Define

    J(x_1,...,x_5)=(sum x_i)(1,1,1,1,1).

Then

    J^2=5J,    B=J-I satisfies B^2=3B+4I.

For a five-cycle sigma and e=sigma-1,

    J=1+sigma+...+sigma^4
     =5+10e+10e^2+5e^3+e^4.                         (H)

Modulo five, ker(J Phi) is the four-dimensional augmentation module U={sum x_i=0}, with

    dim U^G=dim U^H=1,    dim U^(S3)=2,

where S3 fixes two letters. Equality of the downstairs and degree-five intermediate defects is thus compatible with FOUR defects on a closure. Endpoint equality alone does not make that closure neutral.

There is also a full UNRAMIFIED INTEGRAL mode:

    w=(-4,1,1,1,1),       J Phi(w)=0.

It is H-fixed but not G-fixed, and reduces to the invariant vector (1,1,1,1,1) modulo five. The displacement 25w agrees with zero modulo25, is G-fixed modulo125, is not G-fixed modulo625, and continues to solve the linear equation at every Witt precision. Over the torsion-free ring, the G-fixed kernel of J Phi is zero.

This is a linear model, NOT an actual curve or geometric counterexample. All assertions, including subgroup invariants and (H), have been checked exactly. The geometric task is to decide whether the actual oper/normal comparison can carry this mode, or supplies a condition excluding it. First-order equality, an unramified coefficient ring and unlimited linear look-ahead are insufficient on their own.

On a cyclic subgroup this is the e^4 threshold; the completed two-defect theorem controlled e^2. In the S5 quotient most directions are invisible to H-invariants. The issue is therefore not merely replacing e^2 by e in the previous proof.

There is a second geometric route. In the S5 case the off-diagonal component of T times_C T has two degree-four etale maps to T. The integral correspondence algebra is the two-dimensional Hecke algebra above. These are ACTUAL maps, but they can add defects; their simultaneous lifted descent datum has to be constructed.

## 4. Objective research programme

1. Establish the tangent, normal and integral correspondence modules for actual degree-five covers under (D). Retain the original subgroup embeddings. Determine restrictions on the norm mode coming from the active admissible oper, its polarization and its actual periodic tuple.

2. Construct the higher comparison using the established integral global-oper calculus. In the A5/S5 cases work with the actual H-fixed tuple or the two groupoid projections. Keep the first divided term capable of detecting 25w and the nonlinear terms needed for its continuation.

3. Decide the norm mode GEOMETRICALLY. Prove a restriction excluding it and other descent defects, or realize a surviving mode on actual curves with compatible continuation. A calculation in M alone does not complete this step.

4. Complete (N5), including recovery of the GIVEN upper tower and specified data, or construct the actual counterexample. Independently review the decisive new construction and check coefficient Frobenius outside F5. If the proof gives a finite look-ahead bound, state exactly what it establishes.

5. Explain the original two-leg consequence. In the affirmative case deduce arbitrary finite Galois neutral descent by the Sylow factorization below, preserving the same upper tower and maps.

If one route stalls, pursue the explicit operator, Hecke/groupoid and geometric-realization routes before concluding. This is a substantial research task rather than a quick formal extension of the cyclic answer. Quality is more important than speed: take as much time as the construction, calculations and independent checks need. Carry the task list through the hard geometric step and concentrate the final write-up on the new argument and decisive evidence.

## 5. How either verdict advances both curve choices

The data above do not depend on the particular main or backup curve.

If (N5) holds, let h:T→C be ANY defect-neutral finite Galois cover with group G. Choose a Sylow five-subgroup P. The ORIGINAL map T→T/P factors through etale cyclic degree-five steps, while T/P→C has degree prime to five. Injection of defect sections and equality at the endpoints make every intermediate step defect-neutral. Apply (N5), then the established prime-to-five theorem.

This descends the SAME given tower along the full original h, with arbitrary group order and positive defect. It also treats genuinely non-Galois degree-five factors.

In a span A←S→B, a compatible tower supplied by one endpoint can then be descended along these original neutral steps of the other leg. Both finite etale maps retain the SAME source. This provides a shared mixed-characteristic mechanism for either curve choice; the further curve-specific finiteness or nonexistence argument remains separate.

An actual negative example would show that neutral degree-five steps cannot be discarded on endpoint defect equality alone. It would identify the extra geometric or closure invariant needed and prevent a false extension of the common-cover strategy. It need not be a counterexample to the unmarked common-cover goal.

Primary constructions:
[LSZ, Theorem4.1 and Lemmas4.7/4.10](https://arxiv.org/html/1311.6424v4),
[LSYZ, Section6](https://arxiv.org/html/1404.0538v2),
[Stacks, finite-etale lifting](https://stacks.math.columbia.edu/tag/0BQB).
