#include "algebra.hpp"
#include "rational.hpp"
#include "weighted.hpp"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/json_parser.hpp>
#include <chrono>
#include <fstream>
#include <iomanip>
#include <sstream>
using namespace comp;
using boost::property_tree::ptree;
ptree INPUT,SOURCE,BOUNDARY,SAMPLE;
std::string root;
ptree readjson(std::string name){ptree z;boost::property_tree::read_json(root+"/"+name,z);return z;}
FP frow(const ptree& z){std::vector<F> out;for(auto&[k,v]:z)out.emplace_back(v.get_value<unsigned>());return FP(out);}
FP getrow(std::string name){return frow(INPUT.get_child(name));}
F epsilon(){uint32_t z=0,p=1;for(auto&[k,v]:INPUT.get_child("epsilon")){z+=p*v.get_value<unsigned>();p*=25;}return F(z);}
template<class T> Poly<T> basepoly(const FP &p){std::vector<T>z;for(auto v:p.c)z.emplace_back(v);return Poly<T>(z);}
template<class T> T at(const FP&p,T q){T z=0;for(int i=p.deg();i>=0;i--)z=z*q+T(p.c[i]);return z;}
FP PP,QQ,tt,vv,t3p3,dsmall0,dsmall1;
void init(std::string rt){root=rt;F::init();INPUT=readjson("data/inputs.json");SOURCE=readjson("data/scaled_source.json");BOUNDARY=readjson("data/leading_tail_boundary.json");SAMPLE=readjson("data/sample_residual.json");
 PP=getrow("P");QQ=getrow("Q");vv=FP(std::vector<F>{-F(INPUT.get<unsigned>("r")),F(1)});
 tt=getrow("A").exactdiv(FP(std::vector<F>{-F(25),F(1)}).scale(F(13)));
 t3p3=tt.pow(3)*PP.pow(3);dsmall1=PP.pow(13)*tt.pow(5)*vv;dsmall0=dsmall1*PP;
}
template<class T> std::array<Curve<T>,4> sourcebar(T q,T u){
 std::vector<T> qp{T(1)},up{T(1)};for(int i=1;i<=5;i++)qp.push_back(qp.back()*q);for(int i=1;i<=2;i++)up.push_back(up.back()*u);
 T den=q*at(frow(SOURCE.get_child("D0_q")),q),di=den.inverse();
 std::array<Curve<T>,4> gs;int k=0;
 for(auto&[s,gg]:SOURCE.get_child("numerators_Gbar")){
  int j=0;for(auto&[s,rr]:gg){std::vector<T> co;for(auto&[s,pol]:rr){T z=0;for(auto&[s,term]:pol){std::vector<uint32_t>a;for(auto&[s,n]:term)a.push_back(n.get_value<unsigned>());assert(a.size()==3);z+=up[a[0]]*qp[a[1]]*T(F(a[2]));}co.push_back(z*di);}gs[k].c[j++]=Poly<T>(co);}k++;
 }return gs;
}
template<class T> std::array<Curve<T>,3> small_critical(T q,T u){
 using C=Curve<T>;Curve<T>::PQ=basepoly<T>(PP).scale(q.inverse());
 auto gg=sourcebar(q,u);C ee;ee.c[1]=basepoly<T>(t3p3);
 auto co=critical(gg,ee,C(basepoly<T>(QQ)),C(basepoly<T>(vv)));
 auto D0=basepoly<T>(dsmall0),D1=basepoly<T>(dsmall1);
 int row=0;int upper[3][3]={{46,43,40},{45,42,38},{44,40,36}};
 for(auto &z:co){auto a=z.c[0].exactdiv(D0).scale(q),b=z.c[1].exactdiv(D1),c=z.c[2].exactdiv(D1);z.c={b,c,a};for(int j=0;j<3;j++)assert(z.c[j].deg()<=upper[row][j]);row++;}
 return co;
}
template<class T> std::array<Curve<T>,3> weighted_small_critical(T q,T u){
 using W=WCurve<T>;Curve<T>::PQ=W::PQ=basepoly<T>(PP).scale(q.inverse());auto orig=sourcebar(q,u);std::array<W,4>gs;for(int j=0;j<4;j++)gs[j]=W(orig[j]);
 Curve<T> ev;ev.c[1]=basepoly<T>(t3p3);auto raw=critical_ring(gs,W(ev),W(basepoly<T>(QQ)),W(basepoly<T>(vv)));
 std::array<Curve<T>,3>out;int caps[3]={594,590,580};int upper[3][3]={{46,43,40},{45,42,38},{44,40,36}};
 for(int k=0;k<3;k++){assert(raw[k].cap<=caps[k]);out[k].c={high_quotient(raw[k].c[1],dsmall1),high_quotient(raw[k].c[2],dsmall1),high_quotient(raw[k].c[0],dsmall0).scale(q)};for(int j=0;j<3;j++)assert(out[k].c[j].deg()<=upper[k][j]);}
 return out;
}
template<class T> std::vector<Poly<T>> norm_small(const std::array<Curve<T>,3>&co,T q){
 using XP=Poly<T>;using MP=Poly<XP>;std::vector<XP>va,vb,vc;for(auto&z:co){va.push_back(z.c[0]);vb.push_back(z.c[1]);vc.push_back(z.c[2]);}
 MP a(va),b(vb),c(vc);auto pq=Curve<T>::PQ;MP out=a.pow(3)+b.pow(3).scale(pq)+c.pow(3).scale(pq.pow(2))-(a*b*c).scale(pq.scale(T(3)));for(auto&p:out.c)p=p.scale(q.inverse());return out.c;
}
template<class T> std::vector<Poly<T>> actual_residual(T q,T u,bool checklead=true){
 auto co=small_critical(q,u);
 using XP=Poly<T>;using MP=Poly<XP>;
 std::vector<XP>va,vb,vc;for(auto&z:co){va.push_back(z.c[0]);vb.push_back(z.c[1]);vc.push_back(z.c[2]);}
 MP a(va),b(vb),c(vc);auto pq=Curve<T>::PQ;
 MP out=a.pow(3)+b.pow(3).scale(pq)+c.pow(3).scale(pq.pow(2))-(a*b*c).scale(pq.scale(T(3)));
 for(auto& p:out.c)p=p.scale(q.inverse());
 assert(out.deg()==6);assert(out.c[0].deg()==140);for(int i=1;i<=6;i++)assert(out.c[i].deg()<140);
 if(checklead){T ui=u.inverse();T s=(at(getrow("a0"),q)+at(getrow("b"),q)*ui+at(getrow("c"),q)*ui.pow(2)+at(getrow("e"),q)*ui.pow(3))/at(getrow("d"),q);
 T expected=T((F(3)*epsilon().pow(8)).pow(3))*s.pow(3)*u.pow(18)/q.pow(24);assert(out.c[0].c[140]==expected);}
 return out.c;
}
template<class T> std::vector<Poly<T>> sermul(const std::vector<Poly<T>>&a,const std::vector<Poly<T>>&b,int n){
 std::vector<Poly<T>>z(n);for(int i=0;i<std::min(n,(int)a.size());i++)if(a[i])for(int j=0;j<std::min(n-i,(int)b.size());j++)if(b[j])z[i+j]+=a[i]*b[j];return z;
}
template<class T> std::vector<Poly<T>> serfrob(const std::vector<Poly<T>>&a,int exponent,int n){
 std::vector<Poly<T>>z(n);for(int i=0;i<(int)a.size()&&i*exponent<n;i++){auto p=a[i];for(int j=exponent;j>1;j/=5)p=p.fifth();z[i*exponent]=p;}return z;
}
template<class T> std::vector<Poly<T>> tails(const std::vector<Poly<T>>&rr,int n){
 std::vector<Poly<T>>a(n);T li=rr[0][140].inverse();
 for(int i=0;i<n;i++){std::vector<T>p;for(auto&r:rr)p.push_back(r[140-i]*li);a[i]=Poly<T>(p);}
 auto a2=sermul(a,a,n),a3=sermul(a2,a,n);
 return sermul(sermul(a3,serfrob(a2,5,n),n),serfrob(a2,25,n),n);
}
void json(std::ostream&o,const Rat&v);
void json(std::ostream&o,const F&v){o<<v.v;}
void json(std::ostream&o,const E&v){o<<'[';for(size_t i=0;i<v.p.c.size();i++){if(i)o<<',';json(o,v.p.c[i]);}o<<']';}
template<class T>void json(std::ostream&o,const Poly<T>&p){o<<'[';for(size_t i=0;i<p.c.size();i++){if(i)o<<',';json(o,p.c[i]);}o<<']';}
template<class T>void json(std::ostream&o,const std::vector<T>&v){o<<'[';for(size_t i=0;i<v.size();i++){if(i)o<<',';json(o,v[i]);}o<<']';}
void json(std::ostream&o,const Rat&vv){Rat v=vv.normalized();o<<"{\"a\":";json(o,v.a);o<<",\"b\":";json(o,v.b);o<<",\"den\":[";for(int k=0;k<5;k++){if(k)o<<',';o<<v.den[k];}o<<"]}";}
void setup_rational(){
 FP eq=getrow("e").exactdiv(FP(std::vector<F>{0,1}));
 auto ns=readjson("data/norm_s_boundary.json");
 Rat::setup(getrow("C"),{FP(std::vector<F>{0,1}),getrow("d"),eq,frow(BOUNDARY.get_child("Delta")),frow(ns.get_child("discriminant"))});
}
void global_model(std::string output,bool use_weighted=true){
 setup_rational();Rat q(FP(std::vector<F>{0,1})),xi;xi.b=FP(1);
 Rat u=Rat(getrow("e"))*(Rat(getrow("c"))+Rat(3)*xi)/Rat(frow(BOUNDARY.get_child("Delta")));
 auto start=std::chrono::steady_clock::now();auto co=use_weighted?weighted_small_critical(q,u):small_critical(q,u);
 std::cout<<"{\"global_critical_quotient\":\"constructed\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 for(auto&g:co)for(auto&p:g.c)for(auto&v:p.c)v.normalize();
 Rat ss=(Rat(getrow("a0"))+Rat(getrow("b"))/u+Rat(getrow("c"))/u.pow(2)+Rat(getrow("e"))/u.pow(3))/Rat(getrow("d"));
 assert(co[0].c[2][40]==Rat(F(3)*epsilon().pow(8))*ss*u.pow(6)/q.pow(7));
 auto rr=norm_small(co,q);assert(rr.size()==7&&rr[0].deg()==140);for(int i=1;i<7;i++)assert(rr[i].deg()<140);
 std::cout<<"{\"global_residual\":\"constructed\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 int maxa=-1,maxb=-1;std::array<int,5>maxden{};
 for(auto&p:rr)for(auto&v:p.c){v.normalize();maxa=std::max(maxa,v.a.deg());maxb=std::max(maxb,v.b.deg());for(int k=0;k<5;k++)maxden[k]=std::max(maxden[k],v.den[k]);}
 std::cout<<"{\"global_residual\":\"normalized\",\"max_a_b_degrees\":["<<maxa<<','<<maxb<<"],\"max_den\":[";for(int k=0;k<5;k++){if(k)std::cout<<',';std::cout<<maxden[k];}std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 F q0(SAMPLE.get<unsigned>("q")),xi0(SAMPLE.get<unsigned>("xi"));int k=0;
 for(auto&[key,row]:SAMPLE.get_child("Rbar_scale_ascending")){FP expected=frow(row);for(int j=0;j<=140;j++)assert(rr[k][j].eval(q0,xi0)==expected[j]);k++;}
 // Independently compare the actual full second sheet at q=2.
 F q1(2);auto ff=readjson("data/fibre_certificates.json");auto it=ff.begin();std::advance(it,3);F u1(it->second.get<unsigned>("u")),xi1(it->second.get<unsigned>("xi"));
 auto rs=actual_residual(q1,u1);for(int i=0;i<7;i++)for(int j=0;j<=140;j++)assert(rr[i][j].eval(q1,xi1)==rs[i][j]);
 // Normalize the reciprocal coefficient rows, retaining the actual scale.
 Rat il=rr[0][140].inverse();std::vector<Poly<Rat>>a(74);maxa=maxb=-1;maxden.fill(0);
 for(int i=0;i<74;i++)for(int j=0;j<7;j++){Rat v=rr[j][140-i]*il;v.normalize();a[i].c.push_back(v);maxa=std::max(maxa,v.a.deg());maxb=std::max(maxb,v.b.deg());for(int k=0;k<5;k++)maxden[k]=std::max(maxden[k],v.den[k]);}for(auto&p:a)p.trim();
 std::ofstream out(output);out<<"{\"poles\":[";for(int k=0;k<5;k++){if(k)out<<',';json(out,Rat::factors[k]);}out<<"],\"normalized_reciprocal_T0_to_T73\":";json(out,a);out<<"}\n";
 std::cout<<"{\"global_normalized_reciprocal\":\"PASS\",\"max_a_b_degrees\":["<<maxa<<','<<maxb<<"],\"max_den\":[";for(int k=0;k<5;k++){if(k)std::cout<<',';std::cout<<maxden[k];}std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
Rat ratrow(const ptree&z){Rat v;v.a=frow(z.get_child("a"));v.b=frow(z.get_child("b"));int k=0;for(auto&[s,n]:z.get_child("den"))v.den[k++]=n.get_value<int>();assert(k==5);return v;}
Poly<Rat> ratpoly(const ptree&z){std::vector<Rat>p;for(auto&[s,v]:z)p.push_back(ratrow(v));return Poly<Rat>(p);}
void normalize_poly(Poly<Rat>&p){for(auto&v:p.c)v.normalize();p.trim();}
void global_tail_model(std::string input,std::string output){
 setup_rational();auto data=readjson(input);std::vector<Poly<Rat>>a;for(auto&[s,v]:data.get_child("normalized_reciprocal_T0_to_T73"))a.push_back(ratpoly(v));assert(a.size()==74&&a[0]==Poly<Rat>(1));
 auto start=std::chrono::steady_clock::now();std::vector<Poly<Rat>>a2(74),a3(74);
 for(int n=0;n<74;n++){
  for(int i=0;i<=n/2;i++){auto p=a[i]*a[n-i];if(2*i!=n)p=p.scale(Rat(2));a2[n]+=p;}normalize_poly(a2[n]);
  if(n%10==0)std::cout<<"{\"global_a2_through\":"<<n<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 }
 {std::ofstream o(output+".a2.json");json(o,a2);o<<'\n';}
 for(int n=0;n<74;n++)if(n%5>=1&&n%5<=3){
  for(int i=0;i<=n;i++)a3[n]+=a2[i]*a[n-i];normalize_poly(a3[n]);
  if(n%10==3)std::cout<<"{\"global_a3_through\":"<<n<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 }
 {std::ofstream o(output+".a3.json");json(o,a3);o<<'\n';}
 std::vector<Poly<Rat>>f5,f25;for(int i=0;i<=14;i++)f5.push_back(a2[i].fifth());for(int i=0;i<=2;i++)f25.push_back(a2[i].fifth().fifth());
 std::vector<Poly<Rat>>ta(74);
 for(int n=71;n<=73;n++){
  for(int j=0;25*j<=n;j++)for(int i=0;5*i+25*j<=n;i++)ta[n]+=(a3[n-25*j-5*i]*f5[i])*f25[j];normalize_poly(ta[n]);assert(ta[n].deg()<=3*n/4);
  int ma=-1,mb=-1;std::array<int,5>md{};for(auto&v:ta[n].c){ma=std::max(ma,v.a.deg());mb=std::max(mb,v.b.deg());for(int k=0;k<5;k++)md[k]=std::max(md[k],v.den[k]);}
  std::cout<<"{\"global_tail\":"<<n<<",\"mu_degree\":"<<ta[n].deg()<<",\"max_q_a_b_degrees\":["<<ma<<','<<mb<<"],\"den\":[";for(int k=0;k<5;k++){if(k)std::cout<<',';std::cout<<md[k];}std::cout<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 }
 auto expected=readjson("data/sample_tails.json");F q0(SAMPLE.get<unsigned>("q")),x0(SAMPLE.get<unsigned>("xi"));
 for(int n=71;n<=73;n++){auto ep=frow(expected.get_child("C"+std::to_string(n)));for(int j=0;j<=54;j++)assert(ta[n][j].eval(q0,x0)==ep[j]);}
 std::ofstream o(output);o<<"{\"poles\":[";for(int k=0;k<5;k++){if(k)o<<',';json(o,Rat::factors[k]);}o<<"],\"C71\":";json(o,ta[71]);o<<",\"C72\":";json(o,ta[72]);o<<",\"C73\":";json(o,ta[73]);o<<"}\n";
 std::cout<<"{\"global_tail_model\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
void scalar_test(){
 // Independent schoolbook checks cross both exact Kronecker packing widths.
 uint64_t state=20260928;auto rnd=[&](){state^=state<<13;state^=state>>7;state^=state<<17;return F(state%F::N);};
 for(auto [n,m]:std::vector<std::pair<int,int>>{{40,47},{128,191},{510,511},{512,529},{1,1024}}){
  std::vector<F>a(n),b(m),ref(n+m-1);for(auto&v:a)v=rnd();for(auto&v:b)v=rnd();
  for(int i=0;i<n;i++)for(int j=0;j<m;j++)ref[i+j]+=a[i]*b[j];assert(FastK::multiply(a,b)==ref);
 }

 F q(SAMPLE.get<unsigned>("q")),u(SAMPLE.get<unsigned>("u"));auto rr=actual_residual(q,u);int k=0;
 auto fullco=small_critical(q,u),topco=weighted_small_critical(q,u);for(int j=0;j<3;j++)for(int c=0;c<3;c++)assert(fullco[j].c[c]==topco[j].c[c]);
 for(auto&[s,row]:SAMPLE.get_child("Rbar_scale_ascending")){assert(rr[k++]==frow(row));}
 auto ta=tails(rr,74);auto ts=readjson("data/sample_tails.json");for(int i=71;i<=73;i++)assert(ta[i]==frow(ts.get_child("C"+std::to_string(i))));
 auto [g,U,V]=xgcd(ta[71],ta[72]);assert(g==FP(1));assert(U*ta[71]+V*ta[72]==FP(1));
 // Quotient implementation against the independent scalar implementation.
 E::setmod(FP(std::vector<F>{-q,F(1)}));auto er=actual_residual(E(q),E(u));for(int i=0;i<7;i++)for(int j=0;j<=140;j++)assert(er[i][j]==E(rr[i][j]));
 auto et=tails(er,74);for(int i=71;i<=73;i++)for(int j=0;j<=ta[i].deg();j++)assert(et[i][j]==E(ta[i][j]));
 std::cout<<"{\"scalar_sample\":\"PASS\",\"all_987_residual_coefficients\":\"matched Python\",\"C71_C72_C73\":\"matched Python\",\"finite_algebra_engine\":\"PASS\"}\n";
}
void grid(int first,int count){
 int executed=0;for(int qi=first;qi<first+count;qi++){
  F q(qi);assert(bool(q)&&bool(at(frow(SOURCE.get_child("D0_q")),q)));
  for(int ui=0;ui<25;ui++){small_critical(q,F(ui));executed++;}
  std::cout<<"{\"q_code\":"<<qi<<",\"u_nodes\":25,\"nine_fixed_divisions_each\":\"PASS\"}"<<std::endl;
 }
 std::cout<<"{\"grid_start\":"<<first<<",\"grid_count\":"<<count<<",\"ratio_pairs\":"<<executed<<"}\n";
}
// Restrict already-computed tails when a Euclidean pivot is a zero divisor.
Poly<E> restrictpoly(const Poly<E>&p){Poly<E>z;for(auto&v:p.c)z.c.push_back(E(v.p));z.trim();return z;}
void certify_block(FP mod,FP uq,std::vector<Poly<E>> ta,std::ostream&out,bool&first){
 E::setmod(mod);for(auto&p:ta)p=restrictpoly(p);E u(uq),q(FP(std::vector<F>{0,1}));
 try{
  auto [g,U,V]=xgcd(ta[71],ta[72]);
  if(g.deg()>0){auto [gg,A,B]=xgcd(g,ta[73]);if(gg.deg()>0)throw std::runtime_error("first three tails have nonconstant gcd");U=A*U;V=A*V;assert(U*ta[71]+V*ta[72]+B*ta[73]==Poly<E>(1));
   if(!first)out<<',';first=false;out<<"{\"modulus\":";json(out,E::modulus);out<<",\"u\":";json(out,u);out<<",\"C71\":";json(out,ta[71]);out<<",\"C72\":";json(out,ta[72]);out<<",\"C73\":";json(out,ta[73]);out<<",\"U\":";json(out,U);out<<",\"V\":";json(out,V);out<<",\"W\":";json(out,B);out<<'}';
  }else{
   assert(g==Poly<E>(1));assert(U*ta[71]+V*ta[72]==Poly<E>(1));
   if(!first)out<<',';first=false;out<<"{\"modulus\":";json(out,E::modulus);out<<",\"u\":";json(out,u);out<<",\"C71\":";json(out,ta[71]);out<<",\"C72\":";json(out,ta[72]);out<<",\"U\":";json(out,U);out<<",\"V\":";json(out,V);out<<'}';
  }
  std::cout<<"{\"certified_block_degree\":"<<mod.deg()<<",\"tail_degrees\":["<<ta[71].deg()<<','<<ta[72].deg()<<','<<ta[73].deg()<<"],\"identity\":\"PASS\"}"<<std::endl;
 }catch(const Nonunit&exc){
  if(exc.factor.deg()<=0||exc.factor.deg()>=mod.deg())throw;
  auto fac=exc.factor,other=mod.exactdiv(fac);auto copy=ta;
  std::cout<<"{\"pivot_split\":["<<fac.deg()<<','<<other.deg()<<"]}"<<std::endl;
  certify_block(fac,uq,copy,out,first);certify_block(other,uq,ta,out,first);
 }
}
void boundary(int index,std::string path){
 int i=0;for(auto&[key,row]:BOUNDARY.get_child("fibres")){
  if(i++!=index)continue;
  F sigma(row.get<unsigned>("sigma"));FP mod=frow(row.get_child("discriminant")),uq=frow(row.get_child("selected_u_mod_discriminant"));E::setmod(mod);
  E q(FP(std::vector<F>{0,1})),u(uq);auto start=std::chrono::steady_clock::now();
  auto rr=actual_residual(q,u);std::cout<<"{\"sigma\":"<<sigma.v<<",\"full_residual\":\"constructed and exact divisions passed\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
  auto ta=tails(rr,74);assert(!bool(ta[72][54]));
  std::cout<<"{\"sigma\":"<<sigma.v<<",\"tails\":\"constructed\",\"degrees\":["<<ta[71].deg()<<','<<ta[72].deg()<<','<<ta[73].deg()<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
  std::ofstream out(path);if(!out)throw std::runtime_error("cannot write certificate");out<<"{\"sigma\":"<<sigma.v<<",\"index\":"<<index<<",\"discriminant\":";json(out,mod);out<<",\"blocks\":[";bool first=true;certify_block(mod,uq,ta,out,first);out<<"]}\n";
  std::cout<<"{\"sigma\":"<<sigma.v<<",\"degree\":24,\"all_geometric_scales\":\"excluded\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
  return;
 }throw std::runtime_error("invalid boundary index");
}
void norm_s_boundary(std::string path){
 auto row=readjson("data/norm_s_boundary.json");FP mod=frow(row.get_child("discriminant")),uq=frow(row.get_child("selected_u"));E::setmod(mod);
 E q(FP(std::vector<F>{0,1})),u(uq);auto start=std::chrono::steady_clock::now();
 auto rr=actual_residual(q,u);auto ta=tails(rr,74);ta[72][54].inverse();
 std::ofstream out(path);if(!out)throw std::runtime_error("cannot write certificate");
 out<<"{\"kind\":\"norm_s_other_sheet\",\"discriminant\":";json(out,mod);out<<",\"blocks\":[";bool first=true;
 certify_block(mod,uq,ta,out,first);out<<"]}\n";
 std::cout<<"{\"norm_s_boundary\":\"PASS\",\"allowed_ratios\":24,\"all_geometric_scales\":\"excluded\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
void opposite_boundary(int idx,std::string path){
 auto input=readjson("data/opposite_boundary.json");auto it=input.get_child("fibres").begin();std::advance(it,idx);auto row=it->second;
 FP mod=frow(row.get_child("discriminant")),uq=frow(row.get_child("selected_u"));E::setmod(mod);E q(FP(std::vector<F>{0,1})),u(uq);
 auto start=std::chrono::steady_clock::now();auto rr=actual_residual(q,u);auto ta=tails(rr,74);ta[72][54].inverse();
 std::ofstream out(path);if(!out)throw std::runtime_error("cannot write opposite certificate");out<<"{\"kind\":\"opposite_leading_boundary\",\"index\":"<<idx<<",\"opposite_of_sigma\":"<<row.get<unsigned>("opposite_of_sigma")<<",\"discriminant\":";json(out,mod);out<<",\"blocks\":[";bool first=true;
 certify_block(mod,uq,ta,out,first);out<<"]}\n";
 std::cout<<"{\"opposite_boundary\":"<<idx<<",\"ratios\":24,\"all_geometric_scales\":\"excluded\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}
int main(int argc,char**argv){try{
 if(argc<3){std::cerr<<"usage: companion ROOT sample | grid FIRST COUNT | boundary INDEX OUTPUT\n";return 2;}
 init(argv[1]);std::string task=argv[2];auto start=std::chrono::steady_clock::now();
 if(task=="sample")scalar_test();else if(task=="grid"){assert(argc==5);grid(std::stoi(argv[3]),std::stoi(argv[4]));}else if(task=="boundary"){assert(argc==5);boundary(std::stoi(argv[3]),argv[4]);}else if(task=="norm-s"){assert(argc==4);norm_s_boundary(argv[3]);}else if(task=="global-model"){assert(argc==4);global_model(argv[3]);}else if(task=="global-model-full"){assert(argc==4);global_model(argv[3],false);}else if(task=="opposite"){assert(argc==5);opposite_boundary(std::stoi(argv[3]),argv[4]);}else if(task=="global-tails"){assert(argc==5);global_tail_model(argv[3],argv[4]);}else throw std::runtime_error("unknown task");
 std::cout<<"{\"task\":\""<<task<<"\",\"status\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}\n";
 return 0;
 }catch(std::exception&e){std::cerr<<"ERROR: "<<e.what()<<std::endl;return 1;}}
