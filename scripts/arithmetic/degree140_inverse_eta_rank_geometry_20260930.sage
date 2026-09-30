"""Necessary rank and conic equations from the three new quadratic rows.

The three rows are exact consequences of the seven actual divided traces.
Only explicitly excluded chart/content factors may be removed.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_quadratic_reduction.sobj'))
R=d['ring'];H,q=R.gens();K=R.base_ring();Psi=d['Psi'];line=d['line']
base=load(str(root/'inverse_eta_seven_rational_coefficients.sobj'));a0=base['a0']
alpha=K.gen();beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    z=K.zero()
    for i in range(4):
        c=n%25;n//=25;z+=(K(c%5)+(c//5)*beta)*alpha^i
    return z
units=[H,q,Psi,line,a0,q-1,q-dec(15383)]
content=load(str(root/'endpoint_content_norm.sobj'))
for record in content['records']:
    n=record['norm'];eh=min(e[0] for e in n.exponents());ew=min(e[1] for e in n.exponents())
    assert all((e[1]-ew)%3==0 for e in n.exponents())
    units.append(R({(int(e[0]-eh),int((e[1]-ew)/3)):c for e,c in n.dict().items()}))
def strip(N):
    powers=[]
    for f in units:
        count=0
        while N and not N.is_constant():
            z,r=N.quo_rem(f)
            if r:break
            N=z;count+=1
        powers.append(count)
    return N,powers
M=matrix(R,d['quadratics']);row_contents=[]
for i in range(3):
    g=gcd(list(M.row(i)));rest,powrs=strip(g);unit=g//rest
    for j in range(3):M[i,j]=M[i,j]//unit
    row_contents.append({'residual_degrees':list(map(int,rest.degrees())),'unit_powers':list(map(int,powrs))})
    print('row content',i,row_contents[-1],flush=True)
columns=[]
for j in range(3):
    g=gcd(list(M.column(j)));rest,powrs=strip(g);unit=g//rest
    columns.append(unit)
    for i in range(3):M[i,j]=M[i,j]//unit
    print('column units',j,powrs,'residual degree',rest.degrees(),flush=True)
save({'ring':R,'matrix':M,'column_units':columns,'row_contents':row_contents,'units':units},str(root/'inverse_eta_rank_geometry_inputs'))
det=M[0,0]*(M[1,1]*M[2,2]-M[1,2]*M[2,1])-M[0,1]*(M[1,0]*M[2,2]-M[1,2]*M[2,0])+M[0,2]*(M[1,0]*M[2,1]-M[1,1]*M[2,0])
print('det built',det.degrees(),len(det.dict()),'seconds',time.time()-start,flush=True)
det,dp=strip(det)
save({'ring':R,'matrix':M,'column_units':columns,'row_contents':row_contents,'units':units,'determinant':det,'removed_powers':dp},str(root/'inverse_eta_rank_geometry'))
report={'scope':'necessary quadratic-row rank drop; not a zero-locus decision',
        'determinant_zero':not bool(det),'degrees':list(map(int,det.degrees())) if det else None,
        'terms':len(det.dict()),'removed_unit_powers':list(map(int,dp)),
        'rows':row_contents,'seconds':time.time()-start}
(root/'inverse_eta_rank_geometry.json').write_text(json.dumps(report,indent=2,default=int)+'\n')
print(report,flush=True)
