# Proof record: Ordinary HN polygons of all full tensor powers of the Cartier bundle

Canonical statement: [`all_tensor_cartier_hn`](../Theorems/Thm_all_tensor_cartier_hn.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# All Cartier tensor-power HN polygons are universal

Author: /root, 2026-09-06. Status: independently audited PASS by
`/root/all_cartier_tensor_hn_major_audit`, 2026-09-06, with no breaking
objection; [audit record](../routes/global/audits/ALL_CARTIER_TENSOR_HN_AUDIT_2026_09_06.md).
This closes the full-tensor-power slope route, not Litt3.

Let C be a smooth projective connected curve of genus g>=2 over an
algebraically closed field of odd characteristic p. Put s=g-1,
F:C->C1, B=F_*O_C/O_C1, and omega1=omega_C1. For every n>=0,
the ranks and slopes of the ordinary HN filtration of B^{tensor n},
after dividing its slopes by s, depend only on n,p, not on C.

This includes ALL mixed tensor powers of B and B^dual, and canonical
line twists. There is no covering-degree hypothesis. In particular
these exact finite-etale invariants cannot distinguish any two curves.

## 1. A complete polynomial formula

Record the HN polygon by a Laurent polynomial whose coefficient is the
rank at the indicated slope:

    H_n(z) = sum_mu rank(gr_mu) * z^(p*mu/s).

All exponents are integers. Define

    A(z)=z^2+z^4+...+z^(2p-2),
    D(z)=z^(-2)+z^(-4)+...+z^(-2p+4).

Then

    H_0=1,   H_1=(p-1)z^p,
    H_n=z^(2p)H_(n-2)+p*z^(3p-1)*A(z)^(n-2)*D(z), n>=2.    (1)

Equal exponents are combined: an HN factor of a given slope need not
be stable. Its rank is exactly the resulting coefficient.

For n>=2 the extremal slopes are

    mu_max/s = (2n-1)(p-1)/p,
    mu_min/s = 1+(2n-1)/p.                            (2)

For p5,n3, formula(1) gives ranks5,10,15,4,15,10,5 at normalized
slopes2,12/5,14/5,3,16/5,18/5,4, respectively. Their ranks sum to64.

## 2. Proof by a canonical direct summand

Use the [audited differential-operator model](../routes/global/CARTIER_ENDOMORPHISM_HN_IS_THE_DIFFERENTIAL_OPERATOR_FILTRATION.md):

    End(B)=O_C1 direct_sum F_*Q,
    Q=D_+^{<=p-2},  gr(Q)=direct_sum_(j=1)^(p-2) T_C^j.      (3)

The order filtration on Q is viewed with weights -j. Its higher
weights are subbundles. Similarly

    I=F^*B,
    gr(I)=direct_sum_(i=1)^(p-1) omega_C^i,             (4)

with higher weights i as subbundles, by powers of the diagonal ideal.
Precisely, evaluation splits the pulled-back unit in F^*F_*O_C, and
identifies its quotient F^*B with the evaluation ideal I. Locally
I=(alpha) in O_C[alpha]/(alpha^p); I^i/I^(i+1)=omega_C^i. These are
actual vector-bundle filtrations, locally split as modules.

The perfect alternating Raynaud pairing gives

    B tensor B ~= omega1 tensor End(B).

Thus, for n>=2, (3) and the projection formula give an actual direct sum

    B^{tensor n}
      ~= (omega1 tensor B^{tensor(n-2)})
          direct_sum (omega1 tensor F_*(I^{tensor(n-2)} tensor Q)).   (5)

This is why merely tensoring a previously known HN filtration, which
need not stay ordered or semistable in characteristic p, is unnecessary.

Give I^{tensor(n-2)} tensor Q the TOTAL-weight tensor filtration.
Its graded pieces at integer weight k are direct sums of omega_C^k,
one for every tuple

    1<=i_1,...,i_(n-2)<=p-1, 1<=j<=p-2,
    k=i_1+...+i_(n-2)-j.                              (6)

The total filtration is intrinsic; local splittings of (3)--(4) show
that all its subquotients are locally free and identify the associated
graded with the tensor product of the associated gradeds. In particular
this does not discard extension data or assume a splitting of I or Q.

Apply the exact functor F_* and then tensor by omega1. Each resulting
graded piece is a direct sum of omega1 tensor F_*omega_C^k. These
bundles are stable, by Sun's theorem for Frobenius pushforward of a
line bundle. Their slopes are

    2s + ((p-1)+2k)*s/p = (3p-1+2k)*s/p.             (7)

Higher k have strictly higher slopes. The total-weight filtration is
therefore precisely the HN filtration of the second direct summand
in (5). The HN polygon of a direct sum is the merged union of the HN
slopes of its summands. For the initial case H_1 use the stability of
B proved by Joshi, recalled in [file22, Proposition2](../routes/global/22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md).
Induction and (6)--(7) now prove (1).

The largest k in (6) is (n-2)(p-1)-1; the smallest is n-p.
Substitution in (7), together with induction on the first summand
of (5), proves (2). The formulas also hold for p3: the first-summand
extrema may tie the second-summand extrema, but never exceed them.

Finally B^dual~=B tensor omega1^(-1). A mixed tensor power is therefore
a pure tensor power with a canonical line twist, proving the remaining
assertion. All constructions commute with finite etale base change.
QED.

## 3. Do not overextend the conclusion

The theorem is about full tensor powers, not arbitrary subquotients.
A subsequent independent argument now proves
[universality of ALL symmetric powers](Sol_all_symmetric_cartier_hn.md),
also audited PASS. The distinction in the rest of this section remains
essential: that theorem uses differential saturation and a graded
representation theorem, not a deduction from (1).
In particular Sym^n(B) is not generally a direct summand of B^{tensor n}
when n>=p. The maximum slope of a quotient may exceed that of its
source, so one cannot infer its HN polygon from (1).

For example F_abs^*B injects into Sym^p(B) by pth powers, producing a
line of degree2(p-1)s. This is larger than the maximum slope in (2)
for B^{tensor p}; there is no contradiction, because the symmetric
power is a quotient rather than that subbundle of the full tensor power.

Neither the universal tensor polygons nor the canonical local
filtrations imply finiteness of coreless correspondences. The still
open problem requires information not present in these polygons.
