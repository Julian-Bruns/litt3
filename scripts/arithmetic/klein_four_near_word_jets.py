#!/usr/bin/env python3
"""Exact necessary Moore determinants for two-dimensional Hermite spaces.

For constant T test rank_M(1,r,s)<=2; for arbitrary T in a pencil test
rank_M(1,r,r^2,s)<=3. This constructs forced endpoint equations only.
"""
import argparse
import itertools
import json
from pathlib import Path
import klein_four_constant_character_jet as J

F=J.F


def conj(p):
    return {e:F.ep(c,25**3) for e,c in p.items()}


def det(rows):
    n=len(rows); ans={}
    for perm in itertools.permutations(range(n)):
        v={J.EXP0:F.ONE}
        for i,j in enumerate(perm):v=J.mul(v,rows[i][j])
        sign=4 if sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))%2 else 1
        ans=J.add(ans,J.scale(v,sign))
    return ans


def moore(cols):
    rows=[cols]
    for _ in range(len(cols)-1):rows.append([conj(p) for p in rows[-1]])
    return det(rows)


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    old=F.construct_data()
    roots=list(map(tuple,old['alpha_roots']));bases=list(map(tuple,old['B_base']))
    cs=[];ls=[]
    for a in roots:
        apv=F.ev(F.f.der(F.f.A),a)
        cv=F.es(F.ei(apv),13)
        lv=F.em(cv,F.ea(F.em(F.ev(F.f.der(F.f.P),a),F.ei(F.ev(F.f.P,a))),
                         F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),a),F.ei(apv)))))
        cs.append(cv);ls.append(lv)
    tags=[(0,1,2,3)]+[(0,0,i,j) for i,j in itertools.combinations(range(1,4),2)]
    tags += [(0,0,0,i) for i in range(1,4)]
    tags += [(0,0,i,i) for i in range(1,4)]+[(0,0,0,0)]
    cases=[]
    for tag in tags:
        al=[{J.EXP0:roots[t]} for t in tag]
        bs=[J.monomial(i,1,bases[t]) for i,t in enumerate(tag)]
        aa=[J.monomial(i,4,F.em(cs[t],F.ep(bases[t],4))) for i,t in enumerate(tag)]
        cc=[J.monomial(i,5,F.em(ls[t],F.ep(bases[t],5))) for i,t in enumerate(tag)]
        polys=[]
        for signs in J.SIGNS:
            a,b,da,db=[J.fourier(arr,signs) for arr in (al,bs,aa,cc)]
            num=J.sub(J.mul(da,b),J.mul(a,db)); bb=J.mul(b,b);ab=J.mul(a,b)
            m3=moore([bb,ab,num]);m4=moore([bb,ab,J.mul(a,a),num])
            assert all(sum(e)==8 for e in m3)
            assert all(sum(e)==8 for e in m4)
            polys += [b,m3,m4]
        cases.append({'roots':tag,'polynomials':[J.serialize(p) for p in polys]})
        print('Constructed',tag,'sizes',[len(p) for p in polys],flush=True)
    out={'scope':'Necessary endpoint first-jet rank conditions for a two-dimensional Hermite solution space over F25^7.',
         'root_data':old,'cases':cases,'status':'equations_only'}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
    with args.output.with_suffix('.dat').open('w') as f:
        print(*F.D7,file=f);print(len(cases),file=f)
        for case in cases:
            print(*case['roots'],file=f);print(len(case['polynomials']),file=f)
            for p in case['polynomials']:
                print(len(p),file=f)
                for term in p:print(*term,file=f)


if __name__=='__main__':main()
