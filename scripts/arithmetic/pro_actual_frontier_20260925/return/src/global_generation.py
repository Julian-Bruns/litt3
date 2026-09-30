"""Certificate that the nineteen dual sections generate K(17O) everywhere."""
from pathlib import Path
import itertools,json
from exact import *
from stability import load_sections,trim,hermite_columns,padd,pmul
ROOT=Path(__file__).resolve().parents[1]
def generators():
    ss=load_sections();vectors=[]
    for (a,b),(c,d) in itertools.combinations(ss,2):
        for j in range(3):
            p=(a*d-b*c)*LP.term(0,j)
            assert all(i>=0 for i,j,c in p.terms())
            vectors.append([trim([p.coeff(i,j) for i in range(max(0,p.lo+p.a.shape[1]))]) for j in range(3)])
    inf=[[(a-e*b).coeff(4,0),b.coeff(1,2)] for a,b in ss]
    return vectors,inf

def verify(c):
    vs,inf=generators();G=c['Hermite_basis'];C=c['combinations']
    for r in range(3):
        out=[[],[],[]]
        for i,p in C[r].items():out=[padd(a,pmul(p,b)) for a,b in zip(out,vs[int(i)])]
        assert out==G[r] and G[r][r]==[1] and not any(G[r][r+1:])
    assert inf==c['infinity_matrix'];i,j=c['infinity_witness']['rows']
    d=int(ADD[MUL[inf[i][0],inf[j][1]],NEG[MUL[inf[i][1],inf[j][0]]]])
    assert d and d==c['infinity_witness']['determinant']
    return True

def main():
    vs,inf=generators();G,C,used=hermite_columns(vs)
    assert all(G[r] is not None and G[r][r]==[1] for r in range(3))
    iw=None
    for i,j in itertools.combinations(range(19),2):
        d=int(ADD[MUL[inf[i][0],inf[j][1]],NEG[MUL[inf[i][1],inf[j][0]]]])
        if d:iw={'rows':[i,j],'determinant':d};break
    assert iw is not None
    c={'globally_generated':True,'Hermite_basis':G,'combinations':[{str(i):p for i,p in row.items()} for row in C], 'infinity_matrix':inf,'infinity_witness':iw,'generators_processed':used}
    assert verify(c)
    (ROOT/'certificates'/'global_generation.json').write_text(json.dumps(c,indent=2)+'\n')
    print('Global generation certified geometrically: affine unit ideal and infinity rank two;',used,'generators processed')
if __name__=='__main__':main()
