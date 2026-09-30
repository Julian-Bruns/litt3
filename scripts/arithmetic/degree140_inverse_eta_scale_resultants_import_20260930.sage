"""Import the small resultants and strip only proved chart units.

Nondivisibility is detected in a single degree-preserving specialization
before attempting a large multivariate division.
"""
import sys,json,time
from pathlib import Path
import numpy as np
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_scale_resultant_inputs.sobj'));R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1);cache={0:K.zero()}
def dec(n):
    n=int(n)
    if n not in cache:
        t=n;v=K.zero()
        for i in range(4):
            c=t%25;t//=25;v+=(K(c%5)+(c//5)*beta)*a^i
        cache[n]=v
    return cache[n]
S=PolynomialRing(K,'z');z=S.gen();specs={}
def could_divide(p,u):
    axis=0 if u.degree(H)>0 else 1
    for val in [K(2),K(3),a,a+1]:
        key=(axis,val)
        if key not in specs:specs[key]=R.hom([z,val] if axis==0 else [val,z],S)
        ph=specs[key];uu=ph(u)
        if uu.degree()!=u.degree(R.gen(axis)):continue
        return not bool(ph(p).mod(uu))
    return True
rows=[];reports=[]
for idx in range(3):
    meta=json.loads((root/f'inverse_eta_scale_resultants_{idx}.json').read_text());nh,nq=meta['grid']
    arr=np.fromfile(str(root/f'inverse_eta_scale_resultants_{idx}.bin'),dtype='<i4').reshape(nh,nq)
    ii,jj=np.nonzero(arr);p=R({(int(i),int(j)):dec(arr[i,j]) for i,j in zip(ii,jj)});original=p;removed=[]
    for k,u in enumerate(d['units']):
        n=0
        if k<2:
            n=min(e[k] for e in p.exponents())
            if n:p=R({tuple(v-n if j==k else v for j,v in enumerate(e)):c for e,c in p.dict().items()})
        else:
            while p and not p.is_constant() and could_divide(p,u):
                quo,rem=p.quo_rem(u)
                if rem:break
                p=quo;n+=1
        removed.append(n)
        print('row',idx,'unit',k,'power',n,'degrees',p.degrees(),'seconds',time.time()-start,flush=True)
    rows.append(p);reports.append({'index':idx,'removed_powers':removed,'degrees':list(p.degrees()),'terms':len(p.dict())})
    save(dict(d,scale_resultants=rows,reports=reports),str(root/'inverse_eta_scale_resultants_partial'))
save(dict(d,scale_resultants=rows,reports=reports),str(root/'inverse_eta_scale_resultants'))
def code(c):return sum(int(v)*5^i for i,v in enumerate(c.polynomial().list()))
with (root/'inverse_eta_scale_projection_inputs.txt').open('w') as f:
    f.write('3\n')
    for p in rows:
        f.write(f'{p.degree(H)} {p.degree(q)} {len(p.dict())}\n')
        for e,c in p.dict().items():f.write(f'{e[0]} {e[1]} {code(c)}\n')
(root/'inverse_eta_scale_resultants.json').write_text(json.dumps({'scope':'necessary pairwise scale resultants, not simultaneous-root decision','rows':reports,'seconds':time.time()-start},indent=2,default=int)+'\n')
