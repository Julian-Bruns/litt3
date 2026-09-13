"""Finite test of a stronger, still abstract, early-absorption shortcut.

Does demanding a deck-invariant cubic potential remove the known
noninvariant early solution? No Hodge/geometric assertion is made.
Run with Sage Python; coefficients are exact in Z/125.
"""
import itertools
import json
from pathlib import Path
from sage.all import matrix, vector, GF, ZZ, QQ


def main():
    group=list(itertools.product(range(5),repeat=2)); idx={g:i for i,g in enumerate(group)}
    shifts=[[idx[((a+c)%5,(b+d)%5)] for a,b in group] for c,d in group]
    modulus=125
    one=vector(ZZ,[int(i==0) for i in range(25)])
    def conv(a,b):
        out=vector(ZZ,25)
        for i,v in enumerate(a):
            for j,w in enumerate(b):out[shifts[i][j]]+=v*w
        return out.apply_map(lambda v:v%modulus)
    logs=[]
    for g in [(1,0),(0,1)]:
        e=-one;e[idx[g]]+=1;p=one;log=vector(ZZ,25)
        for d in range(1,5):
            p=conv(p,e);log+=((-1)**(d+1)*pow(d,-1,modulus))*p
        logs.append(log.apply_map(lambda v:v%modulus))
    f=conv(logs[0],logs[0])+2*conv(logs[1],logs[1])
    inverse=[idx[(-a%5,-b%5)] for a,b in group]
    fs=vector(ZZ,[(f[i]+f[inverse[i]])*pow(2,-1,modulus)%modulus for i in range(25)])
    x=vector(ZZ,[2*a**4+4*a*a*b*b+3*b**4 for a,b in group])
    monomials=set(itertools.combinations_with_replacement(range(25),3));orbits=[]
    while monomials:
        m=min(monomials)
        orbit=sorted({tuple(sorted(sh[i] for i in m)) for sh in shifts})
        assert len(orbit)==25
        monomials.difference_update(orbit);orbits.append(orbit)
    columns=[]
    for orbit in orbits:
        grad=vector(ZZ,25)
        for mon in orbit:
            for i,j in enumerate(mon):
                grad[j]+=x[mon[(i+1)%3]]*x[mon[(i+2)%3]]
        columns.append(grad)
    C=matrix(ZZ,columns).transpose();K=GF(5)
    C0=C.change_ring(K);r=C0.rank()
    results=[]
    # The Smith data give a COMPLETE modular image test; free first
    # solutions are retained, rather than choosing a possibly bad lift.
    D,U,V=C.smith_form()
    assert U*C*V==D
    def qconv(a,b):
        out=vector(QQ,25)
        for i,v in enumerate(a):
            for j,w in enumerate(b):out[shifts[i][j]]+=v*w
        return out
    qlogs=[]
    for g in [(1,0),(0,1)]:
        e=-vector(QQ,one);e[idx[g]]+=1;p=vector(QQ,one);log=vector(QQ,25)
        for d in range(1,5):
            p=qconv(p,e);log+=QQ((-1)**(d+1))/d*p
        qlogs.append(log)
    qf=qconv(qlogs[0],qlogs[0])+2*qconv(qlogs[1],qlogs[1])
    qfs=vector(QQ,[(qf[i]+qf[inverse[i]])/2 for i in range(25)])
    for label,form in [('original',f),('self_adjoint',fs)]:
        target=vector(ZZ,[sum(form[j]*x[shifts[j][i]] for j in range(25))%modulus for i in range(25)])
        assert all(v%5==0 for v in target)
        target=vector(ZZ,[v//5 for v in target]);b=U*target
        solvable=True;ys=vector(ZZ,C.ncols());bad=[]
        for i in range(C.nrows()):
            d=int(D[i,i]);g=int(ZZ(d).gcd(25))
            if b[i]%g:
                solvable=False;bad.append({'row':i,'divisor':g,'residue':int(b[i]%g)})
            elif d:
                ys[i]=(int(b[i])//g)*pow(d//g,-1,25//g)%(25//g) if g!=25 else 0
        coeff=V*ys
        if solvable:assert all(v%25==0 for v in C*coeff-target)
        exact=None
        if label=='self_adjoint':
            qt=vector(QQ,[sum(qfs[j]*x[shifts[j][i]] for j in range(25))/5 for i in range(25)])
            qb=U*qt;qy=vector(QQ,C.ncols())
            for i in range(C.nrows()):
                assert D[i,i]!=0;qy[i]=qb[i]/D[i,i]
            qc=V*qy
            assert C*qc==qt and all(c.denominator()%5 for c in qc)
            assert all(qfs[i]==qfs[inverse[i]] for i in range(25))
            exact={'identity_over_Q':True,'all_potential_coefficients_in_Z_localized_at5':True,
                'identity':'L_s x = 5 grad(H)(x), with H a G-invariant cubic and L_s self-adjoint',
                'coefficients_mod15625':[int(c.numerator()*pow(int(c.denominator()),-1,15625)%15625) for c in qc],
                'full_rank_smith_test_suffices_for_all_5_adic_precisions':True}
        results.append({'operator':label,'solvable_mod125':solvable,'failed_smith_rows':bad,'exact_5_adic_certificate':exact,
            'nonzero_potential_orbits_mod25':[[i,int(c%25),list(orbits[i][0])] for i,c in enumerate(coeff) if c%25] if solvable else []})
    out={'status':'exact finite algebra test; not geometry','cubic_orbits':len(orbits),
        'gradient_rank_mod5':int(r),'smith_diagonal_5_adic_valuations':[int(ZZ(D[i,i]).valuation(5)) if D[i,i] else None for i in range(25)],
        'x_noninvariant_mod5':len(set(int(v%5) for v in x))>1,'results':results}
    path=Path(__file__).resolve().parents[2]/'Research/computations/equivariant_gradient_absorption_probe.json'
    path.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))


if __name__=='__main__':main()
