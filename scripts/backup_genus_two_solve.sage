#!/usr/bin/env sage
"""Native Singular solve of one disjoint projective backup atlas chart.

For the first nonzero b_j, put b_j=1,b_i=0 for i<j. Solve all12
Frobenius-incidence rows and z*ell(p,b)=1. A solution reconstructs the
normalized original system by (p,b)->(t^-4*p,t*b), t^3=ell(p,b).
Thus all four charts include every normalized atlas and all boundary
positions; no N-only or determinant-only shortcut is made.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(tensor_path,chart,seconds,output):
    started=time.monotonic()
    raw=Path(tensor_path).read_bytes();data=json.loads(raw)
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**data['field_degree'],name='c',modulus=prime(data['field_modulus']));c=k.gen()
    decode=lambda cs:k(prime(cs))
    nfree=3-chart
    names=['p'+str(i) for i in range(4)]+['b'+str(j) for j in range(chart+1,4)]+['z']
    R=PolynomialRing(k,names=names,order='degrevlex')
    pp=list(R.gens()[:4]);bb=[R.zero()]*chart+[R.one()]+list(R.gens()[4:4+nfree]);z=R.gens()[-1]
    original=[sum(decode(data['I'][h][j])*bb[j] for j in range(4))+
              sum(decode(data['tensor'][i][j][h])*pp[i]*bb[j]**5 for i in range(4) for j in range(4))
              for h in range(12)]
    norm=sum(decode(data['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))
    original.append(z*norm-1)
    ideal=R.ideal(original)
    out={'tensor_path':str(Path(tensor_path).resolve()),'tensor_sha256':hashlib.sha256(raw).hexdigest(),
         'twist_index':data['twist_index'],'chart_first_nonzero_b':chart,
         'field_degree':data['field_degree'],'field_modulus':data['field_modulus'],
         'variables':names,'original_equations':[str(f) for f in original],
         'engine':'native libSingular via Sage, degrevlex; independent chart workers',
         'timeout_seconds':seconds,'status':'not_started'}
    target=Path(output);target.parent.mkdir(parents=True,exist_ok=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temporary=Path(str(target)+'.tmp')
        temporary.write_text(json.dumps(out,indent=1,default=int)+'\n');temporary.replace(target)
    print('native chart start',data['twist_index'],chart,'field degree',data['field_degree'],flush=True)
    try:
        alarm(max(1,seconds-(time.monotonic()-started)))
        gb=list(ideal.groebner_basis(algorithm='libsingular:std'))
        out['groebner_basis']=[str(g) for g in gb]
        out['groebner_seconds']=time.monotonic()-started
        print('native basis saved',data['twist_index'],chart,out['groebner_seconds'],flush=True)
        assert all(not f.reduce(gb) for f in original)
        out['all_original_equations_reduce_to_zero']=True
        if gb==[R.one()]:
            out['status']='unit_basis_candidate_certificate_pending'
            checkpoint()
            lift=list(R.one().lift(ideal))
            out['lift_seconds_cumulative']=time.monotonic()-started
            print('native unit lift constructed',data['twist_index'],chart,out['lift_seconds_cumulative'],flush=True)
            assert len(lift)==13 and sum(h*f for h,f in zip(lift,original))==1
            out['identity_verified_seconds_cumulative']=time.monotonic()-started
            out['unit_certificate_multipliers']=[str(h) for h in lift]
            out['exact_unit_identity_verified_against_all13_original_rows']=True
            out['status']='empty_chart_exact_original_equation_certificate'
        else:
            dimension=int(ideal.dimension());out['dimension']=dimension
            assert dimension==0
            out['length']=int(ideal.vector_space_dimension())
            out['status']='nonempty_finite_chart_exact_groebner_algebra'
            # This is a ready-to-evaluate finite coordinate algebra; each
            # geometric point reconstructs three normalized atlas points.
            out['normalized_atlas_point_count']=3*out['length']
            out['reconstruction']='b_j=1,earlier b_i=0; t^3=ell(p,b)=1/z; normalized(p,b)=(t^-4*p,t*b)'
    except (AlarmInterrupt,KeyboardInterrupt) as exc:
        out['status']='bounded_native_slice_incomplete'
        out['interruption']=type(exc).__name__
    finally:
        cancel_alarm()
        checkpoint()
    print(json.dumps({key:out[key] for key in ['twist_index','chart_first_nonzero_b','status','elapsed_seconds']},indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True)
    parser.add_argument('--chart',type=int,choices=range(4),required=True)
    parser.add_argument('--seconds',type=int,default=300)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    run(args.tensor,args.chart,args.seconds,args.output)
