"""Exact small abstract norm-mode certificate; not a geometric Hodge model."""
import itertools, json
from pathlib import Path
from sage.all import QQ, ZZ, matrix, vector, GF


def main():
    p=5
    shifts=[[(i+j)%p for i in range(p)] for j in range(p)]
    def conv(a,b):
        return vector(QQ,[sum(a[j]*b[(i-j)%p] for j in range(p)) for i in range(p)])
    one=vector(QQ,[1,0,0,0,0]); e=vector(QQ,[-1,1,0,0,0])
    power=one; log=vector(QQ,5)
    for j in range(1,5):
        power=conv(power,e);log+=QQ((-1)**(j+1))/j*power
    f=conv(log,log); fs=vector(QQ,[(f[i]+f[-i%p])/2 for i in range(p)])
    mons=set(itertools.combinations_with_replacement(range(p),3)); orbits=[]
    while mons:
        m=min(mons);o=sorted({tuple(sorted(sh[i] for i in m)) for sh in shifts})
        mons.difference_update(o);orbits.append(o)
    x=vector(ZZ,[0,3,2,2,3])
    columns=[]
    for orbit in orbits:
        grad=vector(ZZ,p)
        for mon in orbit:
            for i,j in enumerate(mon):
                grad[j]+=x[mon[(i+1)%3]]*x[mon[(i+2)%3]]
        columns.append(grad)
    C=matrix(ZZ,columns).transpose()
    target=vector(QQ,[(sum(fs[j]*x[(i+j)%p] for j in range(p))-1)/5 for i in range(p)])
    coeff=vector(QQ,[-QQ(1915)/2952,QQ(1531)/28044,QQ(71375)/224352,
                     QQ(71375)/224352,QQ(1531)/28044,0,0])
    assert all(c.denominator()%5 for c in coeff)
    assert C*coeff==target
    assert list(x)==[int(3*i*i%5) for i in range(p)]
    assert all(fs[j]==fs[-j%p] for j in range(p)) and sum(fs)==0
    assert all(a*a+2*b*b!=0 for a in GF(5) for b in GF(5) if a or b)
    # This reflection fixes x; the displayed coefficients also make H invariant.
    by_orbit={tuple(o):c for o,c in zip(orbits,coeff)}
    for o,c in zip(orbits,coeff):
        reflected=tuple(sorted({tuple(sorted((-i)%p for i in mon)) for mon in o}))
        assert by_orbit[reflected]==c
    results=[{'x':list(map(int,x)),'eta':1,
              'orbit_representatives':[list(o[0]) for o in orbits],
              'coefficients':[str(z) for z in coeff],
              'gradient_matrix':[[int(z) for z in row] for row in C.rows()],
              'target':[str(z) for z in target],
              'identity':'L_s*x = constant_one + 5*grad(H)(x)',
              'reflection_invariant':True,
              'rank_mod5':int(C.change_ring(GF(5)).rank())}]
    out={'status':'exact abstract test, no geometric realization',
         'self_adjoint_convolution':[str(c) for c in fs],
         'number_of_cubic_orbits':len(orbits),'certificates':results,
         'rank_two_extension':'On Fun(C5^2), sum H over second-coordinate slices; L=L_s,1+2L_s,2 and x(s,t)=x(s). The identity is exact with eta=1 and rationally anisotropic quadratic symbol.'}
    path=Path(__file__).resolve().parents[2]/'Research/computations/inhomogeneous_early_gradient_probe.json'
    path.write_text(json.dumps(out,indent=2)+'\n');print(json.dumps(out,indent=2))


if __name__=='__main__':main()
