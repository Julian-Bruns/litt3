"""Exact differential compression checks; NOT a global ideal decision."""
from __future__ import annotations
import sys,json,time,itertools
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
import field as F,poly as U,evaluate as E,polynomial_model as PM
from frobenius_rank import solve,matrices,differential_matrix,determinant,matmul,kernel
from check_frobenius import root_product,slim


def minor(R):
    C=differential_matrix(R,half_degree=70)
    return determinant([C[i] for i in range(88) if (i+1)%5])


def run():
    start=time.time()
    a=root_product(range(2,69));b=root_product(range(2,59));j=root_product(range(70))
    tests=[
        ('square_140_fold_root',U.powp([4,1],140)),
        ('square_with_nonsquare_K_leading_scalar',U.scale(U.mul(j,j),25)),
        ('second_stage_failure',U.mul(U.mul(U.powp([0,1],5),[4,1]),U.mul(a,a))),
        ('third_stage_failure',U.mul(U.mul(U.powp([0,1],25),[4,1]),U.mul(b,b))),
        ('fourth_stage_failure_archive_example',U.mul(U.powp([0,1],125),U.powp([4,1],15))),
        ('fourth_stage_failure_second_example',U.mul([0,1],U.powp([4,1],139))),
    ]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        dic,_,_,_=E.cramer(h,w)
        tests.append((f'family_diagnostic_{h}_{w}_{lam}',E.residual(dic,lam)))
    results=[]
    for name,R in tests:
        C=differential_matrix(R)
        N,M,_=matrices(R)
        V,p=kernel(C);W,_=kernel(N)
        assert len(V[0])==len(W[0])
        assert all(not x for row in matmul(N,V) for x in row)
        assert all(not x for row in matmul(C,W) for x in row)
        ans=solve(R,constraint='differential')
        old=solve(R)
        assert [s['kernel_dimension'] for s in ans['stages']]==[s['kernel_dimension'] for s in old['stages']]
        assert ans['geometric_square']==old['geometric_square']==E.square_test(R)[0]
        results.append({'name':name,'same_first_stage_kernels_checked_both_ways':True,
                        'all_stage_dimensions_agree':True,'independent_complete_square_check':True,
                        'result':slim(ans)})
        print(name,'differential compression PASS',flush=True)
    # Global determinant circuits: no new coefficient is inverted.
    S=PM.evaluate_polynomial(1,1,1)
    val0=minor(S);valinf=minor(list(reversed(S)))
    N,_,idx=matrices(S);old=determinant(N[:71])
    rev=list(reversed(S));Ni,_,_=matrices(rev);oldinf=determinant(Ni[:71])
    assert val0==231334 and valinf==307960 and old==337612
    assert old==F.scale(F.mul(F.powk(S[0],71),val0),4)
    assert oldinf==F.scale(F.mul(F.powk(S[-1],71),valinf),4)
    rows=[i for i in range(88) if (i+1)%5]
    circuit={
        'name':'Differential_first_stage_minors',
        'coefficient_ring':'K[H,q,mu]',
        'model':'S_model in data/polynomial_model.json',
        'forward_definition':'Delta_0=det(((2*(i+1)-j)*[x^(i+1-j)]S)_(i in rows,0<=j<=70))',
        'infinity_definition':'Delta_inf=det(((2*(i+1)-j)*[x^(139-i+j)]S)_(i in rows,0<=j<=70))',
        'rows':rows,
        'parameter_degree_bounds_each':{'H':5112,'q':14058,'mu':426},
        'coefficient_degree_each':71,
        'evaluation':{'H':1,'q':1,'mu':1,'S_constant':S[0],'S_leading':S[-1],
                      'Delta_0':val0,'Delta_inf':valinf,'old_forward_minor':old,'old_infinity_minor':oldinf},
        'universal_factor_identities':['Delta_old_forward=4*S(0)^71*Delta_0',
                                      'Delta_old_infinity=4*L^71*Delta_inf'],
        'unit_factor_at_infinity':'L is already a unit on exactly the original open chart; no extra localization',
        'vanish_on_full_square_scheme_including_nilpotents':True,
        'expanded':False,
        'global_unit_ideal_or_zero_set_decided':False}
    (ROOT/'continuation/data/differential_minor_circuits.json').write_text(json.dumps(circuit,indent=2)+'\n')
    print('global differential minors:',val0,valinf,'PASS',flush=True)
    # Test all elementary matrix identities themselves, coefficient by coefficient.
    R=tests[6][1]
    C=differential_matrix(R);N,_,indices=matrices(R)
    r2=U.mul(R,R)
    for j in range(71):
        column=[C[i][j] for i in range(210)]
        assert U.mul(R,U.trim(column))==U.deriv(U.shift(r2,j))
    assert U.evalp(R,9)==369239 and U.evalp(R,25)==234675
    # Retain all reversed-degree drops: these are fixed-bound matrices,
    # not a localization at the forward residual's constant coefficient.
    fixed_drops=[]
    for rev in ([1], [1,1], [1,0,0,0,0,1]):
        Cfix=differential_matrix(rev,half_degree=70)
        Nfix,_,_=matrices(rev,half_degree=70)
        assert len(Cfix)==210 and len(Cfix[0])==71
        assert len(Nfix)==280 and len(Nfix[0])==71
        for j in range(71):
            assert U.mul(rev,U.trim([Cfix[i][j] for i in range(210)]))==U.deriv(U.shift(U.mul(rev,rev),j))
        value=minor(rev)
        assert determinant(Nfix[:71])==F.scale(F.mul(F.powk(rev[0],71),value),4)
        fixed_drops.append({'reversed_polynomial':rev,'fixed_bound':140,
                            'coefficient_matrix_shape':[280,71],
                            'differential_matrix_shape':[210,71],
                            'all_71_column_identities':True,'factor_identity':True})
    print('fixed-bound reversed degree drops: 0,1,5 PASS',flush=True)
    # Bounded algorithm checks; no degree-140 parameter search.
    counts={}
    for deg in (2,4):
        count=squares=0
        for coeff in itertools.product(range(5),repeat=deg):
            R=list(coeff)+[1]
            ans=solve(R,constraint='differential',verify_images=False)
            assert ans['geometric_square']==E.square_test(R)[0]
            count+=1;squares+=int(ans['geometric_square'])
        counts[str(deg)]={'count':count,'geometric_squares':squares}
        print('differential test: all monic F5 degree',deg,'PASS',count,flush=True)
    out={'status':'PARTIAL VERIFIED; original moving-ratio decision UNRESOLVED',
         'constructed_and_family_checks':results,
         'universal_identity_column_checks_at_existing_diagnostic':71,
         'fixed_point_values_at_original_h_w_lambda_1':{'R_r':369239,'R_alpha':234675},
         'bounded_algorithm_checks':counts,'fixed_reversed_degree_drop_checks':fixed_drops,
         'global_minors':circuit['evaluation'],
         'warning':'No fixed-fibre or moving-parameter exclusion is inferred from these evaluations.',
         'seconds':round(time.time()-start,3)}
    (ROOT/'continuation/evidence/differential_checks.json').write_text(json.dumps(out,indent=2)+'\n')
    print('differential compression checks PASS; moving-ratio square decision UNRESOLVED',flush=True)

if __name__=='__main__':run()
