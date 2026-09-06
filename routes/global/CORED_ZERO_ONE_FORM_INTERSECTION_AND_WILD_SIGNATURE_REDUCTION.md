# Zero shared one-forms restrict a common orbifold's wild signature

Author: /root, 2026-09-06. Status: independently audited PASS by
/root/cored_single_jump_degree_bound_audit, 2026-09-06.
[Audit record](audits/CORED_SINGLE_JUMP_DEGREE_BOUND_AUDIT_2026_09_06.md).
This uses the audited fixed-pair one-form theorem and retains both actual
etale maps. It is a reduction of the CORED case, not nonexistence.

## 1. Exact invariant-form formula

Let X <- Z -> Y be a cored finite bi-etale span of smooth projective
hyperbolic curves over an algebraically closed field of characteristic p>=3.
Take its [simultaneous etale Galois refinement](../../Theorems/Thm_cored_orbifold_bridge.md)
W, write X=W/A, Y=W/B, G=<A,B>, and C=W/G. At each branch point c of
W->C let e_c and delta_c be the inertia order and different exponent.
Put

    D = sum_c floor(delta_c/e_c) c.

There is a natural identification

    f*H0(X,omega_X) intersect g*H0(Y,omega_Y)
        = H0(C,omega_C(D)),                          (1)

where the right side is embedded by rational differential pullback.

Proof. A shared form on W is invariant under A and B, hence G, and
descends to a rational form beta on C. Conversely, a G-invariant regular
form descends regularly to both X and Y because W->X,Y are etale.
For w over c, regularity of its pullback is exactly

    e_c ord_c(beta)+delta_c >= 0,

equivalent to ord_c(beta)>=-floor(delta_c/e_c). The same statement with
e=1,delta=0 applies off the branch locus. This proves (1). No averaging
by |G|, tame assumption, or simultaneous ramified closure is used.

If the intersection is zero, then C=P1 and deg D<=1. Indeed regular
forms on C inject into (1), and on P1 the right side has dimension
max(deg D-1,0). A tame branch contributes zero to D; a wild branch has

    delta >= (e-1)+(|I_1|-1) > e,

so contributes at least one. Consequently the common orbifold is either
tame, or has exactly ONE wild branch point and delta/e<2 there.

## 2. Parameterized degree and signature bounds

Suppose (1) is zero and set h=2g(X)-2. Let n=deg(X->[W/G]), so

    h=n(-2+sum_c delta_c/e_c).                       (2)

Every e_c divides n: inertia acts freely on the cosets G/A because A
acts freely on W. Equivalently, X->C has n/e_c points over c, all
with the indicated completed local Galois extension.

If the common orbifold is tame, its positive canonical degree is at
least1/42, by the elementary hyperbolic tame-signature bound. Hence

    n<=42h.                                         (3)

For clarity, the bound uses inertia orders, not |G| prime to p. To see
the signature minimum, four or more branch points give minimum1/6
among positive sums (four2s give zero); three points give minimum1/42
at(2,3,7) by ordering the indices; at most two cannot be hyperbolic.

Now suppose there is one wild branch point. Put c=delta-e, so0<c<e,
and let m_1,...,m_t>=2 be the tame inertia orders. Formula(2) is

    h/n=t-1+c/e-sum_j1/m_j.                          (4)

Thus t>=1. If t>=3 then h/n>=(t/2)-1+c/e>1/2,
so n<2h. If t=2 and the tame orders are not both2, then
h/n>1/6, so n<6h.

If t=2 and both tame orders are2, (4) instead gives

    h=(n/e)c.                                       (5)

For the lower ramification groups at the wild point,

    c=sum_(i>=1)(|I_i|-1)-1 == -1 mod(p-1),          (6)

because every nontrivial I_i for i>=1 is a p-group. Therefore this
signature is impossible whenever h has NO positive divisor congruent
to-1 modulo(p-1). The statement includes mixed tame/wild inertia.

## 3. Fixed genus-nine/genus-twenty-five pair

The [audited eigenform theorem](../../Theorems/Thm_fixed_x_cartier_eigenforms.md)
proves that (1) is zero for EVERY actual span of the file76 pair.
Here p=5 and h=16. No divisor of16 is3 modulo4, so the one-wild/two-
order-two-tame signature is impossible.

Consequently every CORED span has one of these forms:

* Tame common orbifold: n<=672.
* One wild branch and at least two tame branches: n<96 (and n<32
  when there are at least three tame branches).
* Exactly TWO branch points, one wild and one tame: still unbounded
  by this argument. Necessarily 1<delta/e<2.

For a jointly minimal span, its degree b over Y is at most n. Indeed,
Z=W/(A intersect B), so b=[B:A intersect B]<= [G:A]=n. Therefore the
same bounds hold for the fixed-pair parameter b=M. A redundant source
refinement can of course have larger degree; it is not being bounded.

In particular a jointly minimal CORED candidate with M>672 would have
to come from the last, two-branch wild pattern. This is separate from
the still-open CORELESS cases, with or without shared tensors.

The last pattern is not being declared impossible. Ordinary Y does not
make W ordinary, and it does not automatically make arbitrary inertia
in G normalize the free subgroup B. Ordinary-curve automorphism bounds
cannot be applied to W without those missing hypotheses.
