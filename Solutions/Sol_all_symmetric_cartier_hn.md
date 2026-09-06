# Proof record: Ordinary HN polygons of all symmetric powers of the Cartier bundle

Canonical statement: [`all_symmetric_cartier_hn`](../Theorems/Thm_all_symmetric_cartier_hn.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# All Cartier symmetric-power HN polygons are universal

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/cartier_symmetric_power_hn_major_audit, 2026-09-06; no breaking
objection. [Audit record](../routes/global/audits/ALL_CARTIER_SYMMETRIC_HN_AUDIT_2026_09_06.md).
The graded representation input was checked separately by
/root/graded_alpha_p_symmetric_power_sources against Troesch and Touze.
This closes another proposed invariant route, not Litt3.

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of odd characteristic p. Write s=g-1,
F:C->C1, B=F_*O_C/O_C1, and omega=omega_C.

**Theorem.** For every n>=0, the ranks and slopes of the ordinary
Harder--Narasimhan filtration of Sym^n(B), with slopes divided by s,
depend only on n,p. This includes n>=p: no averaging over S_n or
identification with a direct summand of B^{tensor n} is used.

## 1. Explicit formula

Put M=(p-1)n and define integer polynomials

    W_n(z)=[u^n] product_(i=1)^(p-1) (1-u*z^i)^(-1),
    E_n(z)= z^M                         if n=0 modulo p,
            sum_(j=0)^(p-2) z^(M-j)    if n=1 modulo p,
            0                           otherwise,
    Q_n(z)=(W_n(z)-E_n(z))/(1+z+...+z^(p-1)).          (1)

The quotient is a polynomial with nonnegative integer coefficients.
If H_n records an HN factor of rank r and slope mu as r*z^(p*mu/s),
then

    H_n(z)=p*z^(p-1)*Q_n(z^2)
             + z^(2M)                         if n=0 modulo p,
             + (p-1)*z^(2M-p+2)              if n=1 modulo p,
             + 0                              otherwise.       (2)

The last three lines specify one case-dependent additional term.
Equal slopes are combined. For example p5,n5 gives

    z^40 + 5(z^34+z^32+z^30+z^28+z^26+2z^24
                     +z^22+z^20+z^18+z^14).

The ranks sum to56. The slope8s line is compatible with the pth-power
inclusion F_abs^*B -> Sym^p B; it is not a subbundle of B^{tensor p}.

## 2. The precise graded Jordan input

Let V have basis e_1,...,e_(p-1), of integer weights1,...,p-1, and let
N(e_i)=i*e_(i-1), with e_0=0. Extend N as a DERIVATION to Sym(V).
It satisfies N^p=0 and lowers weight by one. Let J_l[a] mean a
graded Jordan block of length l with top weight a.

**Lemma.** Sym^n(V) is a direct sum of length-p blocks and exactly
one additional block J_1[M] if n=0 mod p, or J_(p-1)[M] if n=1
mod p. There is no additional block otherwise.

Here is the source input and the deduction, distinguishing the primitive
derivation action from the diagonal action of a cyclic group. For
W=<e_0,...,e_(p-1)> with the same derivation,
[Troesch, Theorem3.1.3 and Section3.3](https://www.numdam.org/item/10.5802/aif.2133.pdf)
computes Sym^j(W) as a graded p-complex: it is free over
R=k[N]/(N^p) if p does not divide j, and free plus one trivial module
of weight(p-1)j otherwise. Equivalently use
[Touze, Remark9.2 and Theorem9.4](https://www.numdam.org/item/10.24033/asens.2160.pdf).
Remark9.2 identifies the differential as the derivation extending the
Jordan shift. Reverse its cohomological grading: on Sym^j(W) it is
(p-1)j minus our weight. A p-acyclic finite complex consists of
length-p blocks; the stated coresolution adds the one trivial block.

Multiplication by the invariant e_0 gives a weight-preserving exact
sequence of graded R-modules

    0 -> Sym^(n-1)(W) -> Sym^n(W) -> Sym^n(V) -> 0.     (3)

Graded free R-modules are both injective and projective. When neither
n nor n-1 is divisible by p, (3) splits and its quotient is free.
When p divides n, the free source splits off, leaving the one trivial
block at M. When p divides n-1, cancel the free summands in the source.
The remaining quotient is the graded cosyzygy of the one trivial
module at h=(p-1)(n-1), plus free summands. Its injective envelope is
J_p[h+p-1], with that trivial module as its bottom. The quotient is
J_(p-1)[h+p-1]=J_(p-1)[M]. Krull--Schmidt proves the stated full list
of nonfree summands. The n=0 case is immediate.

Every free block with bottom weight b contributes
z^b*(1+...+z^(p-1)) to the character. Subtracting the exceptional
block proves (1), including nonnegative integrality. QED.

## 3. Differential saturation glues; a chosen Jordan basis need not

The canonical connection on F^*B has the following etale-local model.
The evaluation splitting identifies F^*B with the ideal I=(alpha)
in O_C[alpha]/(alpha^p). The quotient connection is

    nabla_partial(alpha)=0,
    nabla_partial(alpha^i)=-i*alpha^(i-1), 2<=i<p.      (4)

The first equality is important: the derivative of alpha in the full
algebra is constant and disappears in the quotient by the pulled-back
unit. The powers I^i give intrinsic graded lines omega^i.

Consequently F^*Sym^n(B)=Sym^n(I) has an intrinsic total-weight
filtration V_(>=w), whose graded piece at q is a direct sum of copies
of omega^q. In an etale coordinate its monomial frame identifies the
connection with partial-N, for the constant derivation matrix in
Section2. Define G_w to be the smallest connection-stable O_C-submodule
containing V_(>=w). Locally it is

    G_w=sum_(j=0)^(p-1) nabla_partial^j(V_(>=w)).       (5)

Formula(5) is stable because nabla_partial^p=0. It is independent of
the coordinate, since connection-stability and the generating subbundle
are intrinsic. In the monomial frame it is O_C tensored with the
N-submodule generated by the weight>=w part. Thus it and all its
successive quotients are vector bundles. Cartier descent gives a
filtration G_w=F^*E_w of Sym^n(B) by subbundles E_w.

A homogeneous Jordan decomposition shows that G_w/G_(w+1) consists
of exactly those blocks with top weight w. This is only a way to
COMPUTE its filtered graded pieces; no chosen Jordan summands are
claimed to glue. All these blocks have the same length l=p, except
for the unique exceptional top block of Section2, which has l=1 or
p-1. The highest weight M has multiplicity one, so it cannot contain
both an exceptional block and another block.

For multiplicity m at top weight w, the induced filtration on
F^*(E_w/E_(w+1)) has graded pieces

    (omega^q)^{direct_sum m},  q=w-l+1,...,w.           (6)

The connection induces isomorphisms between each pair of neighboring
graded pieces after tensoring the lower one by omega. The constant
graded subspaces in this assertion are intrinsic: on the graded
monomial frame, a coordinate change is multiplication by the same
scalar (dt_new/dt)^q in weight q. It therefore preserves every fixed
graded subspace used in the computation.

## 4. An elementary oper slope lemma finishes the proof

Suppose a bundle E on C1 has F^*E with filtration (6), and the displayed
successive connection maps are isomorphisms. Then E is semistable of
slope (2w-l+1)s/p. Indeed, for a subbundle A of E intersect F^*A
with this filtration, and let r_q be the ranks of its graded pieces.
Horizontality and the isomorphisms imply

    r_(w-l+1)>=r_(w-l+2)>=...>=r_w.

Each graded piece injects into (omega^q)^m, so its degree is at most
2q*s*r_q. A decreasing sequence of nonnegative ranks has weighted
average of the increasing weights q at most their unweighted average
w-(l-1)/2. Therefore

    p*deg(A) <= sum_q 2q*s*r_q
              <= (2w-l+1)*s*rank(A).

This proves semistability. If m=1, a proper nonzero horizontal subbundle
has strictly smaller average weight, proving stability as well.

Apply the lemma to each quotient from Section3. The length-p factors
have slopes (2w-p+1)s/p, strictly decreasing as their top weights w
decrease. The exceptional factor, when present, has top weight M and
length less than p. Its slope is strictly larger than the slope of
every other factor. Hence this descended filtration IS the HN
filtration. A free block of bottom weight b has rank p and
p*mu/s=2b+p-1; the exceptional block gives the last term in (2).
This proves the theorem.

## Scope and checks

The construction commutes with finite etale base change. By duality,
the same universality holds for divided powers of B and for symmetric
or divided powers of B^dual, with canonical line twists.

Exact prime-field matrices checked the graded saturation calculation
for p5 and n1,...,12. The proof and character formula, not these
finite tests, establish all n and all odd primes.

This theorem and the [all-full-tensor theorem](Sol_all_tensor_cartier_hn.md)
do not compute arbitrary Schur subquotients or extension classes.
They do not produce a shared differential for two maps and do not
exclude a common finite etale cover.
