# Proof: all balanced phases at small residue mass

[Statement](../../Theorems/cartier_and_spin/klein_four_balanced_small_mass.md).
Use the conventions and moments of
[the structural theorem](klein_four_structural_moments.md). Write
kappa=[17]. For balanced endpoints with phases xi,psi, the sums are
C0=beta xi^5,E0=eta xi^8,Cinf=beta psi^5,Einf=eta psi^8.
The allowed change t_new=a t, epsilon_new=a^-4 epsilon, a in mu29,
changes these phases to a^7 xi,a^-7 psi. Normalize the first to1.
The remaining phase psi ranges over all29 roots. The pole weights
are permuted by this change, and their residue mass is unchanged.

Put x=M2,y=M6 in F_(5^14), xb=M_-2, yb=M_-6. Then xb=bar(x),
yb=bar(y), and the necessary determinant equation is
\[
(1-\bar x)(\psi^8-x)-(\kappa-y)(\kappa\psi^5-\bar y)=0.
\]
It remains necessary when one or more moment factors vanish. We
exclude this determinant equation itself, so there is no division
by a factor or omitted scale boundary.

The source
[F25 implementation](../../scripts/arithmetic/klein_four_balanced_mass.cpp)
represents F_(5^14) as F25[zeta]/f7, with
f7=(4,22,7,20,21,7,24,1). Its fixed irreducibility and coefficient
convention are independently checked in the incoming moment verifier.
It enumerates all integer profiles with each weight in{0,1,2,3,4,6}
and total m=0..8, by nondecreasing multisets; weight5 is rejected.
In particular it includes every residue vector of mass<=8.
For each profile it checks all29 phases in the complete field.

The determinant is evaluated as a psi^8+b psi^5+c, with
a=1-xb,b=-kappa(kappa-y),c=(kappa-y)yb-x(1-xb).
Precomputed multiplication matrices are used only to evaluate this
same field expression coefficient by coefficient. A first nonzero
coordinate proves nonvanishing; every zero would be retained.

The [independent replay](../../scripts/arithmetic/verify_klein_four_balanced_mass.cpp)
uses prime-field polynomial arithmetic modulo
\[
(1,2,4,0,4,4,3,1,3,4,4,0,4,2,1)
\]
with beta=(1,1,0,0,4,3,3,1,1,3,1,2,1,1). It checks beta^2=beta+3,
beta^25=beta, beta^5!=beta, zeta^29=1 and the same f7 relation.
This identifies the same embedded field. It enumerates integer
weights node by node, independently of the multiset recursion.
Counts are checked against coefficients of
(1+T+T^2+T^3+T^4+T^6)^29.

Both implementations found zero determinant solutions in every row:

| Total integer mass | Profiles | Phases per profile |
| ---: | ---: | ---: |
|0|1|29|
|1|29|29|
|2|435|29|
|3|4495|29|
|4|35960|29|
|5|237307|29|
|6|1344092|29|
|7|6712717|29|
|8|30141759|29|

These are exhaustive finite moment checks justified by the finite
cyclotomic residue data; no unknown curve coefficient is restricted
to this field. Since moments depend only on the residues, no larger
integer pole profile with residue mass<=8 can evade the result.
For actual weights, sum w_c=(n-12)-5j2, giving the stated inequality.

Exact outputs are the three pairs `balanced_mass_0_1.json`,
`balanced_mass_2_6.json`, `balanced_mass_7_8.json` and their
`verified_` counterparts in
`../../../litt3-computation-data/finite_loci_v4_replies_20260926/`.
Compile either source with `clang++ -std=c++17 -O3` and pass
`0 8 output.json` to reproduce the whole check. No CAS or network
is required. The second implementation was run over every profile,
not a sample of the first implementation's results.

The nonbalanced geometric cases with epsilon outside F_(5^14)
remain, as do the nonlinear and actual-cover conditions at larger
mass. This theorem does not decide their existence.
