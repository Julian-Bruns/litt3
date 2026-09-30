"""Independent standard-library check of finite-algebra unit certificates.

All arithmetic below uses the original Python K arithmetic, independently
of the native C++ implementation that reconstructed the actual residuals.
This verifies certificate identities and full algebra coverage, not by
itself the source-to-tail computation; native replay provides that check.
"""
from global_checks import *
import argparse

def monic(p):
    return scale(p, inv(p[-1]))

def epadd(a,b):
    z=[list(p) for p in a]+[[] for _ in range(max(0,len(b)-len(a)))]
    for i,p in enumerate(b):z[i]=pa(z[i],p)
    while z and not z[-1]:z.pop()
    return z

def epmul(a,b,mod):
    if not a or not b:return []
    z=[[] for _ in range(len(a)+len(b)-1)]
    for i,p in enumerate(a):
        for j,q in enumerate(b):
            z[i+j]=pa(z[i+j],pm(p,q))
    z=[pdm(p,mod)[1] for p in z]
    while z and not z[-1]:z.pop()
    return z

def run(indices=range(6)):
    master=json.loads((ROOT/'data/leading_tail_boundary.json').read_text())
    for idx in indices:
        start=time.time()
        z=json.loads((ROOT/f'data/boundary_certificate_{idx}.json').read_text())
        row=master['fibres'][idx]
        assert z['sigma']==row['sigma']
        assert z['discriminant']==row['discriminant']
        product=[1]
        for block in z['blocks']:
            mod=block['modulus']
            assert mod==monic(mod)
            assert len(pgcd(product,mod))==1
            product=pm(product,mod)
            assert block['u']==pdm(row['selected_u_mod_discriminant'],mod)[1]
            for label in ['C71','C72','U','V']:
                for p in block[label]:assert len(p)<len(mod)
            eq=epadd(epmul(block['C71'],block['U'],mod),epmul(block['C72'],block['V'],mod))
            if 'W' in block:
                eq=epadd(eq,epmul(block['C73'],block['W'],mod))
            assert eq==[[1]],(idx, 'identity failed')
            assert len(block['C72'])<=54
        assert monic(product)==monic(row['discriminant'])
        print(json.dumps({'boundary_index':idx,'sigma':z['sigma'],'degree':24,
            'complete_algebra_coverage':'PASS','independent_Bezout_multiplication':'PASS',
            'seconds':round(time.time()-start,3)}),flush=True)

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('indices',nargs='*',type=int);args=ap.parse_args()
    run(args.indices or range(6))

def run_norm():
    ts=time.time()
    z=json.loads((ROOT/'data/norm_s_certificate.json').read_text())
    model=json.loads((ROOT/'data/norm_s_boundary.json').read_text())
    assert z['discriminant']==model['discriminant']==disc_sigma(0)
    mod=model['discriminant'];product=[1]
    assert pa(pm(model['coprimality_U'],mod),pm(model['coprimality_V'],model['licensed_and_previously_excluded_product']))==[1]
    for block in z['blocks']:
        m=block['modulus'];assert m==monic(m)
        assert len(pgcd(product,m))==1;product=pm(product,m)
        assert block['u']==pdm(model['selected_u'],m)[1]
        eq=epadd(epmul(block['C71'],block['U'],m),epmul(block['C72'],block['V'],m))
        if 'W' in block:eq=epadd(eq,epmul(block['C73'],block['W'],m))
        assert eq==[[1]]
    assert monic(product)==monic(mod)
    print(json.dumps({'norm_s_other_sheet_degree':24,'complete_algebra_coverage':'PASS',
        'independent_Bezout_multiplication':'PASS','seconds':round(time.time()-ts,3)}),flush=True)

def run_opposites():
    models=json.loads((ROOT/'data/opposite_boundary.json').read_text())['fibres']
    leading=json.loads((ROOT/'data/leading_tail_boundary.json').read_text())['fibres']
    for idx,(model,old) in enumerate(zip(models,leading)):
        ts=time.time();z=json.loads((ROOT/f'data/opposite_certificate_{idx}.json').read_text())
        assert z['discriminant']==model['discriminant']==old['discriminant']
        m=model['discriminant'];product=[1]
        assert pdm(pa(model['xi'],old['xi_mod_discriminant']),m)[1]==[]
        assert pa(pm(model['leading_boundary_factor'],model['leading_factor_inverse']),pm(m,model['leading_factor_bezout_V']))==[1]
        for block in z['blocks']:
            mod=block['modulus'];assert mod==monic(mod)
            assert len(pgcd(product,mod))==1;product=pm(product,mod)
            assert block['u']==pdm(model['selected_u'],mod)[1]
            eq=epadd(epmul(block['C71'],block['U'],mod),epmul(block['C72'],block['V'],mod))
            if 'W' in block:eq=epadd(eq,epmul(block['C73'],block['W'],mod))
            assert eq==[[1]]
        assert monic(product)==monic(m)
        print(json.dumps({'opposite_boundary_index':idx,'degree':24,
            'complete_algebra_coverage':'PASS','independent_Bezout_multiplication':'PASS',
            'seconds':round(time.time()-ts,3)}),flush=True)
