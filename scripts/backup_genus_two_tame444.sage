#!/usr/bin/env sage
"""Exact complete secant sieve for the tame genus-two (4,4,4) profile.

All nonzero J[4] classes give 255 isolated sections in H0(8O). The
trivial Abel class instead gives the ENTIRE canonical pencil, whose
fourth powers form a rational normal quartic. Both loci are retained.
The output tests a necessary and potentially sufficient one-endpoint
map condition; it never asserts either leg of a common etale cover.
"""
import argparse,hashlib,itertools,json,time
from pathlib import Path


def run(certificate,output):
    started=time.monotonic();raw=Path(certificate).read_bytes();data=json.loads(raw)
    assert data['all_order4_twisted_kernels_zero'] and len(data['halving_classes'])==15
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**6,name='rho',modulus=prime(data['small_field_modulus']))
    decode=lambda cs:k(prime(cs))
    a=decode(data['alpha_image']);assert a**3+a+1==0
    R=PolynomialRing(k,'u');u=R.gen();F=u*(u-1)*(u-2)*(u-3)*(u-a)
    encode=lambda value:[int(co) for co in k(value).polynomial().list()]
    encode_poly=lambda value:[encode(co) for co in R(value).list()]
    points=[];seen=set()
    def append(H,B,U,V,infinity,label):
        H=R(H);B=R(B);U=R(U);V=R(V)
        assert H.degree()<=4 and B.degree()<=1
        vec=tuple([H[i] for i in range(5)]+[B[i] for i in range(2)])
        first=next(co for co in vec if co);vec=tuple(co/first for co in vec)
        assert vec not in seen;seen.add(vec)
        assert U.is_monic() and U.degree()+int(infinity)==2
        assert U.gcd(U.derivative())==1 and (V**2-F)%U==0
        points.append({'vector':vec,'U':U,'V':V,'infinity':bool(infinity),'label':label})
    for index,row in enumerate(data['halving_classes']):
        subset=[decode(cs) for cs in row['finite_branch_subset']]
        E=prod(u-b for b in subset);j=len(subset)
        append(E**2,0,E,0,j==1,{'order':2,'fiber':index})
        for offset,point in enumerate(row['solutions']):
            c0,c1,q0,q1=[decode(cs) for cs in point['parameters']]
            C=c0+c1*u;Q=q0+q1*u+(k(2) if j==1 else c1)*u**2
            assert C**2*E-F//E==Q**2
            U=Q/Q[2];V=(-C*E)%U
            assert U.gcd(F)==1
            H=C**2*E+F//E;B=2*C
            assert H**2-F*B**2==Q**4
            append(H,B,U,V,False,{'order':4,'fiber':index,'point':offset})
    assert len(points)==len(seen)==255
    def disjoint(i,j):
        A=points[i];B=points[j]
        if A['infinity'] and B['infinity']:return False
        return A['U'].gcd(B['U']).gcd(A['V']-B['V']).degree()==0
    code_cache={}
    def code(co):
        if co not in code_cache:
            code_cache[co]=sum(int(cc)*5**i for i,cc in enumerate(co.polynomial().list()))
        return code_cache[co]
    line_first={};line_multiple={};canonical_candidates=[];degenerate_canonical=[]
    counts={'pairs':0,'pairs_disjoint':0,'v_component_rank2':0,
            'v_component_rank1':0,'both_sections_polynomial':0,
            'finite_canonical_intersection_pairs':0}
    pairs=list(itertools.combinations(range(255),2))
    for index,(i,j) in enumerate(pairs):
        A=points[i]['vector'];B=points[j]['vector'];counts['pairs']+=1
        is_disjoint=disjoint(i,j);counts['pairs_disjoint']+=int(is_disjoint)
        wedge=[A[r]*B[s]-A[s]*B[r] for r in range(7) for s in range(r+1,7)]
        first=next(co for co in wedge if co)
        inverse=1/first;key=tuple(code(co*inverse) for co in wedge)
        if key in line_first:
            line_multiple.setdefault(key,set(line_first[key])).update([i,j])
        else:line_first[key]=(i,j)
        if A[5]*B[6]-A[6]*B[5]:
            counts['v_component_rank2']+=1;continue
        if any(A[5:]+B[5:]):
            counts['v_component_rank1']+=1
            col=5 if A[5] or B[5] else 6
            P=R([B[col]*A[h]-A[col]*B[h] for h in range(5)])
            assert P
            if P.degree()==0:
                degenerate_canonical.append({'pair':[i,j],'reason':'canonical divisor 2O is nonreduced'})
                continue
            if P.degree()!=4:continue
            root=P[3]/P[4]
            if P!=P[4]*(u-root)**4:continue
            counts['finite_canonical_intersection_pairs']+=1
            good=is_disjoint and bool(F(root)) and bool(points[i]['U'](root)*points[j]['U'](root))
            result={'pair':[i,j],'canonical_parameter':encode(root),'valid_disjoint_reduced_fibers':bool(good)}
            (canonical_candidates if good else degenerate_canonical).append(result)
        else:
            counts['both_sections_polynomial']+=1
            pivot=next((r,s) for r in range(5) for s in range(r+1,5) if A[r]*B[s]-A[s]*B[r])
            r,s=pivot;den=A[r]*B[s]-A[s]*B[r]
            equations=[den*u**(4-h)+(A[s]*B[h]-A[h]*B[s])*u**(4-r)
                       +(A[h]*B[r]-A[r]*B[h])*u**(4-s) for h in range(5) if h not in pivot]
            common=gcd(equations);assert common
            if common.degree()==0:continue
            common=common.monic();counts['finite_canonical_intersection_pairs']+=1
            distinct=common//common.gcd(common.derivative())
            good_poly=distinct//distinct.gcd(F*points[i]['U']*points[j]['U'])
            good=is_disjoint and good_poly.degree()>0
            result={'pair':[i,j],'canonical_parameter_polynomial':encode_poly(common),
                    'allowed_parameter_polynomial':encode_poly(good_poly),
                    'valid_disjoint_reduced_fibers':bool(good)}
            (canonical_candidates if good else degenerate_canonical).append(result)
        if index%4096==0:print('secant pairs',index+1,'seconds',time.monotonic()-started,flush=True)
    assert counts['pairs']==32385
    finite_candidates=[];degenerate_lines=[]
    for indices in line_multiple.values():
        indices=sorted(indices)
        valid=any(disjoint(i,j) for i,j in itertools.combinations(indices,2))
        (finite_candidates if valid else degenerate_lines).append(indices)
    result={'status':'complete exact tame (4,4,4) secant and canonical-pencil test',
            'torsion_certificate_sha256':hashlib.sha256(raw).hexdigest(),
            'nonzero_J4_sections':255,'trivial_class_full_canonical_pencil_retained':True,
            'counts':counts,'distinct_secant_lines':len(line_first),
            'valid_three_isolated_section_lines':finite_candidates,
            'degenerate_three_isolated_section_lines':degenerate_lines,
            'valid_canonical_pencil_intersections':canonical_candidates,
            'degenerate_canonical_pencil_intersections':degenerate_canonical,
            'tame444_excluded_by_complete_secant_test':not finite_candidates and not canonical_candidates,
            'sections':[{'label':point['label'],'coefficients':[encode(co) for co in point['vector']],
                         'U':encode_poly(point['U']),'V':encode_poly(point['V']),
                         'contains_O':point['infinity']} for point in points],
            'elapsed_seconds':time.monotonic()-started,
            'scope':'Exact one-endpoint algebra with all exceptional canonical divisors retained. Author divisor/Hurwitz dictionary requires audit; no common-cover claim.'}
    target=Path(output);temporary=Path(str(target)+'.tmp')
    temporary.write_text(json.dumps(result,indent=1,default=int)+'\n');temporary.replace(target)
    print(json.dumps({key:result[key] for key in ['status','counts','distinct_secant_lines',
         'valid_three_isolated_section_lines','valid_canonical_pencil_intersections',
         'tame444_excluded_by_complete_secant_test','elapsed_seconds']},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--certificate',default='Research/computations/backup_genus_two_four_torsion.json')
    parser.add_argument('--output',default='Research/computations/backup_genus_two_tame444.json')
    args=parser.parse_args();run(args.certificate,args.output)
