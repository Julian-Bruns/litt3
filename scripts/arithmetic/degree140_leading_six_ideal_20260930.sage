"""Analyze the two newly computed leading-six coefficients exactly."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
data=load(str(root/'reciprocal_degree6_invariant.sobj'))
R=data['ring'];H,q=R.gens();K=R.base_ring();a=K.gen()
b=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(n):
    out=K.zero()
    for i in range(4):
        c=n%25;n//=25;out+=(K(c%5)+(c//5)*b)*a^i
    return out
raw=load(str(root/'reciprocal_degree6_symbolic.sobj'))
for fixture in json.loads((root/'degree_six_leading.json').read_text())['rows']:
    hh,ww=dec(fixture['h']),dec(fixture['w'])
    for i,key in enumerate(['x3','y']):
        value=raw['values'][i]
        got=value.numerator()(hh*ww,ww)/value.denominator()(hh*ww,ww)
        assert got==dec(fixture[key]),(fixture,key)
print('all25 independent infinity-residue fixtures agree',flush=True)
a0=sum(dec(c)*q^i for i,c in enumerate([89654,311173,214299,163299,315361,33043,356725,245794]))
Psi=a0+H*q*(dec(299833)+dec(232505)*q)
inputs=[];report=[]
for i,(num,den) in enumerate(data['values']):
    du=[];rest=den
    for f in (H,q,Psi):
        power=0
        while True:
            quo,rem=rest.quo_rem(f)
            if rem:break
            rest=quo;power+=1
        du.append(int(power))
    assert rest.is_constant() and rest!=0, 'unexpected denominator factor'
    units=[]
    for f in (H,q,Psi):
        power=0
        while True:
            quo,rem=num.quo_rem(f)
            if rem:break
            num=quo;power+=1
        units.append(int(power))
    inputs.append(num)
    report.append({'row':i,'denominator_chart_powers':du,
       'numerator_chart_powers':units,'terms_after_stripping':len(num.dict()),
       'H_degree':int(num.degree(H)),'q_degree':int(num.degree(q))})
    print(json.dumps(report[-1]),flush=True)
save({'ring':R,'Psi':Psi,'a0':a0,'inputs':inputs,'original':data['values']},
     str(root/'reciprocal_degree6_leading_inputs'))
I=R.ideal(inputs)
chart=H*q*Psi*a0*(q-1)*(q-dec(15383))
J=I.saturation(R.ideal(chart))[0]
G=list(J.groebner_basis())
save({'ring':R,'Psi':Psi,'inputs':inputs,'basis':G},str(root/'reciprocal_degree6_leading_locus'))
result={'scope':'simultaneous leading-six zero locus only','fixtures':int(25),'rows':report,
    'unit_ideal':bool(R.one() in J),'basis':[(int(g.degree(H)),int(g.degree(q)),len(g.dict())) for g in G],
    'seconds':time.time()-start}
(root/'reciprocal_degree6_leading_locus.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result),flush=True)
