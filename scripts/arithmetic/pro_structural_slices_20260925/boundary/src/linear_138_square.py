"""Geometric squarehood checks for every linear-v degree-138 stratum.
No coefficient-field search: the finite parameter algebras come from exact elimination.
"""
from constant_138_square import *
from weighted_elimination import compress
from exceptional_pivot import run as check_exceptional
from factor import squarefree_factors,is_irreducible
from sympy.polys.rings import ring
from sympy.polys.groebnertools import groebner
from sympy.polys.fglmtools import matrix_fglm
from sympy.polys.orderings import lex
from symfield import K
import argparse,contextlib,os


def prepare(index):
    j=json.loads((ROOT/'data'/f'degree_strata_{index}.json').read_text())
    fs=[compress(deserialize_poly(f),1)[0] for f in j['reduced_F'][:2]]
    dd=compress(deserialize_poly(j['denominator']),1)[0]
    T,u,l,s=ring('u,l,s',K,order='grevlex')
    inp=[T.from_dict({(0,e[1],e[0]):c for e,c in f.items()}) for f in fs]
    den=T.from_dict({(0,e[1],e[0]):c for e,c in dd.items()})
    inp+=[u*l*s*den-1]
    G=groebner(inp,T);H=matrix_fglm(G,T,lex)
    assert len(H)==3
    up=next(f for f in H if f.degree(0)==1);lp=next(f for f in H if f.degree(1)==1 and f.degree(0)==0);gp=next(f for f in H if f.degree(0)==f.degree(1)==0)
    assert up[(1,0,0)]==lp[(0,1,0)]==1
    assert all(e[0]==e[1]==0 or e==(1,0,0) for e in up)
    assert all(e[0]==e[1]==0 or e==(0,1,0) for e in lp)
    gc=[0]*(gp.degree(2)+1);lc=[0]*(lp.degree(2)+1);uc=[0]*(up.degree(2)+1)
    for e,c in gp.items():gc[e[2]]=c.v
    for e,c in lp.items():
        if e!=(0,1,0):lc[e[2]]=neg(c.v)
    for e,c in up.items():
        if e!=(1,0,0):uc[e[2]]=neg(c.v)
    g=FP(gc).monic();lam=FP(lc);uu=FP(uc)
    assert g.deg==49 and g.gcd(g.derivative())==1
    fac=squarefree_factors(g);product=FP(1)
    for f in fac:assert is_irreducible(f);product*=f
    assert product==g
    print('space',index,'shape dimension',g.deg,'factor degrees',[f.deg for f in fac],flush=True)
    exc=check_exceptional(index,7)
    # Read the exact exceptional-branch output rather than infer it from generic elimination.
    excdata=json.loads((ROOT/'data'/f'exceptional_pivot_{index}.json').read_text())
    assert excdata['saturated_unit']
    shape={'space_index':index,'variables':['u','l','s'],'inputs':[[[list(e),c.v] for e,c in f.items()] for f in inp],'grevlex':[[[list(e),c.v] for e,c in f.items()] for f in G],'lex':[[[list(e),c.v] for e,c in f.items()] for f in H],'parameter_polynomial':list(g.c),'lambda_polynomial':list(lam.c),'inverse_open_polynomial':list(uu.c),'factors':[list(f.c) for f in fac]}
    (ROOT/'data'/f'linear_138_shape_{index}.json').write_text(json.dumps(shape,indent=2)+'\n')
    return shape


def build_linear_context(index,shape,mod):
    setup(mod);sv=E([0,1]);Sinv=sv.inverse();lam=eval_fp_at(shape['lambda_polynomial'],sv)
    j=json.loads((ROOT/'data'/f'degree_strata_{index}.json').read_text())
    den=deserialize_poly(j['denominator']);dd=weighted_eval(den,sv,lam,weight=1,totalweight=0)
    pbar=weighted_eval(deserialize_poly(j['p_numerator']),sv,lam,weight=1)/dd
    qbar=weighted_eval(deserialize_poly(j['q_numerator']),sv,lam,weight=1)/dd
    sp=json.loads((ROOT/'data'/'linear_spaces.json').read_text())['spaces'][index]
    from residual import boundary_constants
    ca,cd=boundary_constants(sp)
    ep=-E(fdiv(2,epsilon))*(E(ca)*lam+E(cd))-E(fdiv(mul(eta,epsilon),mul(24,2)))*Sinv
    fp=-E(inv(epsilon))-E(mul(fdiv(8,24),power(fdiv(2,epsilon),5)))*sv
    right,ker,_=adapted_basis(sp);No,_,_=deserialize(sp['origin']);cols=[]
    v=FP(sp['v']);assert No[5]==CR(v*Q)
    for col in right+ker:
        Ns,_,_=combine(sp,col);cols.append([nn-no for nn,no in zip(Ns,No)])
    Hs=[]
    for i in range(2,6):
        assert not cols[0][i][0] and not cols[0][i][2]
        for jj in [1,2]:assert not cols[jj][i][1] and not cols[jj][i][2]
        for jj in [3,4,5,6]:assert not cols[jj][i][0] and not cols[jj][i][1]
        c2=EP()
        for val,jj in zip([ep,fp,pbar,qbar],[3,4,5,6]):c2+=EP(cols[jj][i][2])*EP(val)
        Hs.append(ER([EP(cols[2][i][0])+EP(cols[1][i][0])*EP(lam),EP(cols[0][i][1]),c2*EP(sv)]))
    ER.curveP=EP(P)*EP(Sinv)
    return sv,lam,pbar,qbar,Hs,v


def check_factor(index,shape,jj,mod):
    start=time.monotonic();sv,lam,pbar,qbar,Hs,v=build_linear_context(index,shape,mod)
    print('space',index,'factor',jj,'degree',len(mod)-1,'start',flush=True)
    rr=inverse_kappa_resultant(Hs,v)
    nm=norm_quadratic(rr);den=EP(P**40*t**15*v**3);rc=[z//den for z in nm]
    print('space',index,'factor',jj,'residual degrees',[z.deg for z in rc],'seconds',round(time.monotonic()-start,3),flush=True)
    lc,J,errors=square_equations(rc,138)
    gcd,S,T=errors[0].xgcd(errors[1]);assert errors[0]*S+errors[1]*T==gcd
    print('space',index,'factor',jj,'gcd degree',gcd.deg,'seconds',round(time.monotonic()-start,3),flush=True)
    excluded=gcd==1 or all(not gcd[i] for i in range(gcd.deg))
    data={'space_index':index,'factor_index':jj,'status':'geometrically excluded' if excluded else 'NOT EXCLUDED','parameter_modulus':mod,'s_element':list(sv.c),'lambda':list(lam.c),'pbar':list(pbar.c),'qbar':list(qbar.c),'Hbar':[h.data() for h in Hs],'inverse_kappa_R_coefficients':[z.data() for z in rc],'leading_coefficient':list(lc.c),'monic_root_coefficients':[z.data() for z in J],'first_two_errors':[z.data() for z in errors[:2]],'gcd':gcd.data(),'bezout':[S.data(),T.data()]}
    (ROOT/'data'/f'linear_138_square_{index}_{jj}.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
    assert excluded,('square locus not excluded by these two equations',index,jj)
    return {'factor_index':jj,'degree':len(mod)-1,'excluded':excluded,'gcd_degree':gcd.deg}


if __name__=='__main__':
    a=argparse.ArgumentParser();a.add_argument('--index',type=int,required=True)
    a.add_argument('--prepare',action='store_true');a.add_argument('--factor',type=int)
    args=a.parse_args()
    if args.prepare:prepare(args.index)
    elif args.factor is not None:
        shape=json.loads((ROOT/'data'/f'linear_138_shape_{args.index}.json').read_text())
        check_factor(args.index,shape,args.factor,shape['factors'][args.factor])
    else:
        # A new process is used for every coefficient-algebra context.
        import subprocess,sys
        shape=prepare(args.index)
        for jj in range(len(shape['factors'])):
            subprocess.run([sys.executable,__file__,'--index',str(args.index),'--factor',str(jj)],check=True)
