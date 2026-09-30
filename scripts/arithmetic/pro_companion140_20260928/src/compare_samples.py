"""Executed diagnostic: a companion and its repeated-root partner differ.
This is not a square-class exclusion and not a global certificate.
"""
from residual import *

if __name__=='__main__':
    ts=time.time()
    sample=json.loads((ROOT/'data/sample_residual.json').read_text())
    q,u=sample['q'],sample['u']
    b,c,e=[peval(I[k],q) for k in ['b','c','e']]
    rho=neg(div(mul(u,add(mul(c,u),e)),mul(2,add(add(mul(b,power(u,2)),mul(c,u)),e))))
    repeated=residual(q,rho)
    a_comp=normalized_a(sample['Rbar_scale_ascending'],4)
    a_rep=normalized_a(repeated,4)
    assert not any(a_comp[1][1:]) and not any(a_rep[1][1:])
    assert a_comp[1][0]!=a_rep[1][0]
    row={'q':q,'companion_u':u,'repeated_rho':rho,'companion_a_first_four':a_comp,'repeated_a_first_four':a_rep,
         'scope':'only inequality of the actual normalized residuals; no square-class conclusion'}
    (ROOT/'data/residual_comparison.json').write_text(json.dumps(row,separators=(',',':'))+'\n')
    print(json.dumps({'q':q,'companion_u':u,'repeated_rho':rho,'companion_a1':a_comp[1][0],'repeated_a1':a_rep[1][0],
                      'literal_scale_only_identification':False,'seconds':round(time.time()-ts,3)}))
