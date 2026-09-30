"""Import the native exact determinant and remove only allowed unit factors."""
import sys,json,time
from pathlib import Path
import numpy as np
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_rank_geometry_inputs.sobj'));R=d['ring'];H,q=R.gens();K=R.base_ring();a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1);cache={0:K.zero()}
def dec(n):
    n=int(n)
    if n not in cache:
        t=n;v=K.zero()
        for i in range(4):
            c=t%25;t//=25;v+=(K(c%5)+(c//5)*beta)*a^i
        cache[n]=v
    return cache[n]
meta=json.loads((root/'inverse_eta_rank_det.json').read_text());nh,nq=meta['grid']
arr=np.fromfile(str(root/'inverse_eta_rank_det_coefficients.bin'),dtype='<i4').reshape(nh,nq)
ii,jj=np.nonzero(arr);N=R({(int(i),int(j)):dec(arr[i,j]) for i,j in zip(ii,jj)})
original=N;removed=[]
for k,f in enumerate(d['units']):
    power=0
    while N and not N.is_constant():
        z,r=N.quo_rem(f)
        if r:break
        N=z;power+=1
    removed.append(power)
    print('unit',k,'power',power,'degrees',N.degrees(),'terms',len(N.dict()),'seconds',time.time()-start,flush=True)
    save(dict(d,determinant=N,removed_powers=removed,original_determinant=original),str(root/'inverse_eta_rank_geometry_partial'))
save(dict(d,determinant=N,removed_powers=removed,original_determinant=original),str(root/'inverse_eta_rank_geometry'))
report={'scope':'necessary rank equation; not a common-zero decision','zero':not bool(N),'unit':N.is_constant() and bool(N),
        'degrees':list(map(int,N.degrees())),'terms':len(N.dict()),'removed_powers':removed,'seconds':time.time()-start}
(root/'inverse_eta_rank_geometry.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(report,flush=True)
