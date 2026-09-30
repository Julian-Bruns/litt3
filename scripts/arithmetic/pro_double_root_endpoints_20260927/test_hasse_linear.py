"""Bounded implementation tests. The universal scheme proof and the actual
unimodular certificate, not these tests, establish global correctness.
"""
import random,json,time
from exact import ROOT
from extension import E,Poly,init
from residual import sm
from hasse_linear import build,evaluate,canonical_root,check_hasse_factors,check_pivot

def context(mod,name):
    init(mod);rng=random.Random(27102026);d=len(mod)-1
    B=[Poly(E([rng.randrange(390625) for _ in range(d)])) for _ in range(71)];B[0]=Poly(1)
    A=sm(B,B,141);A[16][0].inv() # Test the hypothesis, not a localization in the actual source.
    model=build(A);assert not any(evaluate(model,B));assert canonical_root(A)==B
    check_pivot(model);check_hasse_factors(model)
    # Failure to impose the coefficient-unit hypothesis is a real trap.
    trap=[Poly() for _ in range(141)];trap[0]=Poly(1);trap[125]=Poly(1)
    Bt=[Poly(1)]+[Poly() for _ in range(70)]
    assert not any(evaluate(build(trap),Bt)) and not any(trap[16:24])
    # The same late deformation is detected on the stated unimodular locus.
    simple=[Poly() for _ in range(71)];simple[0]=simple[8]=Poly(1)
    base=sm(simple,simple,141);assert base[16]==Poly(1)
    x=E([0,1]) if d==2 and mod==[0,0,1] else E(1)
    rec=[]
    for n in (125,140):
        bad=list(base);bad[n]=bad[n]+Poly(x)
        values=evaluate(build(bad),canonical_root(bad));nonzero=[(i+1,v) for i,v in enumerate(values) if v]
        assert nonzero
        if d==2:
            assert not x*x and all(not v*v for _,v in nonzero)
        rec.append({'deformation_T_degree':n,'nonzero_rows':len(nonzero),'nilpotent_equations_retained':d==2})
    return {'ring':name,'exact_square_accepted':True,'unimodular_coefficient_A16_checked':True,
            'three_Hasse_factor_identities_checked':True,'pivot':'3*L^166',
            'missing_hypothesis_trap_demonstrated':True,'late_deformations':rec}

if __name__=='__main__':
    start=time.time();recs=[context([0,1],'K'),context([0,0,1],'K[epsilon]/epsilon^2')]
    out={'status':'passed','tests':recs,'seconds':round(time.time()-start,3),
         'scope':'bounded software tests; no actual-family square point or exclusion is asserted'}
    (ROOT/'logs/hasse_linear_tests.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out,sort_keys=True),flush=True)
