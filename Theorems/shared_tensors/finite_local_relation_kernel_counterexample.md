# Minimal height-one local kernels need not have ample duals

ID: `finite_local_relation_kernel_counterexample`. Version1,
2 October2026. Author proof;
[focused root review](../../Research/audits/FINITE_LOCAL_RELATION_KERNEL_COUNTEREXAMPLE_AUDIT_2026_10_02.md) PASS.

Let Y be ANY smooth projective ordinary genus-two curve over an
algebraically closed field of characteristic five, let
$F:Y\to C=Y^{(1)}$, and let $B=F_*O_Y/O_C$.
For the twenty-four nontrivial lines $A\in\operatorname{Pic}(C)[5](k)$,
choose compatible Frobenius trivializations and their canonical
adjunction maps to B. Then
$R=\bigoplus_{A\ne O_C}A\longrightarrow B$
is surjective and is quotient-minimal as a finite-local coefficient
presentation: no nonzero finite-coefficient subobject maps to zero.
The coefficient is diagonalizable of height one, and $F^*R=O_Y^{24}$.

Its kernel K has rank twenty and degree minus four, but
$h^0(Y,F^*K)\ge7$ and $\mu_{\max}(F^*K)=0$.
In particular $K^\vee$ is NOT ample and K is NOT negative at every
Frobenius height. Moreover a connected finite etale cover of Y kills
a nonzero class in $H^1(Y,F^*K)$.

Thus the ample-dual, all-height negativity and all-height etale-H1
persistence conclusions for minimal FINITE ETALE coefficient kernels
cannot be extended to even diagonalizable height-one local
coefficients. This is a one-endpoint counterexample, not a common
finite coefficient or an actual common-cover witness.

[Proof](../../Proofs/shared_tensors/finite_local_relation_kernel_counterexample.md).
