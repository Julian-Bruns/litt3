"""Read-only verification of the linear, infinity, and elimination certificates.
No Groebner-basis computation is needed to check the unit-ideal certificates:
the stored multipliers are multiplied out as polynomial identities.
"""
from formula_certificate import derive
from linear_family import *
from residual import boundary_constants,adapted_basis,boundary_point,boundary_uv
from infinity_series import symbolic_series,deserialize_poly,R,serialize as spdata,winv
from degree_strata import substitute,coeff_var,no_pq
from linear_degree_strata import substitute_fraction
from constant_deep_boundary import clear_w,h_parts
from weighted_elimination import compress,S,data2
from elimination_certificates import coeff_l,shifted_cols,matvec,evaluate_sl
from exceptional_pivot import specialize_weighted,T as ET
from symfield import K,FE
import platform,sympy

def load(name):return json.loads((ROOT/'data'/name).read_text())
def poly2(d):return S.from_dict({tuple(e):FE.code(c) for e,c in d})
def mult_powers_w(n):return R.from_dict({(n,0,0,0):K.one})

def main():
    print('Python',platform.python_version(),'SymPy',sympy.__version__,flush=True)
    assert Q.derivative()==P*A**2
    assert not (Q-B**5)%(P**2) and not (Q-L**5)%(A**3)
    assert P.gcd(P.derivative())==A.gcd(A.derivative())==P.gcd(A)==1
    assert H.gcd(t)==t.gcd(t.derivative())==1
    assert A==(x-alpha)*t*13 and epsilon and eta
    for name,out in zip(['resultant_formula.json','resultant_inverse_kappa.json'],derive()):assert load(name)==out
    print('Field, contact identities, squarefreeness and universal resultant identities PASS',flush=True)
    spaces=load('linear_spaces.json')['spaces'];allF=[]
    assert len(spaces)==11 and [s['root'] for s in spaces[1:]]==[a for a in range(ORDER) if P.eval(a)==0]
    for index,s in enumerate(spaces):
        v=FP(s['v']);root=s['root'];u,basis,free,_=solve_affine(v,root)
        assert u==s['raw_origin'] and basis==s['raw_basis'] and free==s['free_indices'] and len(basis)==7
        No,ko,D0=deserialize(s['origin']);assert No[5]==CR(v*Q) and not ko and not any(No[2:5]) and not D0
        assert top_coordinates(No,ko,D0,root)==s['top_origin']
        assert serialize(*make_raw(v,u))==s['origin'];all_constraints(No,ko,D0,v,root)
        image_columns=[]
        for jb,(b,bd) in enumerate(zip(basis,s['basis'])):
            Nb,kb,Db=make_raw(FP(),b);assert serialize(Nb,kb,Db)==bd
            all_constraints(Nb,kb,Db,FP(),root,True)
            assert top_coordinates(Nb,kb,Db,root)==s['top_columns'][jb]
            image_columns.append([kb]+[Nb[i][b][a] for i in range(2,6) for b in range(3) for a in range(24)])
        _,image_pivots=rref(list(map(list,zip(*image_columns))));assert len(image_pivots)==7
        ca,cd=boundary_constants(s);assert cd==219628 and ca==(0 if index==0 else 303493)
        right,ker,_=adapted_basis(s);assert len(right)==5 and len(ker)==2
        N,k,D,_=boundary_point(s,1,1,1);all_constraints(N,k,D,v,root)
        assert D.pole()==(12 if index==0 else 13) and boundary_uv(N,k,D,root)==(0,0)
        j=load(f'infinity_{index}.json');F,G,rho=symbolic_series(s,len(j['F']),False)
        assert [spdata(f) for f in F]==j['F'] and [spdata(f) for f in G]==j['G'] and [spdata(f) for f in rho]==j['rho']
        assert all(not f for f in F[:4]) and all(not f for f in G[:9]);allF.append(F)
        print('Space',index,'complete basis, open graph and symbolic critical-root expansion PASS',flush=True)
    j=load('degree_strata_0.json');F=allF[0]
    pv=deserialize_poly(j['p_solution']);qv=deserialize_poly(j['q_solution'])
    det=coeff_var(F[4],2)*coeff_var(F[5],3)-coeff_var(F[5],2)*coeff_var(F[4],3)
    assert det==mult_powers_w(2)*R.ground_new(FE.code(299619)) and spdata(det)==j['determinant']
    assert not substitute(F[4],pv,qv) and not substitute(F[5],pv,qv)
    red=[substitute(f,pv,qv) for f in F[6:]];assert list(map(spdata,red))==j['reduced_F']
    d=load('constant_deep_boundary.json');B1,A1=h_parts(clear_w(red[0]));assert list(A1.c)==d['A'] and list(B1.c)==d['B']
    bez=list(map(FP,d['pivot_bezout']));assert A1*bez[0]+B1*bez[1]==1
    eliminants=[]
    for f in red[1:]:
        parts=h_parts(clear_w(f));n=len(parts)-1;z=FP()
        for i,c in enumerate(parts):z+=c*(-B1)**i*A1**(n-i)
        eliminants.append(z)
    assert [list(f.c) for f in eliminants]==d['eliminants']
    a,b=map(FP,d['bezout78']);assert eliminants[0]*a+eliminants[1]*b==x**4
    assert FP(d['gcd78'])==x**4
    gw=eliminants[0]//x**4;assert gw.gcd(gw.derivative())==1
    assert gw.gcd(A1)==gw.gcd(B1)==gw.gcd(x)==1
    print('Constant-v degree floor: global pivot and w^4 Bezout identities PASS',flush=True)
    for index in range(1,11):
        j=load(f'degree_strata_{index}.json');F=allF[index]
        den=deserialize_poly(j['denominator']);pv=deserialize_poly(j['p_numerator']);qv=deserialize_poly(j['q_numerator'])
        det=coeff_var(F[4],2)*coeff_var(F[5],3)-coeff_var(F[5],2)*coeff_var(F[4],3)
        assert det==mult_powers_w(2)*den and spdata(det)==j['determinant']
        assert all(e[2]==e[3]==0 for pp in [pv,qv,den] for e in pp)
        assert not substitute_fraction(F[4],pv,qv,den)[0] and not substitute_fraction(F[5],pv,qv,den)[0]
        red=list(map(deserialize_poly,j['reduced_F']))
        for f,r,meta in zip(F[6:],red,j['clearing_and_stripping']):
            z,n=substitute_fraction(f,pv,qv,den);assert n==meta[0]
            assert z==r*mult_powers_w(meta[1])*den**meta[2]
        cc=load(f'linear_elimination_certificate_{index}.json');shape=load(f'linear_138_shape_{index}.json')
        fs=[compress(f,1)[0] for f in red[:3]]
        assert [data2(f) for f in fs]==[cc['F6'],cc['F7'],cc['F8']]
        df=coeff_l(compress(den,1)[0])[0];assert list(df.c)==cc['D'] and df.deg==1 and df[0] and df[1]
        f,g=map(coeff_l,fs[:2]);n,m=len(f)-1,len(g)-1
        M=shifted_cols(f,g,m,n);res=FP(cc['resultant']);bv=list(map(FP,cc['resultant_bezout']))
        assert matvec(M,bv)==[res]+[FP()]*(n+m-1)
        gg=FP(cc['g']);lv=FP(cc['lambda']);fact=cc['resultant_factorization'];assert gg.deg==49
        assert fact['constant'] and res==(x**fact['S_power']*df**fact['D_power']*gg).scale(fact['constant'])
        M1=shifted_cols(f,g,m-1,n-1);bv1=list(map(FP,cc['linear_bezout']));lin=matvec(M1,bv1)
        assert [list(z.c) for z in lin[:2]]==cc['linear_subresultant'] and not any(lin[2:])
        a,b=map(FP,cc['linear_pivot_bezout']);assert lin[1]*a+gg*b==1
        assert (lin[1]*lv+lin[0])%gg==0
        assert evaluate_sl(fs[0],lv,gg)==evaluate_sl(fs[1],lv,gg)==0
        fv=evaluate_sl(fs[2],lv,gg);assert list(fv.c)==cc['F8_mod_g']
        a,b=map(FP,cc['F8_bezout']);assert fv*a+gg*b==1
        assert gg.gcd(gg.derivative())==gg.gcd(x*df*lv)==1
        assert list(gg.c)==shape['parameter_polynomial'] and list(lv.c)==shape['lambda_polynomial']
        prod=FP(1)
        for ff in shape['factors']:prod*=FP(ff)
        assert prod==gg
        ex=load(f'exceptional_bezout_{index}.json');sv=ex['s_value'];assert df.eval(sv)==0 and sv
        ef=[specialize_weighted(f,sv) for f in F[4:8]]
        ed=[[[list(e),c.v] for e,c in sorted(f.items())] for f in ef];assert ed==ex['inputs']
        mult=[ET.from_dict({tuple(e):FE.code(c) for e,c in f}) for f in ex['multipliers']]
        assert sum((a*b for a,b in zip(ef,mult)),ET.zero)==ET.one
        print('Space',index,'global resultant/linear-subresultant, F8 and exceptional-branch Bezout identities PASS',flush=True)
    print('ALL LINEAR, INFINITY AND ALGEBRAIC-CLOSURE ELIMINATION CERTIFICATES PASSED',flush=True)

if __name__=='__main__':main()
