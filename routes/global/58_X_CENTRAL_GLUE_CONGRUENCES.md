# Integral gluing, hyperelliptic descent and the residual Prym

Version 3, 2026-09-08. Four original PASS scopes are retained:

- Fixed-X arithmetic and genus-one descent: /root/audit_m9_hyperelliptic,
  2026-09-04, [audit metadata](audits/53_M9_GENUS_ONE_COARSENING_AUDIT.md).
- Genus-two positivity/adjunction input: /root/audit_m9_genus2_spectrum,
  2026-09-04, [audit metadata](audits/56_M9_GENUS_TWO_COARSENING_SPECTRUM_AUDIT.md).
- Integral gluing and hyperelliptic descent:
  /root/degree45_family_endpoint, 2026-09-04,
  [audit metadata](audits/58_X_CENTRAL_GLUE_CONGRUENCES_AUDIT.md).
- Prym decomposition, polarizations and norm restrictions: the same auditor
  and date, [audit metadata](audits/60_ANTI_INVARIANT_PRYM_DECOMPOSITION_AUDIT.md).

The two involution proofs now share the gluing/intersection argument;
the genus-two case has a single congruence survivor. This rewrite has
no new independent audit. Its wider hypothesis observation is AUTHOR
prose, not an extension of those audits. The last section corrects
“noncentral” to the actually proved “not an integer scalar.”

## 1. Integral scalars on the fixed genus-three Jacobian

Over k=Fbar5 put X:v²=x⁷−x+1. Lemma 53.1 gives three pairwise
geometrically nonisogenous ordinary elliptic factors, with traces
(3,−1,−4), and

\[
 \operatorname{End}^0(JX)=
 \mathbf Q(\sqrt{-11})\times\mathbf Q(\sqrt{-19})\times\mathbf Q(i),
 \qquad \operatorname{Aut}(X)=\{1,\iota_X\}.
\]

Here is its retained arithmetic proof. The unchanged
[exact automorphism/point-count certificate](53_X_AUTOMORPHISM_CERTIFICATE.sage)
gives #X(F5),#X(F25),#X(F125)=(8,30,134). Newton identities give

\[
 P_X(T)=T^6+2T^5+4T^4+8T^3+20T^2+50T+125
       =(T^2-3T+5)(T^2+T+5)(T^2+4T+5).
\]

All three elliptic factors are ordinary; their distinct geometric CM
fields have discriminants −11,−19,−4, so they remain nonisogenous.
Every automorphism of the hyperelliptic genus-three X descends to a
projective transformation preserving its eight branch points, with
kernel <ι_X>. The finite branch polynomial has factor degrees 1,6,
so these points split over F_(5^6). A stabilizer is determined by the
images of three branch points and is therefore defined over that field.
The certificate tests ALL 336 ordered image triples and finds only the
identity. This proves the automorphism assertion over k, not only over F5.

The Rosati-fixed algebra is Q³. Every geometric endomorphism commutes
with the fixed F5-Frobenius F because this algebra is commutative.
Thus its action preserves the primary factors of the SAME geometric
Tate lattices, even if a producing correspondence is defined over an
extension. No field-of-definition assumption is hidden.

**Lemma 58.1 (cyclic collision).** Let R be a complete DVR with
uniformizer ℓ and fraction field L. Suppose two two-dimensional
F-modules have integral characteristic polynomials reducing to the
same separable irreducible quadratic q. After the unramified quadratic
splitting extension, corresponding roots differ with valuation a≥1.
If an F-stable lattice M has cyclic reduction with characteristic
polynomial q², then every scalar pair (b_1,b_2)∈R² preserving M
satisfies b_1≡b_2 mod ℓ^a.

**Proof.** Hensel idempotents split M into the two conjugate rank-two
lattices. On either, rescaling the rational eigenlines gives

\[
 R'e_1+R'\ell^{-u}(e_1+\varepsilon e_2),\qquad
 \varepsilon\in R'^\times,\quad 0\le u\le a.
\]

F-stability is exactly u≤a. The off-diagonal entry is a unit times
(α_1−α_2)/ℓ^u, so the nonsplit Jordan reduction forced by cyclicity
requires u=a. A scalar pair preserves this lattice only when
(b_1−b_2)/ℓ^u∈R'. The extension is unramified, proving the claim. QED.

**Proposition 58.2.** Every integral Rosati-fixed endomorphism, in trace
order (3,−1,−4), has integer coordinates satisfying

\[
 \lambda_1\equiv\lambda_2\pmod4,\quad
 \lambda_1\equiv\lambda_3\pmod7,\quad
 \lambda_2\equiv\lambda_3\pmod3.                     \tag{58.3}
\]

Rational coordinates are algebraic integers and hence integers. For
the remaining assertion, set P_i(T)=T²−t_iT+5. The original audited
finite-group computations in the [exact certificate](58_X_CENTRAL_GLUE_CERTIFICATE.sage)
give:

| ℓ | colliding factors | q modulo ℓ | a | n | Sylow subgroup of JX(F_(5^n)) |
|---|---|---|---:|---:|---|
| 2 | 1,2 | T²+T+1 | 2 | 3 | C2 × C16 × C16 |
| 7 | 1,3 | T²+4T+5 | 1 | 48 | C7² × C49² |
| 3 | 2,3 | T²+T+2 | 1 | 8 | C3 × C9³ |

The q are separable irreducible, with root orders n. Their trace
differences are 4,7,3; a simple-root derivative is a unit, giving the
displayed exact root-difference valuations. The certificate computes
the total Jacobian order independently as |Res(P_X,T^n−1)| and finds
a subgroup of the FULL ℓ-primary order. Randomness only finds generators;
full-order equality and invariant-factor assertions certify the result.

The corresponding ℓ-torsion fixed-space dimensions are 3,4,4.
At ℓ=2 the colliding four-dimensional factor, if split, would alone
contribute four fixed dimensions, impossible. At ℓ=7 or 3 the
noncolliding factor contributes two: its roots are (1,5) or (1,−1),
respectively. Only two fixed dimensions remain for the colliding factor,
so it is cyclic rather than two copies of q. Lemma 58.1 proves (58.3).

**Corollary 58.3 (least elliptic degrees).** The least degrees of
nonconstant maps from X to elliptic curves in these three isogeny classes
are 28,12,21. If e_i are the rational projectors and S=F+V, then

\[
 (S+1)(S+4)=28e_1,\quad
 -(S-3)(S+4)=12e_2,\quad
 (S-3)(S+1)=21e_3.                                  \tag{58.14}
\]

These are integral. Conversely (58.3) makes every integral multiple
ne_i divisible by d_i=28,12,21 respectively. Thus d_i e_i is the
primitive symmetric norm endomorphism of its elliptic image E_i; the
restricted theta line bundle has degree d_i, with polarization [d_i].
Its polarized projection composed with the Abel–Jacobi map gives X→E_i of degree d_i.
For any other f in that class, f^*f_*=(deg f)e_i, so d_i divides deg f.
This proves both existence and minimality, not merely denominator bounds.

## 2. The genus-one and genus-two involutions

For the original audited Theorems 53.3 and 58.4, assume the degree-nine
full-span [coefficient setup](47_COEFFICIENT_FIELD_COARSENING.md), with
etale c:C→X of degree nine and a double cover q:C→B, b=g(B)∈{1,2},
involution δ. Then g(C)=19 and q has 40−4b tame ramification points.
The common conclusion, also Corollary 58.5, is

\[
                         c\delta=\iota_X c.          \tag{58.15}
\]

Here is a shorter proof retaining the audited positivity and adjunction
inputs. Put u=c_*δ^*c^*, with integral coordinates λ_i. Positivity of
9 id±u gives −9≤λ_i≤9. The identity

\[
 (q_*c^*)^\dagger(q_*c^*)=9\operatorname{id}+u
\]

has rank at most 2b on H1; thus at least 3−b coordinates equal −9.

Suppose (58.15) false and put Z=(c,cδ)_*[C]. The diagonal intersection
is proper: cδ=c is impossible at a δ-fixed point, since δ has derivative
−1 and c is etale. Each of the 40−4b fixed points contributes one. The
hyperelliptic graph also meets Z properly by the supposition. Writing
S_λ=Σλ_i, the two intersection formulas give

\[
 40-4b\le Z\cdot\Delta_X=18-2S_\lambda,\quad
 0\le Z\cdot\operatorname{Graph}(\iota_X)=18+2S_\lambda,
 \quad -9\le S_\lambda\le2b-11.                         \tag{56.11}
\]

If b=1, the sum is −9 and two coordinates are −9, forcing a
permutation of (−9,−9,9). None satisfies (58.3): when the +9 is
first or second it fails mod 4; when third it fails mod 7. This proves
the genus-one case using the already audited gluing condition.

For b=2 the sum lies in [−9,−7]. Let e be the degree from C to the
reduced joint image Γ. Then e|9, and both maps through its normalization are etale, because their
composites to X are etale and differents are effective and additive.
Thus g(Γ~)=1+18/e. The actual correspondence Γ induces u/e, so
e divides every λ_i. For Q=Σλ_i², adjunction gives

\[
 p_a(\Gamma)=1+(81-Q)/e^2+36/e,\qquad Q\le81+18e.     \tag{56.17}
\]

Only ONE integral triple satisfies the interval, sum and congruence
conditions before using this last bound: (5,−3,−9). For completeness:

- If λ_1=−9, the mod-4 and mod-7 conditions with the sum bound leave
  (λ_2,λ_3)=(-5,5) or (3,-2); both fail mod 3.
- If λ_2=−9, the mod-4 and mod-3 conditions leave
  (λ_1,λ_3)=(-9,9),(-5,6),(-1,3),(3,-3),(7,-6);
  all fail mod 7.
- If λ_3=−9, the mod-7 and mod-3 conditions leave
  (λ_1,λ_2)=(-9,9),(-2,3),(5,-3); only the last passes mod 4.

For the survivor, e|gcd(9,5,3)=1, while Q=115>99=81+18e.
This contradiction proves (58.15). In particular the earlier finite
nonhyperelliptic spectra are excluded; no automorphism classification
is needed to eliminate e=9 in this proof.

The function x c descends to a degree-nine map r_X:B→P1_x, and C is
the normalization of B×_(P1_x)X, since v c is anti-invariant and
generates the quadratic extension. Etaleness of c forces r_X unramified
off the eight branch values of X, with fiber types 1^(a_s)2^(b_s)
there. The 40−4b δ-fixed points are exactly the index-one points, so

\[
       a_s+2b_s=9,\quad \sum_s a_s=40-4b,\quad
       \sum_s b_s=16+2b.
\]

These are respectively the original totals (36,18) and (32,20).

**Author scope observation.** This proof uses only the actual degree-nine
etale c, a double quotient q of genus one or two, and the fixed-X
arithmetic, not the full coefficient span or the Y-leg. Its extension
to any such (c,q) is not relabelled as part of the old audit.

## 3. Both factors lie in the Prym; genus two is impossible

Retain M=9 AND dim W=8 in the actual seven-diamond of file 47:
Y:z²=1−t³¹, the maps V→Y and C→X have degree nine, and p:V→C
is cyclic etale of degree seven. Its coefficient double q:C→B has a
lifted involution γ on V satisfying

\[
 p\gamma=\delta p,\qquad a\gamma=\iota_Ya,\qquad
 c\delta=\iota_Xc.
\]

Set J=J(Y), h=p_*a^*, A=im h, D=im c^*, and P=Prym(C/B).
By the [norm input](40_JACOBIAN_NORM_OBSTRUCTION_FOR_THE_SEVEN_DIAMOND.md),
J is simple of dimension 15, h≠0 and c_*h=0. Also c_*c^*=[9].

Norm functoriality gives δ^*h=p_*γ^*a^*=−h, while δ^*c^*=−c^*.
The images A,D are connected and anti-invariant, so q_* kills them:
its image would be connected and contained in finite 2-torsion.
Thus A,D⊂P, with dimensions 15,3. Their intersection is finite by
simplicity of A and is orthogonal by c_*h=0. If g(B)=2,
dim P=17 cannot contain their 18-dimensional sum. This is the original
Theorem 60.2 excluding BOTH genus-two full-span rows.

If g(B)=1, q is branched at 36 points, dim P=18, and its induced
polarization has type (1^17,2). Indeed the standard tame-double-cover
formula for b base genus and R>0 branch points is (1^(R/2−1),2^b):
the branch-cut pairs are unimodular and the anti-invariant base pairs
have intersection multiplied by two. The prime-to-five polarization
calculation is unchanged in characteristic five. Addition

\[
                       \mu:A\times D\longrightarrow P
\]

is an isogeny of orthogonal factors. These retain Lemma 60.1 and
Proposition 60.3.

## 4. Exact finite gluing and polarization types (Proposition 60.4)

Assume g(B)=1 throughout the rest of the proof.
Let K_c=ker(c^*:JX→D), κ=deg K_c. Then κ∈{1,3,9}. It is a
finite etale group scheme here, since its exponent divides 9 in
characteristic five. Write ρ=log_3 κ. The possibilities are:

| K_c | type of λ_D | full type of λ_A |
|---|---|---|
| 0 | (9,9,9) | (1^12,9,9,18) |
| C3 | (3,9,9) | (1^12,3,9,18) |
| C9 | (1,9,9) | (1^13,9,18) |
| C3² | (1,9,9) or (3,3,9) | (1^13,9,18) or (1^12,3,3,18) |

In all cases

\[
 \deg\lambda_D=3^{12-2\rho},\quad
 \deg\lambda_A=4\cdot3^{12-2\rho},\quad
 \deg(A\cap D)=3^{12-2\rho}.
\]

The addition kernel is purely 3-primary and is the graph of an
anti-isometry of the FULL 3-primary polarization kernels.

**Proof.** Characters trivialized by the connected degree-nine cover
give an abelian monodromy quotient whose order divides that index;
their full character group is K_c. Also c_*c^*=[9], so κ|9 and the
four listed structures exhaust it. Pullback gives

\[
                    (c^*)^*\lambda_D=9\lambda_X.
\]

Thus K_c is isotropic in JX[9]≃(Z/9)^6, and
ker λ_D=K_c^perp/K_c. The elementary symplectic calculation gives the
listed λ_D types: for C3² its plane in JX[3] is either nondegenerate
or isotropic, giving (1,9,9) or (3,3,9), respectively.
Taking degrees also gives deg λ_D=9^6/κ².

At odd primes P is principally polarized. Complementary orthogonal
factors have anti-isometric polarization kernels, with their graph as
the addition kernel. Only the prime 3 occurs for D. At two, λ_D is
principal, so addition has no 2-primary kernel; the single divisor two
of P belongs to A. Combining the primary parts gives the table and
all stated degrees. No additional 5-primary kernel is possible, since
the addition kernel embeds into the prime-to-five ker λ_D. QED.

## 5. Local restrictions on the actual norm (Proposition 60.5)

Factor h:J→A⊂J(C), let d_h=deg(J→A), and put s=h†h.
Then s is positive and

\[
 \sqrt{\deg s}=2d_h3^{6-\rho},\quad
 v_2(d_h)\equiv4\pmod 5,\quad
 v_3(d_h)\equiv\rho-1\pmod5.                         \tag{60.25}
\]

In particular the last residues are 4,0,1 for ρ=0,1,2.

**Proof.** Pullback of λ_A is λ_J s. Taking degrees gives
deg s=d_h² deg λ_A and hence the first identity.
The Honda division algebra of J has index three and center
E=Q(ζ31)^<5>. Its real subfield E+ has degree five. The integral
reduced norm n=Nrd(s) lies in E+ by Rosati symmetry, and

\[
 \deg s=N_{E/\mathbf Q}(n)=N_{E^+/\mathbf Q}(n)^2 .
\]

Both 2 and 3 are inert in E+: their classes have order five in
(Z/31)^×/<−1,5>, with 2^5=1 and 3^5=−5 mod 31 and no smaller
positive exponent in that subgroup. Thus the two valuations of
|N_(E+/Q)(n)| are multiples of five. Applying this to the first
identity gives v_2(d_h)+1≡0 and v_3(d_h)+6−ρ≡0 mod5. QED.

The endomorphism s is NOT multiplication by an integer. Indeed every
λ_A type has kernel exponent 18. If s=[m], its realization as the
quotient of mλ_J forces 18|m. But the
[norm-trace calculation](45_EFFECTIVE_CORRESPONDENCE_AND_CONDUCTOR_FORMULAS.md#3-author-norm-interval-and-induced-polarization-constraints)
gives

\[
 \operatorname{Tr}(s\mid H^1(Y))
        =378-\sum_{j=1}^6 I_j\le378 ,
\]

where the proper effective translate intersections I_j are nonnegative.
For [m], positivity gives m≥18, so the trace 30m≥540, contradiction.

This excludes INTEGER SCALARS, not every central element: non-rational
positive elements of the degree-five real central subfield E+ are not ruled out by
this argument. The retained norm interval is 0<s<[63], with the
trace bound and polarization/valuation restrictions above. These are
necessary conditions, not an existence construction or a contradiction
from the rational Honda algebra alone. The
[dihedral genus-one exclusion](61_D14_GENUS_ONE_ROW_IMPOSSIBLE.md)
is a separate argument; no arbitrary common-cover exclusion is claimed.
