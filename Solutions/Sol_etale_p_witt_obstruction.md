# Proof: norm detects precisely the free defect summands

[Statement](../Theorems/Thm_etale_p_witt_obstruction.md).
Author /root,2026-09-10. Focused medium audit PASS
/root/audit_p_cover_witt_repair; no blockers. Audit record:
Research/audits/CYCLIC_P_WITT_REPAIR_AUDIT_2026_09_10.md.
The explicit base higher-Witt obstruction is an inherited audited theorem.

## 1. The tangent cohomology is free over the deck group algebra

Let V_T=H1(T,T_T), V_C=H1(C,T_C), R=k[P], J=rad(R). Etaleness
identifies T_T=h*T_C. The Cartan--Leray spectral sequence for this
actual Galois cover has only its coherent-degree-one row: H0(T,T_T)=0
by negative degree, and coherent cohomology above degree1 is zero.
Hence V_T^P=V_C via pullback and H^i(P,V_T)=0 for i>0.

The only simple R-module is k. From Ext1_R(k,V_T)=0, induction on
composition series gives Ext1_R(M,V_T)=0 for every finite R-module M.
The finite group algebra is self-injective, so V_T is projective; the
algebra is local, so it is free. Riemann--Roch and etale Hurwitz give
rank_R(V_T)=3(g(C)-1).

Linearize the Frobenius-semilinear Psi_T. Frobenius fixes the group
basis, so the linearized source and target are free R-modules of this
same rank. Write N=sum_(g in P)g. Multiplication by N identifies
coinvariants with invariants of a free R-module. By etale naturality,
the induced map on invariants is Psi_C. Thus reduction of Psi_T mod J
is Psi_C under these identifications.

## 2. Cokernel pullback is norm, including noncommutative P

Let D=D_T. Right exactness gives D/JD=coker(Psi_C), after the above
identifications. The original inclusion of invariant vectors descends
on cokernels to

    D/JD -> D, d mod J -> Nd.

Consequently its rank is dim_k ND. The socle of the left regular
R-module is the single line kN. Every nonzero left ideal contains this
line: apply powers of the nilpotent radical to obtain a nonzero simple
submodule, which must be in the socle.

If Nd!=0 for some d in D, the map R->D, r->rd, has zero kernel.
Otherwise its annihilator left ideal would contain N. This embeds a
free rank-one R-module, which splits because R is injective. Iterate
on the complement. Each free summand contributes one dimension to ND,
and the final complement contributes none. This proves the rank formula
without commutativity. Nakayama gives the minimal number of generators
dim(D/JD)=d_C, whence d_C<=dim_k D<=q d_C.

For cyclic P, the usual Smith form over k[e]/(e^q) gives the stated
lengths and free-summand count. If d_C=1 even for noncyclic P, D is
cyclic, R/I. When I!=0 it contains N and pullback is zero; when I=0
pullback is nonzero and dim D=q. The base cokernel is a line, so its
nonzero epsilon survives precisely in the latter case. Naturality
epsilon(T)=h*epsilon(C) is the inherited higher-Witt transfer theorem.

## 3. All six geometric Artin--Schreier covers

For the explicit pair, use u,v,t,h,mu from the base theorem and
z=u^2/v. The affine ring is k[u,v], and its pole semigroup at O is
<2,5>, with gaps1,3. Hence H1(O_C) has representatives z^-3,z^-1.
Frobenius in this basis is the semilinear matrix

    [[4t^2+t+2,3t+3],[t^3+3t^2+3,4t^2+1]].

Its fourfold semilinear product has characteristic polynomial(x+1)^2
and order10. Every Frobenius-fixed vector therefore has coefficients
in F_(5^40). The ordinary genus-two Artin--Schreier sequence gives a
two-dimensional F5 fixed space, so its SIX nonzero projective classes
are every geometric connected cyclic5 cover, not a field-point sample.

For each class c=c_-3 z^-3+c_-1 z^-1, subtract affine nongaps from
c^5-c to write c^5-c=fU+rem, where fU is an ACTUAL affine polynomial
and rem is regular at O. Then

    wU^5-wU=fU, wO=wU-c, wO^5-wO=-rem

glues an actual unramified cover. The affine AS algebra is etale and
the displayed completed O algebra is etale. The rational function c
and the nonzero Artin--Schreier class identify its smooth projective
connected model. Thus infinity and connectedness are included.

## 4. The actual Psi map, not a guessed genus-six operator

The audited higher matrix uses comparison frames IU,IO with
(IO^-1)11=z^4 a and (IU)22=a/mu, where a^2=(u-t)(u-h)^2.
Changing the next curve lift by chi changes the Frobenius/Taylor
matrix by 5 z^-5 chi^5 E12. Its Hodge projection is therefore

    z z^-5 (IO^-1)11 (IU)22 chi^5
      = a^2 chi^5/mu.

Up to the overall variation sign, which does not change its image,

    Psi([f])=[(u-t)(u-h)^2 f^5/(4+4t)].

This equality holds BEFORE taking cohomology. It hence remains true
under every actual etale base change; it is not inferred from equality
of a few base cohomology vectors. The multiplier is affine with pole
order6. Multiplication takes the Frobenius O-lattice z^10 to z^4,
which is inside the tangent O-lattice z^2. This also checks regularity.
The base3x3 matrix is independently compared with all three variations
in the inherited higher-Witt source, not merely with its rank.

Push tangent cohomology along h and use affine basis1,wU,...,wU^4.
The local basis wO^j=(wU-c)^j gives the triangular transition
binomial(j,i)(-c)^(j-i), with the additional tangent factor z^2.
Descending triangular reduction gives the15 basis classes

    z^e wU^j, e=-3,-1,1, j=0,...,4.

Completeness follows from the five-step polynomial filtration with
trivial line quotients: tensoring with T_C kills H0 at each step, so
each quotient contributes exactly the three-dimensional H1(T_C).

For each input column, expand wU^5=wU+fU and apply the displayed Psi
multiplier. To reduce the jth component, first remove affine nongaps,
then retain its three tangent classes and subtract its regular tail
times the jth local triangular column. This propagates the correction
only to lower components. Since pole(c)<=3, the maximal loss into a
lower component is3j. At each step the script checks absolute tail
precision >3j+2, which certifies every coefficient through exponent1.

## 5. Executed evidence and the failure of map-preserving repair

[cyclic5_witt_obstruction.sage](../scripts/cyclic5_witt_obstruction.sage)
regenerates all six covers and15x15 matrices. The finite data are in
[cyclic5_witt_obstruction.json](../Research/computations/cyclic5_witt_obstruction.json).

    OPENBLAS_NUM_THREADS=1 OMP_NUM_THREADS=1 sage scripts/cyclic5_witt_obstruction.sage --precision 160

All six matrices have rank13. For each the script solves Psi x=h*rho,
then directly replays its AS-algebra expression. It checks deck order5,
rank(deck-1)=12 and the FULL Frobenius-semilinear deck equivariance.
Precision140 and160 give the same verdicts; the latter exported the
certificate successfully in62.69s after startup. An independent medium
auditor replayed the complete precision160 calculation in62.41s.
Every rank and
preimage calculation is exact finite-field arithmetic.

A basic regression check exposed an installed Sage/PARI bug: the exact
monomial z^-3 over F_(5^40) reports coefficient1 at exponent-2 through
ordinary indexing. Finite-precision indexing is correct. The script
uses explicit coefficient-list bounds for exact Laurent polynomials,
retains the regression test, and all strengthened replays use this fix.
The original NumPy higher-Witt source is unaffected.

Thus epsilon(T)=0 and a compatible next Hodge lift of T exists, but
the source still has defect2. Suppose such a T3 extended T2->C2 to
some C3. Naturality in H1(T_T), BEFORE passing to cokernels, would give
0=rho(T3)=h*rho(C3). Actual etale pullback on negative H1 is injective
for every degree. Hence rho(C3)=0, contradicting the nonzero base
epsilon. Repair of the source necessarily abandons descent of that
one map. It supplies no repair of an existing two-leg diagram.
