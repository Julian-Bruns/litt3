#!/usr/bin/env python3
"""Directly verify and complete the corrected marked fifth tuple.

Starts from an executed fourth tuple, applies the independently computed
fourth translation, and solves the whole fifth normal class. Artifacts
and caches remain outside litt3. No sixth assertion is made.
"""
import argparse
import hashlib
import itertools
import json
import math
import os
from pathlib import Path
import pickle
import sys
import time


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--engine-dir',type=Path,required=True)
    ap.add_argument('--fourth-objects',type=Path,required=True)
    ap.add_argument('--fifth-receipt',type=Path,required=True)
    ap.add_argument('--correction',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    root=Path(__file__).resolve().parents[3]
    assert not args.output.resolve().is_relative_to(root)
    receipt=json.loads(args.fifth_receipt.read_text())
    correction=json.loads(args.correction.read_text())
    assert receipt['lambda_code']==8 and receipt['fifth_scalar']==0
    assert correction['status']=='actual relative correction PASS'
    assert correction['fifth_receipt_sha256']==hashlib.sha256(args.fifth_receipt.read_bytes()).hexdigest()
    os.environ['LITT3_REFERENCE_MODULUS']='3125'
    os.environ['LITT3_REFERENCE_PRECISION']=str(receipt['workspace'])
    sys.path.insert(0,str(args.engine_dir.resolve()))
    from build_exact import build
    build()
    import witt_cubic as w,batch_witt as b,primary as pr,schur as sh,cover_char5 as ch
    from field import pw
    from rank125_fourth import Calculation
    from fourth_engine import Engine
    from normal_projection import interpolate,to_affine_coordinates,split_base,project
    started=time.monotonic()
    def log(*x):print(*x,'seconds',round(time.monotonic()-started,2),flush=True)
    calc=Calculation(receipt['frobenius_variant'],receipt['infinity_branch']);data=calc.data
    for i in range(3):
        a=pow(pow((3,1,2)[i],-1,5),625,3125)
        error=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(125)
        calc.W[i]=(calc.W[i]+b.Ser(w.ci(a))*error).mod(125)
        check=(calc.W[i]**5-a*calc.W[i]-b.Ser(a*calc.FU[i])).mod(125).cut(60)
        assert check.prec>=60 and check.iszero()
    calc.Wpowers.clear()
    with args.fourth_objects.open('rb') as f:old=pickle.load(f)
    assert args.fourth_objects.name==args.fifth_receipt.stem+'_fourth_objects.pkl'
    assert ch.records(old['source4'])==receipt['source4'],'fourth cache/receipt source mismatch'
    H=receipt['H'];nH,_,_,_=ch.primary_repair(H,data)
    en=Engine(b.Ser,calc.o,calc.evaluate(nH,m=125))
    V=[0]*125
    for i,c in enumerate(correction['fourth_translation']):
        if c:V=sh.padd(V,sh.pscale(data['nus'][i],c))
    nV,nV5,affV,boundV=ch.primary_repair(V,data)
    nVv=calc.evaluate(nV,m=25)
    en.ell-=25*(calc.evaluate(old['source4'],m=25)+nVv)
    P2U,P2O=old['P2U'],old['P2O']
    zu=b.Ser(calc.o['zeta']);zo=b.Z**4*(en.g/b.Z**2).frob()
    phiP2=(P2U.frob()+(en.fuz-b.Z**5)*P2U.deriv().frob()).mod(25)
    BU=[[b.Ser(0),-zu],[-25*phiP2*zu,b.Ser(0)]]
    BO=[[b.Ser(0),-zo],[-25*P2O.frob()*zo,b.Ser(0)]]
    av=calc.evaluate(affV,m=25)
    bv=calc.evaluate(boundV,formal=True,m=25).shift(-2)
    assert bv.valuation>=0
    en.zero(b.Ser(w.peval(calc.o['AP'],calc.u))*nVv.frob()-av-b.Z**2*bv,
            5,60,'whole fourth translation primary repair')
    def linear_graph(I,q,di,P,weight):
        # Exact when weight^2=0 in the output ring. Using current frames
        # only modulo625/weight preserves precision as well as all terms.
        modulus=625//weight
        assert weight*weight%625==0
        q=q.mod(modulus);di=di.mod(modulus);P=P.mod(modulus)
        dq=(q.deriv()*di).mod(modulus)
        ddq=(dq.deriv()*di).mod(modulus)
        half=b.Ser(w.ci(2))
        T=[[-half*dq,q],[q*P-half*ddq,half*dq]]
        delta=en.mm(en.mmod(I,modulus),en.mmod(T,modulus),modulus)
        out=en.mmod(en.madd(I,en.scalar(weight,delta)),625)
        # tr(T)=0 gives determinant preservation because weight^2=0.
        en.zero(out[0][0]*out[1][1]-out[0][1]*out[1][0]-1,625,30,
                'linear graph determinant')
        return out
    # Two graph corrections of weight25 compose additively modulo625.
    GU=linear_graph(old['GU2'],av,en.gi,P2U,25)
    GO=linear_graph(old['GO2'],-bv,b.Z**2*en.gi,P2O,25)
    log('incremental second graphs and determinants PASS')
    ov=en.overlap()
    rho5,G5=en.comparison(ov,GU,GO,P2U,625,125)
    en.horizontal_check(ov,G5,BU,BO,625)
    def jet_check(G,GU,GO,m,label):
        jet=en.mm(en.mm(en.mi(GO,m),G,m),[[en.tau(x,m) for x in row] for row in GU],m)
        for i in range(2):
            for j in range(2):en.zero(jet[i][j]-ov['J'][i][j],m,30,f'{label} {i}{j}')
    jet_check(G5,GU,GO,125,'translated fourth full jet')
    E5,N5,projection5=project(rho5,calc)
    assert not any(E5),('direct translated fifth scalar class',ch.coded_nonzero(E5))
    log('direct translated whole fifth class ZERO',rho5)

    def even_jmath(poly):
        return all((int(bool(c&1))+int(bool(c&2))+e[0])%2==0
                   for e,p in poly.items() for c,h in p)
    def odd_first(poly):
        return all((int(bool(c&2))+sum(e))%2==1
                   for e,p in poly.items() for c,h in p)
    for poly in (nH,nV,affV,boundV,old['source4']):
        assert even_jmath(poly) and odd_first(poly),'both special-fibre tame parities'
    def solve_primary(normal):
        rhs=[[0]*125 for _ in range(6)]
        for we,vec in normal.items():
            e=tuple(4-x for x in we);idx=pr.MONIDX[e]
            fac=math.prod(math.factorial(4)//math.factorial(4-x) for x in e)%5
            for j,c in enumerate(vec):rhs[j][idx]=pr.MUL[c][pr.INV[fac]]
        scalar=sh.sum_poly([sh.pmul(a,x) for a,x in zip(data['ell'],rhs)])
        assert not any(ch.quotient(scalar,data))
        columns=[]
        for i in range(125):
            mon=[0]*125;mon[i]=1;columns.append(sh.pmul(data['f'],mon))
        rr,pv=sh.rref([list(r)+[scalar[i]] for i,r in enumerate(zip(*columns))],125)
        assert len(pv)==82 and all(not r[-1] for r in rr[len(pv):])
        x0=[0]*125
        for i,p in enumerate(pv):x0[p]=rr[i][-1]
        M=data['M'];inv=sh.matinv([[M[i][j][0] for j in range(1,6)] for i in range(1,6)])
        x=[x0]+[[0]*125 for _ in range(5)]
        for idx,e in enumerate(pr.MONS):
            rem=[]
            for i in range(1,6):
                value=pr.ADD[rhs[i][idx]][pr.NEG[sh.pmul(M[i][0],x0)[idx]]]
                for j in range(1,6):
                    for mi,ai in sh.RP[idx]:
                        if mi:value=pr.ADD[value][pr.NEG[pr.MUL[M[i][j][mi]][x[j][ai]]]]
                rem.append(value)
            sol=sh.mv(inv,rem)
            for j in range(1,6):x[j][idx]=sol[j-1]
        for i in range(6):assert sh.sum_poly([sh.pmul(M[i][j],x[j]) for j in range(6)])==rhs[i]
        poly={}
        for j,row in enumerate(x):
            for idx,c in enumerate(row):
                if not c:continue
                e=pr.MONS[idx];we=tuple(4-a for a in e)
                fac=math.prod(math.factorial(4)//math.factorial(4-a) for a in e)%5
                coef=pr.MUL[pr.MUL[pw(c,25)][pow(3,3*e[0]+e[2],5)]][fac]
                term=poly.setdefault(we,{})
                term[pr.NM[j]]=pr.ADD[term.get(pr.NM[j],0)][coef]
        poly={e:{k:v for k,v in p.items() if v} for e,p in poly.items() if any(p.values())}
        assert even_jmath(poly) and odd_first(poly)
        return x,poly
    x5,n5=solve_primary(N5)
    n5v=calc.evaluate(n5,m=5)
    en.ell-=125*n5v
    ov=en.overlap()
    repaired5,G5=en.comparison(ov,GU,GO,P2U,625,125)
    en.zero(repaired5-rho5+b.Ser(w.peval(calc.o['AP'],calc.u))*n5v.frob(),
            5,60,'actual terminal fifth source response')
    en.horizontal_check(ov,G5,BU,BO,625)
    coeffs=to_affine_coordinates(interpolate(repaired5,150),calc)
    powers=[[(x**j).mod(5) for j in range(5)] for x in [-c for c in calc.chi]]
    shifts={e:(powers[0][e[0]]*powers[1][e[1]]*powers[2][e[2]]).mod(5) for e in pr.MONS}
    aff3={};minimum=min(v.prec for v in coeffs.values())
    for e in reversed(pr.MONS):
        if coeffs[e].iszero():continue
        vec,bound,records=split_base(coeffs[e],e[0]%2,calc)
        minimum=min(minimum,bound.prec);assert not any(vec),'terminal fifth normal'
        if records:aff3[e]={(c,h):a for c,h,a in records}
        if bound.iszero():continue
        for f in itertools.product(*(range(a+1) for a in e)):
            if f==e:continue
            shift=tuple(e[i]-f[i] for i in range(3))
            fac=math.prod(math.comb(e[i],f[i]) for i in range(3))%5
            coeffs[f]=(coeffs[f]-bound*shifts[shift]*fac).mod(5)
    assert minimum>=2 and even_jmath(aff3) and odd_first(aff3)
    assert all(h>=0 for p in aff3.values() for c,h in p)
    fa3=calc.evaluate(aff3,m=5)
    fo3=((repaired5-fa3).mod(5)).shift(-2)
    assert fo3.valuation>=0 and fo3.prec>=60
    en.zero(repaired5-fa3-b.Z**2*fo3,5,60,'whole third regular repair')
    GU3=linear_graph(GU,-fa3,en.gi,P2U,125)
    GO3=linear_graph(GO,fo3,b.Z**2*en.gi,P2O,125)
    jet_check(G5,GU3,GO3,625,'complete corrected fifth jet')
    log('complete marked fifth tuple PASS')
    output={'status':'complete fifth tuple PASS; independent audit pending',
            'source_modulus':3125,'flat_modulus':625,'lambda_code':8,
            'fourth_translation':correction['fourth_translation'],
            'direct_E5':E5,'direct_projection5':projection5,
            'primary_source5_coordinates':x5,'source5':ch.records(n5),
            'third_affine':ch.records(aff3),
            'third_formal_definition':'whole (source-repaired rho5 - actual affine polynomial)/z^2; other branch by jmath transport',
            'third_formal_precision':fo3.prec,'minimum_normal_precision':minimum,
            'checks':en.checks,'seconds':time.monotonic()-started,
            'source_sha256':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in
                             [Path(__file__),args.correction,args.fifth_receipt,args.fourth_objects]+
                             sorted(args.engine_dir.glob('*.py'))+sorted(args.engine_dir.glob('*.cpp'))}}
    with args.output.with_suffix('.pkl').open('wb') as f:
        pickle.dump({'GU3':GU3,'GO3':GO3,'GU2':GU,'GO2':GO,'P2U':P2U,'P2O':P2O,
                     'ell':en.ell,'source5':n5,'fa3':fa3,'fo3':fo3,'G5':G5},f)
    args.output.write_text(json.dumps(output,indent=2)+'\n')


if __name__=='__main__':main()
