"""Executed evaluator/proof diagnostics; NOT a search for family square points."""
from __future__ import annotations
import sys,json,time,itertools
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT/'src'))
import field as F,poly as U,evaluate as E,polynomial_model as PM
from frobenius_rank import solve,matrices,kernel,determinant


def root_product(codes):
    out=[1]
    for c in codes: out=U.mul(out,[F.neg(c),1])
    return out


def slim(result):
    result=json.loads(json.dumps(result))
    for stage in result['stages']:
        stage.pop('selected_pivot_rows',None)
    return result


def run():
    start=time.time(); rows=[]
    # Distinct elements are literal exact K codes, not residues in F5.
    a=root_product(range(2,69))
    b=root_product(range(2,59))
    j=root_product(range(70))
    cases=[
      ('square_140_fold_root', U.powp([4,1],140),[15,3,1,1], True),
      ('geometric_square_with_nonsquare_K_scalar',U.scale(U.mul(j,j),25),[1,1,1,1],True),
      ('failure_at_second_stage',U.mul(U.mul(U.powp([0,1],5),[4,1]),U.mul(a,a)),[1,0],False),
      ('failure_at_third_stage',U.mul(U.mul(U.powp([0,1],25),[4,1]),U.mul(b,b)),[3,1,0],False),
      ('archive_late_tail_counterexample',U.mul(U.powp([0,1],125),U.powp([4,1],15)),[15,3,1,0],False),
      ('second_high_multiplicity_exception',U.mul([0,1],U.powp([4,1],139)),[14,3,1,0],False),
    ]
    for name,R,dims,ok in cases:
        got=solve(R,keep_bases=False)
        assert got['geometric_square']==ok
        assert [s['kernel_dimension'] for s in got['stages']]==dims,(name,got)
        direct=E.square_test(R)[0]
        assert direct==ok
        rows.append({'name':name,'scope':'algorithm test; NOT a member asserted to lie in the r=[9] family',
                     'result':slim(got),'agrees_with_full_square_test':True})
        print(name, 'PASS',dims,flush=True)
    family=[]
    for h,w,lam in [(1,1,1),(2,3,4),(101,102,103),(251,12345,625)]:
        dic,pars,fs,det=E.cramer(h,w)
        R=E.residual(dic,lam)
        got=solve(R)
        assert got['geometric_square']==E.square_test(R)[0]
        assert not got['geometric_square']
        family.append({'h':h,'w':w,'lambda':lam,'H':F.div(h,w),'q':F.powk(w,3),'mu':F.div(lam,w),
                       'scope':'pre-existing diagnostic point, not an exhaustive search',
                       'result':slim(got),'agrees_with_complete_square_test':True})
        print('family',h,w,lam,'PASS',[s['kernel_dimension'] for s in got['stages']],flush=True)
    # A specific GLOBAL polynomial obstruction, retained as an arithmetic circuit.
    S=PM.evaluate_polynomial(1,1,1)
    N,M,indices=matrices(S)
    ker,piv=kernel(N)
    assert len(ker[0])==0 and len(piv)==71
    val=determinant([N[i] for i in piv])
    assert val
    circuit={'name':'Delta_first_stage',
      'coefficient_ring':'K[H,q,mu]',
      'model':'S_model in data/polynomial_model.json',
      'definition':'det( [ [x^(i-j)] S_model(x)^2 ]_(i in row_indices, 0<=j<=70) )',
      'row_indices':[indices[i] for i in piv],
      'parameter_degree_bounds':{'H':10224,'q':28116,'mu':852},
      'evaluation':{'H':1,'q':1,'mu':1,'value_K_code':val},
      'nonzero_globally_certified':True,
      'vanishes_on_entire_localized_square_scheme':True,
      'expanded':False,
      'not_claimed_to_be_a_unit_on_the_requested_open_chart':True,
      'remaining_gap':'Its zero locus has not been eliminated; no new rank localization is imposed.'}
    (ROOT/'continuation/data/global_minor_circuit.json').write_text(json.dumps(circuit,indent=2)+'\n')
    print('global obstruction at (1,1,1):',val,flush=True)
    # Complete bounded algorithm check, not any finite-field approximation to the task.
    counts={}
    for deg in (2,4):
        count=0; square=0
        for lower in itertools.product(range(5),repeat=deg):
            R=list(lower)+[1]
            ans=solve(R,verify_images=False)['geometric_square']
            assert ans==E.square_test(R)[0]
            count+=1; square+=int(ans)
        counts[deg]={'all_monic_F5_polynomials_tested':count,'geometric_squares':square}
        print('all monic degree',deg,'over F5: PASS',count,flush=True)
    out={'status':'VERIFIED PARTIAL RESULTS; moving-ratio square decision remains UNRESOLVED',
       'constructed_polynomial_tests':rows,'family_diagnostics':family,
       'bounded_exhaustive_algorithm_tests':counts,
       'bounded_test_warning':'These test the general algorithm, not the remaining geometric r=[9] scheme.',
       'global_minor_test_value_K_code':val,'seconds':round(time.time()-start,3)}
    (ROOT/'continuation/evidence/frobenius_checks.json').write_text(json.dumps(out,indent=2)+'\n')
    print('all checks PASS; global decision UNRESOLVED',flush=True)
if __name__=='__main__':run()
