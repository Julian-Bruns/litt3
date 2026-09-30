"""Homogeneous polynomial arithmetic and Macaulay matrices, standard library only."""
from core import add, mul, NEG, hommons

def h_add(A,B):
    C=A.copy()
    for m,b in B.items():
        C[m]=add(C.get(m,0),b)
        if not C[m]:del C[m]
    return C

def h_neg(A):return {m:NEG[c] for m,c in A.items()}

def h_mul(A,B):
    C={}
    for a,x in A.items():
        for b,y in B.items():
            m=tuple(i+j for i,j in zip(a,b));c=add(C.get(m,0),mul(x,y))
            if c:C[m]=c
            elif m in C:del C[m]
    return C

def h_der(A,i):
    C={}
    for m,c in A.items():
        if m[i]%5:
            e=list(m);e[i]-=1;C[tuple(e)]=mul(c,m[i]%5)
    return C

def forms(data,cover):
    """Order: Q, K, K_i Q_j - K_j Q_i, 0<=i<j<=3."""
    K={tuple(m):c for m,c in zip(data['quartic_monomials'],data['dual_Kummer']) if c}
    Q={}
    for (i,j),c in zip(data['quadric_monomials'],cover['quadric']):
        if c:
            m=[0]*4;m[i]+=1;m[j]+=1;Q[tuple(m)]=c
    dK=[h_der(K,i) for i in range(4)];dQ=[h_der(Q,i) for i in range(4)]
    G=[Q,K]
    for i in range(4):
        for j in range(i+1,4):
            G.append(h_add(h_mul(dK[i],dQ[j]),h_neg(h_mul(dK[j],dQ[i]))))
    return G

def macaulay(G,N):
    """Rows are all degree-N monomial multiples of the supplied generators."""
    mons=hommons(4,N);idx={m:i for i,m in enumerate(mons)};rows=[];labels=[]
    for j,g in enumerate(G):
        if not g:continue
        d=sum(next(iter(g)))
        assert all(sum(e)==d for e in g)
        for e in hommons(4,N-d):
            row=[0]*len(mons)
            for m,c in g.items():row[idx[tuple(i+h for i,h in zip(m,e))]]=c
            rows.append(row);labels.append([j,e])
    return rows,labels
