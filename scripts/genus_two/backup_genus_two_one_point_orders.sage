#!/usr/bin/env sage
"""Bounded exact one-point torsion jets for the fixed backup genus-two curve.

All nonbranch points are retained. Polynomial Hasse coefficients avoid
fraction-field determinants. A unit Bezout identity excludes that order;
a nonconstant final gcd is only a retained candidate locus. Branch points
are handled separately (their nonzero classes have exact order two).
"""
import argparse
import itertools
import json
import time
from pathlib import Path
from cysignals.alarm import alarm,cancel_alarm


def run(order,seconds,output):
    assert order>=7
    started=time.monotonic()
    k=GF(125,name='a',modulus=PolynomialRing(GF(5),'z')([1,1,0,1]));a=k.gen()
    R=PolynomialRing(k,'t');t=R.gen()
    F=t*(t-1)*(t-2)*(t-3)*(t-a)
    S=PolynomialRing(R,'h');h=S.gen();FH=F(t+h)
    # a_i=F(t)^i*[h^i]sqrt(F(t+h)/F(t)), so only division by2 occurs.
    coeff=[R.one()]
    for i in range(1,order):
        coeff.append((F**(i-1)*FH[i]-sum(coeff[j]*coeff[i-j] for j in range(1,i)))/2)
    m=order//2;bd=(order-5)//2
    row_indices=list(range(m+1,order));column_indices=list(range(bd+1))
    assert len(row_indices)==len(column_indices)+1
    mat=matrix(R,[[coeff[n-j] for j in column_indices] for n in row_indices])
    enc=lambda f:[[int(v) for v in c.polynomial().list()] for c in R(f).list()]
    out={'curve':'v^2=t(t-1)(t-2)(t-3)(t-a); a^3+a+1=0',
         'order':order,'field_modulus':[1,1,0,1],
         'rows':row_indices,'columns':column_indices,
         'status':'bounded_jet_minors_incomplete','minors':[],
         'scope':'Nonbranch points only; O is zero and other Weierstrass classes have order2.'}
    path=Path(output);path.parent.mkdir(parents=True,exist_ok=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temp=Path(str(path)+'.tmp');temp.write_text(json.dumps(out,indent=1,default=int)+'\n');temp.replace(path)
    gcd=R.zero();lifts=[];minors=[];original_minors=[];removed_factors=[]
    try:
        alarm(seconds)
        for selected in itertools.combinations(range(len(row_indices)),int(len(column_indices))):
            determinant=mat.matrix_from_rows(selected).det()
            reduced=determinant;removed=R.one()
            while reduced:
                common=reduced.gcd(F)
                if common.degree()==0:break
                reduced=R(reduced//common);removed*=common
            assert reduced*removed==determinant
            original_minors.append(determinant);removed_factors.append(removed)
            gcd,s0,t0=gcd.xgcd(reduced)
            lifts=[s0*v for v in lifts]+[t0];minors.append(reduced)
            assert sum(v*f for v,f in zip(lifts,minors))==gcd
            out['minors'].append({'selected_rows':[row_indices[j] for j in selected],
                'fraction_denominator_F_exponent':sum(row_indices[j] for j in selected)-sum(column_indices),
                'polynomial_determinant_degree':int(determinant.degree()),
                'removed_branch_factors':enc(removed),'reduced_minor':enc(reduced)})
            out['gcd']=enc(gcd);out['bezout_multipliers']=[enc(v) for v in lifts]
            print('order',order,'minor',len(minors),'gcd degree',gcd.degree(),
                  'seconds',time.monotonic()-started,flush=True)
            if gcd==1:
                exponent=0;right_side=R.one()
                while any(right_side%factor for factor in removed_factors):
                    exponent+=1;right_side*=F
                canonical_lifts=[v*R(right_side//factor) for v,factor in zip(lifts,removed_factors)]
                assert sum(v*f for v,f in zip(canonical_lifts,original_minors))==F**exponent
                out['status']='all_nonbranch_points_of_order_dividing_N_excluded_exact_bezout'
                out['exact_bezout_sum_one_verified']=True
                out['canonical_jet_bezout_F_exponent']=exponent
                out['canonical_jet_bezout_multipliers']=[enc(v) for v in canonical_lifts]
                checkpoint();break
            checkpoint()
        else:
            out['status']='complete_jet_rank_drop_candidate_locus'
            checkpoint()
    except (AlarmInterrupt,KeyboardInterrupt) as exc:
        out['interruption']=type(exc).__name__;checkpoint()
    finally:
        cancel_alarm();checkpoint()
    print(json.dumps({key:out[key] for key in ['order','status','elapsed_seconds']},indent=1),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--order',type=int,required=True)
    parser.add_argument('--seconds',type=int,default=240)
    parser.add_argument('--output',required=True)
    args=parser.parse_args();run(args.order,args.seconds,args.output)
