# Bounded Frobenius–Steiner literature check

2026-09-07. Reference note, not a proved library dependency.

Target supplied by the active rectangular-rank reduction: on the specified
theta-complement U in P(B), dim A=dim B=32 and dim H=96, the map
A tensor O(-5) -> H tensor O has full column rank. Its quotient Q has
rank64. The fixed injection I:B->H defines the section of Q(1) whose
vanishing means I(alpha) belongs to im L_alpha. The normalized intrinsic
atlas theorem is already audited; this note does not reprove the new
theta-open equivalence or remove its hypotheses.

**Outcome:** no close primary-source theorem was found that excludes the
zeros of this particular section, or provides a cheaper exact emptiness
certificate. The two closest sources have concrete applicability gaps.
Generic emptiness from rank64>31 does not exclude this tensor's section.

## 1. Shimada: reciprocal universal incidence

Ichiro Shimada, *On Frobenius incidence varieties of linear subspaces over
finite fields*, Finite Fields and Their Applications18 (2012),337–361.
[Author's paper](https://home.hiroshima-u.ac.jp/ichiro-shimada/preprints/Frob/FIV.pdf),
Definition1.2/formula(1.3), Propositions1.1 and2.1.

For V/F_p of dimension n, positive l,c with l+c<n, and p-powers r,s with
at least one greater than1, the scheme

    X={(L,M) in Gr(l,V) x Gr(n-c,V): L^r subset M, L subset M^s}

is smooth and geometrically irreducible, of dimension
(n-l-c)(l+c). Proposition2.1 proves transversality of the section of the
rank2lc bundle obtained by the two Frobenius pullbacks of the universal
incidence bundle.

Application boundary: the crucial special structure is two reciprocal
incidences involving the SAME subspaces of one fixed V. It is not merely
the presence of fifth powers, nor a general symmetric-tensor hypothesis.
Our map alpha -> (I(alpha), im L_alpha) only pulls back one incidence
condition along a tensor-dependent graph. No second reciprocal condition
or identification with Shimada's full Grassmannian product is established.
His smoothness and point-count conclusions cannot be inherited by this
graph intersection. His tangent calculation uses the vanishing
differential of Frobenius, but supplies no emptiness certificate here.

## 2. Arrondo–Marchesi: dual decomposable tensors

Enrique Arrondo and Simone Marchesi, *Jumping pairs of Steiner bundles*.
[Primary preprint](https://arxiv.org/pdf/1208.0571), section1 opening,
Definition3.1 and Theorem3.9.

The paper explicitly works over an algebraically closed field of
characteristic0. For a reduced Steiner bundle on Gr(k,n) with resolution
S tensor U_taut -> T tensor O -> F, put s=dim S,t=dim T. Jumping pairs
are a line a in S* and a (k+1)-space Gamma in H0(U_taut*) satisfying
a tensor Gamma subset im(T* -> S* tensor H0(U_taut*)).
At every jumping pair Lambda, Theorem3.9 states

    dim T_Lambda Jtilde(F) <= (k+1)[t-(k+1)(s+n-k-1)-k].

Application boundary: this theorem does not require symmetry of the
Steiner coefficient tensor. Its gaps here are characteristic0, a global
Steiner vector bundle, and a different incidence in the DUAL coefficient
image. Our rank assertion is only on U, and Q is a Frobenius pullback
there. Vanishing of I's section is not the displayed decomposability
condition. Even the formal substitution k=0,n=31,s=32,t=96 gives upper
bound34, not a negative bound implying emptiness. No characteristic5
extension or identification of the two incidence problems was found.

## Search boundary

Checked primary texts for the two directly matching theories, and focused
queries combining Frobenius pullback, Steiner bundles, sections, and
incidence. No broad review or new solver run was undertaken. This negative
search result is not a theorem that other applicable literature cannot
exist. It supplies no exclusion of any oper or torsion choice.
