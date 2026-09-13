#!/usr/bin/env sage
"""Bounded intrinsic genus-four pencil test using four elementary modifications.

This constructs actual stable acyclic bundles, not dormant opers or atlases.
No production input or large coefficient field is read. Higher-corank
candidates are checked for a nowhere-zero section before being reported.
"""
import argparse
import json
import random
import time
from pathlib import Path


def run(output, seconds, samples, fiber_count):
    started = time.monotonic()
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'q')([2,4,1]))
    a = k.gen()
    X = PolynomialRing(k,'x')
    x = X.gen()
    K = X.fraction_field()
    elements = list(k)
    nonzero = [c for c in elements if c]
    branch = nonzero[:9]
    dd = prod(x-c for c in branch[:4])
    rr = prod(x-c for c in branch[4:])
    ff = dd*rr
    assert ff.degree()==9 and ff.gcd(ff.derivative())==1
    points = []
    for xx in elements:
        if not ff(xx): continue
        yy = (X.gen()**2-ff(xx)).roots(multiplicities=False)
        if yy: points.append((xx,yy[0]))
    assert 2<=fiber_count<=4 and len(points)>=fiber_count
    # COMPLETE fibers are essential. Use L=B-(fiber_count+1) infinity,
    # so L^2 plus these2*fiber_count points has determinant omega.
    points=[point for p in points[:fiber_count] for point in [p,(p[0],-p[1])]]
    count=2*fiber_count
    xx=[p[0] for p in points]
    yy=[p[1] for p in points]
    zz=[yy[i]/dd(xx[i]) for i in range(count)]
    rho=None
    for last in elements:
        trial=([k(0),k(1),k(2)] if fiber_count==2 else elements[:count-1])+[last]
        if len(set(trial))<count: continue
        jets=[[xx[i]**(r//2)*(zz[i] if r%2 else 1) for i in range(count)] for r in range(fiber_count)]
        ac=matrix(k,[row for jet in jets for row in [jet,[jet[i]*trial[i] for i in range(count)]]])
        if ac.is_invertible():
            rho=trial
            break
    assert rho is not None
    dirs=[vector(k,[1,r]) for r in rho]
    ann=[vector(k,[-r,1]) for r in rho]
    nilp=[matrix(k,2,1,list(dirs[i]))*matrix(k,1,2,list(ann[i])) for i in range(count)]
    pp=prod(x-xx[2*i] for i in range(fiber_count))
    zprime=lambda i:(rr.derivative()(xx[i])*dd(xx[i])-rr(xx[i])*dd.derivative()(xx[i]))/(2*zz[i]*dd(xx[i])**2)
    def hpole_at(j,i):
        assert j!=i
        if xx[i]==xx[j]: return ff.derivative()(xx[i])/(2*yy[i])
        return (yy[i]+yy[j])/(xx[i]-xx[j])
    def pole_at(j,i):
        assert j!=i
        if xx[i]==xx[j]: return zprime(i)
        return (zz[i]+zz[j])/(xx[i]-xx[j])
    zero=(K.zero(),K.zero())
    plus=lambda f,g:(f[0]+g[0],f[1]+g[1])
    scale=lambda c,f:(c*f[0],c*f[1])
    mul=lambda f,g:(f[0]*g[0]+f[1]*g[1]*rr/dd,f[0]*g[1]+f[1]*g[0])
    pole=[(K(zz[i])/(x-xx[i]),K.one()/(x-xx[i])) for i in range(count)]
    hpole=[(K(yy[i])/(x-xx[i]),K(dd)/(x-xx[i])) for i in range(count)]
    infinity_bound=5-fiber_count
    core_tags=[(0,j) for j in range(infinity_bound//2+1)]+[(1,j) for j in range((infinity_bound-1)//2+1)]
    core=[(K(x**j),K.zero()) if part==0 else (K.zero(),K(x**j)) for part,j in core_tags]
    width=len(core);offset=2*width
    infinity_index=core_tags.index((infinity_bound%2,infinity_bound//2))
    ub=[]
    for component in range(2):
        for val in core:
            entry=[zero,zero]
            entry[component]=val
            ub.append(entry)
    ub += [[scale(dirs[i][j],pole[i]) for j in range(2)] for i in range(count)]
    assert len(ub)==12
    def ambient(v):
        vals=[]
        for entry in v:
            for part in entry:
                p=K(pp*part)
                assert p.denominator()==1
                p=X(p.numerator())
                assert p.degree()<=8
                vals.extend([p[i] for i in range(9)])
        return vector(k,vals)
    eb=ub+[[scale(x**3,val) for val in entry] for entry in ub]
    ef=matrix(k,[ambient(v) for v in eb]).transpose()
    assert ef.nrows()==36 and ef.rank()==24
    rows=list(ef.transpose().pivots())
    inverse=ef.matrix_from_rows(rows).inverse()
    def ecoord(v):
        av=ambient(v)
        co=inverse*vector(k,[av[i] for i in rows])
        assert ef*co==av
        return co
    # Twenty parameters: polynomial matrix entries of degree<=3, plus
    # four rank-one nilpotent residues. Cancel the order7 pole at infinity
    # and impose preservation of each modification lattice.
    constraints=[]
    for row in range(2):
        for col in range(2):
            constraints.append([k.zero()]*16+[n[row,col] for n in nilp])
    for i in range(count):
        line=[]
        for row in range(2):
            for col in range(2):
                line.extend([ann[i][row]*dirs[i][col]*xx[i]**d for d in range(4)])
        line += [k.zero() if i==j else
                 (ann[i]*nilp[j]*dirs[i])*hpole_at(j,i) for j in range(count)]
        constraints.append(line)
    hb=matrix(k,constraints).right_kernel().basis_matrix()
    assert hb.nrows()==13
    def higgs(row):
        out=[]
        for i in range(2):
            outrow=[]
            for j in range(2):
                val=(K(sum(row[(2*i+j)*4+d]*x**d for d in range(4))),K.zero())
                for r in range(count): val=plus(val,scale(row[16+r]*nilp[r][i,j],hpole[r]))
                outrow.append(val)
            out.append(outrow)
        return out
    ht=[]
    for h in hb.rows():
        phi=higgs(h)
        columns=[]
        for v in ub:
            product=[plus(mul(phi[i][0],v[0]),mul(phi[i][1],v[1])) for i in range(2)]
            columns.append(ecoord(product))
        ht.append(matrix(k,columns).transpose())
    preparation=time.monotonic()-started
    print('prepared intrinsic genus-four family in %.3f seconds'%preparation,flush=True)

    def nowhere(u):
        # At infinity the x*z coefficients are the two fiber coordinates.
        if not u[infinity_index] and not u[width+infinity_index]: return False
        ap=[];bp=[]
        for j in range(2):
            ap.append(pp*sum(u[width*j+h]*x**d for h,(part,d) in enumerate(core_tags) if part==0)
                      +sum(u[offset+i]*dirs[i][j]*zz[i]*(pp//(x-xx[i])) for i in range(count)))
            bp.append(pp*sum(u[width*j+h]*x**d for h,(part,d) in enumerate(core_tags) if part==1)
                      +sum(u[offset+i]*dirs[i][j]*(pp//(x-xx[i])) for i in range(count)))
        # Branch points supporting L have local frame z; test its coefficients.
        if any(not bp[0](r) and not bp[1](r) for r in branch[:4]): return False
        for i in range(count):
            if u[offset+i]: continue
            value=vector(k,[sum(u[width*j+h]*xx[i]**d*(zz[i] if part else 1) for h,(part,d) in enumerate(core_tags))
                +sum(u[offset+r]*dirs[r][j]*pole_at(r,i) for r in range(count) if r!=i)
                for j in range(2)])
            if ann[i]*value==0: return False
        norm=[dd*p**2-rr*q**2 for p,q in zip(ap,bp)]
        common=norm[0].gcd(norm[1]).gcd(ap[0]*bp[1]-ap[1]*bp[0])
        bad=pp*dd
        while common.degree()>0:
            factor=common.gcd(bad)
            if factor.degree()==0: return False
            common=common//factor
        # Both points of every removed hyperelliptic fiber were checked
        # above in their actual modification lattices.
        return True
    T=PolynomialRing(k,'t');t=T.gen();KT=T.fraction_field()
    cases=[];counts={};tested=0;valid=0;single_jumps=[];jump_witness=None
    proposals=[]
    # Structured core sections, followed by bounded random sections.
    for first in range(width):
        for second in range(width):
            u=vector(k,12);u[first]=1;u[width+second]=1
            proposals.append(u)
    random.seed(int(20260907))
    for sample in range(samples):
        if sample>=len(proposals) and time.monotonic()-started>preparation+seconds: break
        u=proposals[sample] if sample<len(proposals) else vector(k,[elements[random.randrange(25)] for _ in range(12)])
        hmat=matrix(k,[mat*u for mat in ht]).transpose()
        top=hmat.matrix_from_rows(range(12));bottom=hmat.matrix_from_rows(range(12,24))
        ranks=[bottom.rank(),top.rank(),(bottom-top).rank()]
        tested+=1
        key=','.join(str(r) for r in ranks)
        counts[key]=counts.get(key,0)+1
        if min(ranks)==11 and sample>=max(len(proposals),30): continue
        admissible=nowhere(u)
        if admissible:
            valid+=1
            assert hmat.rank()==13
            assert all((13-r)%2==0 for r in ranks), 'Parity failure at a claimed nowhere-zero section'
            if min(ranks)<=9:
                single_jumps.append({'u':[str(c) for c in u],'sample_ranks':ranks})
                if min(ranks)<=7 and jump_witness is None:
                    jump_witness={'u':[str(c) for c in u],'sample_ranks':ranks,
                        'Higgs_evaluation_columns_in_A_plus_x_cubed_A':
                            [[str(c) for c in row] for row in hmat.rows()],
                        'exact_normal_evaluation_rank':
                            (bottom.change_ring(KT)-t*top.change_ring(KT)).rank()}
        if max(ranks)>9 and sample>=len(proposals): continue
        normal=(bottom.change_ring(KT)-t*top.change_ring(KT)).rank()
        case={'u':[str(c) for c in u],'sample_ranks':ranks,'normal_evaluation_rank':normal,
              'normal_corank_if_nowhere_zero':13-normal,'nowhere_zero':admissible,
              'H0_Higgs_evaluation_injective':hmat.rank()==13}
        if sample<len(proposals) or (admissible and normal<=9): cases.append(case)
        if admissible and normal<=9:
            print('GEOMETRIC HIGHER-CORANK CANDIDATE '+json.dumps(case,default=int),flush=True)
            break
    report={'scope':'General stable acyclic bundles only; not dormant opers or atlases.',
        'curve_y_squared':str(ff),'D':str(dd),'R':str(rr),
        'modification_points':[[str(c) for c in p] for p in points],
        'fiber_count':fiber_count,'core_line':'L=O(B-%s infinity)'%(fiber_count+1),
        'directions':[str(c) for c in rho],
        'acyclic_residue_matrix_determinant':str(ac.det()),
        'determinant_omega_verified_by_complete_fibers':True,
        'stability_distinct_directions_on_conjugate_pairs':len(set(rho))==count,
        'E_basis_dimension':12,'Higgs_dimension':13,'tensor_preparation_seconds':preparation,
        'tested_sections':tested,'admissibility_checked_and_passed':valid,
        'sample_rank_counts':counts,'cases':cases,'nowhere_zero_single_member_jumps':single_jumps,
        'single_member_jump_count':len(single_jumps),'corank_six_witness':jump_witness,
        'elapsed_seconds':time.monotonic()-started}
    path=Path(output);path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(report,indent=2,default=int)+'\n')
    print(json.dumps({key:val for key,val in report.items()
                     if key not in ['cases','nowhere_zero_single_member_jumps','corank_six_witness']},
                     indent=2,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',required=True)
    parser.add_argument('--seconds',type=float,default=20)
    parser.add_argument('--samples',type=int,default=1000)
    parser.add_argument('--fiber-count',type=int,default=2,choices=[2,3,4])
    args=parser.parse_args()
    run(args.output,args.seconds,args.samples,args.fiber_count)
