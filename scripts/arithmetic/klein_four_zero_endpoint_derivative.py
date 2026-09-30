#!/usr/bin/env python3
"""Forced-label numerator for a vanishing endpoint ratio derivative."""
import argparse,json
from pathlib import Path
import klein_four_constant_character_jet as J
F=J.F


def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('near_data',type=Path);ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--include-individual-jets',action='store_true')
    a=ap.parse_args();data=json.loads(a.near_data.read_text());old=F.construct_data();assert data['root_data']==old
    roots=list(map(tuple,old['alpha_roots']));bases=list(map(tuple,old['B_base']))
    cs=[];ls=[]
    for v in roots:
        c=F.es(F.ei(F.ev(F.f.der(F.f.A),v)),13)
        l=F.em(c,F.ea(F.em(F.ev(F.f.der(F.f.P),v),F.ei(F.ev(F.f.P,v))),F.en(F.em(F.ev(F.f.der(F.f.der(F.f.A)),v),F.ei(F.ev(F.f.der(F.f.A),v))))))
        cs.append(c);ls.append(l)
    cases=[]
    for case in data['cases']:
        tag=case['roots'];arrays=[[{J.EXP0:roots[t]} for t in tag],
          [J.monomial(i,1,bases[t]) for i,t in enumerate(tag)],
          [J.monomial(i,4,F.em(cs[t],F.ep(bases[t],4))) for i,t in enumerate(tag)],
          [J.monomial(i,5,F.em(ls[t],F.ep(bases[t],5))) for i,t in enumerate(tag)]]
        ps=[]
        for signs in J.SIGNS:
            av,b,dav,db=[J.fourier(arr,signs) for arr in arrays]
            ps += [b,av,J.sub(J.mul(dav,b),J.mul(av,db))]
            if a.include_individual_jets:ps += [dav,db]
        cases.append({'roots':tag,'polynomials':[J.serialize(p) for p in ps]})
    out={'scope':'Exact forced-label conditions B=0=>A=0 and nonzero-B derivative numerator.', 'includes_individual_jets':a.include_individual_jets, 'cases':cases}
    a.output.write_text(json.dumps(out,separators=(',',':'))+'\n')
    with a.output.with_suffix('.dat').open('w') as f:
        print(*F.D7,file=f);print(len(cases),file=f)
        for c in cases:
            print(*c['roots'],file=f);print(15 if a.include_individual_jets else 9,file=f)
            for p in c['polynomials']:
                print(len(p),file=f)
                for t in p:print(*t,file=f)
    print('Prepared all eleven endpoint-label patterns, with collisions retained.')


if __name__=='__main__':main()
