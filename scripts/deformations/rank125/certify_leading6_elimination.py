#!/usr/bin/env python3
"""Exact radical identities: E4=0 and H5=0 force all six H6 coefficients zero."""
import argparse
import ast
import itertools
import json
import subprocess
import sys
from pathlib import Path

parser = argparse.ArgumentParser()
parser.add_argument("evidence", type=Path)
parser.add_argument("equations", type=Path)
parser.add_argument("--output", type=Path, required=True)
args = parser.parse_args()
sys.path.insert(0, str(args.evidence.resolve()))
import arith as a
data = json.loads(args.equations.read_text())
n = len(data["variables"])
assert n == 14
assert [v["leading_degree"] for v in data["variables"]] == [6]*6+[7]*8

def power(indices):
    powers = [0] * n
    for i in indices:
        powers[i] += 1
    return tuple(powers)

original = [{power(indices): c for indices, c in row["terms"]}
            for row in data["equations"]]

def field_expression(c):
    return "("+"+".join(str(x)+("*t^"+str(i) if i else "")
                         for i,x in enumerate(a.DIG[c]) if x)+")"

def poly_expression(p):
    return "+".join(field_expression(c)+"".join("*x"+str(i)+"^"+str(x)
                                              for i,x in enumerate(e) if x)
                    for e,c in p.items()) or "0"

def field_parse(text):
    def visit(node):
        if isinstance(node,ast.Constant):
            return int(node.value)%5
        if isinstance(node,ast.Name) and node.id=="t":
            return 5
        if isinstance(node,ast.UnaryOp):
            return a.NEG[visit(node.operand)] if isinstance(node.op,ast.USub) else visit(node.operand)
        if isinstance(node,ast.BinOp):
            if isinstance(node.op,ast.Pow):
                return a.fpow(visit(node.left),ast.literal_eval(node.right))
            x,y=visit(node.left),visit(node.right)
            if isinstance(node.op,ast.Add): return a.ADD[x][y]
            if isinstance(node.op,ast.Sub): return a.SUB[x][y]
            if isinstance(node.op,ast.Mult): return a.MUL[x][y]
            if isinstance(node.op,ast.Div): return a.MUL[x][a.INV[y]]
        raise ValueError(ast.dump(node))
    return visit(ast.parse(text.replace("^","**"),mode="eval").body)

def lifted_identity(polys,target):
    source = "\n".join([
        "ring r=(5,t),("+",".join("x"+str(i) for i in range(n))+"),dp;",
        "minpoly=t^3+t+1;",
        "ideal I="+",".join(poly_expression(p) for p in polys)+";",
        "ideal J="+poly_expression({target:1})+";",
        "matrix C=lift(I,J);",
        "poly p; int i; intvec e;",
        'for(i=1;i<=nrows(C);i++){p=C[i,1];while(p!=0){e=leadexp(p);print("TERM|"+string(i-1)+"|"+string(leadcoef(p))+"|"+string(e));p=p-lead(p);}}',
        "quit;",
    ])
    result = subprocess.run(["Singular","-q"],input=source,text=True,
                            capture_output=True,timeout=30,check=True)
    terms=[]
    for line in result.stdout.splitlines():
        if line.startswith("TERM|"):
            _,row,c,mon=line.split("|")
            terms.append({"equation":int(row),"powers":[int(v) for v in mon.split(",")],
                          "coefficient":field_parse(c)})
    value={}
    for term in terms:
        for e,c in polys[term["equation"]].items():
            mon=tuple(x+y for x,y in zip(e,term["powers"]))
            value[mon]=a.ADD[value.get(mon,0)][a.MUL[c][term["coefficient"]]]
    assert {e:c for e,c in value.items() if c}=={target:1}, result.stdout[:2000]
    return terms
steps = []
killed = []
for variable in (5, 4, 3, 2, 1, 0):
    polys = [{e:c for e,c in p.items() if not any(e[j] for j in killed)} for p in original]
    target = power([variable] if variable == 1 else [variable, variable])
    active = [j for j in range(n) if j not in killed]
    for bound in range(3):
        monomials = [power(indices) for d in range(bound + 1)
                     for indices in itertools.combinations_with_replacement(active, d)]
        columns, labels = [], []
        for i, p in enumerate(polys):
            if not p:
                continue
            for m in monomials:
                columns.append({tuple(x+y for x,y in zip(e,m)): c for e,c in p.items()})
                labels.append((i,m))
        rows = sorted({target}.union(*(set(p) for p in columns)), key=lambda x:(sum(x),x))
        matrix = [[p.get(e,0) for p in columns]+[int(e==target)] for e in rows]
        rr,pivots = a.rref(matrix,aug=1)
        if any(not any(row[:-1]) and row[-1] for row in rr):
            continue
        coefficients = [0]*len(columns)
        for i,j in enumerate(pivots):
            coefficients[j] = rr[i][-1]
        value = {}
        for c,p in zip(coefficients,columns):
            for e,b in p.items():
                value[e] = a.ADD[value.get(e,0)][a.MUL[c][b]]
        assert {e:c for e,c in value.items() if c} == {target:1}
        terms = [{"equation":i,"powers":list(m),"coefficient":c}
                 for (i,m),c in zip(labels,coefficients) if c]
        steps.append({"set_to_zero":killed.copy(),"target_powers":list(target),
                      "multiplier_degree_bound":bound,"identity":terms})
        print("target",variable,"power",sum(target),"bound",bound,"terms",len(terms),flush=True)
        killed.append(variable)
        break
    else:
        terms=lifted_identity(polys,target)
        bound=max(sum(v["powers"]) for v in terms)
        steps.append({"set_to_zero":killed.copy(),"target_powers":list(target),
                      "multiplier_degree_bound":bound,"identity":terms,
                      "method":"Singular lift followed by independent exact polynomial multiplication"})
        print("target",variable,"power",sum(target),"bound",bound,"terms",len(terms),flush=True)
        killed.append(variable)
report = {"field":"F5[t]/(t^3+t+1)","steps":steps,
          "conclusion":"On geometric points all six H6 parameters vanish. Each step is a verified identity modulo previously vanished parameters; squares imply zero over every field extension. No scheme reducedness claim."}
args.output.write_text(json.dumps(report,indent=2)+"\n")
