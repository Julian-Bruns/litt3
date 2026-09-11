#!/usr/bin/env sage-python
"""Direct rational and primary-vector audit; no multiplication-by-five API.

Also identifies the earlier Artin--Schreier coordinate explicitly as
w=y_E*B(s)/d(s), so the two models are compared as covers, not just by
their genera or their isogeny classes.
"""
import argparse
import hashlib
import json
from pathlib import Path
import time
from sage.all import GF, PolynomialRing, matrix, vector


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",required=True)
    args=parser.parse_args()
    started=time.monotonic()
    paths={"model":"Research/computations/neutral5_hyperelliptic_model.json",
           "primary":"Research/computations/neutral5_w4_input.json",
           "covers":"Research/computations/explicit_nonordinary_dihedral5.json"}
    raw={key:Path(path).read_bytes() for key,path in paths.items()}
    data={key:json.loads(value) for key,value in raw.items()}
    covers=data["covers"]; primary=data["primary"]; model=data["model"]
    prime=PolynomialRing(GF(5),"a")
    modulus=prime(covers["field_modulus"])
    assert modulus.is_irreducible() and modulus.degree()==16
    k=GF(5**16,name="a",modulus=modulus)
    decode=lambda cc:k(prime(cc))
    encode=lambda c:[int(k(c).polynomial()[j]) for j in range(16)]
    t=decode(covers["parameter"])
    assert t**4+4*t**3+t**2+4*t+3==0
    R=PolynomialRing(k,"s"); s=R.gen()
    from_small=lambda cc:sum((k(c)*t**j for j,c in enumerate(cc)),k.zero())
    polynomial=lambda name:R([from_small(cc) for cc in model[name]])
    poly_encode=lambda f:[encode(c) for c in R(f)]
    rat_encode=lambda f:{"numerator":poly_encode(f.numerator()),
                          "denominator":poly_encode(f.denominator())}
    N=polynomial("numerator"); denominator=polynomial("denominator")
    d=polynomial("denominator_square_root"); J=polynomial("elliptic_y_numerator")
    S5=polynomial("elliptic_source_polynomial"); curve=polynomial("hyperelliptic_polynomial")
    assert model["field_modulus"]==[3,4,1,4,1]
    assert N.degree()==5 and d.degree()==2 and J.degree()==6
    assert denominator==d**2 and N.gcd(d)==1 and d.gcd(d.derivative())==1
    assert S5==s**3-t**5*s**2+s-t**5 and S5.is_squarefree()
    q=N/denominator
    S=lambda x:(x-2)*(x-3)*(x-t)
    assert S(s)==s**3-t*s**2+s-t
    assert J**2*S5==N**3-t*N**2*d**2+N*d**4-t*d**6
    assert curve==N*(N-d**2)*S5 and curve.degree()==13 and curve.is_squarefree()
    assert d.gcd(curve)==1
    assert (J/d**5)**2*curve==q*(q-1)*S(q)
    H=t**2+2
    assert H and (S(s)**2)[4]==H
    c=q.derivative()*d**3/J
    assert c in [H,-H]
    c=c.numerator()[0]/c.denominator()[0]
    saved_eta=polynomial("eta_numerator")/polynomial("eta_denominator")
    assert saved_eta==c*d**2

    source=covers["covers"][0]
    assert source["pair"]==[0,1]
    assert primary["parameter"]==covers["parameter"]
    assert primary["field_modulus"]==covers["field_modulus"]
    assert primary["AS_scale"]==source["AS_scale"]
    lam=decode(source["AS_scale"])
    assert lam**4*H==1

    # Solve the exact Artin--Schreier identity with w=y_E*(a*s+b)/d.
    # Its four coefficients are initially independent; then explicitly
    # verify that the first two are the fifth powers of the last two.
    terms=[S5**2*s**5,S5**2,-s*d**4,-d**4]
    rhs=lam**5*J*(N-2*t*d**2)
    system=matrix(k,[[term[j] for term in terms] for j in range(12)])
    aa,bb,a,b=system.solve_right(vector(k,[rhs[j] for j in range(12)]))
    assert aa==a**5 and bb==b**5
    B=a*s+b
    assert S5**2*B**5-B*d**4==rhs
    # The inherited infinity coordinate is w_O=w-chi. It has a regular
    # expression at the d-roots and at infinity, with only N-poles left.
    infinity_numerator=B*N-lam*J
    remainder=infinity_numerator% d
    assert remainder==0 and infinity_numerator.degree()<=5
    infinity_reduced=infinity_numerator//d
    assert infinity_reduced.degree()<=3
    # After substitution, w_O=y_E*infinity_reduced/N.

    # Independent base-coordinate conversion, by formal polynomial identity.
    Z=PolynomialRing(k,"z"); z=Z.gen(); a0=t+1
    x=z**2-a0*z**4+(a0**2+a0)*z**6
    assert (x-z**2*(1-a0*x+a0*x**2-a0*x**3+t*x**4))%(z**8)==0
    assert ((x//z**2)*(1+a0*z**2-a0*z**4)-1)%(z**6)==0
    rho_z=vector(k,[1+4*t+2*t**2,1+t+t**3,t+2*t**2+2*t**3])
    rho=vector(k,[rho_z[0],rho_z[1]-a0*rho_z[0],rho_z[2]+a0*rho_z[0]])
    assert rho==vector(k,[decode(cc) for cc in primary["rho_u"]])
    weights=vector(k,[3*(2*t**2+4),3*(t+3),3])
    assert weights.dot_product(rho)==1/(4+4*t)

    psi=matrix(k,[[decode(cc) for cc in row] for row in source["hodge_matrix"]])
    xi=vector(k,30); kernel=vector(k,30)
    kC=vector(k,[1,4,4+t+3*t**2])
    xi[0]=4+4*t+t**3; xi[1]=1+3*t**3; xi[10]=(t+2)*lam**3
    for j in range(3):
        xi[12+j]=lam**2*(2+2*t+4*t**3)*kC[j]
        kernel[j]=kC[j]
    assert len([cc for cc in xi if cc])==6
    assert xi==vector(k,[decode(cc) for cc in primary["particular_displacement"]])
    assert kernel==vector(k,[decode(cc) for cc in primary["kernel_generator"]])
    target=vector(k,list(rho)+[0]*27)
    assert psi*vector(k,[cc**5 for cc in xi])==target
    assert psi*vector(k,[cc**5 for cc in kernel])==0
    assert weights*psi[:3,:3]==0
    assert weights.dot_product(kC)==0
    comp=[3,3,3,2,1,2]
    tau=[(-1)**((comp[j%6]&1)+((comp[j%6]>>1)&1)+j//6) for j in range(30)]
    hyp=[(-1)**((comp[j%6]&1)+1) for j in range(30)]
    plus=[j for j in range(30) if tau[j]==1]
    assert plus==source["quotient_basis"]
    assert len(plus)==15 and sum(hyp[j]==1 for j in plus)==11
    assert all(not cc or (tau[j]==1 and hyp[j]==1)
               for vv in [xi,kernel] for j,cc in enumerate(vv))
    assert psi.matrix_from_rows_and_columns(plus,plus).rank()==14

    # Optional explicit cochain transport to the hyperelliptic model.
    # xi = Y*Fxi(s)*eta_C^(-1), eta_C=c*d^2 ds/Y, so the
    # tangent coefficient in d/ds is curve*Fxi/(c*d^2).
    fxi=J/d**5*(xi[0]/q+xi[1]/q**2)
    fxi+=xi[10]*B/(d*N)
    fxi+=(S5*B**2/d**2)*(J/d**5)*sum(xi[12+j]/q**(j+1) for j in range(3))
    fker=J/d**5*sum(kC[j]/q**(j+1) for j in range(3))
    ds_xi=curve*fxi/(c*d**2)
    ds_kernel=curve*fker/(c*d**2)
    assert not ds_xi or ds_xi.denominator().gcd(N**3*d**20).degree()==ds_xi.denominator().degree()
    small_basis=matrix(GF(5),[encode(t**i) for i in range(4)]).transpose()
    def small_encode(coefficient):
        assert coefficient**625==coefficient
        return [int(cc) for cc in small_basis.solve_right(vector(GF(5),encode(coefficient)))]
    def small_poly_encode(poly):
        return [small_encode(cc) for cc in R(poly)]
    def small_rat_encode(rational):
        return {"numerator":small_poly_encode(rational.numerator()),
                "denominator":small_poly_encode(rational.denominator())}
    result={"status":"PASS direct rational model and primary-family audit",
            "input_sha256":{key:hashlib.sha256(value).hexdigest() for key,value in raw.items()},
            "degree_q":5,"genus":6,"eta_constant":encode(c),
            "AS_coordinate_numerator_B":poly_encode(B),
            "AS_coordinate_B_over_lambda_F625":small_poly_encode(B/lam),
            "AS_infinity_reduced_numerator":poly_encode(infinity_reduced),
            "particular_displacement_support":[j for j,cc in enumerate(xi) if cc],
            "tau_positive_dimension":15,"hyperelliptic_positive_dimension":11,
            "hyperelliptic_ds_coefficient_particular":rat_encode(ds_xi),
            "hyperelliptic_ds_coefficient_kernel":rat_encode(ds_kernel),
            "hyperelliptic_ds_coefficient_particular_F625":small_rat_encode(ds_xi),
            "hyperelliptic_ds_coefficient_kernel_F625":small_rat_encode(ds_kernel),
            "seconds":time.monotonic()-started,
            "scope":"Exact same-cover rational identification and primary semilinear repair; no W4 obstruction."}
    Path(args.output).write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({key:result[key] for key in ["status","degree_q","genus","particular_displacement_support","seconds"]}))
    print("AS coordinate B(s) =",B)
    print("eta constant =",c)
    print("B/lambda, F625 coefficient lists =",result["AS_coordinate_B_over_lambda_F625"])
    print("eta constant, F625 coefficient list =",small_encode(c))


if __name__=="__main__":main()
