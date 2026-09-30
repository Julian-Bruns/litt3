"""Complete-algebra, full-scale checks of the actual linear square model.
These bounded implementation checks are not a global rank computation.
"""
import ctypes as ct,json,gzip,time,sys
from math import comb
from exact import ROOT,DATA,add,mul,power,peval
from extension import E,Poly,init
from ratio_eliminant_data import load
from interpolate_global import library
from residual import sm,sf,square_equations
from hasse_linear import build,eliminated,check_pivot,INDICES,order,hasse

def run(nodes):
    start=time.time();meta,raw=load();n=133;m=7*141*9
    inp=(ct.c_int*len(raw))(*raw);out=(ct.c_int*m)();ev=library()
    src=json.loads((ROOT/'evidence/global_source.json').read_text())
    cert=json.load(gzip.open(ROOT/'evidence/late_linear_global.json.gz','rt'));assert cert['leading_power']==1
    records=[]
    for u0 in nodes:
        mod=[0]*10
        for iq,iu,a in src['critical_monic']:mod[iq]=add(mod[iq],mul(a,power(u0,iu)))
        init(mod);q=E([0,1]);u=E(u0)
        # Verify all original ratio-open factors without selecting a q root.
        d=Poly(DATA['d']).eval(q);a0,b,c,e=[Poly(DATA[k]).eval(q) for k in ('a0','b','c','e')]
        F=a0*u**3+b*u*u+c*u+e
        for a in (q,u,d,F,b*u+c,q-E(10149),q-E(118020),q-E(64426)):a.inv()
        ev.ff_evaluate_rows(inp,n,m,u0,out)
        A=[Poly([E(list(out[(s*141+140-t)*9:(s*141+141-t)*9])) for s in range(7)]) for t in range(141)]
        L=A[0][0];L.inv();assert A[0].degree()==0
        for t,a in enumerate(A):assert a.degree()<=min(6,3*t//4)
        lhs=Poly()
        for r in cert['certificate']:
            cc=E(peval(r['u_coefficients'],u0))*q**r['q_power']
            lhs=lhs+A[140-r['x']]*cc
        assert lhs==Poly(L)
        print('ACTUAL HASSE input and coefficient-unit certificate checked, complete u algebra',u0,flush=True)
        model=build(A);check_pivot(model);B,gens=eliminated(model)
        assert len(gens)==77
        # An independent coefficient square-root recurrence, not a Frobenius power.
        alpha=[a/L for a in A];ref=[Poly(1)]
        for j in range(1,71):
            ref.append(3*(alpha[j]-sum((ref[i]*ref[j-i] for i in range(1,j)),Poly())))
        assert ref==B
        # Check the matrix indexing against direct Hasse-polynomial products.
        for r,N in ((1,148),(5,141),(25,76)):
            direct=sm(model['powers'][r],hasse(B,r,N),N)
            hb=sm(model['H'][r],B,N);direct=[a-b for a,b in zip(direct,hb)]
            for n0,row in zip(INDICES,model['rows']):
                if order(n0)==r:
                    assert sum((a*b for a,b in zip(row,B)),Poly())==direct[n0-r]
        # Actual bounds are checked coefficient by coefficient, with scale free.
        rdegs=[]
        for n0,row in zip(INDICES,model['rows']):
            bound=min(6*order(n0),3*n0//4)
            assert max(p.degree() for p in row)<=bound
            rdegs.append(max(p.degree() for p in row))
        assert max(p.degree() for p in gens)<=82
        # Match the original all-70 square circuit, not a truncated tail list.
        R=[Poly([A[140-x][s] for x in range(141)]) for s in range(7)]
        old=square_equations(R,True);Eres=[a-b for a,b in zip(sm(B,B,141),alpha)]
        assert not any(Eres[:71])
        normalized=[p/(L**63) for p in old[:54]]+[p/(L**126) for p in old[54:]]
        assert normalized[54:]==Eres[125:141]
        for k in range(71,125):
            assert Eres[k]==sum((3*normalized[j-71]*B[k-j] for j in range(71,k+1)),Poly())
        rec={'u_code':u0,'complete_algebra_length':9,'original_ratio_open_verified':True,
             'actual_coefficient_unit_identity_checked':True,'actual_coefficients':987,
             'scale':'polynomial variable throughout','linear_rows':147,'canonical_root_matches_independent_recurrence':True,
             'row_indexing_checked_against_polynomial_products':True,'original_54_plus_16_circuit_compared':True,
             'observed_max_row_scale_degree':max(rdegs),'observed_max_eliminated_scale_degree':max(p.degree() for p in gens),
             'eliminated_scale_degrees':[p.degree() for p in gens]}
        records.append(rec);print('ACTUAL HASSE MODEL PASSED',u0,'max row degree',max(rdegs),'max generator degree',rec['observed_max_eliminated_scale_degree'],flush=True)
    summary={'status':'passed','samples':records,'seconds':round(time.time()-start,3),
             'scope':'bounded complete-algebra implementation checks; theorem plus literal certificate establish global equivalence',
             'global_square_decision':'unresolved'}
    (ROOT/'logs'/('hasse_actual_'+('_'.join(map(str,nodes)))+'.json')).write_text(json.dumps(summary,indent=2)+'\n')
    return summary
if __name__=='__main__':run([int(a) for a in sys.argv[1:]] or [1,132])
