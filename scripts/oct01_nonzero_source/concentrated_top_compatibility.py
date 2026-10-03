#!/usr/bin/env python3
"""Two universal top-coefficient compatibilities for concentrated numerators."""
import argparse,json,sys
from math import comb
from pathlib import Path
import numpy as np

ARCHIVE=Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited')
sys.path.insert(0,str(ARCHIVE/'src'))
from exact import Field,Poly,Curve,monomials,B0_CODES,L0_CODES
from cubic_extension import CubicExtension


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--work',type=Path,required=True)
    args=ap.parse_args();k=Field(args.work/'cache');p=Poly(k);C=Curve(k)
    e=CubicExtension(k);ep=Poly(e)
    projection=json.loads((args.work/'data/annihilator_endpoint_projection.json').read_text())
    J=np.array(projection['matrix'],dtype=np.uint32)
    rows=projection['row_pivots'];columns=projection['pivots']
    square=J[np.ix_(rows,columns)]
    augmented=np.hstack((square,np.eye(53,dtype=np.uint32)))
    rr,piv=k.rref(augmented);assert piv==list(range(53))
    inverse=rr[:,53:]
    assert np.array_equal(k.matmul(square,inverse),np.eye(53,dtype=np.uint32))
    fam=json.loads((args.work/'data/adapted_family.json').read_text())
    t=fam['t'];z=p.sub(B0_CODES,L0_CODES)
    def pi(function,n):
        raw=C.mul(C.polyx(p.power(z,n)),function);out=C.zero()
        for char,component in enumerate(raw):
            power,target=divmod(char-n,3)
            out[target]=p.mul(component,p.power(C.P,power)) if power>=0 else p.divmod(component,p.power(C.P,-power))[0]
        return out
    def numerator(a5,a4,rs):
        c3=C.add(pi(a4,1),rs[3])
        c2=C.add(C.neg(C.add(C.scale(pi(c3,1),3),pi(a4,2))),rs[2])
        c1=C.add(C.neg(C.add(C.add(C.scale(pi(c2,1),2),C.scale(pi(c3,2),3)),C.scale(pi(a4,3),4))),rs[1])
        c0=C.add(C.neg(C.add(C.add(C.add(C.add(pi(c1,1),pi(c2,2)),pi(c3,3)),pi(a4,4)),pi(a5,5))),rs[0])
        return [c0,c1,c2,c3,a4,a5]
    def clear(cs,j):
        out=C.zero()
        for hh in range(j,6):
            scalar=comb(hh,j)%5
            if scalar:
                term=C.mul(C.polyx(p.power(z,hh-j)),cs[hh])
                term=C.mul(term,C.power(C.monomial(0,1),5-hh))
                out=C.add(out,C.scale(term,scalar))
        return out
    def ordinary_rows(cs):
        out=[]
        for j in range(3):
            modulus=p.power(t,3-j)
            for component in clear(cs,j):
                rem=p.mod(component,modulus)
                out.extend(rem+[0]*(len(modulus)-1-len(rem)))
        return np.array(out,dtype=np.uint32)
    top_labels=[];U=[];old_functional=[]
    functional=np.array(projection['cokernel'][0],dtype=np.uint32)
    for degree,space in ((5,16),(4,20)):
        for b,char in monomials(space):
            top=C.monomial(b,char)
            raw=numerator(top if degree==5 else C.zero(),top if degree==4 else C.zero(),[C.zero() for _ in range(4)])
            rhs=ordinary_rows(raw)
            old_functional.append(int(k.matmul(functional[None,:],rhs[:,None])[0,0]))
            solution=k.mulv(k.matmul(inverse,rhs[rows,None])[:,0],4)
            rs=[C.zero() for _ in range(4)]
            for scalar,index in zip(solution,columns):
                j,a,r=projection['rlabels'][index]
                rs[j]=C.add(rs[j],C.monomial(a,r,int(scalar)))
            U.append(numerator(top if degree==5 else C.zero(),top if degree==4 else C.zero(),rs))
            top_labels.append([degree,b,char])
    assert len(U)==21 and not any(old_functional[:9])
    reports=[]
    for suffix in ('','_sheet1','_sheet2'):
        data=json.loads((args.work/'data'/('shifted_concentrated_projection'+suffix+'.json')).read_text())
        for item in data['records']:
            root=item['root_K_code'];y0=item['y0_extension_code'];cut=7
            def shift(poly):
                out=[]
                for scalar in reversed(poly):out=p.add(p.mul(out,[root,1]),[scalar])[:cut]
                return out
            value=p.eval(C.P,root);rhs=p.scale(shift(C.P),k.inv(value));h=[1]
            for n in range(1,cut):
                power=p.power(h,3)
                h.append(k.div(k.sub(rhs[n] if n<len(rhs) else 0,power[n] if n<len(power) else 0),3))
            y=ep.scale(h,y0);yi=[e.inv(y0)]
            for n in range(1,cut):
                product=ep.mul(y,yi)
                yi.append(e.neg(e.div(product[n] if n<len(product) else 0,y0)))
            aa=ep.mul(shift(z),yi)[:cut]
            def evaluate(function):
                out=[]
                for char in range(3):out=ep.add(out,ep.mul(shift(function[char]),ep.power(y,char)))
                return out[:cut]
            A=[]
            for cs in U:
                vals=[evaluate(c) for c in cs];short=[]
                for j in range(4):
                    out=[]
                    for hh in range(j,6):
                        out=ep.add(out,ep.scale(ep.mul(vals[hh],ep.power(aa,hh-j)),comb(hh,j)%5))
                    short.append(out[:cut])
                A.append(short)
            extra=[]
            for j,n in item['row_tags']:
                block=[]
                for short,cs in zip(A,U):
                    out=[]
                    for hh in range(j,6):
                        if hh<4:series=short[hh]
                        else:series=evaluate(cs[hh])
                        degree=hh-j;ix=n-degree
                        coefficient=series[ix] if 0<=ix<len(series) else 0
                        if coefficient:out=ep.add(out,ep.shift([e.mul(comb(hh,j)%5,coefficient)],degree))
                    block.append(out)
                extra.append(block)
            w=[ep.scale(f,1 if ix%2==0 else 4) for ix,f in enumerate(item['maximal_minors_by_omitted_row'])]
            for column in range(9):
                total=[]
                for row in range(10):total=ep.add(total,ep.mul(w[row],item['polynomial_matrix'][row][column]))
                assert not total
            new=[]
            for column in range(21):
                total=[]
                for row in range(10):total=ep.add(total,ep.mul(w[row],extra[row][column]))
                new.append(total)
            old_pivot=next(i for i,scalar in enumerate(old_functional) if scalar)
            reduced=[ep.sub(f,ep.scale(new[old_pivot],e.div(old_functional[i],old_functional[old_pivot])))
                     for i,f in enumerate(new)]
            gcd=[]
            for f in reduced:
                if f:gcd=ep.gcd(gcd,f)
            assert gcd
            reports.append({'root_K_code':root,'sheet_suffix':suffix,'y0_extension_code':y0,
                            'new_compatibility_coefficients':new,
                            'extra_top_matrix':extra,'left_kernel':w,
                            'second_compatibility_rank_drop_polynomial':gcd})
    report={'scope':'exact two polynomial linear compatibilities on A5 in L16,A4 in L20; substituted actual eight top coords remain source dependent',
            'top_labels':top_labels,'ordinary_compatibility_coefficients':old_functional,
            'particular_finite_numerator_coefficients':U,'records':reports}
    (args.work/'data/concentrated_top_compatibility.json').write_text(json.dumps(report,separators=(',',':'))+'\n')
    print(json.dumps({'top_function_count':21,'endpoint_records':len(reports),
                      'new_compatibility_max_degrees':[max(len(f)-1 for f in item['new_compatibility_coefficients']) for item in reports]}))
    print(json.dumps({'source_independent_top_rank_drop_degrees':[len(item['second_compatibility_rank_drop_polynomial'])-1 for item in reports]}))


if __name__=='__main__':main()
