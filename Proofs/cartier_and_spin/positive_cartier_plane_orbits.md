# Proof: the canonical positive plane and its actual orbit

[Statement](../../Theorems/cartier_and_spin/positive_cartier_plane_orbits.md).
23September2026. Integrates the two returned rank-four replies and
the independent positive-plane calculation in the rank-three reply.
Focused author review and the supplied exact certificates pass.
No independent-agent audit is claimed.

## The fixed plane and the new line

Use the actual split quotient and
[stable Frobenius kernel](../../Theorems/cartier_and_spin/cartier_generated_frobenius_hn.md).
The degree-ten HN summand defines P and gives rank2, degree7.
Its pullback intersects H_X in O(19O); surjectivity of
H_X->O(30O) gives the exact evaluation sequence in the statement.
Every line L in an étale pullback of B_X has a nonzero adjunction
F^*L->omega. Thus 5 deg L<=16d<5(7d/2), proving stability of P
after every étale pullback.

For the degree-six quotient \(U\to\mathcal O(6O)\), write its row in
the original exact-section frame as
\[
r_2=([19]+x,-[16]-x,[20]+[14]x+[15]x^2).
\]
The original evaluation rows \(q_i\) satisfy
\[
\sum_{i=0}^2r_{2,i}^{\,5}
(q_{i+1}q'_{i+2}-q_{i+2}q'_{i+1})=P(x)A(x),
\quad A=(1,21,14,22,13),
\]
with cyclic indices. The [exact checker](../../scripts/arithmetic/cartier_positive_plane_branch.py)
verifies this identity and that \(A\) is squarefree and coprime to
\(PW\). Since \(r_{2,0}+r_{2,1}=[3]\), the plane row is surjective at
every finite branch point. There \(P\) has order three and \(dx\)
order two; the resulting order-five Wronskian factor is precisely
the Frobenius pullback of its length-one lattice defect. Thus the
finite branch divisor is \(x^*\operatorname{div}_0A\), with twelve
reduced points. The second fundamental map has zero degree
\(2\deg\omega_X-19=13\), so the remaining
point is \(O\). The new quotient row
([5]+[21]x,[8]+[9]x,[3]+[8]x+x^2) is a scalar multiple of \(r_2\);
its branch polynomial (20,3,24,23,4) is [20] times \(A\). Hence
both calculations describe the same embedded plane and divisor.

For the new canonical line, work in any Lagrangian plane whose
evaluation is surjective and whose kernel has simple branching.
Let its horizontal generators evaluate to f du,g du. Write
w=fg'-gf', a=w'/w. The two functions solve
\[
z''=az'+bz.
\]
The alternating Cartier condition gives
\[
fg'''-f'''g+4(f'g''-f''g')=0,\qquad 3b=a'+a^2.
\]
The vector
\[
(wg'-2w'g,\;2w'f-wf')
\]
is horizontal: differentiating its coordinates and using the last
identity gives zero. Its evaluation is w^2. It is nonzero at every
simple zero of w, since w' is a unit and f,g do not vanish together;
elsewhere its evaluation is nonzero. It therefore defines a saturated
horizontal line, which descends by Cartier.

Change of horizontal frame multiplies w^2 by det(frame)^2. Changing
coordinates gives the extra omega^-5 factor upstairs. Consequently
the descended source is (det P)^2 omega^-1, with evaluation divisor
2R_P. This proves the canonical construction, including membership
in P and saturation. It uses reduced branching.

For fixed X its degree is -2. The supplied exact vector
\[
v=([10]+[13]x,\ [22]x,\ [8])^t
\]
satisfies r_2 v=0 and sum v_i^5 q_i=A^2. It directly verifies the
stated evaluation in the actual bundle. The identity
\[
2PWA'-A(P'W/3+PW')=B_*^5
\]
computes the Wronskian of the radical evaluation yW theta and the
new evaluation A^2 theta as A B_*^5 theta^3. The Wronskian of P
contributes R_P; the remaining fifth multiple is the pullback of
the determinant divisor of ell+lambda. Saturation and degree12
give the stated Delta. The polynomial B_* is squarefree and coprime
to P,W,A. All identities are checked by the imported
[positive-line verifier](../../scripts/arithmetic/pro_cartier_positive_line.py).

In lambda_i-perp/lambda_i the line P_i/lambda_i has degree9d,
whereas its rank-two ambient bundle has degree16d. Two distinct
lines of degree at least9d are impossible. It is the HN line and
recovers P_i. Products of the DISTINCT Plücker lines descend to Y;
their descended degree is 7M/8. Thus 8 divides their number M.

## Trace refinements and the kernel-line exclusion

The original radical trace image J has colength at most5. A
transverse pair P_i,P_j injects into the pulled-back positive-plane
trace image; its degree14d gives downstairs degree at least2,
hence colength at most2.

Locally over a DVR, put L=sum ell_i and H=sum ell_i-perp. If
length(B/H)=m, then H contains ell_0-perp and B/H is cyclic.
Perfect duality implies that all primitive ell_i generators are
proportional modulo t^m; their proportionality factors are units.
Thus L is contained in ell_0+t^m B and length(B/L)>=3m.
Summing downstairs gives the hyperplane-trace colength at most1.

Set V=F_Y^*B_Y and A=ker(V->omega_Y), of rank3 and degree18.
Let E_i=F_T^*P_i and K_i=ker(E_i->omega_T), of degree19d.
These are saturated lines in q^*A. Their distinct product lines
descend with degree19M_K/8, so 8 divides M_K. In particular there
are at least eight distinct generic K_i. Generically
E_i=K_i+nabla K_i, and the full radical span gives sum E_i=q^*V.

Suppose their saturated descended span S has rank two. If S were
Lagrangian generically, its second fundamental form would be a
symmetric binary form vanishing on at least three distinct K_i:
each E_i is horizontal and Lagrangian. That form would vanish,
forcing S horizontal and contradicting sum E_i=V. Thus S is
generically nondegenerate. Away from its pairing-degeneracy divisor C
we have V=S+S-perp and
\[
E_i=K_i+L_i',\qquad L_i'=E_i\cap S^\perp .
\]
The projected connections preserve each K_i and each L_i'. The
off-diagonal connection map beta:S->S-perp tensor omega is
generically invertible, since S+nabla S=V.

Choose a local nonzero vector field D and write B=beta_D.
The rational endomorphism
B^-1(nabla_D^perp B-B nabla_D^S) preserves all K_i; at least three
distinct generic lines force it to be scalar. Hence
\[
\nabla_D^\perp B-B\nabla_D^S=cB.
\]
Locally off C, write Bk_i=b_i l_i'. The regular induced line
connections imply dlog(b_i/b_j) is regular. The b_i zero orders
are exactly the branch orders of E_i, each zero or one. Their
differences are divisible by5, so the orders coincide.

At a point of C, use the canonical Taylor frame e_0,...,e_3 with
ev(e_0)=du, ev(e_i)=0 for i>0, and nabla e_i=-i e_(i-1) du.
Here A=<e_1,e_2,e_3>, A_2=<e_2,e_3>, A_3=<e_3>=A-perp.
If k_i=a e_1+b e_2+c e_3, its branch coefficient is -a.
At a simple zero, horizontality of E_i gives a'-2b=0; therefore
K_i lies in A_2 but not A_3. The degenerate plane S(t) contains A_3.
If S(t)=A_2, all K_i branch; otherwise S(t) meets A_2 just in A_3
and none branch. Thus all reduced R_i coincide everywhere.
Their G-invariant common divisor would descend with degree13/8,
impossible. This excludes rank2, so the K_i span all q^*A.
Three independent degree19d lines give the residual trace bound
deg I>=8, hence length(A/I)<=10.

## The new-line trace alternatives

Let J_lambda be the actual trace image and S its saturation.
Its coefficient q_*lambda_0 is strongly semistable of slope -1/4,
since its pullback splits into conjugate degree-2d lines. Quotient
slopes give mu_min(F^{r*}J_lambda)>=-5^r/4.

In rank two, two independent lines give deg J_lambda>=0.
Put e=deg S. Let B be the evaluation-zero divisor of F^*q^*S.
It satisfies B<=2R_i for every i. The kernel's second fundamental
form is nonzero: a horizontal kernel would contradict adjunction
for a nonzero subline of B_T. Its zero divisor has degree
\[
48d-40de-2\deg B.
\]
Each R_i point outside B gives a zero of this form. Consequently
40de<=35d-2 deg B+deg B_red<=35d. Thus e=0 and J_lambda=S.
The minimum-slope bound implies semistability. Since the actual orbit
generates everywhere, B=2 gcd_i R_i=2q^*C with C reduced, deg C<=1.
The second fundamental divisor descends, has degree6-4deg C on Y,
and contains every R_i outside q^*C. This is the stated containment.
If deg C=1 the evaluation sequence on Y is an extension of two
degree-zero lines; its Frobenius pullbacks stay semistable. Hence
S is strongly semistable.

In rank three, three independent lines give deg J_lambda>=0;
stability of B_Y gives deg S<=2. In rank four the same calculation
gives deg J_lambda>=-1. At equality any four independent orbit lines
have the same total degree as q^*J_lambda, so their injection is an
isomorphism. Any other orbit line maps nontrivially into a summand
of equal degree, hence is isomorphic to that summand. Entries within
an isotypic summand are constants on the proper connected T.

## Scope and verification

The original five supplied files are preserved in the external
[manifest](../../../litt3-computation-data/radical_orbit_replies_20260923/manifest.json).
The three supplied computations pass. The
[integration check](../../scripts/arithmetic/check_radical_orbit_reply_integration.py)
identifies the two scalar normalizations of P and R_P and checks the
new logarithmic form independently of the returned arithmetic modules.
Its [receipt](../../../litt3-computation-data/radical_orbit_replies_20260923/integration_check.json)
does not claim an audit of all prose.

The associated weight13 tensor A^16 theta^13 has reduced zero
multiplicity16. The existing ramified-root contact theorem DOES NOT
apply: its first index is q=3 and 13(q-2)=13<16. Reusing the old
weight31 radical recognition for this new tensor would be invalid.
No new-line field-recognition theorem, common tensor, clump, or
original common-cover exclusion is asserted.
