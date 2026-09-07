# Prime-ratio diamonds and the corrected coefficient reduction

Cleaned by /root, 2026-09-06; parameterized corollaries and consolidation
by /root/library_generalization_cleanup_max, 2026-09-07 (author prose,
not a new independent audit). The numbering below is retained for
dependencies. The previously asserted general quadratic intersection
was rejected by the 2026-09-04 audit of c14_elliptic_translation:
[audit metadata](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md).
Its invalid proof and unconditional divisor list have been removed.
The complete corrected replacement is
[file81, independently audited PASS](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md).

The prime-ratio diamond, norm bound, nonpencil theorem, case A, and
direct case-B Prym inequality below are retained. The quadratic-square
conclusions in case B require the displayed EXTRA intersection hypothesis;
it is automatic when the coefficient degree is two. This is a reduction,
not an all-degree common-cover exclusion.

All curves are smooth projective connected over an algebraically closed
field. Let r be an odd prime and g(X)=s+1, g(Y)=rs+1, s>=1.

## 1. The prime-ratio diamond (Theorem 68.1)

A common finite etale cover gives an equal-degree diagram

    V --a--> Y,     V --p--> C --c--> X,
    deg(p)=r,      deg(a)=deg(c)=M,

where p is a C_r-torsor with generator beta and a beta!=a.

**Proof.** Take a Galois closure W->X of a common cover, with group G
and induced degree-N etale map W->Y. Riemann--Hurwitz gives |G|=rN.
A Sylow r-subgroup P has order r^{v_r(N)+1}, so W->Y cannot descend
through W/P. In a composition series
1=P_0 normal P_1 normal ... normal P_j=P, with successive quotients C_r,
choose the first step where the map ceases to be invariant. Set
V=W/P_i, C=W/P_(i+1), M=N/|P_i|. The induced maps are etale and
deg(C/X)=|G|/(r|P_i|)=M. QED.

## 2. Norm obstruction (Lemma 68.2, Theorem 68.3, Corollary 68.4)

**Lemma 68.2.** If p:R->D is finite separable of degree r and b:R->Y
is finite, then p_*b^*=0 on Jacobians implies a degree-r pencil on Y.

**Proof.** The Rosati-dual homomorphism is induced by the family
d |-> O_Y(b_*p^*d) in Pic^r(Y). If it is zero, these moving divisors
lie in one complete linear system. They have no common base point:
for any y, parameters whose divisor contains y form the finite set
p(b^{-1}(y)). The family is nonconstant since b is surjective. Thus the
complete system is basepoint-free and has positive dimension. Two
suitable sections without common zeros give a degree-r map to P1. QED.

Assume J(Y) is absolutely simple and Y has no degree-r pencil.
For h=p_*a^*:J(Y)->J(C), the lemma implies h!=0, hence dim im(h)=rs+1.
The composite c_*h is zero because g(X)<g(Y). Thus

    rs+1 <= dim Prym(C/X)=(M-1)s,  so M>=r+2.       (68.13)

This is Theorem 68.3. If char(k)!=2,r and Y is hyperelliptic,
the missing pencil hypothesis follows: a degree-r map and the
hyperelliptic map have coprime degrees and generate k(Y), so
Castelnuovo--Severi would give g(Y)<=r-1, a contradiction.
This is Corollary 68.4.

## 3. The coefficient curve and nonpencil result (Proposition 68.4a)

For the remainder assume char(k)!=2,r, Y hyperelliptic with simple
Jacobian, and write k(Y)=k(t,z), z^2=f(t). Put F=k(C), K=k(V).
The element t is primitive in K/F: if beta fixed t, its odd order
would also force it to fix z, contradicting a beta!=a.

The homogeneous norm of the hyperelliptic pencil is a degree-r binary
form. Its r+1 coefficients generate a basepoint-free line bundle L on C
of degree2M. Their span W satisfies

    3 <= dim W <= r+1.                              (68.17a)

**Nonpencil proof.** Dimension one cannot generate a positive-degree
line bundle. If dim W=2, the coefficient pencil expresses V as the
normalized integral fiber product of maps

    C -> P1_b of degree2M,   R:P1_t -> P1_b of degree r.

Let A be the 2rs+4 hyperelliptic branch points and B=R(A).
For b in B put k_b=|A intersect R^{-1}(b)| and let l_b count the
other points in that fiber. Etaleness of V/C and the fact that
V->P1_t has local indices2 on A and1 elsewhere imply a common
local index2*rho_b for every point of C above b, and indices rho_b
at the A-points and2*rho_b at the other points of R^{-1}(b).
Consequently

    r=rho_b(k_b+2l_b),  rho_b in {1,r},  k_b odd.

The contribution above b to Diff(C/P1_b) is at least
(M/rho_b)(2rho_b-1)>=M. Its total degree is2M(s+2); hence |B|<=2s+4.
Since k_b<=r, |B|>=ceil((2rs+4)/r), and the sum of the odd k_b is
even. Thus |B| is2s+2 or2s+4. The same index identities give

    R^*B = A modulo2.

The double cover of P1_b branched at B therefore receives a degree-r
map from Y. Its genus is s or s+1, positive and strictly below g(Y),
contradicting simplicity of J(Y). QED.

Let B now denote the smooth normalized coefficient image, with
q:C->B, coefficient degree e=[F:k(B)], and image degree d. Thus
L=q^*A_B, deg(A_B)=d, and ed=2M. Put E=k(B)(t).
The degree-r norm polynomial is irreducible over F, hence over k(B).
The incidence equation has bidegrees r,d, giving

    [E:k(B)]=r,  [K:E]=e,  [E:k(t)]=d,  FE=K.

## 4. Correct scope of the square-root dichotomy (Theorem 68.5)

### A. z belongs to E — unconditional

The maps V->E->Y are finite etale, of degrees e and n=M/e=d/2.
Trace functoriality and Lemma68.2 give

    q_*h=[e](E/B)_*(E/Y)^* != 0,
    rs+1 <= g(B) <= ns+1,  n>=r.

With eta_A=ns+1-g(B), Riemann--Hurwitz gives

    deg Diff(C/B)=2e eta_A,  deg Diff(E/B)=2r eta_A.

Thus these lower maps are etale simultaneously; n=r forces eta_A=0.
For separability of C/B, base change by E gives K/E, which is an
intermediate extension of the etale extension K/k(Y).

### B. z does not belong to E — unconditional part

Set E'=E(z). Then E'/E is quadratic, e is even, [K:E']=e/2,
and E'->Y is finite etale of degree d. Always

    q_*h=0,  im(h) subset Prym(C/B),  g(B)<=(M-r)s.  (68.27)

**Proof.** Let gamma generate E'/E and b:E'->Y. It induces the
hyperelliptic involution on Y. For pi:E'->E,

    pi^* pi_* b^*=(1+gamma^*)b^*=0,

so pi_*b^*=0, since pi^* has finite kernel. Factor the full trace
V->B through E'->E->B to obtain q_*h=0. The dimension of im(h)
is rs+1, giving (68.27). This proof uses no field-intersection formula.
The extension C/B is separable, for example by file81's full-orbit
construction, so the stated Prym dimension is valid. QED.

### B. Additional quadratic-square consequences — CONDITIONAL

Impose the extra hypothesis

    D=F intersect E' has [D:k(B)]=2.                 (*)

Then m=e/2, [F:D]=m, [E':D]=r, and F tensor_D E'=K: the equality
of the latter degree with [K:F]=r proves linear disjointness.
The normalized square has lower maps C->D and E'->D of degrees m,r.
Writing h_D=(E'/D)_*(E'/Y)^*, Lemma68.2 and base change give

    h_D!=0, h=(C/D)^*h_D,
    rs+1 <= g(D) <= ds+1,  d>=r,
    eta=ds+1-g(D),
    deg Diff(C/D)=e eta,  deg Diff(E'/D)=2r eta.

Thus d=r forces eta=0. Hypothesis(*) is automatic when e=2:
then E'=K, so F intersect E'=F and [F:k(B)]=2.
It is NOT justified in general by compositum degrees.

## 5. Correct replacement for the former divisor list (Corollary 68.6)

The old unconditional case-B list was based on the invalid intersection
step. Its INITIAL-INTERVAL conclusion has since been repaired by the
audited signed-orbit argument below; the unrestricted prime-M claim has
not. First use
[file81, Theorems81.1--81.2](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md):
the coefficients of the FULL interpolation polynomial Q(t_i)=z_i
generate an intermediate field D with

    j=[D:k(B)]<=2^r,  m=[F:D],  e=mj,
    m divides M,  N=M/m=jd/2>=r.

Here j=1 is case A; otherwise j is even. For r3,
j is in {1,2,4,8}. This retains all sign choices and replaces the
unproved quadratic intersection. Its proof and group refinements are
retained in file81, not duplicated here.

The unconditional odd-degree observation survives: odd e implies
case A, so odd e>1 forces M>=3r. The all-prime Hadamard argument in
[the same proof, Corollary82.4](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md#corollary824)
gives M<2r+2 => j in{1,2}, and r+2<=M<2r => m=1,e=j in{1,2},
WITHOUT(*). Stronger all-degree quadratic-square claims still require(*).

The coefficient dimension gives a further unconditional case-A sieve.
Put w=dim W and write d-1=u(w-2)+v, 0<=v<w-2. The Castelnuovo bound
for the birational nondegenerate degree-d coefficient image gives

    rs+1 <= pi(d,w-1):=(w-2)u(u-1)/2+uv,  d even,
    M=ed/2 >= re.

This uses its normalization B, not the possibly singular image genus.
For r=7,s=2 and w=3,4,5,6,7,8, the least permitted even d is respectively
8,10,12,14,16,18. Thus odd e>1 requires M at least21,21,21,21,24,27.
These are necessary lower bounds, not assertions that the endpoints occur.

## 6. Quadratic coefficient maps, uniformly in r and s

Suppose e=2 and put b=g(B). Then K/B is Galois with group C_(2r) or
D_(2r). The reduced branch divisor of C/B has degree

    Delta=2Ms-4b+4,
    g(E)=r(b-1)+1             in the cyclic case,
    g(E)=b+(r-1)Ms/2          in the dihedral case.

Indeed the splitting field L of P over B lies between E and K, so
[L:B] is r or2r. In the first case L/B and the quadratic F/B are
Galois with compositum K; in the second L=K. Every inertia subgroup
meets Gal(K/F)=C_r trivially and hence has order at most2. In C_(2r)
it dies in E/B; in D_(2r) a reflection has cycle type1 2^((r-1)/2).
Riemann--Hurwitz gives the formulas.

If z belongs to E, etale E->Y has degree M/2; comparison forces
M even, b=Ms/2+1, and C/B etale. If z does not belong to E, C/B
may still be etale: the converse is not asserted.

The incidence maps E->B and E->P1_t generate k(E). Castelnuovo--Severi
therefore gives g(E)<=r b+(r-1)(M-1). In the dihedral case this yields

    b>=1+M(s-2)/2.

In particular b=0 is impossible for s>=2 (also in the cyclic case,
where it would give g(E)=1-r). This recovers the group/genus theorem
of the degree-seven, genus-three special case without restricting w.

Even when the lower maps in a normalized square are etale, a chosen
deck action need not descend without compatible descent data. When their
differents are nonzero, matched ramification can disappear after the
normalized base change. Neither issue is repaired by a field intersection.
