"""Test a possible differential compression of the new endpoint formulas.

Only exact univariate specializations are used to reject or motivate
identities.  A passing probe is not a universal proof.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
data=load(str(root/'endpoint_small_top_symbolic.sobj'));R=data['ring'];H,q=R.gens();K=R.base_ring()
U=PolynomialRing(K,'h');h=U.gen();F=U.fraction_field();rows=[]
for i,record in enumerate(data['records']):
    for q0 in [K(2),K(3),K.gen()]:
        qp=[K.one()]
        for _ in range(400):qp.append(qp[-1]*q0)
        def specialize(f):
            coeff={}
            for (a,b),c in f.dict().items():
                a=int(a);coeff[a]=coeff.get(a,K.zero())+c*qp[int(b)]
            return U(coeff)
        vals={key:F(specialize(pair[0]))/specialize(pair[1]) for key,pair in record.items() if isinstance(pair,tuple)}
        tn,td=record['T_degree2_normalized'];den=specialize(td)
        test={'T_over_log_derivative':vals['T_degree2_normalized']/(F(den.derivative())/den),
              'Q_over_T_third_derivative':vals['Q_degree5_normalized']/vals['T_degree2_normalized'].derivative(3),
              'tQ_over_T_second_derivative':vals['tQ_degree4_normalized']/vals['T_degree2_normalized'].derivative(2)}
        rows.append({'endpoint':int(i),'q_label':str(q0),'ratio_degrees':{
            name:[int(v.numerator().degree()),int(v.denominator().degree())] for name,v in test.items()}})
        print(rows[-1],flush=True)
report={'scope':'exact falsification probes, not a global identity','rows':rows,'seconds':time.time()-start}
(root/'content_derivative_probe.json').write_text(json.dumps(report,indent=2)+'\n')
