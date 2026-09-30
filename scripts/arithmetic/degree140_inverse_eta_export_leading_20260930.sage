"""Prepare the three quadratic leading coefficients for exact resultants."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
d=load(str(root/'inverse_eta_rank_geometry_inputs.sobj'));M=d['matrix'];R=d['ring'];H,q=R.gens()
rows=[];units=d['units']
for i in range(3):
    N=M[i,2];powers=[]
    for f in units:
        power=0
        while N and not N.is_constant():
            z,r=N.quo_rem(f)
            if r:break
            N=z;power+=1
        powers.append(power)
    rows.append(N);print('row',i,'degrees',N.degrees(),'terms',len(N.dict()),'units',powers,flush=True)
save(dict(d,leading_inputs=rows),str(root/'inverse_eta_quadratic_leading_inputs'))
def code(c):return sum(int(a)*5^i for i,a in enumerate(c.polynomial().list()))
with (root/'inverse_eta_quadratic_leading.txt').open('w') as f:
    f.write('3\n')
    for p in rows:
        f.write(str(p.degree(H))+' '+str(p.degree(q))+' '+str(len(p.dict()))+'\n')
        for e,c in p.dict().items():f.write(str(e[0])+' '+str(e[1])+' '+str(code(c))+'\n')
print('exported seconds',time.time()-start,flush=True)
