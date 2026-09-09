# An odd-prime spin probe reduces both legs after one closure

Use the actual coreless spin-Cartier span X<-Z->Y and compatible reduced
sections of spin_cartier_root_normal_form in odd characteristic p.
Assume

    X: y^a=F(x),  a an odd prime different from p,
    F squarefree, gcd(a,deg F)=1, g(X)-1>=a,

and Y has genus2 with an effective spin A_Y whose section square eta
and Cartier(eta) are independent. The original endpoint spins may be
ineffective. These hypotheses include our degree-ten trigonal X and C_t.

There is a connected etale refinement V->Z of degree at most8. Take
ONE Galois closure T->Y of V->Y, keeping both embedded endpoint fields.
The complete pulled-back spin series on T is base-point-free, and its
normalized image map phi:T->S is finite ETALE. Both original maps factor
through S, and the resulting S->X,Y are finite etale and coreless.
The common spin and reduced section h descend to S and agree with its
image spin. All spin sections descend, so the complete spin series on S
is base-point-free and birational. It stays so under subsequent alternating
normal closures by normal_closure_section_field.

Key extra probe: choose any effective spin A' on X distinct from
A_0=O_X((g(X)-1)O). If e'^2=eta' and e_0^2=theta=dx/y^(a-1), then

                 k(x,eta'/theta)=k(X).

The existence of A' follows from the odd-theta parity count in
characteristic different from2. No equation for A' is required.

Thus the selected-pair source reduction needs neither an eight-step
different descent nor the unique-clump or strict-growth theorems.
This is a structural replacement of that reduction, NOT a nonexistence
theorem, a degree bound on T, or a treatment of other/no-clump profiles.

Version1,2026-09-08. Fresh medium audit PASS by
/root/audit_prime_spin_probe,2026-09-08; no objections or revisions.
Not Lean verified.
[Audit record](../Research/audits/PRIME_SPIN_PROBE_REDUCTION_AUDIT_2026_09_08.md).
[Proof](../Solutions/Sol_prime_spin_probe_reduction.md).
