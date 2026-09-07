# Composite abelian decks: the normalizer and rational Hecke constraint

Author proof; self-check recorded2026-09-04, NOT independently audited.
Version2,2026-09-07: compressed proof and explicit trivial-cover correction.
The bound d<=|H|-1 requires |H|>1; the exact dimension inequality remains
valid for H=1 and then gives d=1. Also A>H need not be a counterexample
to normality: only A>N_A(H) is. Division-algebra actions below are written
as LEFT-module actions, so the rank-one corner is the opposite algebra.

All curves are smooth projective connected over algebraically closed k.
Fix an odd prime p, possibly char(k), and assume

    g(X)=g>=2, JX simple, Aut(X)=C_p, X/C_p=P1,

with trivial PGL2(k)-stabilizer of the reduced branch set Bcal.
Let D->X be connected finite etale Galois with ANY finite abelian
deck group H. Put A=Aut(D), N=N_A(H), h=|H|. The
[abelian rigidity toolkit](91_ARBITRARY_ABELIAN_DECK_RIGIDITY.md) and
[branch-rigid prime-power theorem](92_BRANCH_RIGID_ABELIAN_PRIME_POWER_COVERS.md)
are the inputs. This note does not extend the latter to arbitrary H.

## 1. The forced bottom of the subgroup lattice

**Lemma94.1.** No M<=A satisfies H<M, H maximal in M and N_M(H)=H.
This is exactly the relative minimal-overgroup proof of Theorem91.1:
D/M=P1 by simplicity, the core-free coset action is Frobenius, and
its derangement kernel would give a nontrivial etale quotient of P1.

**Theorem94.2.** If A>H, then

    N/H=C_p, D/N=P1, N_A(N)=N.

Moreover every K with H<K<=A contains N, so N is the unique minimal
overgroup of H.

**Proof.** The normalizer injection gives N/H<=Aut(X)=C_p. If N=H,
Theorem91.1 gives A=H. Otherwise N/H=C_p and D/N=X/C_p=P1.
Because D/X is etale its N-quotient has branch set exactly Bcal.
The normalizer quotient N_A(N)/N acts faithfully on P1 preserving
Bcal, hence is trivial. Given H<K, choose M<=K minimal over H.
Its normalizer of H is H or M; Lemma94.1 rules out the former.
Thus M<=N, and [N:H]=p forces M=N. QED.

## 2. The coprime part and its normalizer

Write H=H_p x L with L the characteristic p-prime Hall subgroup.

**Theorem94.3.** If A>H, there is t in N of order p such that

    N=H semidirect<t>,
    L=[L,t], C_L(t)=1, N_A(L)=N.

If L!=1, then the Fitting subgroup F(N)=H.

**Proof.** The ramified cover D->D/N=P1 has inertia meeting H trivially,
so every nontrivial inertia group has order p and supplies t. Inertia
normally generates N: otherwise its normal closure would leave a
nontrivial connected etale quotient of P1.

For an inertia generator h t^i with i!=0, the L-component lambda has
norm1 under t^i. Coprime cyclic cohomology and the abelian decomposition
give

    ker(1+t+...+t^(p-1))=(t-1)L,
    L=C_L(t) x [L,t].

Thus every inertia generator maps to identity in L/[L,t]; their normal
generation forces L=[L,t] and C_L(t)=1.

The curve E=D/L is an actual etale abelian p-group cover of X, including
the trivial-cover case. Theorem92.1 gives |Aut(E)|<=p|H_p|. But N/L
already embeds in Aut(E) with exactly that order. The injection
N_A(L)/L->Aut(E) therefore gives N_A(L)=N.

Finally H is nilpotent normal in N, so H<=F(N). Since [N:H]=p, a larger
Fitting subgroup would equal N, making N nilpotent. Its p-subgroup would
then centralize the nontrivial L, contrary to C_L(t)=1. QED.

Only A>N could violate deck normality. In that case L!=1 by Theorem92.1.
The possibilities A=N>H with H a p-group are NOT excluded by that theorem.

## 3. One active rational packet

For an irreducible rational A-module W, let Delta_W=End_QA(W), acting
on W on the left. Call W active if its central idempotent acts nontrivially
on JD and W^H!=0. Put d=dim_(Delta_W) W.

**Theorem94.4.** If A>H, exactly one packet W is active. It satisfies

    dim_(Delta_W) W^H=1, W^N=0,
    Q(zeta_p) embeds in Delta_W^op embeds in End^0(JX),
    d*g <= 1+h(g-1).                                 (A)

For h>1 this implies d<=h-1; for h=1 it implies d=1.
The last case was missing from the former abbreviated statement.

**Proof.** The averaging idempotent e_H=(1/h)sum_(u in H)u has image
the pullback of JX inside JD, up to isogeny. Distinct rational central
simple components cut out independent abelian subvarieties of that
image, so simplicity allows only one active component. In that component,

    S_W=End_(Delta_W)(W),
    e_H S_W e_H=End_(Delta_W)(W^H).

If W^H had Delta_W-dimension>1, its matrix corner would have a proper
nonzero idempotent and split JX. Thus it has dimension1, and the corner
is Delta_W^op. Every active simple component acts faithfully on its
nonzero isotypic abelian subvariety. Since D/N=P1, e_N acts as zero
on JD, hence as zero on W; thus W^N=0.

The order-p inertia lift t preserves W^H. Its action in the division
corner is a unit u with

    u^p=1, 1+u+...+u^(p-1)=0.

It is not1 and has minimal polynomial Phi_p, giving the cyclotomic
embedding. The faithful corner action gives its embedding into End^0(JX).

Finally the d rank-one matrix idempotents in S_W have mutually isogenous
images; one is the g-dimensional JX. The active isotypic subvariety thus
has dimension d*g, at most g(D)=1+h(g-1). This proves(A).
For h>1, division by g gives d<=h-(h-1)/g<h; for h=1 it gives d=1.
No tame assumption is used: all averaging is in rational endomorphisms.
QED.

## 4. Two excluded abstract envelopes

**Corollary94.5.** Neither

    (A,N,H)=(A5,A4,V4)
    nor (PSL2(7),C7 semidirect C3,C7)

can occur under these geometric hypotheses.

**Proof.** The rational A5 packets have dimensions1,6,4,5, with the
six-dimensional packet combining the conjugate3-dimensional characters.
Their pairs of Delta-dimensions (W^H,W^N) are respectively

    (1,1), (0,0), (1,1), (2,0).

None has (1,0), as Theorem94.4 requires. For PSL2(7), the two conjugate
3-dimensional representations and the rational6-dimensional one have
no C7-invariants. The7-dimensional one has both C7- and
(C7 semidirect C3)-fixed rank1. The8-dimensional one has fixed ranks
(2,0), again the only N-anisotropic possibility. It also fails the
rank-one condition. These are character calculations, independent of
branch signature and characteristic. QED.

## Remaining boundary

A genuinely nonnormal composite-order cover must realize A>N with
L!=1 and the SINGLE packet in Theorem94.4. Such a packet must actually
occur in the curve's cohomology; satisfying numerical ranks alone does
not construct a cover. The raw group configuration A5>A4>V4 already
satisfies the local normalizer and Fitting conditions, so those conditions
alone cannot prove deck normality. Nor may arbitrary bi-etale spans be
replaced by Galois ones. The composite-order and non-Galois gaps remain.
