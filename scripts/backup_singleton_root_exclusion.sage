#!/usr/bin/env sage
"""Three complete singleton-root charts: generate or replay exact unit identities.
Default is REPLAY only: no Groebner basis, ideal membership, or root search.
Geometry and completeness: Solutions/Sol_backup_singleton_root_exclusion.md.
"""
import argparse,json,time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def system(mode,coefficient_field=None):
    k=coefficient_field if coefficient_field is not None else GF(125,name='alpha',modulus=GF(5)['t']([1,1,0,1]))
    alpha=k.gen()
    base=PolynomialRing(k,'u');u0=base.gen()
    F0=u0*(u0-1)*(u0-2)*(u0-3)*(u0-alpha)
    assert F0.gcd(F0.derivative())==1
    Cartier=matrix(k,[[(F0**2)[j-i] for i in range(7)] for j in [4,9,14]],implementation='generic')
    assert Cartier.rank()==3
    if mode=='contains_O':
        block=Cartier.matrix_from_columns(range(4))
        assert block.rank()==2
        small=matrix(k,block.right_kernel().basis_matrix().rows(),implementation='generic')
        assert small.nrows()==2 and (block*small.transpose()).is_zero()
        S=PolynomialRing(k,names=['z','a0','a1','b0','b'],order='degrevlex')
        z,a0,a1,b0,b=S.gens();R=PolynomialRing(S,'u');u=R.gen();F=R(F0.list())
        A=sum(a*R(v.list()) for a,v in zip([a0,a1],small));B=b0+u;N=A**2-F*B**2
        eq=[N[3],N[4]]
        for j in [0,5]:eq += [N[j+1]+2*b*N[j+2],N[j]-b**2*N[j+2]]
        eq += [z*A(b)-1]
    elif mode=='contains_P':
        S=PolynomialRing(k,names=['z','a0','a1','a2','a3','b0','b1','b'],order='degrevlex')
        z,a0,a1,a2,a3,b0,b1,b=S.gens();R=PolynomialRing(S,'u');u=R.gen();F=R(F0.list())
        Ar=a0+a1*u+a2*u**2+a3*u**3+u**4;Br=b0+b1*u
        A=(u-b)**2*Ar;N=Ar**2-F*Br**2
        eq=[(A*F**2)[i] for i in [4,9,14]]
        eq += [N[4],N[7]+3*b,N[6]-3*b**2,N[5]+b**3,
               N[2]+3*b*N[3],N[1]-3*b**2*N[3],N[0]+b**3*N[3]]
        eq += [z*F(b)-1]
    elif mode=='open':
        polars=Cartier.right_kernel().basis_matrix();assert polars.nrows()==4
        last=next(i for i,row in enumerate(polars) if row[6])
        lead=polars[last]/polars[last][6]
        other=[row-row[6]*lead for i,row in enumerate(polars) if i!=last]
        assert len(other)==3 and all(not row[6] for row in other)
        assert matrix(k,[lead]+other,implementation='generic').rank()==4
        assert (Cartier*matrix(k,[lead]+other,implementation='generic').transpose()).is_zero()
        S=PolynomialRing(k,names=['z','a0','a1','a2','b0','b1','b2','b3','b'],order='degrevlex')
        z,a0,a1,a2,b0,b1,b2,b3,b=S.gens();R=PolynomialRing(S,'u');u=R.gen();F=R(F0.list())
        A=R(lead.list())+sum(a*R(v.list()) for a,v in zip([a0,a1,a2],other))
        B=b0+b1*u+b2*u**2+b3*u**3;N=A**2-F*B**2
        eq=[N[j] for j in [3,4,8,9]]
        for j in [0,5,10]:eq += [N[j+1]+2*b*N[j+2],N[j]-b**2*N[j+2]]
        eq += [z*A(b)-1]
    else:raise ValueError(mode)
    return k,S,eq


def run(args):
    started=time.monotonic();alarm(args.seconds)
    try:
      for mode in ([args.chart] if args.chart else ['open','contains_O','contains_P']):
        k,S,eq=system(mode)
        encode=lambda f:[[list(ex),[int(c) for c in co.polynomial().list()]] for ex,co in sorted(f.dict().items())]
        def decode(rows):
            return S({tuple(ex):sum(k(c)*k.gen()**i for i,c in enumerate(cs)) for ex,cs in rows})
        path=Path(args.directory)/('singleton_norm_'+mode+'.json')
        if args.generate:
            multipliers=list(S.one().lift(S.ideal(eq)))
            data={'chart':mode,'variables':list(S.variable_names()),
                  'equations':[encode(f) for f in eq],'multipliers':[encode(f) for f in multipliers],
                  'status':'EXACT ORIGINAL UNIT IDENTITY','seconds':time.monotonic()-started}
        else:
            data=json.loads(path.read_text())
            assert data['chart']==mode and data['variables']==list(S.variable_names())
            assert [decode(f) for f in data['equations']]==eq
            multipliers=[decode(f) for f in data['multipliers']]
        assert len(eq)==len(multipliers)
        assert sum(f*g for f,g in zip(eq,multipliers))==1
        # Negative control: a damaged multiplier is not silently accepted.
        assert sum(f*g for f,g in zip(eq,multipliers))+eq[0]!=1
        if args.generate:path.write_text(json.dumps(data,separators=(',',':'))+'\n')
        print('PASS',mode,'original equations',len(eq),'unit terms',sum(len(f.monomials()) for f in multipliers),
              'elapsed',round(time.monotonic()-started,3),flush=True)
      print('PASS all three exhaustive charts; no-solver replay' if not args.generate else 'PASS generation',flush=True)
    finally:cancel_alarm()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--generate',action='store_true')
    parser.add_argument('--chart',choices=['open','contains_O','contains_P'])
    parser.add_argument('--directory',default='Research/computations')
    parser.add_argument('--seconds',type=int,default=60)
    run(parser.parse_args())
