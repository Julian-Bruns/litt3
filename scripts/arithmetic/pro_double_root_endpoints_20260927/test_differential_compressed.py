"""Exact bounded tests of the14-auxiliary circuit, including nilpotents.
No search for new geometric ratio points is performed.
"""
import random,json,time
from exact import ROOT
from extension import E,Poly,init
from residual import sm
from differential_square import differential_values,root_residual
from differential_compressed import (build,numerator,equations,candidate_root,
    canonical_auxiliaries,linear_matrix,LINEAR_INDICES,QUADRATIC_INDICES)
from test_differential_square import canonical_root

def context(mod,name):
    init(mod);rng=random.Random(270929);d=len(mod)-1
    rand=lambda:Poly(E([rng.randrange(390625) for _ in range(d)]))
    B=[rand() for _ in range(71)];B[0]=Poly(1);L=E(27)
    A=[p*L for p in sm(B,B,141)]
    model=build(A);c=canonical_auxiliaries(model)
    assert candidate_root(model,c)==B
    lin,quad=equations(model,c);assert not any(lin+quad)
    # Generic coefficients and arbitrary auxiliary values, not just roots.
    A=[rand() for _ in range(141)];A[0]=Poly(L)
    model=build(A);c=[rand() for _ in range(15)];c[0]=Poly(1)
    P=numerator(model,c);B=candidate_root(model,c)
    DD=differential_values(A,B,full=True);EE=root_residual(A,B)
    assert not any(DD[:70])
    lin,quad=equations(model,c)
    assert lin==[DD[m-1]*(L**3) for m in LINEAR_INDICES]
    assert quad==[EE[m]*(L**5) for m in QUADRATIC_INDICES]
    indices,rows=linear_matrix(model,full=True)
    for m,row in zip(indices,rows):
        assert sum((x*y for x,y in zip(row,c)),Poly())==DD[m-1]*(L**3)
    cc=canonical_auxiliaries(model);BB=candidate_root(model,cc)
    assert BB==canonical_root(A)
    lin,quad=equations(model,cc);assert not any(quad[:14])
    assert any(lin+quad[14:])
    # Exact monic auxiliary pivots: earlier quadratics are unchanged and
    # the jth changes by2*L^6 when c_j is increased by1.
    c=[rand() for _ in range(15)];c[0]=Poly(1)
    old=equations(model,c)[1]
    for j in range(1,15):
        cp=c[:];cp[j]=cp[j]+1;new=equations(model,cp)[1]
        assert new[:j-1]==old[:j-1]
        assert new[j-1]-old[j-1]==Poly(2*(L**6)),('unit pivot',j)
    nilpotent=False
    if mod==[0,0,1]:
        eps=E([0,1]);A=[Poly() for _ in range(141)];A[0]=Poly(1);A[140]=Poly(eps)
        model=build(A);c=canonical_auxiliaries(model);lin,quad=equations(model,c)
        assert not any(lin) and not any(quad[:27]) and quad[27]==Poly(-eps)
        assert quad[27] and not quad[27]*quad[27];nilpotent=True
    return {'ring':name,'exact_root':'recovered','arbitrary_auxiliary_transfer':'passed',
        'full139_by15_linear_matrix':'checked','all14_unit_pivots':'checked',
        'canonical_auxiliaries':'agree with exponent63 root',
        'nonzero_nilpotent_final_quadratic_retained':nilpotent}

def run():
    start=time.time();records=[context([0,1],'K'),context([0,0,1],'K[epsilon]/epsilon^2')]
    result={'status':'passed','scope':'bounded circuit checks, not a geometric search or global exclusion',
        'contexts':records,'number_auxiliaries':14,'linear_equations':56,'quadratic_equations':28,
        'seconds':round(time.time()-start,3)}
    (ROOT/'logs/differential_compressed_tests.json').write_text(json.dumps(result,indent=2)+'\n')
    print('COMPRESSED DIFFERENTIAL CIRCUIT TESTS PASSED',json.dumps(result),flush=True)
    return result
if __name__=='__main__':run()
