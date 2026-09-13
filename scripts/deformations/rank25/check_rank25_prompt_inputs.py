"""Independent finite algebra / pullback stress tests for the new prompt.

Run with sage -python. This uses saved primary matrices and the audited
cyclic-five W4 vector, not an uncomputed rank25 W4 obstruction.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
from sage.all import *


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument("input",type=Path)
    ap.add_argument("recheck",type=Path)
    ap.add_argument("cyclic_input",type=Path)
    ap.add_argument("cyclic_result",type=Path)
    ap.add_argument("--output",type=Path)
    args=ap.parse_args()
    contents={str(path):path.read_bytes() for path in [args.input,args.recheck,args.cyclic_input,args.cyclic_result]}
    a,b,c,cyc=[json.loads(contents[str(path)]) for path in [args.input,args.recheck,args.cyclic_input,args.cyclic_result]]
    volatile={"seconds","precision"}
    assert {k:v for k,v in a.items() if k not in volatile}=={k:v for k,v in b.items() if k not in volatile}
    p=PolynomialRing(GF(5),"x"); x=p.gen()
    k=GF(625,"t",modulus=p(a["coefficient_modulus"])); t=k.gen()
    decode=lambda v:sum(k(c)*t**i for i,c in enumerate(v))
    mat=lambda v:matrix(k,[[decode(c) for c in row] for row in v])
    vec=lambda v:vector(k,[decode(c) for c in v])
    enc=lambda v:[int(v[i]) for i in range(4)]
    psi=mat(a["hodge_matrix"]); hh=mat(a["additive_matrix"])
    dual=mat(a["obstruction_dual_rows"]); kernels=mat(a["kernel_basis"])
    assert psi.rank()==66 and dual.rank()==9 and dual*psi==0
    assert psi*kernels.apply_map(lambda v:v**5).transpose()==0
    # Independently compute ordinary function trace in the exact algebra
    # with two INDETERMINATE right sides, so vanishing is not a fiber test.
    pr=PolynomialRing(k,["f0","f1"]); f0,f1=pr.gens()
    indices=list(itertools.product(range(5),repeat=2))
    positions={ab:i for i,ab in enumerate(indices)}
    def reduce_terms(terms):
        terms=dict(terms)
        while any(max(ab)>=5 for ab in terms):
            ab=max((ab for ab in terms if max(ab)>=5),key=lambda ij:(sum(ij),ij))
            val=terms.pop(ab)
            if not val: continue
            j=0 if ab[0]>=5 else 1
            base=(ab[0]-5*(j==0),ab[1]-5*(j==1))
            terms[base]=terms.get(base,pr(0))+val*[f0,f1][j]
            for ell in range(2):
                dest=(base[0]+(ell==0),base[1]+(ell==1))
                terms[dest]=terms.get(dest,pr(0))+val*hh[j,ell]
        return terms
    trace_values=[]
    for ij in indices:
        value=sum(reduce_terms({(ij[0]+ab[0],ij[1]+ab[1]):pr(1)}).get(ab,pr(0)) for ab in indices)
        assert value== (hh.det() if ij==(4,4) else 0)
        trace_values.append(str(value))
    # Exact original quotient w=w1+t*w2, on H1(Tangent).
    embed=matrix(k,75,15)
    for j in range(5):
        for i in range(j+1):
            for exponent in range(3):
                embed[3*positions[i,j-i]+exponent,3*j+exponent]=binomial(j,i)*t**(j-i)
    psi5=mat(c["hodge_matrix"])
    assert psi*embed.apply_map(lambda v:v**5)==embed*psi5
    induced=dual*embed
    rank=induced.rank()
    obstruction=induced*vec(cyc["rho4_coordinates"])
    assert rank==1 and obstruction!=0
    # Constancy in the cyclic quotient means the entire embedded repair
    # plane has the same nonzero rank25 obstruction: induced is a multiple
    # of its first dual row, which was proved constant geometrically.
    trace5=mat(c["obstruction_dual_rows"])[0]
    pivot=next(i for i,v in enumerate(trace5) if v)
    assert all(row==row[pivot]/trace5[pivot]*trace5 for row in induced.rows())
    offset=embed*vec(c["primary_repair"])-vec(a["primary_repair"])
    assert psi*offset.apply_map(lambda v:v**5)==0
    origin=kernels.transpose().solve_right(offset)
    plane_dirs=[kernels.transpose().solve_right(embed*vec(c[name])) for name in ["kernel_d","kernel_b"]]
    assert matrix(k,plane_dirs).rank()==2
    # A genuine danger absent from the cyclic calculation: a top-degree
    # kernel representative can have a trace-visible square. This is a
    # function-algebra test, NOT an assertion about its Hodge primitive.
    lz=LaurentPolynomialRing(k,"z"); z=lz.gen()
    squares=[]
    for row in kernels:
        tops={ab:sum(row[3*positions[ab]+i]*z**ex for i,ex in enumerate([-3,-1,1]))
              for ab in indices if sum(ab)==4}
        coefficient=sum(v*tops.get((4-ab[0],4-ab[1]),lz(0)) for ab,v in tops.items())
        squares.append(str(hh.det()*coefficient))
    # Frobenius-semilinear kernel coordinates are returned as actual
    # tangent coefficients, so parameter Frobenius must be retained.
    result={"status":"PASS exact trace, cyclic pullback, primary spaces, and two precisions",
            "input_sha256":{path:hashlib.sha256(raw).hexdigest() for path,raw in contents.items()},
            "trace_values":trace_values,"cokernel_pullback_rank":int(rank),
            "embedded_cyclic_fourth_obstruction":[enc(v) for v in obstruction],
            "embedded_cyclic_plane_origin":[enc(v) for v in origin],
            "embedded_cyclic_plane_directions":[[enc(v) for v in row] for row in plane_dirs],
            "kernel_top_degree_square_traces":squares,
            "at_least_one_trace_visible_kernel_square":any(value!="0" for value in squares),
            "scope":"All-points exclusion ONLY of embedded cyclic repair plane; rank25 full W4 locus remains uncomputed."}
    if args.output:args.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({name:result[name] for name in ["status","cokernel_pullback_rank","embedded_cyclic_fourth_obstruction","kernel_top_degree_square_traces"]},indent=2))


if __name__=="__main__":main()
