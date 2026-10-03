"""Prepare three pairwise scale-resultants with explicit support bounds."""
import sys,json,time,itertools
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_quadratic_matrix.sobj'));R=d['ring'];H,q=R.gens();M=d['matrix']
polys=[[M[i,0],M[i,1],H^4*M[i,2]] for i in range(3)]
dd=load(str(root/'inverse_eta_seven_rational_coefficients.sobj'));Psi=dd['Psi']
cc=[(int(n),R(N),(int(dh)-5*int(n),int(dq)+13*int(n),int(dp)+6*int(n)))
    for j,n,N,(dh,dq,dp) in dd['coefficients'] if j==0]
D=tuple(max(v[2][i] for v in cc) for i in range(3))
cubic=[R.zero() for _ in range(4)]
for n,N,e in cc:cubic[n]=N*H^(D[0]-e[0])*q^(D[1]-e[1])*Psi^(D[2]-e[2])
g=gcd(cubic);rest=g
for u in d['units'][:7]:
    while not rest.is_constant():
        z,r=rest.quo_rem(u)
        if r:break
        rest=z
unit=g//rest;cubic=[c//unit for c in cubic];polys.append(cubic)
def bounds(f,g):
    m=len(f)-1;n=len(g)-1;z=R.zero();rows=[]
    for i in range(n):rows.append([z]*i+list(reversed(f))+[z]*(n-i-1))
    for i in range(m):rows.append([z]*i+list(reversed(g))+[z]*(m-i-1))
    bd=[0,0]
    for p in itertools.permutations(range(m+n)):
        pp=[rows[i][p[i]] for i in range(m+n)]
        if any(not a for a in pp):continue
        for j in range(2):bd[j]=max(bd[j],sum(a.degree(R.gen(j)) for a in pp))
    return bd
pairs=[(0,1),(0,2),(0,3)];bb=[bounds(polys[i],polys[j]) for i,j in pairs]
save(dict(d,scale_polynomials=polys,resultant_pairs=pairs,resultant_bounds=bb),str(root/'inverse_eta_scale_resultant_inputs'))
def code(c):return sum(int(a)*5^i for i,a in enumerate(c.polynomial().list()))
with (root/'inverse_eta_scale_resultant_inputs.txt').open('w') as f:
    f.write(str(len(polys))+' '+str(len(pairs))+'\n')
    for pp in polys:
        f.write(str(len(pp))+'\n')
        for p in pp:
            f.write(str(len(p.dict()))+'\n')
            for e,c in p.dict().items():f.write(str(e[0])+' '+str(e[1])+' '+str(code(c))+'\n')
    for (i,j),(bh,bq) in zip(pairs,bb):f.write(f'{i} {j} {bh} {bq}\n')
report={'bounds':bb,'coefficients':[[{'degrees':list(p.degrees()),'terms':len(p.dict())} for p in pp] for pp in polys],'seconds':time.time()-start}
(root/'inverse_eta_scale_resultant_inputs.json').write_text(json.dumps(report,indent=2,default=int)+'\n');print(report,flush=True)
