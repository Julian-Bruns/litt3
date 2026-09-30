"""Leading-quintic degeneracy ideal, with explicit scope and checkpoints."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);mode=sys.argv[2] if len(sys.argv)>2 else 'prepare';start=time.time()
data=load(str(root/'quintic_leading_equations.sobj'));R=data['ring'];H,q=R.gens();K=R.base_ring();alpha=K.gen()
beta=-(alpha^4+2*alpha^3+alpha^2+2*alpha)/(alpha^3+alpha^2+1)
def dec(n):
    out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(K(c%5)+(c//5)*beta)*alpha^i
    return out
a0=sum(dec(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
Psi=a0+H*q*(dec(299833)+dec(232505)*q)
content=R(load(str(root/'endpoint_content_norm.sobj'))['norm'])
units=[H,q,Psi,a0,q-1,q-dec(15383)]
equations=[];rows=[]
for i,equation in enumerate(data['equations']):
    removed=[]
    for unit in units:
        power=0
        while True:
            quotient,remainder=equation.quo_rem(unit)
            if remainder:break
            equation=quotient;power+=1
        removed.append(int(power))
    equations.append(equation)
    rows.append({'row':int(i),'degrees':list(map(int,equation.degrees())),
                 'terms':len(equation.dict()),'removed_unit_powers':removed})
    print(json.dumps(rows[-1]),flush=True)
chart=prod(units)*content
save({'ring':R,'equations':equations,'chart':chart,'content':content,'Psi':Psi},str(root/'quintic_leading_ideal_inputs'))
print('gcd degrees',gcd(equations).degrees(),'seconds',time.time()-start,flush=True)
if mode=='prepare':exit()
assert mode=='solve'
J=R.ideal(equations).saturation(R.ideal(chart))[0]
gb=list(J.groebner_basis())
save({'ring':R,'basis':gb,'inputs':equations,'chart':chart},str(root/'quintic_leading_locus'))
report={'scope':'leading-coefficient degeneracy only','rows':rows,
        'unit_ideal':bool(R.one() in J),'seconds':time.time()-start,
        'basis_degrees':[list(map(int,f.degrees())) for f in gb]}
if R.one() not in J:
    report['dimension']=int(J.dimension())
    if J.dimension()==0:report['length']=int(J.vector_space_dimension())
(root/'quintic_leading_locus.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
