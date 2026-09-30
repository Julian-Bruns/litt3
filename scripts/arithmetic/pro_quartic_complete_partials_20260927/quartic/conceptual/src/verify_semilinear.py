"""Exact small verification cases, not a search for the full-system zero set."""
import json,time
from semilinear_reduction import *
from newton_endpoints import encode
start=time.monotonic();checks=[]
def check_matrix(name,M,expect=None):
    ys,rec=oriented_y(M)
    if expect is not None:assert rec['case']==expect
    a=M[1][0];b=M[1][1];c=-M[0][0];d=-M[0][1]
    assert all((a*y+b)*rho(y)+c*y+d==K.zero for y in ys)
    assert all(a*rho(y)+c for y in ys)
    checks.append({'name':name,'case':rec['case'],'projective_points':'all' if rec['all_projective_points'] else len(rec['points']),
                   'oriented_affine_points':len(ys)})
    return ys,rec
check_matrix('zero',[[K.zero]*2 for _ in range(2)],'rank_zero')
check_matrix('rank_one_kernel_finite',[[K.zero,K.zero],[K.one,K.one]],'rank_one')
check_matrix('rank_one_no_oriented',[[K.zero,K.one],[K.zero,K.zero]],'rank_one')
check_matrix('rank_one_second_pattern',[[K.one,K.one],[K.zero,K.zero]],'rank_one')
check_matrix('identity',identity(),'invertible_scalar_norm')
check_matrix('split_constant',[[K.one,K.zero],[K.zero,K(2)]],'invertible_nonscalar_norm')
ns=next(constant(i) for i in range(1,25) if constant(i)**12==K(4))
ys,_=check_matrix('nonsplit_constant',[[K.zero,ns],[K.one,K.zero]],'invertible_nonscalar_norm');assert not ys
C=[[zeta+K.one,zeta**2],[K.one,zeta**3+K(2)]]
assert matdet(C)
M=matmul(twist(C),matinv(C))
ys,rec=check_matrix('nonconstant_descent',M,'invertible_scalar_norm')
expected=[normalize_point(matvec(C,[constant(i),K.one])) for i in range(25)]+[normalize_point(matvec(C,[K.one,K.zero]))]
assert set(expected)==set(rec['points'])
# Actual Q, selected u; all results remain subsystem tests only.
actual=[[(0,0),(1,4),(2,8),(3,13)],[(0,0),(0,0),(1,2),(3,7)],
        [(0,0),(1,0),(2,9),(3,23)]]
us=[K.zero,K.one,zeta,zeta**2+constant(5)]
subsystem=[];total=0;full=0;rank_polynomial_checks=0;rank_boundary_checks=[]
for labels in actual:
 Q=normalized_endpoint(labels)
 rank=scalar_rank_polynomial(Q)
 assert rank['D'] and Q['U'].c[3] and Q['V'].c[1]
 assert (not rank['s'] and not rank['t']) == (not rank['s'] and not rank['J'])
 if rank['s']:
  special=rank['center']-rank['t']/rank['s']
  Mstar,Wstar=moment_matrix(Q,special)
  assert not matdet(Mstar)
  ystar,record=oriented_y(Mstar)
  assert len(ystar)<=1
  boundary_full=0
  for yy in ystar:
   ss=recover_from_y(Q,special,yy,Wstar)
   assert ss['epsilon'].c[3] and not ss['eq2'].c[3]
   if not ss['eq2'] and not any(ss['H_Newton_residuals']) and not any(ss['H_grid_residuals']):boundary_full+=1
  rank_boundary_checks.append({'Q':labels,'case':record['case'],
                              'oriented_y_count':len(ystar),'full_residual_zero_count':boundary_full})
 for u in us:
  M,W=moment_matrix(Q,u);ys,rec=oriented_y(M)
  h=norm_quartic(Q['U']-scalar(u))
  assert h*matdet(M)==rank['s']*(u-rank['center'])+rank['t']
  rank_polynomial_checks+=1
  passed=0
  for y in ys:
   s=recover_from_y(Q,u,y,W)
   assert s['epsilon'].c[3] and not s['eq2'].c[3]
   total+=1
   if not s['eq2'] and not any(s['H_Newton_residuals']) and not any(s['H_grid_residuals']):passed+=1
  full+=passed
  subsystem.append({'Q':labels,'u':encode(u),'case':rec['case'],
                    'oriented_y_count':len(ys),'all_residuals_zero_count':passed})
# The exact formal positive example independently exercises recovery of H.
q={name:FT.row([constant(i) for i in row]) for name,row in {
 'C':[7,21,23,3],'E':[21,10,15,0],'U':[23,17,24,7],'V':[22,18,3,0]}.items()}
u=constant(9);M,W=moment_matrix(q,u);ys,rec=oriented_y(M);y=constant(24)
assert y in ys
s=recover_from_y(q,u,y,W)
assert not s['eq2'] and s['epsilon']==FT.row([constant(i) for i in [22,19,22,24]])
expected={'C':[8,1,6,10],'E':[6,22,13,0],'U':[18,6,2,18],'V':[5,17,20,0]}
assert all(s['H'][name]==FT.row([constant(i) for i in row]) for name,row in expected.items())
assert any(s['H_Newton_residuals']) and any(s['H_grid_residuals'])
print(json.dumps({'status':'PASS','kind':'implementation corroboration; NO global exclusion',
 'matrix_cases':checks,'actual_endpoint_subsystem_cases':subsystem,
 'affine_rank_polynomial_checks':rank_polynomial_checks,'rank_boundary_cases':rank_boundary_checks,
 'oriented_subsystem_points_replayed':total,'selected_case_full_residual_zeros':full,
 'formal_positive_recovery_checked':True,
 'formal_positive_is_NOT_an_endpoint_witness':True,
 'seconds':time.monotonic()-start},indent=2))
