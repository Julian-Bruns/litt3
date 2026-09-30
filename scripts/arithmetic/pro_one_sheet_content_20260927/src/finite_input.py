from integral_chart import *
ends=json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints']
js=json.loads((ROOT/'data'/'J_algebras.json').read_text())
for ch,e,j in zip(json.loads((ROOT/'data'/'integral_charts.json').read_text()),ends,js):
    rows=[('F',ch['F']),('beta',ch['beta']),('delta',dumps(pshift(loads(e['Delta']),(8,0)))),('J',dumps({(i,0):c for i,c in enumerate(j['v_modulus']) if c})),('Hn',ch['H_numerator']),('Hd',ch['H_denominator'])]
    for b in ch['branches']:rows += [(b['name']+'_n',b['numerator']),(b['name']+'_d',b['denominator'])]
    with open(ROOT/'data'/f"finite_input_{ch['r']}.txt",'w') as f:
        f.write(f"{ch['r']} {e['P_r']}\n")
        for name,p in rows:
            f.write(f'{name} {len(p)}\n')
            for row in p:f.write(' '.join(map(str,row))+'\n')
