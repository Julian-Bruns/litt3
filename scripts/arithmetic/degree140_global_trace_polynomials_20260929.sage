"""Build the exact global trace equations from the proved interpolation box.
This constructs new equations; it does not rerun incoming certificates.
"""
import json, sys, time
from pathlib import Path
import numpy as np

root=Path(sys.argv[1]); name=sys.argv[2] if len(sys.argv)>2 else 'global_positive'
prefix=root/name
compact_only='--compact-only' in sys.argv[3:]
meta=json.loads((root/(name+'_summary.json')).read_text())
nh,nq=meta['grid']; rows=meta['coefficients']
arr=np.fromfile(str(prefix)+'_coefficients.bin',dtype='<i4').reshape(len(rows),nh,nq)
F=GF(5); Rz=PolynomialRing(F,'z'); z=Rz.gen()
u=z^4+2*z^3+z^2+2*z; v=z^3+z^2+1; modulus=u^2+u*v-3*v^2
K=GF(5^8,'a',modulus=modulus); a=K.gen(); beta=-u(a)/v(a)
assert beta^2-beta-3==0
R=PolynomialRing(K,['H','q'],order='degrevlex'); H,q=R.gens()
cache={0:K.zero()}; basis=[a^i for i in range(4)]
def decode(n):
    n=int(n)
    if n not in cache:
        t=n; s=K.zero()
        for i in range(4):
            c=t%25; t//=25; s+=(K(c%5)+(c//5)*beta)*basis[i]
        cache[n]=s
    return cache[n]
a0=sum(decode(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
Psi=a0+H*q*(decode(299833)+decode(232505)*q)
coeffs=[]; start=time.time()
for k,row in enumerate(rows):
    ii,jj=np.nonzero(arr[k]); terms={(int(i),int(j)):decode(arr[k,i,j]) for i,j in zip(ii,jj)}
    N=R(terms); dh,dq,dp=map(int,row['denominator_H_q_Psi'])
    if N:
        sh=min(dh,min(e[0] for e in N.dict())); sq=min(dq,min(e[1] for e in N.dict()))
        if sh or sq: N=R({(e[0]-sh,e[1]-sq):c for e,c in N.dict().items()});dh-=sh;dq-=sq
        while dp:
            quo,rem=N.quo_rem(Psi)
            if rem: break
            N=quo;dp-=1
    coeffs.append((row['j'],row['n'],N,(dh,dq,dp)))
    print('coefficient',row['j'],row['n'],'terms',len(N.dict()),'den',(dh,dq,dp),'elapsed',round(time.time()-start,2),flush=True)
save({'field_modulus':modulus,'ring':R,'Psi':Psi,'a0':a0,'coefficients':coeffs},str(root/(name+'_rational_coefficients')))
if compact_only:
    summary={'status':'constructed_exact_rational_coefficients','coefficients':len(coeffs),'seconds':time.time()-start,
             'rows':[{'j':int(j),'n':int(n),'terms':len(N.dict()),'denominator_H_q_Psi':list(map(int,D)),
                      'degrees':[int(N.degree(v)) for v in R.gens()]} for j,n,N,D in coeffs]}
    (root/(name+'_rational_summary.json')).write_text(json.dumps(summary)+'\n')
    print('compact rational construction complete',summary['seconds'],flush=True)
    sys.exit(0)
R3=PolynomialRing(K,['H','q','mu'],order='degrevlex'); HH,qq,mu=R3.gens(); inc=R.hom([HH,qq],R3)
equations=[]; summaries=[]
for j in sorted(set(int(c[0]) for c in coeffs)):
    cc=[c for c in coeffs if c[0]==j]; D=tuple(max(c[3][i] for c in cc) for i in range(3))
    out=R3.zero()
    for _,n,N,(dh,dq,dp) in cc:
        out+=inc(N*H^(D[0]-dh)*q^(D[1]-dq)*Psi^(D[2]-dp))*mu^n
    equations.append(out)
    summaries.append({'index':j,'denominator':list(D),'terms':len(out.dict()),'degrees':[int(out.degree(t)) for t in R3.gens()]})
    print('equation',summaries[-1],flush=True)
save({'ring':R3,'equations':equations,'Psi':inc(Psi),'a0':inc(a0)},str(root/(name+'_equations')))
(root/(name+'_equations_summary.json')).write_text(json.dumps({'status':'constructed_exact_global_equations','modulus':list(map(int,modulus.list())),'equations':summaries,'seconds':time.time()-start})+'\n')
