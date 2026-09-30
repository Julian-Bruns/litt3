# Igusa–Hecke correspondences with a shared logarithmic form

ID: `igusa_hecke_correspondences`. Version1.

Let k be algebraically closed of characteristic p>=5, p!=7. Write
C=X^D_1(7)_k for the fine quaternionic curve of discriminant6, and
I=I^D_1(7)_k for its full Igusa curve, in Buzzard's notation. There are
maps I→P→C, with P=I/{±1}, and nonzero regular forms eta on I and alpha
on P such that

    g(C)=5,    g(I)=1+2p(p−1),    g(P)=1+(p−1)^2,
    div(eta)=p ss_I,            div(alpha)=((p−1)/2) ss_P,
    deg(ss_I)=deg(ss_P)=4(p−1),
    eta=(I→P)^*alpha,           Cartier(eta)=eta, Cartier(alpha)=alpha.

Here ss denotes the reduced supersingular divisor. Equivalently, P
is the cyclic root cover of Krishnamoorthy's Hasse invariant
H∈H⁰(C,Omega_C^((p−1)/2)), with alpha^((p−1)/2) the pullback of H.
The maps I→C
and P→C are cyclic, respectively of degrees p−1 and (p−1)/2, totally
ramified exactly over those supersingular points. A diamond c∈F_p^*
acts on eta by c²; thus alpha has the faithful residual character.

For every prime ell≡1 mod p with ell not dividing42, and every n>=1,
put d_n=(ell+1)ell^(n−1). Each of the fixed endpoints T=C,I,P has a
jointly minimal coreless finite étale self-correspondence

    T ← Z_(T,n) → T,    deg(left)=deg(right)=d_n,
    g(Z_(T,n))=1+(g(T)−1)d_n.

Both actual maps from the same source preserve eta when T=I and alpha
when T=P. On I there is also q∈k(I)^* with

    eta=dlog(q),    div(q)=pE,    f^*q=u^p g^*q,

for an integral degree-zero divisor E and u∈k(Z_(I,n))^*. Hence dq
is nonzero exact with divisor p(E+ss_I); its p-th-power line is shared.

The matched canonical ring on I is k[eta], and on P it is k[alpha].
In either case no nonzero matched pluriform of weight prime to p has
zero twisted Cartier image after raising to a weight congruent to1
modulo p.

For p=5 and ell=11 this gives a genus41 full curve and a genus17
partial curve. The partial curve has sixteen double zeros and actual
jointly minimal coreless degrees12·11^(n−1), all preserving alpha.
Thus fixed endpoints, uniform double zeros, and corelessness do not
imply bounded correspondence degree. No assertion concerns the
particular endpoint pair of the common-cover problem.

The underlying Igusa mechanism is in Krishnamoorthy, Remark3.18 and
Example8.5; the numerical forms and full prime-power family are the
deductions below. [Proof and exact sources](../../Proofs/examples/igusa_hecke_correspondences.md).
