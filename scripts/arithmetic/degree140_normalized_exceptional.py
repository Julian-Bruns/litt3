#!/usr/bin/env python3
"""Remove cube-root coefficient extensions in the exceptional degree140 chart.

Write w^3=q, h=wH, y=wY, mu=lambda/w. Then H_i(x,wY)/w and
the normalized residual lie over K(H). The curve becomes Y^3=P/q,
the parameter polynomial becomes q*t, and R_new=q^13 R_old(w*mu).
This driver proves full two-parameter exclusions only when every ensuing
resultant and finite-exception certificate succeeds. H is treated over K
or its quadratic extension, as selected by --quadratic-field.
"""
import argparse
import json
from pathlib import Path
import subprocess
import sys
import time


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument('workspace', type=Path)
    ap.add_argument('--case', type=int, required=True)
    ap.add_argument('--prepare-only', action='store_true')
    ap.add_argument('--quadratic-field', action='store_true',
                    help='Use K[b]/(b^2=alpha); Frobenius supplies the conjugate H branch.')
    args = ap.parse_args()
    work = args.workspace.resolve()
    if 'litt3-computation-data' not in work.parts:
        raise ValueError('Evidence must remain in the computation-data tree.')
    sys.path.insert(0, str(work/'src'))
    import ff
    if args.quadratic_field:
        from degree140_quadratic_field import install
        base=install(ff)
    import reconstruct as rc
    from laurent import LP
    from series import Hpolys
    from extract_parametric import extract
    from square_slice import slice_certificate
    import verify_original as vo
    add, mul, neg, inv, div, powf = ff.add, ff.mul, ff.neg, ff.inv, ff.div, ff.powf
    cases=json.loads((work/'data/spaces.json').read_text())['cases']
    charts=json.loads((work/'data/charts.json').read_text())['cases']
    exs=json.loads((work/'data/exceptional.json').read_text())['cases']
    bc=json.loads((work/'data/boundary_series.json').read_text())['cases']
    i=args.case; case=cases[i]; ex=exs[i-1]
    q=ex['w3']; c0,c1,c2=ex['H_polynomial']; disc=ex['H_discriminant']
    if args.quadratic_field:
        assert ff.LOG[disc]%2==1
        divided=base['mul'](disc,base['inv'](25))
        assert ff.LOG[divided]%2==0
        sq=390625*ff.EXP[ff.LOG[divided]//2]
    else:
        assert ff.LOG[disc]%2==0, 'H requires a quadratic coefficient extension'
        sq=ff.EXP[ff.LOG[disc]//2]
    W,R=LP.var(0),LP.var(1)
    records=[]

    def run(cmd):
        start=time.monotonic();print('$ '+' '.join(map(str,cmd)),flush=True)
        subprocess.run(list(map(str,cmd)),cwd=work,check=True)
        records.append({'command':list(map(str,cmd)),'exit_code':0,
                        'seconds':round(time.monotonic()-start,3)})

    def reduce_w(p):
        out=LP()
        for e,c in p.d.items():
            k,r=divmod(e[0],3)
            out+=LP.mon((r,e[1],e[2],e[3]),mul(c,powf(q,k)))
        return out

    def write_input(path, HH, kronecker=False):
        rows=[Pn,rc.Q,tn,[neg(case['root']),1]]
        for j in range(2,6):
            for ell in range(3):
                if kronecker:
                    a,b=HH[j][ell]
                    p=a+[0]*(1024-len(a))+b
                else:p=HH[j][ell]
                rows.append(ff.trim(p))
        path.write_text('\n'.join(' '.join(map(str,[len(p)]+p)) for p in rows)+'\n')

    Pn=ff.pscale(rc.P,inv(q));tn=ff.pscale(rc.t,q)
    for sign in ((0,) if args.quadratic_field else (0,1)):
        H=div(add(neg(c1),sq if sign==0 else neg(sq)),mul(2,c2))
        assert ff.peval([c0,c1,c2],H)==0 and H
        cc=ff.peval(ex['F6_constant'],H)
        slope=ff.peval(ex['F6_slope_div_w'],H);assert slope
        uu=(R-LP(cc))/(W*slope)
        ss=LP.load(charts[i]['exceptional']['s']).subs({0:W*H,1:W,3:uu})
        repl={0:W*H,1:W,2:ss,3:uu}
        assert not reduce_w(LP.load(bc[i]['F']['4']).subs(repl))
        assert not reduce_w(LP.load(bc[i]['F']['5']).subs(repl))
        assert reduce_w(LP.load(bc[i]['F']['6']).subs(repl))==R
        hp=Hpolys(case); HH={j:[] for j in range(2,6)}
        for j in range(2,6):
            for ell,pp in enumerate(hp[j]):
                a=[];b=[]
                for p in pp:
                    p=reduce_w(p.subs(repl)*(W**(ell-1)))
                    assert all(e[0]==e[2]==e[3]==0 and e[1] in (0,1) for e in p.d)
                    a.append(p.d.get((0,0,0,0),0));b.append(p.d.get((0,1,0,0),0))
                HH[j].append([ff.trim(a),ff.trim(b)])
        name=f'normalized_exceptional_{i}_{sign}'
        meta={'index':i,'root':case['root'],'sign':sign,'q':q,'H':H,
              'P_new':Pn,'t_new':tn,'H_coefficients_affine_R':HH,
              'variables':'R=F6; mu=lambda/w; w^3=q; y=wY',
              'residual_identity':'R_new(x,mu,R)=q^13 R_old(x,w*mu,R)',
              'F4_F5_zero_F6_R_and_cube_root_elimination':'exact Laurent identities verified'}
        (work/'data'/f'{name}_metadata.json').write_text(json.dumps(meta,indent=2)+'\n')
        write_input(work/'data'/f'{name}.txt',HH,True)
        run([work/'src/residual',work/'data',work/'data'/f'{name}.txt',work/'data'/f'{name}.json'])
        extract(name)
        par=json.loads((work/'data'/f'{name}.json').read_text())
        assert par['lambda_coefficients'][0][3*1024+140] == mul(powf(q,16),powf(mul(3,mul(powf(H,3),powf(rc.epsilon,8))),3))
        old=work/'data'/f'exceptional_param_{i}_{sign}.json'
        if old.exists() and ff.LOG[q]%3==0:
            w=ff.EXP[ff.LOG[q]//3]; oldr=json.loads(old.read_text())['lambda_coefficients']
            assert par['lambda_coefficients']==[ff.pscale(p,mul(powf(q,13),powf(w,l))) for l,p in enumerate(oldr)]
            print('Exact full-polynomial normalization cross-check passed.',flush=True)
        if args.prepare_only:continue
        prefix=work/'data'/f'normalized_values_{i}_{sign}'
        run([work/'src/parametric_eval',work/'data',work/'data'/f'{name}_coeffs.txt',48828,prefix])
        certpath=work/'certificates'/f'normalized_branch_{i}_{sign}.json'
        run([work/'src/interpolate',work/'data',prefix.with_suffix('.bin'),48828,384425,certpath])
        cert=json.loads(certpath.read_text());g=cert['cofactor_gcd']
        text=[f"{cert['N']} {cert['omega']}"]
        for j in range(3):
            for x in (cert['resultants'][j],cert['r_valuations'][j],cert['cofactor_bezout_coefficients'][j]):
                text.append(str(x) if isinstance(x,int) else ' '.join(map(str,[len(x)]+x)))
        text.append(' '.join(map(str,[len(g)]+g)))
        check=work/'data'/f'{name}_big_check.txt';check.write_text('\n'.join(text)+'\n')
        run([work/'src/verify_big',work/'data',check,prefix.with_suffix('.bin')])
        assert len(g)==16 and g[-1]==1 and g[0] and not any(g[1:15]), 'Unclosed gcd shape'
        rad=[powf(g[0],5**(15 if args.quadratic_field else 7)),0,0,1]
        assert ff.ppow(rad,5)==g
        target=neg(rad[0])
        if args.quadratic_field:
            m=(390625**2-1)//3
            assert m%3 and powf(target,m)==1, 'Finite exceptions require a further coefficient extension'
            r0=powf(target,pow(3,-1,m))
        else:
            assert ff.LOG[target]%3==0, 'Finite exceptions require a coefficient extension'
            r0=ff.EXP[ff.LOG[target]//3]
        zeta=ff.EXP[390624//3]
        roots=[mul(r0,powf(zeta,j)) for j in range(3)]
        prod=[1]
        for rr in roots:prod=ff.pmul(prod,[neg(rr),1])
        assert prod==rad and len(set(roots))==3 and all(roots)
        finite=[]
        for j,rr in enumerate(roots):
            hs={k:[ff.padd(a,ff.pscale(b,rr)) for a,b in HH[k]] for k in range(2,6)}
            fn=f'{name}_finite_{j}'
            write_input(work/'data'/f'{fn}.txt',hs)
            run([work/'src/residual',work/'data',work/'data'/f'{fn}.txt',work/'data'/f'{fn}.json'])
            direct=json.loads((work/'data'/f'{fn}.json').read_text())
            for lam,p in enumerate(par['lambda_coefficients']):
                specialized=[0]*141
                for idx,c in enumerate(p):
                    if c:
                        power,x=divmod(idx,1024)
                        specialized[x]=add(specialized[x],mul(c,powf(rr,power)))
                assert ff.trim(specialized)==direct['lambda_coefficients'][lam]
            sc=slice_certificate(direct['lambda_coefficients'],verbose=False)
            assert sc['excludes_all_nonzero_lambda']
            (work/'certificates'/f'{fn}_bezout.json').write_text(json.dumps(sc,indent=2)+'\n')
            # The independent Sylvester checker evaluates this rescaled cubic.
            if args.quadratic_field:
                count=quadratic_sylvester_checks(ff,hs,Pn,rc.Q,tn,[neg(case['root']),1],direct)
            else:
                saved=(vo.P,vo.t);vo.P,vo.t=Pn,tn
                try:count=vo.test_resultant(hs,[neg(case['root']),1],direct)
                finally:vo.P,vo.t=saved
            finite.append({'R':rr,'bezout_gcd':sc['gcd'],'sylvester_checks':count})
            print('Finite exception excluded over the algebraic closure:',rr,flush=True)
        closure={'status':'complete_two_parameter_exclusion', 'index':i,'sign':sign,
                 'root':case['root'],'q':q,'H':H,'radical':rad,'finite':finite,
                 'geometric_components':6 if args.quadratic_field else 3,
                 'coefficient_extensions':'Cube root eliminated. In quadratic mode the 5^8-Frobenius conjugate supplies the other H-root.',
                 'quadratic_field':args.quadratic_field}
        (work/'certificates'/f'normalized_closure_{i}_{sign}.json').write_text(json.dumps(closure,indent=2)+'\n')
    if not args.prepare_only:
        (work/'certificates'/f'normalized_case_{i}_run.json').write_text(json.dumps({'status':'PASS','geometric_components':6,'commands':records},indent=2)+'\n')
        print('PASS: all six geometric exceptional components for this root excluded.',flush=True)


def quadratic_sylvester_checks(ff,H,P,Q,t,v,data):
    """Direct 12x12 determinants, independent of the resultant shortcut."""
    add,mul,neg,div,powf=ff.add,ff.mul,ff.neg,ff.div,ff.powf
    def curve_eval(a,x,y):return ff.sumf(mul(ff.peval(p,x),powf(y,j)) for j,p in enumerate(a))
    def det(M):
        z=1;M=[row[:] for row in M]
        for i in range(len(M)):
            nz=next((j for j in range(i,len(M)) if M[j][i]),None)
            if nz is None:return 0
            if nz!=i:M[i],M[nz]=M[nz],M[i];z=neg(z)
            p=M[i][i];z=mul(z,p)
            for j in range(i+1,len(M)):
                if M[j][i]:
                    s=div(M[j][i],p)
                    for k in range(i,len(M)):M[j][k]=ff.sub(M[j][k],mul(s,M[i][k]))
        return z
    count=0;zeta=ff.EXP[390624//3]
    for x in range(1,200):
        px=ff.peval(P,x)
        assert px<390625
        if not px or ff.LOG[px]%3 or not ff.peval(t,x) or not ff.peval(v,x):continue
        y=ff.EXP[ff.LOG[px]//3]
        for lam in (0,1,7):
            product=1
            for twist in range(3):
                yy=mul(y,powf(zeta,twist));hh={i:curve_eval(H[i],x,yy) for i in range(2,6)}
                q=ff.peval(Q,x);vv=ff.peval(v,x);q0=mul(powf(ff.peval(t,x),3),powf(yy,10))
                f=[0]*11;f[10]=mul(lam,vv);f[8]=hh[2];f[7]=hh[3];f[6]=hh[4]
                f[5]=add(hh[5],mul(mul(2,lam),mul(vv,q)));f[3]=mul(q,hh[2]);f[2]=mul(q,hh[3]);f[1]=mul(q,hh[4]);f[0]=add(add(mul(q,hh[5]),q0),mul(lam,mul(vv,mul(q,q))))
                g=[hh[4],mul(2,hh[3]),mul(3,hh[2])]
                M=[[0]*i+f[::-1]+[0]*(1-i) for i in range(2)]
                M += [[0]*i+g[::-1]+[0]*(9-i) for i in range(10)]
                direct=det(M)
                assert direct==ff.sumf(mul(powf(lam,j),curve_eval(data['resultant_coefficients'][j],x,yy)) for j in range(3))
                product=mul(product,direct)
            numerator=mul(ff.sumf(mul(powf(lam,j),ff.peval(p,x)) for j,p in enumerate(data['lambda_coefficients'])),mul(powf(px,40),mul(powf(ff.peval(t,x),15),powf(ff.peval(v,x),3))))
            assert product==numerator
        count+=1
        if count==3:return 27
    raise AssertionError('Not enough independent Sylvester checks')


if __name__=='__main__':main()
