# Returned initial dihedral obstruction calculation

2026-09-10. Pro reply received in chat after
PRO_DIHEDRAL_INITIAL_OBSTRUCTION_REQUEST.md. Focused medium audit PASS
by /root/audit_dihedral_initial_as_product, with the corrected Taylor
estimate below; see audits/DIHEDRAL_INITIAL_AS_PRODUCT_AUDIT_2026_09_10.md.
The earlier universal cyclic-power
Smith lemma is unrelated pure algebra and is saved separately.

## Claimed result and actual setup

On Delta=(t^5-t)(t²+2t+3)(t²+2t+4)!=0, use the ACTUAL D10 family,
full preceding filtered/graded tuple and flat periodicity twist in the
request. Write q=log(sigma), Psi_nil=q²Frob, and normalize the divided
linear carry so that the next obstruction on compatible lifts
T3(d,b)=T3^0+d q³+b q4 is

    P_t(d,b)=d^5 q.                                      (1)

The returned claim is B_t=0, with no additional exceptional parameters.
It assumes the request's cochain-level q³ repair and integral linear
carry inputs. The consequence is initial delayed descent of the GIVEN
T3 along the ORIGINAL h:T→C whenever it has a compatible W4 extension.

## 1. Actual Artin--Schreier multiplication

On either chart, A=B[w]/(w^5-Hw-f), sigma(w)=w+lambda, lambda^4=H.
For reduced representatives of degree<=4,

    q(P(w))=lambda*P'(w).

With P_m=B<1,w,...,w^m>, this gives

    q³ A=P_1, q² A=P_2, P_1*P_1⊂P_2.                   (2)

This is NOT the false rule q³A*q³A⊂q6A. A q² primitive of
(a+bw)(c+dw) is

    ac*w²/(2lambda²)+(ad+bc)*w³/(6lambda²)
       +bd*w4/(12lambda²).

The chart change w_O=w_U-z^-1 preserves degree. Frobenius preserves
this filtration since w^5=Hw+f. Bundle coefficients pulled from C
have degree zero. The normal line N is pulled from C and the supplied
Fitting decomposition gives q²H1(T,N)⊂im Psi_T.

## 2. First repairs and graded restoration

Put p=5,U=d^5,V=b^5. In reference frames pulled from C, the first
transition difference is pK modulo p², with reduced entries linear
in U,V and in q³, hence P_1. The equivariant primitive supplies the
actual normal repair e_i+p ell_i n_i with ell_i in q³=P_1.

For connection matrix ((alpha,beta),(theta,delta)), this graph
change gives lower entry

    theta+p(d ell+(delta-alpha)ell)-p² beta ell².

The previous tuple is only modulo p², so its quadratic last term is
zero. Restoring prescribed Higgs entry/determinant uses first-order
linear changes and a square root with denominator2, not1/p. Thus
all first-order reduced coefficients stay in P_1. The actual flat
periodicity line has base transition units and preserves this degree.

## 3. Precision in the actual filtered-and-graded construction

The returned proof uses the actual tilde matrices

    tilde nabla=p d+((p alpha,p² beta),(theta,p delta)),
    tilde f_ij=((g1_ij,p b_ij),(0,g0_ij)).                (3)

Here the diagonal transitions and lower connection coefficient are
the PRESCRIBED new graded data, not arbitrary lifts of raw graph
matrices. A change by p in previous W2 filtered data is therefore an
ADDITIVE p² change in the tilde object modulo p³. Products of two p
repairs vanish in the previous W2 tuple and are not divided back into
existence. Graded changes from the p² curve deformation have quadratic
order p4 and do not survive. Source: LSZ1311.6424 Lemmas4.7,4.10.

For Taylor transport let D=tilde nabla_partial. Modulo p it is the
weight-one Higgs operator, so D² is divisible by p. The reply gives:

* one p²X insertion in D^n has valuation at least
  2+max(0,floor((n-2)/2)); after n! division this is still>=2;
* two insertions have valuation at least
  4+max(0,floor((n-4)/2))-v5(n!)>=3;
* the reply's displacement-square estimate wrongly counted all n
  factors as changed. For EXACTLY TWO changed factors the correct
  estimate is 2+floor(n/2)-v5((n-2)!)>=3 (n>=2), using
  binomial(n,2)/n!=1/(2(n-2)!). This repairs the vanishing claim;
* mixed displacement/operator changes vanish modulo p³.

The intended conclusion is that higher Taylor terms, including
factorials divisible by5, preserve additive p² changes and create
no extra DIVIDED quadratic normal term. In particular the result must
not rest on truncating the Taylor series at degree4. Source:
LSYZ1404.0538 Section5.

## 4. Final Hodge graph

Use G=((A,B),(0,D0))+pK+p²L modulo p³ and
R_i=((1,0),(p ell_i,1)). The lower entry of R_j^-1 G R_i is

    p(K21+D0 ell_i-A ell_j)
      +p²(L21+K22 ell_i-K11 ell_j-B ell_i ell_j).         (4)

The first bracket vanishes modulo p but its DIVIDED integral remainder
can leave q³; this is precisely the stipulated linear carry, not killed
by the filtration argument. The ordinary quadratic normal products in
the second bracket already have coefficient p², so after division by
p² they are just reduced products of P_1 coefficients. By(2) they
lie in P_2=q²A. The checks in Section3 purport to exclude any further
divided quadratic term outside this conclusion.

On a two-affine pulled-back cover, a quadratic normal cochain is
q²Q_UO. Every Cech one-cochain is a cocycle, hence its class lies in
q²H1(T,N) and maps to zero in D_T. Additive next-digit terms on the
q³ inputs vanish by the request's comparison input. The remaining
linear carry is +Uq. This yields(1).

The equivariance signs check the result but do not prove it. No global
trivialization of the periodicity line is made; its actual flat gluing
is part of the comparison.

## 5. Stated geometric consequence

Since q!=0 in R/q², P_t(d,b)=0 iff d=0. In that case the compatible
lower lift C3^0+b e_C (h*e_C=q4 e_tan) pulls back to the GIVEN marked
T3(0,b). Its vanishing next obstruction ensures an actual compatible
W4 extension: for any smooth fourth lift S, solve Psi(xi)=rho(S),
then rho(S+xi)=0. The Hodge line is unique by negative normal degree.
For d!=0 no fourth digit can remove the nonzero obstruction class.

## Root's initial audit questions

The multiplication mechanism appears independent of the dihedral
involution and even of this particular AS equation; test its exact
scope before making a broader claim. The q operator on the reduced
polynomial basis is not a derivation of the whole AS algebra, so use
only the stated image/degree identities, not a Leibniz rule for q.

The auditor checked that corrected estimate and the mixed bound
3+floor((n-2)/2)-v5((n-1)!)>=3. The actual initial comparison and
original-map descent PASS. No involution is used. The same argument
works for any actual cyclic-five AS torsor WITH ALL the stipulated
reference/Fitting/cochain/integral/additive inputs; it does not by
itself establish those inputs for an arbitrary cover.

References: https://arxiv.org/pdf/1311.6424 and
https://arxiv.org/pdf/1404.0538. The complete reply is in the user
message of this date; the mathematical claims and their proof steps
are recorded here for the focused audit and continuation.
