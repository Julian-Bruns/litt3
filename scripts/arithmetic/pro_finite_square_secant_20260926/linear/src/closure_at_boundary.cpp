#define RESIDUAL_LIBRARY
#include "residual.cpp"
struct CubicGuard{Poly old;CubicGuard(Poly p):old(CP){CP=p;}~CubicGuard(){CP=old;}};
Source normalized_source(const RationalChart&c,F H,F q){Source s;F den=sub(q,QPIVOT[std::find(ROOTS.begin(),ROOTS.end(),c.c.r)-ROOTS.begin()]);if(!den||!q)throw std::runtime_error("excluded q");for(int b=0;b<4;b++)for(int j=0;j<3;j++){s[b].a[j].resize(c.num[b][j].size());for(unsigned i=0;i<c.num[b][j].size();i++)s[b].a[j][i]=divi(eval(toHq(c.num[b][j][i],j-1),H,q),den);trim(s[b].a[j]);}return s;}
LambdaPoly normalized_residual(const RationalChart&c,F H,F q){auto s=normalized_source(c,H,q);CubicGuard guard(scale(P,inv(q)));Fun v(Poly{neg(c.c.r),1});Fun T=Fun(power(tp,3)*power(P,3))*monom(0,1);auto rr=resultant_coeffs(s,Fun(Q),T,v);auto R=lpnorm(rr);Poly den=power(P,40)*power(tp,15)*power(v.a[0],3);for(auto&f:R)f=scale(quo(f,den),fpow(q,25));return R;}
Poly eval_q(const Bi&p,F q){Poly out;for(auto[e,c]:p.t){if(e.first<0)throw std::runtime_error("negative H degree");out.resize(std::max(out.size(),size_t(e.first+1)));out[e.first]=add(out[e.first],mul(c,fpow(q,e.second)));}trim(out);return out;}
Poly rat_H_numerator(const Rat&a,F q,int &wresidue){wresidue=0;if(!a.n.zero()){auto e=a.n.t.begin()->first;wresidue=((e.first+e.second)%3+3)%3;}return eval_q(toHq(a.n,-wresidue),q);}
// Polynomial interpolation at distinct, exact K-elements.
std::vector<Poly> interpolate_R_H(const RationalChart&c,F q,int samples=73){
 std::vector<F>xs;std::vector<Poly>values;for(int i=0;i<samples;i++){F h=i;auto R=normalized_residual(c,h,q);xs.push_back(h);values.push_back(R[0]);}
 std::vector<Poly>out(141);Poly M={1};for(F x:xs)M=M*Poly{neg(x),1};auto Md=diff(M);
 for(int i=0;i<samples;i++){Poly basis=scale(quo(M,Poly{neg(xs[i]),1}),inv(eval(Md,xs[i])));for(int j=0;j<=140;j++)out[j]=out[j]+scale(basis,coeff(values[i],j));}
 // Independent interpolation check at a point not used for fitting.
 auto check=normalized_residual(c,137,q);for(int j=0;j<=140;j++)assert(eval(out[j],137)==coeff(check[0],j));return out;
}
Poly frob_n(Poly p,int n){while(n--)p=frob(p);return p;}
std::vector<Poly> square_R_reversed(const std::vector<Poly>&R,int M){std::vector<Poly>s(M+1);for(int i=0;i<=M;i++)for(int j=0;j+i<=M;j++)s[i+j]=s[i+j]+R[i]*R[j];return s;}
std::pair<Poly,Poly> first_two_root_numerators(const std::vector<Poly>&ascending){
 auto R=ascending;std::reverse(R.begin(),R.end());int M=72;auto R2=square_R_reversed(R,M);std::vector<Poly>R3(M+1);
 for(int m=0;m<=M;m++)if(m%5==1||m%5==2)for(int i=0;i<=m;i++)R3[m]=R3[m]+R[i]*R2[m-i];
 auto target=[&](int m){Poly out;for(int j=0;25*j<=m;j++){Poly inner;for(int i=0;25*j+5*i<=m;i++)inner=inner+frob_n(R2[i],1)*R3[m-25*j-5*i];out=out+frob_n(R2[j],2)*inner;}return out;};
 return {target(71),target(72)};
}
#ifndef CLOSURE_LIBRARY
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";
 std::cout.setf(std::ios::unitbuf); unsigned first=argc>2?std::stoul(argv[2]):0, last=argc>3?std::stoul(argv[3]):ROOTS.size();
 if(first>last||last>ROOTS.size())throw std::runtime_error("bad root index interval");
 for(unsigned ix=first;ix<last;ix++){
  F r=ROOTS[ix],q=QBOUND[ix];auto c=parametrize(r);auto f6=fullF6(c,7);auto f7=fullF6(c,8);int wt6,wt7;Poly p6=rat_H_numerator(f6,q,wt6),p7=rat_H_numerator(f7,q,wt7);assert(wt6==0);auto[g,u,v]=xgcd(p6,p7);assert(g==Poly{1});assert(u*p6+v*p7==g);assert(coeff(p6,0));
  auto s0=normalized_source(c,0,q);assert(coeff(s0[0].a[2],4));auto R0=normalized_residual(c,0,q);int degree=-1;for(auto&p:R0)degree=std::max(degree,deg(p));assert(degree==137);for(unsigned j=1;j<R0.size();j++)assert(deg(R0[j])<137);
  std::cout<<"PASS lower-degree closure r="<<r<<" H=0 degree=137 F6-degree="<<deg(p6)<<" gcd(F6,F7)=1 (F6 zeros have degree139)\n";
  auto R=interpolate_R_H(c,q);auto[e71,e72]=first_two_root_numerators(R);auto[gg,b1,b2]=xgcd(e71,e72);assert(b1*e71+b2*e72==gg);Poly bad=R[140];Poly remaining=gg,removed={1};for(;;){auto a=gcd(remaining,bad);if(deg(a)<=0)break;remaining=quo(remaining,a);removed=removed*a;}
  std::cout<<"mu=0 q-boundary r="<<r<<" first errors H-degrees="<<deg(e71)<<","<<deg(e72)<<" gcd-degree="<<deg(gg)<<" saturated-gcd-degree="<<deg(remaining)<<'\n';
  assert(deg(remaining)==0);assert(removed*remaining==gg);
  std::ofstream o(dest+"/closure_"+std::to_string(r)+".json");o<<"{\"r\":"<<r<<",\"q\":"<<q<<",\"F6_H_numerator\":";printpoly(o,p6);o<<",\"F7_H_numerator\":";printpoly(o,p7);o<<",\"F7_w_residue\":"<<wt7<<",\"F6_F7_bezout\":[";printpoly(o,u);o<<',';printpoly(o,v);o<<"],\"H0_degree\":137,\"scale0\":{\"errors\":[";printpoly(o,e71);o<<',';printpoly(o,e72);o<<"],\"bezout\":[";printpoly(o,b1);o<<',';printpoly(o,b2);o<<"],\"gcd\":";printpoly(o,gg);o<<",\"bad_factor\":";printpoly(o,bad);o<<",\"removed\":";printpoly(o,removed);o<<",\"remaining\":";printpoly(o,remaining);o<<"}}\n";
 }
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
