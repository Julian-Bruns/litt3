// Exact Newton-edge invariants and their exceptional ratio equations.
// No geometric square-existence conclusion is inferred from edge equations.
#define RESIDUAL_LIBRARY
#include "../../src/residual.cpp"
#include <filesystem>
using HP=std::vector<Poly>; // ascending in H, coefficient polynomials in q
void htrim(HP&a){while(!a.empty()&&a.back().empty())a.pop_back();}
HP hpol(const Bi&b){HP p;for(auto[e,c]:b.t){if(e.first<0||e.second<0)throw std::runtime_error("Laurent input to hpol");if((int)p.size()<=e.first)p.resize(e.first+1);if((int)p[e.first].size()<=e.second)p[e.first].resize(e.second+1);p[e.first][e.second]=c;}htrim(p);return p;}
Bi clearunits(Bi a){if(a.zero())return a;int mi=10000,mj=10000;for(auto[e,c]:a.t){mi=std::min(mi,e.first);mj=std::min(mj,e.second);}return shift(a,-mi,-mj);}
Poly hresultant(const HP&a,const HP&b){
 if(a.empty()||b.empty())return {};
 int n=a.size()-1,m=b.size()-1,N=m+n;
 if(!n)return power(a[0],m);if(!m)return power(b[0],n);
 std::vector<std::vector<Poly>> M(N,std::vector<Poly>(N));
 for(int i=0;i<m;i++)for(int j=0;j<=n;j++)M[i][i+j]=a[n-j];
 for(int i=0;i<n;i++)for(int j=0;j<=m;j++)M[m+i][i+j]=b[m-j];
 Poly prev{1};F sign=1;
 for(int k=0;k<N-1;k++){
  if(M[k][k].empty()){int i=k+1;while(i<N&&M[i][k].empty())i++;if(i==N)return {};std::swap(M[k],M[i]);sign=neg(sign);}
  Poly pivot=M[k][k];
  for(int i=k+1;i<N;i++)for(int j=k+1;j<N;j++)M[i][j]=quo(pivot*M[i][j]-M[i][k]*M[k][j],prev);
  for(int i=k+1;i<N;i++)M[i][k].clear();prev=pivot;
 }
 return scale(M[N-1][N-1],sign);
}
F ratvalue(const Rat&a,F h,F w){return divi(eval(a.n,h,w),fpow(eval(DEN,h,w),a.d));}
std::vector<Poly> full_root(const LambdaPoly&R,int upto){
 F lc=coeff(R[0],140);if(!lc)throw std::runtime_error("zero lc");std::vector<Poly>j(upto+1);j[0]={1};
 for(int m=1;m<=upto;m++){Poly b(R.size());for(unsigned l=0;l<R.size();l++)b[l]=divi(coeff(R[l],140-m),lc);trim(b);Poly s;for(int i=1;i<m;i++)s=s+j[i]*j[m-i];j[m]=scale(b-s,3);}
 return j;
}
#ifndef NEWTON_LIBRARY
int main(int argc,char**argv){try{
 initdata();std::string dest=argc>1?argv[1]:"continuation/data";std::filesystem::create_directories(dest);
 F zeta=fpow(primitive,ORDER/3);assert(zeta!=1&&fpow(zeta,3)==1);
 for(F r:ROOTS){auto c=parametrize(r);auto f6=fullF6(c,7),f7=fullF6(c,8);
  Rat ap(c.num[0][2][4],1);Bi ctop=term(Ca,1,0)+term(Cd,0,1);
  Rat betab=scale(Rat(scale(ctop,inv(eps)))+Rat(shift(ap.n,-1,0),ap.d),3);
  std::ofstream o(dest+"/edge_"+std::to_string(r)+".json");
  o<<"{\"r\":"<<r<<",\"status\":\"global edge equations; validation fibers are not geometric exclusions\",\"F6_num\":";printbi(o,toHq(f6.n));o<<",\"F6_den_power\":"<<f6.d<<",\"F7_over_w_num\":";printbi(o,toHq(f7.n,-1));o<<",\"F7_den_power\":"<<f7.d<<",\"beta_big_over_w_num\":";printbi(o,toHq(betab.n,-1));o<<",\"beta_big_den_power\":"<<betab.d;
  o<<",\"validation\":[";bool first=true;
  for(auto hw:std::vector<std::pair<F,F>>{{2,3},{25,2}}){F h=hw.first,w=hw.second;auto s=evaluate_source(c,h,w);F small=ratvalue(f6,h,w);if(!small)throw std::runtime_error("validation F6=0");verify_source_direct(r,s);auto R=residual(r,s);F lc=coeff(R[0],140);
   F gb=divi(mul(3,fpow(eps,2)),fpow(h,3)),gs=divi(fpow(24,2),small);
   F aa=fpow(gb,3),bb=fpow(gs,3),kb=mul(3,mul(fpow(gb,2),ratvalue(betab,h,w))),ks=mul(3,mul(fpow(gs,2),divi(ratvalue(f7,h,w),small)));
   auto B=[&](int l,int m){return divi(coeff(R[l],140-m),lc);};
   assert(B(3,4)==add(aa,bb));assert(B(6,8)==mul(aa,bb));assert(B(2,3)==add(kb,ks));assert(B(5,7)==add(mul(kb,bb),mul(ks,aa)));
   for(int l=0;l<=6;l++)for(int m=0;m<=140;m++)if(3*m<4*l)assert(B(l,m)==0);
   auto j=full_root(R,80);
   F expected=mul(2,mul(mul(fpow(aa,5),fpow(bb,5)),mul(fpow(add(aa,bb),6),fpow(sub(aa,bb),2))));
   assert(coeff(j[72],54)==expected);
   if(!first)o<<',';first=false;o<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"a\":"<<aa<<",\"b\":"<<bb<<",\"kb\":"<<kb<<",\"ks\":"<<ks<<",\"j72_l54\":"<<expected<<",\"j71_degree\":"<<deg(j[71])<<",\"j72_degree\":"<<deg(j[72])<<"}";
  }
  o<<"],\"exceptional_ratio_equations\":[";
  for(int j=0;j<3;j++){
   F zz=fpow(zeta,j),cc=divi(mul(2,mul(fpow(zz,2),fpow(24,2))),fpow(eps,2));
   Rat u=f6-scale(Rat(term(1,3,0)),cc),v=f7-scale(Rat(term(1,3,0))*betab,mul(zz,cc));
   Bi U=clearunits(toHq(u.n)),V=clearunits(toHq(v.n,-1));
   HP hu=hpol(U),hv=hpol(V);Poly res=hresultant(hu,hv),sf;
   if(!res.empty()){sf=quo(res,gcd(res,diff(res)));while(!sf.empty()&&coeff(sf,0)==0)sf=shift(sf,-1);}
   if(j)o<<',';o<<"{\"zeta\":"<<zz<<",\"c_zeta\":"<<cc<<",\"first_H_q\":";printbi(o,U);o<<",\"second_H_q\":";printbi(o,V);o<<",\"resultant_q\":";printpoly(o,res);o<<",\"separable_part_q\":";printpoly(o,sf);o<<"}";
   std::cout<<"PASS r="<<r<<" branch="<<j<<" H-degrees="<<hu.size()-1<<","<<hv.size()-1<<" resultant degree="<<deg(res)<<" separable_part="<<deg(sf)<<std::endl;
  }
  o<<"]}\n";
 }
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
#endif
