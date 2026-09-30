// Exact degree-seven rational-quotient boundary certificate.
// Formula derivation and independent Sage checks accompany this program.
#define main degree6_retained_verifier_main
#include "pro_degree6_actual_return_20260924/degree6/src/genus0_boundary.cpp"
#undef main
#include <map>
static E powE(E a,unsigned n){E b=one();while(n){if(n&1)b=mul(b,a);a=sq(a);n>>=1;}return b;}
static E FI[28][28];static uint8_t inv25[25];
static void init_frobenius(){
 for(int a=1;a<25;a++)for(int b=1;b<25;b++)if(mt[a][b]==1)inv25[a]=b;
 int qm=1;
 for(int m=0;m<28;m++){
  for(int j=0;j<7;j++)for(int i=0;i<4;i++){
   E aa=powE(AR[m%4],i),bb{};
   for(int t=0;t<7;t++)bb.c[4*t]=ZP[(qm*j)%29][t];
   FI[m][4*j+i]=mul(aa,bb);
  }
  qm=qm*25%29;
 }
}
static E frob(const E&a,int m){
 E r;for(int j=0;j<28;j++)if(a.c[j])for(int i=0;i<28;i++)
  r.c[i]=at[r.c[i]][mt[a.c[j]][FI[m%28][j].c[i]]];
 return r;
}
static E inverse(const E&a){
 if(a.zero())throw std::runtime_error("inverse zero");
 E p2=mul(a,frob(a,1)),p3=mul(p2,frob(a,2));
 E p6=mul(p3,frob(p3,3)),p12=mul(p6,frob(p6,6));
 E p24=mul(p12,frob(p12,12)),p27=mul(p24,frob(p3,24));
 E b=frob(p27,1),n=mul(a,b);
 if(!n.c[0])throw std::runtime_error("zero norm");
 for(int i=1;i<28;i++)if(n.c[i])throw std::runtime_error("norm not in F25");
 return sc(b,inv25[n.c[0]]);
}
using Pol=std::vector<E>;
static void trim(Pol&a){while(!a.empty()&&a.back().zero())a.pop_back();}
static Pol pa(Pol a,const Pol&b){a.resize(std::max(a.size(),b.size()));for(size_t i=0;i<b.size();i++)a[i]=add(a[i],b[i]);trim(a);return a;}
static Pol pn(Pol a){for(auto&x:a)x=neg(x);return a;}
static Pol ps(Pol a,const E&b){for(auto&x:a)x=mul(x,b);trim(a);return a;}
static Pol pm(const Pol&a,const Pol&b){if(a.empty()||b.empty())return {};Pol c(a.size()+b.size()-1);for(size_t i=0;i<a.size();i++)for(size_t j=0;j<b.size();j++)c[i+j]=add(c[i+j],mul(a[i],b[j]));trim(c);return c;}
static Pol mono(const E&a,int n){Pol p(n+1);p[n]=a;trim(p);return p;}
static Pol rem(Pol a,const Pol&b){
 if(b.empty())throw std::runtime_error("polynomial division by zero");
 E iv=inverse(b.back());
 while(a.size()>=b.size()&&!a.empty()){
  size_t shift=a.size()-b.size();E f=mul(a.back(),iv);
  for(size_t j=0;j<b.size();j++)a[shift+j]=sub(a[shift+j],mul(f,b[j]));
  trim(a);
 }
 return a;
}
static Pol gcdp(Pol a,Pol b){trim(a);trim(b);while(!b.empty()){if(b.size()==1)return b;Pol r=rem(a,b);a=b;b=r;}return a;}
static Pol quotient(Pol a,const Pol&b){
 Pol q(a.size()>=b.size()?a.size()-b.size()+1:0);E iv=inverse(b.back());
 while(a.size()>=b.size()&&!a.empty()){
  size_t shift=a.size()-b.size();E f=mul(a.back(),iv);q[shift]=add(q[shift],f);
  for(size_t j=0;j<b.size();j++)a[shift+j]=sub(a[shift+j],mul(f,b[j]));
  trim(a);
 }
 if(!a.empty())throw std::runtime_error("inexact quotient");trim(q);return q;
}
static Pol strip_zero(Pol a){while(a.size()>1&&a[0].zero())a.erase(a.begin());return a;}
static Pol remove_roots(Pol a,const Pol&p,bool nonzero_variable=true){
 if(nonzero_variable)a=strip_zero(a);if(a.empty()||p.empty())return a;
 while(a.size()>1){Pol b=gcdp(a,p);if(b.size()<2)break;a=quotient(a,b);}
 return a;
}
static E evaluate(const Pol&p,const E&x){E v;for(size_t i=p.size();i>0;i--)v=add(mul(v,x),p[i-1]);return v;}
static uint64_t contact_resolved=0,contact_unresolved=0;
static Pol det2(const Pol&a,const Pol&b,const Pol&c,const Pol&d){return pa(pm(a,d),pn(pm(b,c)));}
static Pol bezout2(const array<Pol,3>&a,const array<Pol,3>&b){
 Pol c10=det2(a[1],a[0],b[1],b[0]),c20=det2(a[2],a[0],b[2],b[0]);
 Pol c21=det2(a[2],a[1],b[2],b[1]);return det2(c10,c20,c20,c21);
}
struct C7{int j,k,l,u,t,v,r;};
struct Result{std::string stage;int degree;E witness{};};
static Result test(const C7&x){
 int vm=(x.v+x.t)%29;
 E a=sub(AR[0],AR[x.j]),b=sub(AR[x.k],AR[x.l]);
 E f=sub(HP[0][0],HP[x.j][x.u]),c=sub(FP[0][0],FP[x.j][x.u]);
 E d=sub(GP[0][0],GP[x.j][x.u]),e=sub(JP[0][0],JP[x.j][x.u]);
 E h=sub(HP[x.k][x.v],HP[x.l][vm]),i=sub(FP[x.k][x.v],FP[x.l][vm]);
 E j=sub(GP[x.k][x.v],GP[x.l][vm]),k=sub(JP[x.k][x.v],JP[x.l][vm]);
 if(f.zero()&&h.zero())return {"both_endpoint_differences_zero",0,one()};
 auto avg=[](E a,E b){return sc(add(a,b),3);};
 E dp=avg(GP[0][0],GP[x.j][x.u]),ep=avg(JP[0][0],JP[x.j][x.u]);
 E jp=avg(GP[x.k][x.v],GP[x.l][vm]),kp=avg(JP[x.k][x.v],JP[x.l][vm]);
 E r{};for(int z=0;z<7;z++)r.c[4*z]=ZP[x.r][z];
 E r2=sq(r),r3=mul(r,r2),r4=sq(r2),r7=powE(r,7),r8=mul(r7,r);
 E en=sub(mul(r8,jp),kp),ed=sub(mul(r8,ep),dp);
 if(ed.zero())return {en.zero()?"EXCEPTION_free_epsilon":"residue_contradiction",0,en};
 if(en.zero())return {"zero_epsilon",0,ed};
 E eps=mul(en,inverse(ed));
 E FF=sub(f,mul(r7,a)),BB=sub(b,mul(r7,h)),DD=sub(d,mul(r7,c)),II=sub(i,mul(r7,j));
 Pol den=pa(mono(mul(eps,FF),0),mono(BB,3));
 Pol num=pn(pa(mono(mul(mul(r,eps),DD),0),mono(mul(r,II),1)));
 array<Pol,3>A,B;
 A[0]=pa(pa(mono(sc(mul(mul(eps,r2),e),2),2),mono(sc(mul(r,sub(j,mul(r,h))),3),3)),
             pa(mono(sc(mul(mul(eps,r),c),3),2),mono(neg(mul(mul(eps,r2),a)),0)));
 A[1]=pa(mono(sc(h,3),5),mono(sc(mul(eps,sub(mul(r,c),a)),2),2));
 A[2]=mono(sc(mul(eps,a),3),2);
 B[0]=pa(pa(mono(sc(mul(mul(eps,r3),d),2),0),mono(sc(mul(r2,sub(k,mul(r,i))),3),1)),
             pa(mono(mul(r2,b),3),mono(sc(mul(mul(eps,r2),f),3),0)));
 B[1]=pa(mono(sc(sub(mul(r2,b),mul(r,i)),2),3),mono(sc(mul(mul(eps,r2),f),2),0));
 B[2]=mono(sc(b,2),5);
 Pol exceptional=strip_zero(gcdp(den,num));
 if(exceptional.empty()||exceptional.size()>1){
  Pol criterion=bezout2(A,B);exceptional=strip_zero(gcdp(exceptional,criterion));
  if(exceptional.size()==2){
   E root=neg(mul(exceptional[0],inverse(exceptional[1]))),rt2=sq(root),rt3=mul(root,rt2);
   Pol aw,bw;for(int n=0;n<3;n++){aw.push_back(evaluate(A[n],root));bw.push_back(evaluate(B[n],root));}
   trim(aw);trim(bw);Pol gw=gcdp(aw,bw);
   E J=sub(jp,mul(eps,ep));
   Pol contactline=pa(mono(add(mul(eps,a),mul(rt3,h)),1),
                        mono(add(mul(mul(eps,c),r),mul(mul(j,r),root)),0));
   if(contactline.empty())gw={one()};
   else{
    Pol factor=pa(mono(add(r2,rt2),0),mono(sc(rt2,3),1));
    Pol hh=pa(mono(sc(mul(mul(rt2,r4),sq(J)),4),0),pn(pm(factor,pm(contactline,contactline))));
    gw=gcdp(gw,hh);
    Pol discriminant=pa(mono(rt2,2),mono(neg(r2),0));
    gw=remove_roots(gw,contactline,false);
    gw=remove_roots(gw,discriminant,false);
   }
   if(gw.size()==1){contact_resolved++;exceptional={one()};}
   else{contact_unresolved++;return {"EXCEPTION_contact_W",int(gw.size())-1};}
  }
  if(exceptional.empty()||exceptional.size()>1){contact_unresolved++;return {"EXCEPTION_contact_chart",int(exceptional.size())-1};}
 }
 if(den.empty())return {"regular_chart_empty",0,one()};
 Pol dd=pm(den,den),nd=pm(num,den),nn=pm(num,num);
 auto substitute=[&](const array<Pol,3>&p){return pa(pa(pm(p[0],dd),pm(p[1],nd)),pm(p[2],nn));};
 Pol E1=substitute(A),E2=substitute(B);
 Pol g=remove_roots(gcdp(E1,E2),den);
 if(g.size()==1)return {"two_jet_polynomials",0,g[0]};
 E J=sub(jp,mul(eps,ep));
 Pol Hfirst=pm(mono(sc(mul(r4,sq(J)),4),2),pm(dd,den));
 Pol Hfactor=pa(pm(pa(mono(r2,0),mono(one(),2)),den),pm(mono(sc(one(),3),2),num));
 Pol Hline=pa(pm(pa(mono(mul(eps,a),0),mono(h,3)),num),
                 pm(pa(mono(mul(mul(eps,c),r),0),mono(mul(j,r),1)),den));
 Pol H=pa(Hfirst,pn(pm(Hfactor,pm(Hline,Hline))));
 g=remove_roots(gcdp(g,H),den);
 if(g.size()==1)return {"opposite_sheet_polynomial",0,g[0]};
 return {"SURVIVOR",int(g.size())-1};
}
int main(int argc,char**argv){
 tables();preload();init_frobenius();
 if(argc==9&&std::string(argv[1])=="--case"){
  C7 c{std::stoi(argv[2]),std::stoi(argv[3]),std::stoi(argv[4]),std::stoi(argv[5]),std::stoi(argv[6]),std::stoi(argv[7]),std::stoi(argv[8])};
  auto r=test(c);std::cout<<r.stage<<" degree "<<r.degree<<" contact_resolved "<<contact_resolved<<" contact_unresolved "<<contact_unresolved<<"\n";return 0;
 }
 if(argc<3||argc>4){std::cerr<<"usage: --sample N | --exhaust N(0=all) | --exhaust-j J CERT | --verify-j J CERT\n";return 2;}
 std::string mode=argv[1];bool sample=mode=="--sample",split=mode=="--exhaust-j"||mode=="--verify-j",verify=mode=="--verify-j";
 uint64_t limit=split?0:std::stoull(argv[2]),count=0;
 int firstj=split?std::stoi(argv[2]):0,lastj=split?firstj+1:4;
 if(firstj<0||lastj>4)throw std::runtime_error("invalid j");
 std::fstream cert;
 if(argc==4){cert.open(argv[3],std::ios::binary|(verify?std::ios::in:std::ios::out|std::ios::trunc));if(!cert)throw std::runtime_error("certificate unavailable");}
 std::map<std::string,uint8_t>stage={{"both_endpoint_differences_zero",1},{"residue_contradiction",2},{"zero_epsilon",3},{"regular_chart_empty",4},{"two_jet_polynomials",5},{"opposite_sheet_polynomial",6}};
 std::map<std::string,uint64_t>counts;uint64_t state=0x2507292026ULL;
 auto ran=[&](unsigned n){state^=state<<13;state^=state>>7;state^=state<<17;return int(state%n);};
 // Check the accelerated inverse against multiplication in the full field.
 for(int n=0;n<100;n++){E a;for(auto&x:a.c)x=ran(25);if(!a.zero()&&!(mul(a,inverse(a))==one()))throw std::runtime_error("inverse audit failed");}
 auto start=std::chrono::steady_clock::now();
 auto run=[&](C7 x){
  uint64_t previous_contact=contact_resolved;
  Result r=test(x);counts[r.stage]++;count++;
  if(argc==4){
   array<uint8_t,3> record{};
   if(stage.count(r.stage)){
    int p=0;while(p<28&&!r.witness.c[p])p++;
    if(p==28)throw std::runtime_error("missing exclusion witness");
    record={uint8_t(stage[r.stage]+(contact_resolved>previous_contact?128:0)),uint8_t(p),r.witness.c[p]};
   }
   if(verify){array<uint8_t,3>stored{};if(!cert.read((char*)stored.data(),3)||stored!=record)throw std::runtime_error("record mismatch");}
   else cert.write((const char*)record.data(),3);
  }
  if(r.stage.rfind("EXCEPTION",0)==0||r.stage=="SURVIVOR")
   std::cout<<r.stage<<" "<<x.j<<" "<<x.k<<" "<<x.l<<" "<<x.u<<" "<<x.t<<" "<<x.v<<" "<<x.r<<" degree "<<r.degree<<std::endl;
  if(count%(sample?100:10000)==0)std::cout<<"PROGRESS "<<count<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
  return limit&&count>=limit;
 };
 if(sample){while(count<limit)run({ran(4),ran(4),ran(4),ran(29),ran(29),ran(29),ran(29)});}
 else{
  std::vector<array<int,3>>reps;
  for(int u=0;u<29;u++)for(int t=0;t<29;t++)for(int v=0;v<29;v++){
   array<int,3>a{u,t,v},b=a;bool keep=true;
   for(int m=0;m<6;m++){for(auto&x:b)x=x*24%29;if(b<a){keep=false;break;}}
   if(keep)reps.push_back(a);
  }
  bool stop=false;
  for(int j=firstj;j<lastj&&!stop;j++)for(int k=0;k<4&&!stop;k++)for(int l=0;l<4&&!stop;l++)
   for(auto t:reps){for(int r=0;r<29;r++){if(run({j,k,l,t[0],t[1],t[2],r})){stop=true;break;}}if(stop)break;}
 }
 for(auto a:counts)std::cout<<"COUNT "<<a.first<<" "<<a.second<<"\n";
 std::cout<<"CONTACT resolved "<<contact_resolved<<" unresolved "<<contact_unresolved<<"\n";
 if(verify&&cert.peek()!=std::char_traits<char>::eof())throw std::runtime_error("trailing certificate bytes");
 std::cout<<"TOTAL "<<count<<" seconds "<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
 for(auto a:counts)if(!stage.count(a.first))throw std::runtime_error("unresolved configuration");
 if(contact_unresolved)throw std::runtime_error("unresolved contact chart");
 if(split){
  if(count!=1617040||contact_resolved!=uint64_t(firstj==0?232:242))throw std::runtime_error("coverage mismatch");
  if(counts["both_endpoint_differences_zero"]!=uint64_t(firstj==0?580:0))throw std::runtime_error("endpoint count mismatch");
  if(counts["two_jet_polynomials"]!=1617040-counts["both_endpoint_differences_zero"])throw std::runtime_error("exclusion count mismatch");
  std::cout<<"PASS: complete partition; all exceptional contact charts retained and excluded.\n";
 }else std::cout<<"PASS for the explicitly reported scope; bounded runs are not exhaustive.\n";
}
