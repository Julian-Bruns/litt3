"""Two infinity coefficients certify a uniform monic actual quintic."""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_symbolic_leading_six_20260930.sage').read_text()
source=source[:source.index('answer=[A.zero()')]
source=source.replace('N=12;', 'N=6;')
exec(preparse(source))
Z=large
phi=(Z^5+qpoly)/y^5
ss=(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3])/y^5
lam=-(ss/phi+tt/phi^2)
assert lam.valuation()==-4 and lam.precision_absolute()>-3
c0,c1=lam[-4],lam[-3]
t5=3*c1/c0^5;t6=c0^-5
data=load(str(root/'actual_derivative_topblock.sobj'))
assert t5==data['matrix'][2,0] and t6==data['matrix'][3,1]
VK,fromV,toV=K.vector_space(map=True)
basis=matrix(GF(5),[toV(alpha^i*beta^j) for i in range(4) for j in range(2)]).transpose()
def enc(x):
    v=basis.solve_right(toV(x));return sum(int(v[2*i])*25^i+5*int(v[2*i+1])*25^i for i in range(4))
def monomial(value):
    assert len(value.numerator().dict())==len(value.denominator().dict())==1
    en,cn=next(iter(value.numerator().dict().items()))
    ed,cd=next(iter(value.denominator().dict().items()))
    return {'coefficient_code':int(enc(cn/cd)),'H_exponent':int(en[0]-ed[0]),'w_exponent':int(en[1]-ed[1])}
report={'scope':'exact two-jet proof of actual-splitting quintic leading unit',
        'Lambda_c0':monomial(c0),'Lambda_c1':monomial(c1),
        'T1_degree5':monomial(t5),'Tx_degree6':monomial(t6),
        'agrees_with_larger_new_topblock':True,'seconds':time.time()-start}
save({'ring':R,'c0':c0,'c1':c1,'T1_degree5':t5,'Tx_degree6':t6},str(root/'actual_derivative_leading'))
(root/'actual_derivative_leading.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
