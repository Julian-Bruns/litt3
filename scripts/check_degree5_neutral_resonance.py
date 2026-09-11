#!/usr/bin/env python3
"""Exact obstruction to purely linear non-Galois defect-neutral descent.

No curve, oper, or geometric counterexample is constructed.
"""
from itertools import permutations


def rank_mod5(rows, columns):
    a=[[x % 5 for x in row] for row in rows]
    pivot=0
    for j in range(columns):
        k=next((i for i in range(pivot,len(a)) if a[i][j]),None)
        if k is None:
            continue
        a[pivot],a[k]=a[k],a[pivot]
        inverse=pow(a[pivot][j],-1,5)
        a[pivot]=[(x*inverse)%5 for x in a[pivot]]
        for i in range(len(a)):
            if i!=pivot and a[i][j]:
                c=a[i][j]
                a[i]=[(x-c*y)%5 for x,y in zip(a[i],a[pivot])]
        pivot+=1
    return pivot


def act(g,x):
    result=[0]*5
    for i in range(5):
        result[g[i]]=x[i]
    return result


def matmul(a,b):
    return [[sum(a[i][k]*b[k][j] for k in range(5))
             for j in range(5)] for i in range(5)]


def main():
    group=list(permutations(range(5)))
    point_stabilizer=[g for g in group if g[0]==0]
    pair_stabilizer=[g for g in point_stabilizer if g[1]==1]
    assert (len(group),len(point_stabilizer),len(pair_stabilizer))==(120,24,6)
    aug_basis=[[int(i==j)-int(i==4) for i in range(5)] for j in range(4)]
    dims=[]
    for subgroup in (group,point_stabilizer,pair_stabilizer):
        rows=[]
        for g in subgroup:
            columns=[[y-x for x,y in zip(v,act(g,v))] for v in aug_basis]
            rows.extend([[columns[j][i] for j in range(4)] for i in range(5)])
        dims.append(4-rank_mod5(rows,4))
    assert dims==[1,1,2]
    print('AUGMENTATION_MODULE: dimension4; G,H,H2 invariant dimensions',dims)

    eye=[[int(i==j) for j in range(5)] for i in range(5)]
    norm=[[1]*5 for _ in range(5)]
    off=[[1-int(i==j) for j in range(5)] for i in range(5)]
    assert matmul(norm,norm)==[[5]*5 for _ in range(5)]
    assert matmul(off,off)==[[3*off[i][j]+4*eye[i][j] for j in range(5)] for i in range(5)]
    cycle=(1,2,3,4,0)
    ematrix=[[int(i==cycle[j])-eye[i][j] for j in range(5)] for i in range(5)]
    power=eye
    expanded=[[0]*5 for _ in range(5)]
    for coefficient in [5,10,10,5,1]:
        expanded=[[expanded[i][j]+coefficient*power[i][j] for j in range(5)] for i in range(5)]
        power=matmul(power,ematrix)
    assert expanded==norm
    print('INTEGRAL_HECKE: J^2=5J, B^2=3B+4I, J=5+10e+10e^2+5e^3+e^4')

    w=[-4,1,1,1,1]
    assert sum(w)==0 and all(act(g,w)==w for g in point_stabilizer)
    assert any(act(g,w)!=w for g in group)
    assert [x%5 for x in w]==[1]*5
    x=[25*c for c in w]
    assert all(c%25==0 for c in x)
    for precision in range(2,8):
        fixed=all(all((u-v)%(5**precision)==0 for u,v in zip(act(g,x),x)) for g in group)
        assert fixed==(precision<=3)
    print('UNRAMIFIED_LINEAR_MODE: 25*(-4,1,1,1,1) is H-fixed and J-killed')
    print('G-fixed through W3, not W4; all higher linear equations still vanish')
    print('PASS. This disproves only an abstract-linear implication, not geometric descent.')


if __name__=='__main__':
    main()
