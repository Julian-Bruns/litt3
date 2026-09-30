#!/usr/bin/env sage
"""Verify a stable acyclic genus-four bundle with individual corank six.

Reconstructs the fixed curve, bundle, nowhere-zero section and full Higgs
matrix. The canonical pencil has generic corank two. No search is needed.
Use --output only to export the reconstructed witness matrix.
"""
import argparse
import json
import time
from pathlib import Path


def verify(output=None):
    started = time.monotonic()
    k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'q')([2,4,1]))
    a = k.gen()
    X = PolynomialRing(k,'x')
    x = X.gen()
    K = X.fraction_field()
    branch = [a, a+3, 4*a+3, 2*a+2, 4*a+1, k(2), 2*a, 2*a+1, 3*a+1]
    dd = prod(x-c for c in branch[:4])
    rr = prod(x-c for c in branch[4:])
    ff = dd*rr
    assert ff.degree()==9 and ff.gcd(ff.derivative())==1
    points = [(k(3),k(4)), (k(3),k(1)),
              (3*a+4,4*a+2), (3*a+4,a+3)]
    assert all(y*y==ff(x0) and ff(x0) for x0,y in points)
    assert points[0][0]==points[1][0] and points[0][1]==-points[1][1]
    assert points[2][0]==points[3][0] and points[2][1]==-points[3][1]
    assert points[0][0]!=points[2][0]
    fiber_count=2
    count=4
    xx=[p[0] for p in points]
    yy=[p[1] for p in points]
    zz=[yy[i]/dd(xx[i]) for i in range(count)]
    rho=[k(0),k(1),k(2),a]
    assert len(set(rho))==4
    ac=matrix(k,[[k(1)]*4,rho,zz,[zz[i]*rho[i] for i in range(4)]])
    assert ac.det()==3
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
    u=vector(k,[2*a+4,3*a+1,2*a,3*a+3,0,a+2,1,a+1,1,3*a+3,2*a+4,4*a])
    assert nowhere(u), 'The fixed section must be nowhere zero at every geometric point'
    hmat=matrix(k,[mat*u for mat in ht]).transpose()
    assert hmat.rank()==13
    top=hmat.matrix_from_rows(range(12));bottom=hmat.matrix_from_rows(range(12,24))
    ranks=[bottom.rank(),top.rank(),(bottom-top).rank()]
    normal=(bottom.change_ring(KT)-t*top.change_ring(KT)).rank()
    assert ranks==[7,11,11] and normal==11
    report={
        'curve_y_squared':str(ff),'D':str(dd),'R':str(rr),
        'modification_points':[[str(c) for c in p] for p in points],
        'directions':[str(c) for c in rho],
        'acyclic_residue_matrix_determinant':str(ac.det()),
        'u':[str(c) for c in u],
        'sample_ranks':ranks,
        'Higgs_evaluation_columns_in_A_plus_x_cubed_A':
            [[str(c) for c in row] for row in hmat.rows()],
        'exact_normal_evaluation_rank':normal}
    if output is not None:
        path=Path(output)
        path.parent.mkdir(parents=True,exist_ok=True)
        path.write_text(json.dumps(report,indent=2,default=int)+'\n')
    print('PASS: nowhere-zero section; individual coranks6,2,2; generic corank2; %.3fs'
          %(time.monotonic()-started),flush=True)
    return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',help='Export the full reconstructed witness matrix')
    verify(parser.parse_args().output)
