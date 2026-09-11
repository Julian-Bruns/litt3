# Uniform early descent through cyclic powers of five

Prove the uniform early-descent theorem (U) below. The opportunity is
to complete descent for every cyclic power of five with one geometric
argument: the integral nonlinear absorption theorem is now available
at every precision, and the later Witt stages are already proved.
The remaining task is to construct and control the actual early
comparison uniformly, including displacement degrees five and higher.

The degree125 bootstrap is established, with its genuine global-oper
construction included below. Extend the mechanism through the first
nonpolarizable degrees and arbitrary precision. A proof of (U) would
complete full-tower descent for this entire cyclic family, rather than
one further degree. A different geometric proof of (U) is equally useful.

## 1. The actual cover and the target

Work over k=overline(F5). Put p=5 and W_j=W(k)/(p^j). Let a>=4,
q=p^a, and let h:T→C be an ACTUAL connected finite etale cyclic-q
cover of smooth projective curves, with g(C)>=2.

Fix an active admissible nilpotent projective connection on C and its
weight-one maximal-Higgs projective periodic tuple. Retain the full
preceding filtered flat object, prescribed graded identification and
actual square-trivial flat periodicity line. The upper special-fiber
data are the original pullbacks. A compatible W_j curve carries this
specified full tuple through W_(j-1).

Let V_S=H^1(S,T_S), and let Psi_S be the actual Frobenius-semilinear
Hodge-projection operator. Assume Psi_C has a bijective part of dimension
3g(C)-4 and one zero line, and dim ker Psi_T=2. Use

    rho(S+xi)=rho(S)-Psi_S(xi),    epsilon=[rho] in coker Psi_S.

Coefficient Witt Frobenius fixes the abstract deck generator sigma;
it does not send sigma to sigma^5. Write e=sigma-1 and
N=sum_(i=0)^(q-1) sigma^i, retaining source and target Frobenius twists.

Fix a GIVEN compatible initial reference C_(a+3)^0 and its lift of
the ORIGINAL cover, with their W2 marking. Later lower curves need
not remain on this reference tower.

**(U).** For every 2<=n<=a, suppose compatible C_n and the original
marked cover h_n:T_n→C_n are given, extending that initial marking.
If the GIVEN T_n has a compatible W_(n+a+1) extension, its GIVEN
W_(n+1) truncation descends compatibly along the original map:

    h_(n+1): T_(n+1)→C_(n+1),

where C_(n+1) extends the given C_n. The specified Hodge line,
projective graded map and actual flat periodicity line are pullbacks.
Lower compatibility is part of the conclusion.

At n=2 use the compatible initial reference. At n>=3, the chosen next
lower reference may be incompatible; its obstruction must be retained.
The target recovers the GIVEN upper truncation, without asking the
given longest extension itself to descend to its full precision.

Together with the known late theorem, (U) gives descent and algebraization
of EVERY GIVEN full compatible cyclic-q tower for every a. In the
existing ordinary-opposite-endpoint/two-defect/Galois-leg reduction,
this removes the remaining nontrivial-five-action cyclic carriers with
unbounded actual five-part. A geometric counterexample to (U) would
instead identify a real early obstruction or insufficient look-ahead;
it need not disprove infinite-tower descent. If the proposed normal form
fails while (U) survives, an explicit actual term and corrected uniform
comparison would also resolve the mechanism at issue.

## 2. Established geometric inputs

These facts are available for use, including the stronger results that
would otherwise be natural intermediate targets.

The actual source and normal cohomology lattices on a descended smooth
reference are free of rank r=3g(C)-3 over the relevant Witt deck ring.
Their Fitting parts have ranks r-1 and1. In normalized nil-block bases,

    Psi_nil=e²Phi,   R=k[e]/e^q,
    ker Psi_T=k e^(q-2)+k e^(q-1),
    coker Psi_T=R/e²,   h*(ker Psi_C)=k e^(q-1).

Here Phi is coefficient Frobenius. The base operator is identified on
invariants first, then on augmentation coinvariants using the norm.
Negative tangent H0 and Cartan--Leray justify freeness; no abstract
module is substituted for the actual cover cohomology.

The pulled-back two-affine normal Cech complexes have integral deck-linear
sections and primitives before division. Maximal Higgs identifies the
normal line with the tangent line. Tangent H1 pullback is injective for
the original map. Compatible Hodge lines and marked maps are unique;
maximal graded Higgs automorphisms are scalar, hence trivial projectively.

Full original-map tower descent is proved for q=5,25,125. At125,
GIVEN T6 descends its GIVEN T3, and GIVEN T7 descends its GIVEN T4;
the initial third normal class is d^5e. The proof uses the combined
integral variable, not a false square-filtration rule for separate repairs.

For EVERY a>=2, descent is already proved for n>=a+1:
GIVEN compatible T_(n+a+1) descends its GIVEN T_(n+1), starting from
given compatible C_n and the original map. The proof retains every
relevant additive scalar-feedback digit and the auxiliary norm error.
Thus the new range in (U) is only 2<=n<=a, a>=4.

Once all stages descend, uniqueness makes the maps an inverse system.
Compatible ample canonical bundles and Grothendieck existence algebraize
the original finite etale cover, its deck action and the specified tuple.
These effectivity and later-induction steps may be used directly.

## 3. A uniform nonlinear absorption theorem, now proved

Put O=W_(a+1)(k), M=Fun(Z/q,O), sigma f(s)=f(s+1), and
B_i(s)=binom(s,i), P_j=span_O(B_0,...,B_j). Equivalently M is the
rank-one regular Witt deck lattice; e^(q-1) modulo5 is the invariant line.

Let A:M→M be ANY additive deck-equivariant map with A mod5=e².
Mixed noncommuting coefficient-linear/Frobenius corrections are allowed.
For each d>=2, let Q_d:M→M be deck-equivariant and a finite sum of
diagonals of d-additive maps of underlying Z/p^(a+1)-modules. The
individual d-additive presentations need NOT be deck-equivariant.

The following statements are proved:

    Ay=sum_(d=2)^(a+1) p^(d-1) Q_d(y)
       implies y mod5∈k e^(q-1);                        (A1)

and, for m>=2,

    Ay=Neta+sum_(d=2)^(1+floor(a/m)) p^(m(d-1)) Q_d(y)
       implies eta∈pO and y mod5∈k e^(q-1).             (A2)

The needed pure norm theorem is also available:

    coker A ≅ O ⊕ e W_a(k),   [Neta]=(p^a eta,0).

Norm solubility forces eta∈pO and has exactly the invariant solution
reductions. It applies to arbitrary mixed additive correction operators.

Here is the stronger filtration mechanism behind (A1)--(A2), to specify
their scope. For (A1), preceding equations force

    y mod p^a ∈ sum_(j=0)^(a-1) p^j P_(3j+1).

The complete nonlinear error belongs to F_1=sum_(j=1)^a p^j P_(3j-1),
and F_1⊂A(E_1), where E_1=sum_(j=1)^a p^j P_(3j+1)⊂pM.
For (A2), the corresponding input degrees are 2j+2, and

    F_m=sum_(j=m)^a p^j P_(2j+4-2m)
       ⊂ A(sum_(j=m)^a p^j P_(2j+6-2m)).

Double binomial integration constructs the preimages. Its wrap terms
vanish at exactly these weighted precisions because the integration
degree is <p^j. The remaining additive correction gains p and can be
removed by a finite geometric series. Thus subtracting an absorbed
nonlinear error never changes the leading given deformation digit.

This argument already works at d>=5 WITHOUT dividing by d!. Indeed,

    sigma^s v=sum_i binom(s,i)e^i v

at the appropriate quotient precision. Substitute this into any
d-additive presentation of Q_d, then use equivariance of Q_d itself.
Products of integer binomial polynomials have integral expansions and
degrees add. Evaluating at the zero sheet gives the required degree
bound. Equivariance of the individual presentation is unnecessary.
Frobenius fixes the integer binomial coefficients.

Exact tests include q=5,25,125,625 over unramified quadratic coefficient
rings, noncommuting additive corrections and quintic nonlinearities:
240 coefficient-basis generators and 80 nonlinear examples pass.
These test the algebra, not an actual all-order Hodge comparison.

Consequently it is enough to construct the ACTUAL early nil equation
after one transport y=Phi(x) in the form (A1) or (A2), with the same
leading x and the actual lower norm error. Another geometric argument
with the same descent conclusion can replace that proposed route.

## 4. Genuine global opers provide the finite comparison chart

The following construction is established at the degree125 precision.
Its uniform extension, rather than its low-order repetition, is the task.

A chosen smooth lower reference has genuine global projective filtered
oper extensions, since H1(omega²)=0. They retain the previous tuple,
grading and actual flat two-torsion line, although their next periodicity
equation may fail. Such opers are valid higher inverse-Cartier inputs.

The integral tangent module is regular, so its dual cotangent is
projective over the Witt group ring. Splitting the formal augmentation
ideal onto its cotangent gives equivariant coordinates around the
descended fixed reference, over the finite reference ring. Cohomology
frames are obtained similarly. This uses projectivity, not averaging
by q or formal smoothness alone.

Keep the genuine GLOBAL input-oper scalar variables independent of
the LOCAL output Hodge graphs. Integral Serre duality makes H0(omega²)
a regular dual, and the scalar Cech sequence has a deck-linear projection
onto global scalars. The input IC output always exists. Normalize local
output graphs and project their scalar discrepancy onto H0(omega²).
Solve that projected scalar equation with the normal boundary and
ordinary equations. Only afterward impose nil normal cohomology.
When it vanishes, the graphs glue and the projected scalar equation
becomes actual periodicity. Actual compatible tuples solve this system.

Thus nongluing local Hodge graphs are never used as preceding IC inputs.
Compatible cochain identifications and finite homological perturbation
extend the reference splittings over the parameter ball. The preceding
graph is the appropriate reduction of the SAME graph in the given tuple;
the preceding input scalar is needed only to the precision read by IC.

For curve displacement p^(m+1)x, graph p^m u and scalar p^m R,
the finite equations have integral invertible boundary/scalar/ordinary
blocks and their scalar feedback raises valuation by2. At the degree125
precision this yields

    Lx=Neta+pQ2(x)+p²Q3(x)+p³Q4(x),    m=1;
    Lx=Neta+p²Q2(x),                    m=2.

The descended error is retained before projection as Neta. For the
initial compatible reference it is zero. At later stages its leading
coefficient is the zero-line obstruction of the ACTUAL chosen lower
reference. A new compatible lower reference is not presumed.

## 5. The higher-degree issue to resolve

Use the exact normal graph and scalar equations, not only first variations:

    c+d s_j-s_i a-s_i b s_j=0,

and, for H=(1,s)^t, V=nabla H, D=det(H,V),

    r_new=det(nabla V,V)/D-D''/(2D)+3(D')²/(4D²).

For a companion input D=1+s'-rs². The square-root normalization is
5-integral. The corrected filtered/graded construction is

    Jtilde=epsilon [[lambda,p lambda'/f'],[0,lambda^-1]],
    nablatilde=p partial+[[0,p²r],[1,0]],  lambda²=f'.

The diagonal uses the NEW prescribed graded map and the upper entry
the PREVIOUS filtered map. The actual flat epsilon is retained.

For K_0=I, K_(j+1)=p partial K_j+B_r K_j, v_p(K_j)>=j-1 and
(K_5)21=p^4(r²+3r''). A Taylor variation with ell changed factors
has coefficient 1/(ell!(j-ell)!). Track this full coefficient, including
factorials divisible by p. The desired normalized degree-d valuation
is m(d-1), uniformly in all orders that survive at precision p^(a+1).

The first new issue at a=4,m=1 is the quintic normal term; in general
polarization by d! is unavailable. Section3 removes the need for an
EQUIVARIANT polarization. What remains is to justify integral additive
presentations of the ACTUAL homogeneous terms, and their weights,
after all scalar, boundary and ordinary eliminations.

Distinguish termwise integral presentations from pointwise integrality.
For example delta(u)=(Phi(u)-u^5)/p is integral on Witt coefficients
but is not itself an integral homogeneous additive polynomial. Retaining
the weighted curve input gives the exact identity

    delta(p^(m+1)x)=p^m Phi(x)-p^(5m+4)x^5.

This identity and its nonprime-field checks support the proposed weight
bound, but do not control every divided term of the actual functor.
Any analogous division involving a previous Hodge repair must retain
the factors supplied by the corrected filtered/graded construction.
Keep inverse coefficient Frobenius explicitly when eliminating the
ordinary block; an ordinary derivative of Frobenius would be zero.

A possible proof is a precision-uniform calculus closed under these
actual operations, including scalar feedback, with coefficient norm
terms retained. The composition-tree rule adds d_i-1 to external
displacement degree minus one; establish that its hypotheses survive
the divided Taylor and Witt operations before applying it generally.

## 6. Objective completion list

1. Construct the actual early comparison at arbitrary a and 2<=n<=a,
   retaining global input opers, the marked upper tuple, its previous
   filtered member, grading and actual flat twist.
2. Prove the uniform valuation and integral presentation statement for
   every surviving nonlinear degree, beginning with the quintic case.
   Include coefficient Frobenius, inverse Frobenius and divided terms.
3. Eliminate the auxiliary variables without assuming earlier nil
   compatibility or a compatible lower next reference. Identify the
   resulting norm coefficient with the actual lower obstruction.
4. Apply the supplied absorption theorem to recover the GIVEN next
   truncation and conclude (U). Independently check a decisive new
   degree-five calculation and the general precision argument.
5. State the full-tower consequence through the known late induction,
   or give an actual geometric obstruction to the proposed theorem or
   normal form with its precise effect on the next approach.

If a new technical identity appears during this work, pursue it as part
of the same task. Quality is more important than speed: take the time
needed for the construction, calculation and independent review, and
follow the concrete mathematical routes available before concluding.
Concentrate the final write-up on the new argument and use the supplied
algebra and finite results where they already suffice.

The primary constructions are
[LSZ, Theorem4.1 and Lemmas4.7/4.10](https://arxiv.org/html/1311.6424v4)
and [LSYZ, Section6](https://arxiv.org/html/1404.0538v2).
