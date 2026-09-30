// Exact necessary conditions for n=7, comparison pole degree6, g(S)=1.
// Reuse the unchanged, independently verified exact compositum arithmetic.
// Geometric coverage is proved in degree_seven_genus_one_comparison_exclusion.
// Exceptional denominator cases are retained and must all be absent.
#define main degree6_retained_verifier_main
#include "pro_degree6_actual_return_20260924/degree6/src/genus0_boundary.cpp"
#undef main
#include <map>
#include <string>

static E power(E a,unsigned n) {
 E r=one(); while(n){if(n&1)r=mul(r,a);a=sq(a);n>>=1;} return r;
}
static E inv(const E&a) {
 if(a.zero())throw std::runtime_error("division by zero");
 E r=one(),a4=power(a,4);
 for(int i=0;i<55;i++)r=mul(power(r,5),a4);
 r=mul(power(r,5),power(a,3));
 if(!(mul(a,r)==one()))throw std::runtime_error("inverse check failed");
 return r;
}
struct Case {int j,k,l,u,t,v,r;};
struct Outcome {std::string stage;E witness;};
static E average(const E&a,const E&b){return sc(add(a,b),3);}
static Outcome test_case_slow(const Case&x){
 int vm=(x.v+x.t)%29;
 E a=sub(AR[0],AR[x.j]),b=sub(AR[x.k],AR[x.l]);
 E f=sub(HP[0][0],HP[x.j][x.u]),c=sub(FP[0][0],FP[x.j][x.u]);
 E d=sub(GP[0][0],GP[x.j][x.u]),e=sub(JP[0][0],JP[x.j][x.u]);
 E h=sub(HP[x.k][x.v],HP[x.l][vm]),ii=sub(FP[x.k][x.v],FP[x.l][vm]);
 E jj=sub(GP[x.k][x.v],GP[x.l][vm]),kk=sub(JP[x.k][x.v],JP[x.l][vm]);
 E dp=average(GP[0][0],GP[x.j][x.u]),ep=average(JP[0][0],JP[x.j][x.u]);
 E jp=average(GP[x.k][x.v],GP[x.l][vm]),kp=average(JP[x.k][x.v],JP[x.l][vm]);
 E rr{};for(int i=0;i<7;i++)rr.c[4*i]=ZP[x.r][i];
 E r2=sq(rr),r7=power(rr,7),r8=mul(r7,rr);
 E Del=sub(mul(h,ii),mul(b,jj));
 if(Del.zero())throw std::runtime_error("verified Delta unexpectedly zero");
 E T0=sub(mul(h,d),mul(b,c)),T1=sub(mul(a,b),mul(h,f));
 E U0=sub(mul(jj,d),mul(ii,c)),U1=sub(mul(ii,a),mul(jj,f));
 E bb=sub(b,mul(r7,h));
 E pp=add(sub(ii,mul(r7,jj)),mul(rr,bb));
 E q0=add(mul(Del,sub(f,mul(r7,a))),mul(rr,sub(mul(pp,T0),mul(bb,U0))));
 E q1=mul(rr,sub(mul(pp,T1),mul(bb,U1)));
 if(q1.zero()){
  if(!q0.zero())return {"contact_linear",q0};
  return {"EXCEPTION_free_u",{}};
 }
 E uu=neg(mul(q0,inv(q1)));
 E tn=add(T0,mul(T1,uu)),un=add(U0,mul(U1,uu));
 if(tn.zero())return {"zero_T",one()};
 E T=mul(tn,inv(Del)),ll=mul(un,inv(tn)),iT=mul(Del,inv(tn));
 E rv=sub(sub(e,mul(T,h)),mul(uu,c));
 E rm=sub(sub(kk,mul(f,iT)),mul(ll,ii));
 if(a.zero()&&!rv.zero())return {"repeated_zero_endpoint",rv};
 if(b.zero()&&!rm.zero())return {"repeated_infinity_endpoint",rm};
 if(a.zero()||b.zero())return {"EXCEPTION_free_quartic_coefficient",{}};
 E en=sub(mul(r8,jp),kp),ed=sub(mul(r8,ep),dp);
 if(ed.zero()){
  if(!en.zero())return {"rational_residue",en};
  return {"EXCEPTION_free_epsilon",{}};
 }
 if(en.zero())return {"zero_epsilon",one()};
 E eps=mul(en,inv(ed));
 E vv=add(sq(uu),mul(rv,inv(a)));
 E mm=add(sq(ll),mul(rm,inv(b)));
 E rho2=sq(mul(eps,T));
 E A=add(sub(one(),sc(mul(rr,uu),4)),mul(r2,add(sq(uu),sc(vv,2))));
 E B=add(sub(add(sq(ll),sc(mm,2)),sc(mul(rr,ll),4)),r2);
 E compatibility=sub(mul(rho2,A),B);
 if(!compatibility.zero())return {"quartic_coefficient",compatibility};
 // Common-pole cancellation on the opposite sheet is also necessary.
 E Br=mul(power(rr,3),add(sub(sc(ll,2),rr),
              mul(rho2,add(neg(sc(uu,2)),mul(rr,add(sq(uu),sc(vv,2)))))));
 E eb= sc(add(add(mul(a,iT),mul(rr,sub(jj,mul(ll,h)))),mul(r2,h)),3);
 E ar=mul(power(rr,3),sub(jp,mul(eps,ep)));
 E cancellation=sub(sq(ar),mul(Br,sq(eb)));
 if(!cancellation.zero())return {"opposite_sheet_cancellation",cancellation};
 return {"SURVIVOR",{}};
}
// The same necessary conditions, with every denominator explicitly cleared.
static Outcome test_case(const Case&x){
 int vm=(x.v+x.t)%29;
 E a=sub(AR[0],AR[x.j]),b=sub(AR[x.k],AR[x.l]);
 E f=sub(HP[0][0],HP[x.j][x.u]),c=sub(FP[0][0],FP[x.j][x.u]);
 E d=sub(GP[0][0],GP[x.j][x.u]),e=sub(JP[0][0],JP[x.j][x.u]);
 E h=sub(HP[x.k][x.v],HP[x.l][vm]),ii=sub(FP[x.k][x.v],FP[x.l][vm]);
 E jj=sub(GP[x.k][x.v],GP[x.l][vm]),kk=sub(JP[x.k][x.v],JP[x.l][vm]);
 E dp=average(GP[0][0],GP[x.j][x.u]),ep=average(JP[0][0],JP[x.j][x.u]);
 E jp=average(GP[x.k][x.v],GP[x.l][vm]),kp=average(JP[x.k][x.v],JP[x.l][vm]);
 E rr{};for(int i=0;i<7;i++)rr.c[4*i]=ZP[x.r][i];
 E r2=sq(rr),r7=power(rr,7),r8=mul(r7,rr);
 E Del=sub(mul(h,ii),mul(b,jj));
 if(Del.zero())throw std::runtime_error("verified Delta unexpectedly zero");
 E T0=sub(mul(h,d),mul(b,c)),T1=sub(mul(a,b),mul(h,f));
 E U0=sub(mul(jj,d),mul(ii,c)),U1=sub(mul(ii,a),mul(jj,f));
 E bb=sub(b,mul(r7,h)),pp=add(sub(ii,mul(r7,jj)),mul(rr,bb));
 E q0=add(mul(Del,sub(f,mul(r7,a))),mul(rr,sub(mul(pp,T0),mul(bb,U0))));
 E Du=mul(rr,sub(mul(pp,T1),mul(bb,U1))),Nu=neg(q0);
 if(Du.zero()){
  if(!q0.zero())return {"contact_linear",q0};
  return {"EXCEPTION_free_u",{}};
 }
 E Tp=add(mul(T0,Du),mul(T1,Nu)),Up=add(mul(U0,Du),mul(U1,Nu));
 if(Tp.zero())return {"zero_T",one()};
 E RV=sub(sub(mul(mul(e,Del),Du),mul(h,Tp)),mul(mul(c,Nu),Del));
 E RM=sub(sub(mul(kk,Tp),mul(mul(f,Del),Du)),mul(ii,Up));
 if(a.zero()&&!RV.zero())return {"repeated_zero_endpoint",RV};
 if(b.zero()&&!RM.zero())return {"repeated_infinity_endpoint",RM};
 if(a.zero()||b.zero())return {"EXCEPTION_free_quartic_coefficient",{}};
 E en=sub(mul(r8,jp),kp),ed=sub(mul(r8,ep),dp);
 if(ed.zero()){
  if(!en.zero())return {"rational_residue",en};
  return {"EXCEPTION_free_epsilon",{}};
 }
 if(en.zero())return {"zero_epsilon",one()};
 E Li=add(sub(sq(Du),sc(mul(mul(rr,Nu),Du),4)),sc(mul(r2,sq(Nu)),3));
 E Ln=add(mul(mul(a,Del),Li),sc(mul(mul(r2,RV),Du),2));
 E Ri=add(sub(sc(sq(Up),3),sc(mul(mul(rr,Up),Tp),4)),mul(r2,sq(Tp)));
 E Rn=add(mul(b,Ri),sc(mul(RM,Tp),2));
 E left=mul(mul(mul(b,sq(en)),sq(sq(Tp))),Ln);
 E right=mul(mul(mul(mul(a,sq(ed)),mul(sq(Del),Del)),sq(sq(Du))),Rn);
 E obstruction=sub(left,right);
 if(!obstruction.zero())return {"quartic_coefficient",obstruction};
 return test_case_slow(x);
}
int main(int argc,char**argv){
 tables();preload();
 if(argc<3||argc>4){std::cerr<<"usage: degree7_genus1_boundary --sample N | --exhaust N(0=all) [CERT] | --verify N CERT\n";return 2;}
 bool sample=std::string(argv[1])=="--sample";uint64_t limit=std::stoull(argv[2]),tested=0;
 bool verifying=std::string(argv[1])=="--verify";
 std::fstream certificate;
 if(argc==4)certificate.open(argv[3],std::ios::binary|(verifying?std::ios::in:(std::ios::out|std::ios::trunc)));
 if(argc==4&&!certificate)throw std::runtime_error("cannot open certificate");
 std::map<std::string,uint8_t> stages={{"contact_linear",1},{"zero_T",2},
  {"repeated_zero_endpoint",3},{"repeated_infinity_endpoint",4},{"rational_residue",5},
  {"zero_epsilon",6},{"quartic_coefficient",7},{"opposite_sheet_cancellation",8}};
 std::map<std::string,uint64_t> counts;uint64_t rng=0x2507292026ULL;
 auto random=[&](unsigned n){rng^=rng<<13;rng^=rng>>7;rng^=rng<<17;return int(rng%n);};
 auto start=std::chrono::steady_clock::now();
 auto run=[&](Case x){
  if((x.j==0&&x.u==0)||(x.k==x.l&&x.t==0))return false;
  Outcome o=test_case(x); counts[o.stage]++;tested++;
  if(sample&&tested<=1000){
   Outcome slow=test_case_slow(x);
   if(slow.stage!=o.stage)throw std::runtime_error("cleared and rational tests disagree");
  }
  if(argc==4){
   array<uint8_t,3> record{};
   if(stages.count(o.stage)){
    int pos=0;while(pos<28&&!o.witness.c[pos])pos++;
    if(pos==28)throw std::runtime_error("zero exclusion witness");
    record={stages[o.stage],uint8_t(pos),o.witness.c[pos]};
   }
   if(verifying){array<uint8_t,3> stored{};if(!certificate.read((char*)stored.data(),3)||stored!=record)
    throw std::runtime_error("certificate record mismatch");}
   else certificate.write((const char*)record.data(),3);
  }
  if(o.stage.rfind("EXCEPTION",0)==0||o.stage=="SURVIVOR")
   std::cout<<o.stage<<" "<<x.j<<" "<<x.k<<" "<<x.l<<" "<<x.u<<" "<<x.t<<" "<<x.v<<" "<<x.r<<"\n";
  if(tested%(sample?1000:100000)==0)std::cout<<"PROGRESS "<<tested<<" seconds "
   <<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
  return limit&&tested>=limit;
 };
 if(sample){while(tested<limit)run({random(4),random(4),random(4),random(29),random(29),random(29),random(29)});}
 else{
  std::vector<array<int,3>> reps;
  for(int u=0;u<29;u++)for(int t=0;t<29;t++)for(int v=0;v<29;v++){
   array<int,3>a{u,t,v},b=a;bool keep=true;
   for(int m=0;m<6;m++){for(auto&x:b)x=x*24%29;if(b<a){keep=false;break;}}
   if(keep)reps.push_back(a);
  }
  bool stop=false;
  for(int j=0;j<4&&!stop;j++)for(int k=0;k<4&&!stop;k++)for(int l=0;l<4&&!stop;l++)
   for(auto r:reps){for(int z=0;z<29;z++){if(run({j,k,l,r[0],r[1],r[2],z})){stop=true;break;}}if(stop)break;}
 }
 for(auto a:counts)std::cout<<"COUNT "<<a.first<<" "<<a.second<<"\n";
 if(verifying&&certificate.peek()!=std::char_traits<char>::eof())throw std::runtime_error("trailing certificate data");
 std::cout<<"TOTAL "<<tested<<" sample "<<sample<<" seconds "
 <<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
 if(!sample&&limit==0){
  if(tested!=6356452)throw std::runtime_error("incomplete geometric boundary enumeration");
  for(auto a:counts)if(!stages.count(a.first))throw std::runtime_error("unresolved boundary case");
  std::cout<<"PASS: complete genus-one necessary-condition certificate; use the scoped two-map model proof. Rational quotient case not covered.\n";
 } else std::cout<<"BOUNDED CHECK ONLY; not an exhaustive decision.\n";
}
