"""Bounded direct determinant checks of the global polynomial identity.
This is not a global elimination or a new ratio exclusion.
"""
import ctypes as ct,json,time
from exact import ROOT,mul,power as kp
from extension import E,Poly,init
from ratio_eliminant_data import load
from ratio_eliminant import point_coefficients,library
from hasse_linear import build,eliminated,polynomial_generators,bordered_minor,INDICES

def run():
    start=time.time();_,raw=load();u,q=25,338890
    vals=point_coefficients(raw,u,q);init([0,1])
    A=[Poly(vals[t*7:(t+1)*7]) for t in range(141)]
    model=build(A);B,eqs=eliminated(model);C,G=polynomial_generators(model);L=A[0][0]
    assert [c/(L**63) for c in C]==B
    assert G==[p*(L**63) for p in eqs]
    lib=library();IP=ct.POINTER(ct.c_int);lib.independent_det.argtypes=[IP,ct.c_int]
    records=[]
    for n in [71,100,145]:
        mat=bordered_minor(model,n);idx=INDICES[70:].index(n)
        for nu in (1,2):
            flat=[p.eval(E(nu)).a[0] for row in mat for p in row]
            actual=lib.independent_det((ct.c_int*len(flat))(*flat),71)
            expected=mul(mul(3,kp(L.a[0],103)),G[idx].eval(E(nu)).a[0])
            assert actual==expected
            records.append({'n':n,'nu_code':nu,'determinant_code':actual,'matches_3_L103_G':True})
    out={'status':'passed','ratio':{'u_code':u,'q_code':q},'all_scale_polynomial_generator_identity_checked':True,
         'direct_determinants':records,'seconds':round(time.time()-start,3),
         'scope':'bounded circuit implementation checks; the global identity is proved in REPORT Section55',
         'is_square_witness':False,'global_square_decision':'unresolved'}
    (ROOT/'logs/hasse_minors_checks.json').write_text(json.dumps(out,indent=2)+'\n')
    print(json.dumps(out,sort_keys=True),flush=True)
if __name__=='__main__':run()
