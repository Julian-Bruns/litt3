"""Homogeneous Macaulay certificates for all candidate intersections."""
from core import *
import numpy as np, time, os
AT=np.array(ADD,dtype=np.uint8); MT=np.array(MUL,dtype=np.uint8)
ST=AT[:,np.array(NEG,dtype=np.int64)]

from homogeneous import forms, macaulay as _macaulay

def macaulay(G,N):
    A,labels=_macaulay(G,N)
    return np.array(A,dtype=np.uint8),labels

def fast_rank(A):
    A=A.copy();nr,nc=A.shape;r=0;ids=list(range(nr));chosen=[];pivs=[]
    for c in range(nc):
        nz=np.flatnonzero(A[r:,c])
        if not len(nz):continue
        i=int(nz[0])+r
        if i!=r:A[[r,i]]=A[[i,r]];ids[r],ids[i]=ids[i],ids[r]
        chosen.append(ids[r]);piv=int(A[r,c]);pivs.append(piv)
        A[r,c:]=MT[INV[piv],A[r,c:]]
        vals=A[r+1:,c]
        nz=np.flatnonzero(vals)
        if len(nz):
            inds=nz+r+1
            prod=MT[A[inds,c,None],A[None,r,c:]]
            A[inds,c:]=ST[A[inds,c:],prod]
        r+=1
        if r==nr:break
    return r,chosen,pivs

if __name__=='__main__':
    from locations import certificate_dir
    HERE=certificate_dir()
    HERE.mkdir(parents=True,exist_ok=True)
    with (HERE/'data.json').open() as fp:data=json.load(fp)
    cert=[]
    for cover in data['covers']:
        G=forms(data,cover);t0=time.time()
        for N in range(6,13):
            A,labels=macaulay(G,N);rank,chosen,pivs=fast_rank(A)
            print(cover['pair'],N,A.shape,rank,'defect',A.shape[1]-rank,'sec',round(time.time()-t0,2),flush=True)
            if rank==A.shape[1]:
                detcode=1
                for x in pivs:detcode=mul(detcode,x)
                cert.append({'pair':cover['pair'],'degree':N,'rank':rank,'rows':chosen,'determinant':detcode})
                break
        else:print('NOT CERTIFIED',cover['pair'],flush=True)
    with (HERE/'smoothness_certificates.json').open('w') as fp:json.dump(cert,fp,indent=2)
