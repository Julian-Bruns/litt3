"""Polynomial whole-curve residual model by certified-degree interpolation.

This is a global identity construction, NOT a finite-field point search.
With z=b(q)u, define G=b^72 q^83 d^36 Rcal.  It is polynomial in q,z,mu,x
modulo z^2+2cz+3be, with weighted q-degree <=624 (wt z=7).
Each of its two z coefficients is recovered from 625 exact values.
The source-degree proof is in REPORT.md; no claimed exclusion is implicit.
"""
import argparse, ctypes as C, json, time
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
import numpy as np
import ext
from ext import Element as E
from ff import Poly, add,mul,inv,power,vm,u32p,GENERATOR
from residual import RATIO,check_open
from residual_jet import residual_jet
ROOT=Path(__file__).resolve().parents[1]
WORK=ROOT/'scratch/global_model'
OUT=ROOT/'data/global_residual.npz'
N=625; WIDTH=2*141*7

def nodes():
    # A full additive coset of F_625 in K. Avoid precisely the denominators
    # used by the evaluation implementation (not an additional localization).
    gen=power(GENERATOR,626)
    sub=[0]+[power(gen,i) for i in range(624)]
    assert len(set(sub))==625 and all(power(x,625)==x for x in sub)
    pp={k:Poly(v) for k,v in RATIO.items()};used=set()
    for off in range(1,390625):
        if off in used:continue
        ns=[add(off,x) for x in sub];used.update(ns);ok=True
        for qv in ns:
            bv,cv,ev=[pp[k].eval(qv) for k in ('b','c','e')]
            if not bv:ok=False;break
            uv=ext.context([mul(3,ev),mul(2,cv),bv])
            try:check_open(E(qv),uv)
            except (ext.NonUnit,ZeroDivisionError):ok=False;break
        if ok:return ns,off
    raise RuntimeError('no admissible interpolation coset')

def one(qv):
    bv,cv,ev,dv=[Poly(RATIO[k]).eval(qv) for k in ('b','c','e','d')]
    u=ext.context([mul(3,ev),mul(2,cv),bv]);q=E(qv);check_open(q,u)
    rr,_=residual_jet(q,u,140)
    fac=mul(mul(power(bv,72),power(qv,83)),power(dv,36));facz=mul(fac,inv(bv))
    values=np.zeros((2,141,7),dtype=np.uint32)
    for s,p in enumerate(rr):
        values[0,:len(p),s]=vm(p.a[:,0],np.uint32(fac))
        values[1,:len(p),s]=vm(p.a[:,1],np.uint32(facz))
    return qv,values.ravel()

def load_interp():
    ll=C.CDLL(str(ROOT/'src/global_interpolate.so'))
    ll.ff_interpolate_batch.argtypes=[u32p,u32p,C.c_int,C.c_int,u32p];ll.ff_interpolate_batch.restype=C.c_int
    ll.ff_eval_batch.argtypes=[u32p,C.c_int,C.c_int,C.c_uint32,u32p]
    return ll

def build(workers=4):
    start=time.time();WORK.mkdir(parents=True,exist_ok=True);nf=WORK/'nodes.json'
    if nf.exists():data=json.loads(nf.read_text());ns=data['nodes']
    else:
        ns,offset=nodes();data={'nodes':ns,'coset_offset':offset,'degree_bound':624};nf.write_text(json.dumps(data)+'\n')
    pending=[n for n in ns if not (WORK/f'{n}.npy').exists()]
    print('GLOBAL_MODEL_NODES',len(ns),'remaining',len(pending),flush=True)
    with ProcessPoolExecutor(max_workers=workers) as pool:
        futures=[pool.submit(one,n) for n in pending];count=0
        for fut in as_completed(futures):
            qv,val=fut.result();np.save(WORK/f'{qv}.npy',val);count+=1
            if count%50==0:print('GLOBAL_MODEL_SAMPLES',count,'of',len(pending),'seconds',round(time.time()-start,2),flush=True)
    vals=np.array([np.load(WORK/f'{n}.npy') for n in ns],dtype=np.uint32);out=np.zeros_like(vals);narr=np.array(ns,dtype=np.uint32)
    print('GLOBAL_MODEL_INTERPOLATE',flush=True);ll=load_interp();assert ll.ff_interpolate_batch(narr,vals.ravel(),N,WIDTH,out.ravel())
    g=out.reshape((N,2,141,7)).transpose(1,2,3,0).copy();assert not g[1,:,:,618:].any()
    np.savez_compressed(OUT,coefficients=g,nodes=narr)
    buf=np.empty(WIDTH,dtype=np.uint32)
    for i,n in enumerate(ns):
        ll.ff_eval_batch(out.ravel(),N,WIDTH,n,buf);assert np.array_equal(buf,vals[i])
    extras=[]
    for n in range(1,100):
        if n in ns:continue
        try:_,v=one(n)
        except (ext.NonUnit,ZeroDivisionError):continue
        ll.ff_eval_batch(out.ravel(),N,WIDTH,n,buf);assert np.array_equal(buf,v);extras.append(n)
        if len(extras)==3:break
    summary={'status':'global polynomial model reconstructed; no global square decision','degree_bound':624,'interpolation_nodes':625,'z_coefficient_degree_bound':617,'additional_check_nodes':extras,'seconds':round(time.time()-start,3)}
    (ROOT/'checks/global_model.json').write_text(json.dumps(summary,indent=2)+'\n');print('GLOBAL_MODEL_SUMMARY_JSON='+json.dumps(summary,sort_keys=True),flush=True)

def inspect():
    g=np.load(OUT)['coefficients'];contents=[]
    for s in range(7):
        h=None;maxds=[-1,-1]
        for j in range(2):
            for n in range(141):
                p=Poly(g[j,n,s]);maxds[j]=max(maxds[j],p.degree())
                if p:h=p.monic() if h is None else h.gcd(p)
        contents.append(h);print('SCALE_CONTENT',s,'degrees',maxds,'gcd_degree',h.degree(),flush=True)
    h=contents[0]
    for p in contents[1:]:h=h.gcd(p)
    print('OVERALL_CONTENT',h.degree(),flush=True)
    dat={'contents':[p.tolist() for p in contents],'overall':h.tolist()};(ROOT/'data/global_contents.json').write_text(json.dumps(dat)+'\n')

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--inspect',action='store_true');ap.add_argument('--workers',type=int,default=4);args=ap.parse_args()
    if args.inspect:inspect()
    else:build(args.workers)
