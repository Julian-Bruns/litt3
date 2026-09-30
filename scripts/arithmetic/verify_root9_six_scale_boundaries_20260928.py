"""Independent quotient-polynomial multiplication of all new unit witnesses.

Arguments: preserved companion archive root, new certificate JSON.
"""
import json
import sys
from pathlib import Path

root = Path(sys.argv[1]).resolve()
sys.path.insert(0,str(root/'src'))
from verify_boundary import epadd, epmul, monic
from field import pa, pm, ps, scale, peval, inv, mul, sub, neg, pgcd, pdm, deriv, ppow

I=json.loads((root/'data/inputs.json').read_text())
receipt=json.loads(Path(sys.argv[2]).read_text())
rows=receipt['rows']
assert [r['sigma'] for r in rows] == [112400,246025,215500,360225,164100,272625]
for row in rows:
    sigma = row['sigma']
    if 'q' in row:
        q = row['q']
        assert q and q not in I['excluded_q'] and peval(I['d'],q)
        assert peval(ps(I['a0'],scale(I['d'],sigma)),q)==0
        b,c,e = [peval(I[key],q) for key in ['b','c','e']]
        mod=monic([e,c,b]);assert row['modulus_in_u']==mod
        assert e and b and len(pgcd(mod,deriv(mod)))==1
    else:
        mod=row['modulus_in_u'];q=row['q_in_u']
        assert len(mod)==17 and mod==monic(mod) and len(pgcd(mod,deriv(mod)))==1
        def ev(pol):
            ans=[]
            for cc in reversed(pol):ans=pdm(pa(pm(ans,q),[cc]),mod)[1]
            return ans
        ebar=I['e'][1:]
        a=ps(I['a0'],scale(I['d'],sigma))
        assert ev(ebar)==[]
        assert pdm(pa(pa(pm(ev(a),[0,0,1]),pm(ev(I['b']),[0,1])),ev(I['c'])),mod)[1]==[]
        for unit in [q,[0,1],ev(a),ev(I['d'])]+[ps(q,[bad]) for bad in I['excluded_q']]:
            assert len(pgcd(unit,mod))==1
        assert len(pgcd(a,ebar))==1
        columns=[]
        for j in range(2):
            for i in range(8):
                p=pdm(pm(ppow(q,i,mod),[0]*j+[1]),mod)[1]
                columns.append(p+[0]*(16-len(p)))
        matrix=[list(r) for r in zip(*columns)]
        for k in range(16):
            pivot=next(j for j in range(k,16) if matrix[j][k])
            matrix[k],matrix[pivot]=matrix[pivot],matrix[k]
            matrix[k]=[mul(x,inv(matrix[k][k])) for x in matrix[k]]
            for j in range(k+1,16):
                cc=matrix[j][k]
                matrix[j]=[sub(x,mul(cc,y)) for x,y in zip(matrix[j],matrix[k])]
    product=[1]
    for block in row['blocks']:
        m=block['modulus'];assert m==monic(m) and len(pgcd(product,m))==1
        product=pm(product,m)
        assert block['u']==pdm([0,1],m)[1]
        eq=epadd(epmul(block['C71'],block['U'],m),epmul(block['C72'],block['V'],m))
        if 'W' in block: eq=epadd(eq,epmul(block['C73'],block['W'],m))
        assert eq==[[1]]
        assert len(block['C72']) <= 54
    assert product==mod
    print(json.dumps(dict(sigma=sigma,complete_u_degree=len(mod)-1,unit_identity='PASS')),flush=True)
print('PASS:',receipt['geometric_ratio_count'],'ratios, arbitrary geometric scales; no further square exclusion asserted.')
