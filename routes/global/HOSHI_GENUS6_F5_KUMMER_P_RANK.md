# Hoshi's genus-six Kummer construction over F5: exact p-rank four

Status: exact computational certificate, 2026-09-05; not independently
audited. Optional example only. No change to the fixed pair in file 76.

Take

    E: y^2=x^3+3x+2,   P=(1,1),   O=infinity,
    f=(x+3)y+4x^2+4x+3.

The curve E has five F5-points. Writing f=A+By, exact identities are

    A^2-B^2(x^3+3x+2)=4(x-1)^5,
    df/f=dx/(2y).

Moreover f(P)=0 and f(-P)=2. The unique pole is O, of order five,
so div(f)=5P-5O. Let Y be the smooth normalization of w^6=f over E.
The valuations 5 and -5 are coprime to six, so this is a connected
tame degree-six cover, totally ramified precisely at P and O.
Its genus is six. The unique points P_Y,O_Y above P,O are rational.

The logarithmic differential beta=dlog(f)=dw/w is nonzero and
Cartier-fixed. Since dx/(2y) has no zeros on E, tame ramification gives

    div(beta)=5(P_Y+O_Y).

Thus this is a concrete instance of
[Hoshi's construction](https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1917.pdf).
For i=1,2,3,4, div(d(f^i)) is divisible by five; their ratios are
non-fifth-powers for distinct i, giving at least four maximal Tango
structures. No assertion that these are all the structures is made.

Exact counts over F_(5^n), n=1,...,6, are

    2, 44, 158, 572, 3082, 16574.

Newton identities and the genus-six functional equation give

    P_Y(T)=(T^2-4T+5)(T^2-3T+5)(T^2-T+5)
           (T^2+4T+5)(T^2+5)^2.

Therefore Y has p-rank FOUR, not one. In particular this example
does not achieve the requested rank-one target.

The search over F5 is complete for the stated #E(F5)=5 construction:
the only nonsingular short-Weierstrass models y^2=x^3+ax+b with five
rational points have (a,b)=(3,2),(3,3), and these are F5-isomorphic.
All four nonzero points on each model were checked, with the xy
coefficient of f normalized to one. Every resulting Y has p-rank
four. Multiplying f by a nonzero scalar does not change geometric
p-rank, since the resulting covers become isomorphic over Fbar5.

The full count/Frobenius data and exact divisor checks are executable
in [the Sage certificate](HOSHI_GENUS6_F5_KUMMER_P_RANK_CERTIFICATE.sage).
The certificate also checks a seventh count for the displayed model,
independently of the six counts used to reconstruct its polynomial.
Arbitrary F25 elliptic models were not searched.
