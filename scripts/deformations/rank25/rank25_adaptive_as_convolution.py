"""Exact subfield compression for the audited AS25 Kronecker product."""
def adaptive_dense_product(ns, original, a, b, precision):
    np=ns['np'];DEG=ns['DEG'];step=DEG//4
    active=[x for x in a+b if not x.iszero()]
    while step>1:
        mask=[i for i in range(DEG) if i%step]
        if all(not np.any(x.a[mask]) for x in active):break
        step//=2
    if step==1:return original(a,b,precision)
    dim=DEG//step;wide=2*dim-1
    la=min(x.l for x in a if not x.iszero());lb=min(x.l for x in b if not x.iszero())
    na=max(x.end-la for x in a if not x.iszero());nb=max(x.end-lb for x in b if not x.iszero())
    nz=na+nb-1;indices=ns['indices'];MOD=ns['MOD']
    def pack(vals,lo):
        out=np.zeros((5,9,wide,nz),dtype=np.int64);high=0
        for (i,j),x in zip(indices,vals):
            if x.iszero():continue
            out[i,j,:dim,x.l-lo:x.end-lo]=x.a[::step]
            high=max(high,((i*9+j)*wide+dim-1)*nz+x.end-lo)
        return out.ravel()[:high]
    raw=ns['gmp_conv'](pack(a,la),pack(b,lb))%MOD
    full=np.zeros(9*9*wide*nz,dtype=np.int64);full[:len(raw)]=raw
    ar=full.reshape(9,9,wide,nz)
    take=max(0,min(nz,ns['MAX']-la-lb,precision-la-lb));ar=ar[:,:,:,:take]
    Q=ns['Q'][::step]
    for i in range(2*dim-2,dim-1,-1):
        for j,q in enumerate(Q[:-1]):
            if q:ar[:,:,i-dim+j,:]=(ar[:,:,i-dim+j,:]-q*ar[:,:,i,:])%MOD
    out=np.zeros((25,DEG,take),dtype=np.int64)
    for i in range(9):
        for j in range(9):
            val=ar[i,j,:dim,:]
            if not np.any(val):continue
            if i<5 and j<5:out[ns['pos'][i,j],::step]+=val
            else:
                for k,mat in ns['RED'][i,j]:out[k,::step]+=mat[::step,::step]@val
    out%=MOD;p=min(precision,ns['MAX']) if take<nz else precision
    return [ns['Ser'](ar,la+lb,p) for ar in out]
