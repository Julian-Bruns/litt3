# Uniform early cyclic comparison — focused mathematical audit

Date: 2026-09-10. Auditor: `/root/audit_uniform_early_comparison`.

Verdict: **PASS under the exact established inputs of the request.**

This audits the newly returned proof of (U), not arbitrary common-cover
descent. The new range is q=5^a, a>=4, 2<=n<=a. It includes the actual
uniform geometric normal equation, identification of its lower norm
coefficient, and recovery of the GIVEN next truncation along the ORIGINAL
cyclic cover. It is an independent prose audit, not formal verification.

The audit found no new incorrect coefficient and no required change to
the theorem. The termwise integrality argument is materially stronger
than checking integer-valued Witt expressions or low-order examples.
Some shorthand in that argument is expanded below for the permanent
proof. The pure nonlinear absorption and additive norm theorems were
used as established inputs, not re-audited.

## Inputs inspected and scope retained

I read the entire
[uniform request](../PRO_UNIFORM_EARLY_CYCLIC_DESCENT_REQUEST.md), the
returned proof, and the canonical statements/dependencies of
`cyclic_power_nonlinear_absorption` and `cyclic125_bootstrap`. I opened
the [finite global-oper construction](../../Solutions/Sol_cyclic125_bootstrap.md)
because its extension is exactly what is being audited. No old audit
body was used as a substitute for checking the new argument.

The following are hypotheses or supplied established inputs here:

- actual connected finite etale h:T->C, not an abstract deck module;
- the prescribed full weight-one tuple and actual flat two-torsion line;
- the simple-zero base operator and source defect two, giving the
  normalized nil block e^2 Phi and its stated original pullback line;
- integral regular tangent/normal lattices and deck-linear Cech
  sections/primitives on descended references;
- the finite global-input-oper/scalar-projection construction, including
  its identification with actual compatibility on the final nil zero
  locus;
- a GIVEN compatible initial reference through W_(a+3), and the stated
  original-map uniqueness, late descent and effectivity results.

In particular, this audit does not manufacture the initial reference,
assert source ordinariness, or extend the theorem to a base zero block
of dimension two. The arbitrary unmarked common-cover problem remains
outside the conclusion.

## 1. The actual higher functor and the all-order Taylor estimate

I checked the domain and gluing conventions against
[LSZ, Theorem 4.1, Lemmas 4.7--4.10 and formula 4.16.1](https://arxiv.org/html/1311.6424v4).
These use the previous filtered flat object together with the new
graded object and their prescribed identification. They do not require
that an auxiliary preceding oper already satisfy the next periodicity
equation. The divided Taylor action is part of the twisted connection,
not arbitrary division in a truncated p-connection.

Consequently it is legitimate to compute that action on a torsion-free
oper lift and reduce afterwards. In the supplied oper convention,

    P=diag(p,1), C_r=[[0,r],[1,0]],
    L_0=I, L_(j+1)=partial L_j+C_r L_j,
    K_j=P p^j L_j P^(-1).

The identity follows by direct induction from the actual tilde
connection. Every entry of L_j is an integral ordered differential
polynomial in r. Expanding r+R in those ordered products gives integral
multi-additive presentations without polarization.

For a Taylor term with ell changed displacement factors the smallest
possible coefficient valuation is

    j-1-v_5(ell!)-v_5((j-ell)!)
      >=j-1-v_5(j!)>=0,                  j>=1.

The first inequality is the integrality of binom(j,ell), and the second
follows from Legendre's formula. Thus this controls each mixed term
before collecting terms or evaluating parameters. The bound tends to
infinity, so at fixed output precision the purported series is finite.

The separate scalar-feedback claim also survives all orders. For j=1,2
the actual scalar-containing entries have a factor p^2. For j>=3,
j-1-v_5(j!)>=2. Hence variation of the genuine input scalar acquires
p^2 even after all the divided Taylor terms. There is no missing
factorial-divisible contribution that lowers this gain.

In particular, (K_5)_21=p^4(r^2+3r'') is consistent with the general
bound; its divided coefficient has valuation three. This is not a
reason to delete the genuine graph quintic, whose normalized valuation
is only four when m=1.

## 2. Frobenius divisions and integral additive presentations

The relevant variable is a curve displacement pX, not an unweighted
Witt coordinate. On an etale coordinate chart one can keep the smooth
affine rings fixed and put the deformation in their overlap maps.
An integral expansion of an overlap change begins with pX. A term of
positive displacement degree d in the Frobenius numerator therefore
has p^d, whether its coefficients occur as X or Phi(X). Dividing by the
single p in that discrepancy leaves p^(d-1), an integral coefficient.
The zero-displacement part is the genuine reference discrepancy.

This uses integral Hasse expansion, or equivalently expansion in the
completed diagonal of an etale coordinate chart. It does not require
partial^d/d! to be integral as an unsupported operator on the truncated
ring. Inverting an etale coordinate change uses its unit Jacobian.

The illustrative formula

    delta(p^(m+1)x)=p^m Phi(x)-p^(5m+4)x^5

has the claimed coefficients. It would be invalid to replace Phi(x)
by x^5 as a mixed-characteristic coefficient operation. The proof does
not do so. Nor is there an unweighted delta applied to an output graph:
the previous filtered map enters the corrected tilde transition with
a factor p, and its scalar enters the connection with p^2.

All the other normalizations have integral presentations. For example,

    (1+u)^(-1/2)=sum_n (-1)^n binom(2n,n)u^n/4^n

has coefficients integral at five at every order. Unit inversions,
products and derivations preserve ordered multi-additive presentations.
Thus degrees divisible by five present no polarization problem.

For clarity, additive degree is degree in displacement factors, not
degree in a special-fiber scalar variable after writing Phi(x)=x^5.
At a fixed finite precision and for any coefficient calculation one
may work in an unramified finite coefficient extension. In a Z_5 basis
its coefficient Frobenius and inverse are integral additive matrices.
Multiplication, the formal unit expansions, and the reference linear
maps are then ordinary integral multi-additive operations on these
additive coordinates. This explains precisely the presentations needed
by the supplied absorption theorem. It does not use pointwise
integer-valuedness to justify division of a homogeneous coefficient.

The deck action can be represented by constant permutation matrices on
each regular coordinate block. It fixes the abstract generator under
coefficient Frobenius. Naturality of the construction and the chosen
equivariant charts give equivariance of each collected homogeneous
map Q_d. The individual ordered presentations need not be equivariant;
the supplied algebraic theorem explicitly does not ask for that.

## 3. Genuine global inputs and the uniform auxiliary elimination

The reference may be extended smoothly and as a global projective
filtered oper without extending its periodicity. The obstruction to
the latter *oper extension*, not to periodicity, is H^1(omega^2)=0.
The prescribed square-trivial flat line is retained and has unique
infinitesimal lift. This creates a legitimate input for every inverse
Cartier transform used in the comparison.

The existing finite chart has no precision-specific use of dividing
by 125. Projectivity of the integral regular cotangent splits the
augmentation ideal onto its cotangent over each needed finite Witt
ring. The resulting formally etale map of smooth deformation charts
is an equivariant coordinate isomorphism. The same projective-fiber
argument gives cohomology frames. Extending the supplied contractions
uses a finite perturbation series, since the changed boundary raises
p-adic valuation. These arguments work at the arbitrary but finite
precision required here.

It remains essential to keep GLOBAL input-oper variables independent
of LOCAL output graphs. The inverse-Cartier output always exists.
Normalizing its local graphs yields local scalar discrepancies; only
their projection onto global scalars is imposed during elimination.
The input scalar enters the output with p^2, so this projected equation
has identity scalar block modulo p. Boundary and ordinary equations
have the stated invertible blocks. When the remaining nil normal
equation vanishes, all graph equations glue. Their scalar discrepancy
is then genuinely global, and its global projection being zero is
actual periodicity. Conversely an actual compatible tuple satisfies
this system and has the uniquely eliminated auxiliary variables.

This avoids both previous dangerous substitutions: a nongluing graph
is not treated as an inverse-Cartier input, and a non-descended earlier
scalar digit is not silently placed in fixed descended coefficients.
Scalar equality is imposed at the precision read by the next functor.
Unread last filtered-map and scalar digits disappear through the p
and p^2 factors, respectively. No infinite compatible reference has
been assumed.

After writing (X,U,R)=p^m(x,u,R), a degree-d term has p^(md).
Normalizing the whole discrepancy by p^m yields the uniform bound
p^(m(d-1)). This is a bound on integral presentations, not just values.

The auxiliary elimination preserves that bound. First solve the
constant auxiliary system, then translate by its solution. A degree-D
term producing degree d<=D retains p^(m(D-1)), which is at least the
required p^(m(d-1)). The full additive block has an ordered finite
inverse obtained from its invertible reduction; no coefficient
operators are commuted. Successive substitution has a composition-tree
description, and sum(d_i-1)=d-1 for its nonlinear vertices. This proves
the same weight and presentation assertion for every remaining Q_d.

Thus the stated actual nil equation is justified over W_(a+1):

    Lx=N eta+sum_(d=2)^(1+floor(a/m))p^(m(d-1))Q_d(x),
    L mod p=e^2 Phi.

The variable x is still the combined coordinate of the GIVEN curve
displacement. Auxiliary elimination does not replace its leading digit
by a separately chosen repair.

## 4. The norm constant is the lower obstruction

Merely knowing that the constant is invariant would not suffice. The
returned proof supplies the needed extra identification.

At x=0 the auxiliary solution is unique and equivariant, hence
invariant. A fixed marked curve deformation is an actual deformation
of the original cover: each deck isomorphism has a unique lift because
H^0(T,T_T)=0; uniqueness forces the group relations. The action is
free over the nilpotent thickening since it is free on the special
fiber. Its quotient is the lower smooth-curve deformation. The same
argument and the equivariant global-oper chart retain actual descended
oper data.

Restricting the boundary, global scalar and ordinary equations to
these fixed coordinates therefore gives the lower equations, not an
unrelated invariant representation. The normal reference projection
and norm identification are the specified original pullback ones.
The remaining integral invariant nil vector is N eta, and its first
coefficient eta mod p is the actual lower zero-line obstruction after
the ordinary correction. Higher reference errors remain in eta.

For n=2 the initial reference satisfies the whole comparison at the
given precision, so eta=0. For n>=3 no such compatibility is presumed;
its zero-line compatibility is subsequently forced by (A2). This
checks the precise distinction needed for the later lower-reference
case.

## 5. Recovery of the given truncation

Transporting once by y=Phi(x) gives exactly the hypotheses of (A1) or
(A2). Their conclusions are invariant leading y, and at n>=3 also
eta mod p=0. Inverse coefficient Frobenius preserves the original
invariant pullback line. The ordinary leading coordinate relative to
the corrected descended reference is zero by its invertible reduced
equation.

Hence the whole leading curve displacement is the pullback of the
base zero-line digit. Altering the actual compatible lower reference
by that digit and lifting the ORIGINAL finite etale cover reproduces
the GIVEN W_(n+1) curve with its marking. Injective tangent pullback
and the supplied uniqueness identify its map, Hodge line, projective
graded identification and original flat twist. Only that truncation
has been recovered; no step asserts that the longest given extension
already descends at its full precision.

This proves the requested (U) on its exact supplied hypotheses. The
known late theorem and effectivity then give the stated full-tower
consequence; their separate hypotheses have not been removed.

## Independent checks performed in this audit

Beyond comparing the actual formulas with the primary constructions,
I independently tested 21,702 mixed factorial inequalities through
j=2500, including split positions 5,25,125,625, and 1000 coefficients
of the inverse-square-root expansion. All passed. These are auxiliary
finite checks; the all-order arguments above do not rely on the cutoff.

The genuine graph stress test gives

    p^(-1) (p u)/(1+p u)
      =u-pu^2+p^2u^3-p^3u^4+p^4u^5 mod p^5.

It confirms that the quintic must be retained at a=4,m=1. Its integral
five-additive presentation is multiplication in five arguments, not
polarization divided by 5!. The supplied local script is useful for
the Taylor and scalar identities, but is not itself evidence for the
global input-oper chart or lower norm identification audited above.

The first normal derivative is the stipulated actual Psi; its
geometric factorization agrees with
[LSYZ, Theorem 6.2](https://arxiv.org/html/1404.0538v2).

No common-cover stratum outside the stated cyclic/simple-zero branch
was audited or excluded by this record.
