"""Certify that the newly excluded J boundary is the H-degree-drop boundary."""
from endpoints import *
ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints']
result=[]
for e in ends:
    B,C,E,D=map(loads,[e['B'],e['C'],e['E'],e['D']])
    B0,B1=splitH(B);C0,C1=splitH(C);E0,E1=splitH(E)
    J=padd(pscale(ppow(C1,2),mul(2,e['M_r'])),pmul(E1,B1))
    j=padd(psub(pmul(ppow(B,5),E),pmul(D,ppow(C,5))),pscale(pmul(ppow(B,4),ppow(C,2)),mul(2,e['M_r'])))
    leading={(i,0):c for (i,h),c in j.items() if h==6}
    assert leading==pmul(ppow(B1,4),J)
    result.append({'r':e['r'],'H_degree':max(h for i,h in j),'leading_coefficient_identity':'B1^4*(2*M_r*C1^2+E1*B1)','verified':True})
(ROOT/'evidence'/'H_degree_drop_checks.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: [H^6]j=B1^4 J at all three endpoints.')
