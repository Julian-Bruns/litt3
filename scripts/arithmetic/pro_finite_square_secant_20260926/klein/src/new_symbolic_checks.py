#!/usr/bin/env python3
"""Redundant exact checks of REPORT theorems; not a geometric solution search."""
import sympy as S

def main():
    ep,t,E,Uj,Uk,Tj,Tk = S.symbols('ep t E Uj Uk Tj Tk')
    Vj, Vk = ep*t**7*Uj+E*Tj, ep*t**7*Uk+E*Tk
    assert S.expand(Uj*Vk-Uk*Vj-E*(Uj*Tk-Uk*Tj))==0
    assert S.expand(Vj*Tk-Vk*Tj-ep*t**7*(Uj*Tk-Uk*Tj))==0
    e,ci,cj,ck,hi,hj,hk,j,j1,g = S.symbols('e ci cj ck hi hj hk j j1 g')
    # sum of the three pair-degree bounds, sum c_i=2j, sum h_i=g+3
    total=S.expand(3*(e-14)+2*((10+ci-hi)+(10+cj-hj)+(10+ck-hk)))
    assert S.expand(total.subs(ck,2*j-ci-cj).subs(hk,g+3-hi-hj) - (3*e+12+4*j-2*g))==0
    Ji,Ki,Li,Aj,x=S.symbols('Ji Ki Li Aj x')
    Ak=Aj-Ji*Ki
    G=Aj*(x+Ji*Li)**2-Ak*x**2
    assert S.expand(G-Ji*(Ki*x**2+2*Aj*x*Li+Ji*Aj*Li**2))==0
    # Scalar genus-n+1 input profiles and the new summed inequality.
    survivors=[]
    for n in range(26,55,2):
        j1=(n-26)//2; e=14; g=n+1
        if 2*g+j1 <= 3*e+12+4*j1:
            survivors.append(n)
    assert survivors==[26]
    triples=[(a,b,26-a-b) for a in range(14) for b in range(14)
             if 0 <= 26-a-b <= 13]
    unordered=sorted({tuple(sorted(q)) for q in triples})
    assert all(sum(35-x for x in q)==79 for q in triples)
    # Diagonal root contact: first nonzero perturbation v=u+b*s^r.
    assert (39*2-26)%5==2
    assert [r for r in range(2,20) if (39*r-26)%5==0]==[4,9,14,19]
    # Second coefficient in the branch-incidence expansion.
    aa,ab,daa,dab,ba,bb=S.symbols('aa ab daa dab ba bb', nonzero=True)
    lam=aa/ab
    mu=lam*(lam*bb-ba)/2
    numerator=daa-lam**2*dab-2*mu*ab
    J_a=(daa+aa*ba)/aa**2
    J_b=(dab+ab*bb)/ab**2
    assert S.simplify(numerator-aa**2*(J_a-J_b))==0
    print('PASS: determinant identities and degree-cancellation formula.')
    print('PASS: summed genus inequality and second-order companion numerator.')
    print('PASS: genus n+1 can remain only at n=26 among accepted equality profiles.')
    print('n=91 necessary q triples: ordered',len(triples),'unordered',len(unordered))
    print('Unordered q triples:',unordered)
    print('PASS: diagonal contact coefficient is nonzero; second-jet J formula.')
    print('SymPy',S.__version__)
    print('Checks are redundant arithmetic/symbolic verification, NOT actual objects.')

if __name__=='__main__': main()
