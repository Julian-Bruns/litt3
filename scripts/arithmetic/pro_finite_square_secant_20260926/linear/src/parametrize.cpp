#define RECONSTRUCT_LIBRARY
#include "reconstruct.cpp"
#include "bivariate.hpp"
using BiFun=std::array<std::vector<Bi>,3>;
using BiSource=std::array<BiFun,4>;
BiSource combine(const Chart&c,const std::array<Bi,7>&p){BiSource out;for(int k=0;k<7;k++)for(int b=0;b<4;b++)for(int j=0;j<3;j++){
 auto&a=out[b][j];auto&from=c.s[k][b].a[j];a.resize(std::max(a.size(),from.size()));for(unsigned i=0;i<from.size();i++)a[i]=a[i]+scale(p[k],from[i]);
}return out;}
Poly Yseries(unsigned n){Poly out(n);out[0]=1;for(unsigned m=1;m<n;m++){auto cube=powtrunc(out,3,m+1);F target=m%3==0?coeff(P,10-m/3):0;out[m]=mul(2,sub(target,coeff(cube,m)));}trim(out);return out;}
Jet at_infinity(const BiFun&a,int offset,int n){Jet r(n);Poly Y=Yseries(n);for(int j=0;j<3;j++)for(unsigned i=0;i<a[j].size();i++){
 int start=offset-3*int(i)-10*j;if(start<0){if(!a[j][i].zero())throw std::runtime_error("negative jet exponent");continue;}if(start>=n)continue;auto yj=powtrunc(Y,j,n-start);
 for(unsigned k=0;k<yj.size();k++)r[start+k]=r[start+k]+scale(a[j][i],yj[k]);
}return r;}
Jet Fjet(const BiSource&s,int n=7){
 Jet a=jscale(at_infinity(s[0],35,n),3),b=jscale(at_infinity(s[1],46,n),2),c=at_infinity(s[2],57,n);assert(a[0].zero());assert(b[0]==Bi(mul(2,eps)));
 Jet rho(n);rho[0]=scale(c[0],neg(inv(mul(2,eps))));
 for(int i=1;i<n;i++){auto eq=jadd(jadd(jmul(a,jmul(rho,rho,n),n),jmul(b,rho,n),n),c,n);rho[i]=scale(eq[i],neg(inv(mul(2,eps))));}
 auto eq=jadd(jadd(jmul(a,jmul(rho,rho,n),n),jmul(b,rho,n),n),c,n);for(auto&x:eq)assert(x.zero());
 BiFun qfun;qfun[0].resize(Q.size());for(unsigned i=0;i<Q.size();i++)qfun[0][i]=Bi(Q[i]);Jet qq=at_infinity(qfun,57,n);
 Jet L=jadd(qq,jshift(jpow(rho,5,n),2,n),n);
 Jet M=jadd(at_infinity(s[3],70,n),jshift(jadd(jmul(a,jpow(rho,3,n),n),jscale(jmul(b,jpow(rho,2,n),n),2),n),2,n),n);
 auto r=jmul(L,M,n);
 auto tt=power(tp,3);auto yy=powtrunc(Yseries(n),10,n);
 Jet T(n);for(unsigned i=0;i<tt.size();i++){int st=27-3*int(i);if(st<0)throw std::runtime_error("bad t pole");for(unsigned k=0;k<yy.size()&&st+int(k)<n;k++)if(st+int(k)>=0)T[st+k]=T[st+k]+Bi(mul(tt[i],yy[k]));}
 return jadd(r,T,n);
}
struct RationalChart{Chart c;Bi det;std::array<Bi,2> kernelnum;BiSource num;Bi F6num;Bi den;};
RationalChart parametrize(F r){Chart c=chart(r);Bi h=term(1,1,0),w=term(1,0,1);Bi z=scale(w,divi(2,eps));Bi cc=scale(h,Ca)+scale(w,Cd);Bi ee=Bi()-cc*z-term(divi(mul(eta,eps),mul(24,2)),0,-1);Bi ff=scale(power(w,2),neg(inv(eps)))-scale(power(z,5),divi(8,24));
 std::array<Bi,7>par={Bi(1),h,w,ee,ff,Bi(),Bi()};auto S0=combine(c,par);auto f0=Fjet(S0);
 for(int j=0;j<4;j++)assert(f0[j].zero());
 auto p1=par;p1[5]=Bi(1);auto f1=Fjet(combine(c,p1));auto p2=par;p2[6]=Bi(1);auto f2=Fjet(combine(c,p2));
 Bi a11=f1[4]-f0[4],a12=f2[4]-f0[4],a21=f1[5]-f0[5],a22=f2[5]-f0[5];Bi det=a11*a22-a12*a21;
 Bi u=a12*f0[5]-a22*f0[4],v=a21*f0[4]-a11*f0[5];
 // Injective Kronecker check. F4,F5 have degree <=8 in source jets.
 // After the graph, the base h-degree is <=8 and w-exponents lie in [-8,40].
 // k1=h^100,k2=w^1000 therefore separates the relevant monomials.
 auto ptest=par;ptest[5]=power(h,100);ptest[6]=power(w,1000);auto ft=Fjet(combine(c,ptest));
 assert(ft[4]==f0[4]+a11*ptest[5]+a12*ptest[6]);assert(ft[5]==f0[5]+a21*ptest[5]+a22*ptest[6]);
 RationalChart out;out.c=c;out.det=det;out.kernelnum={u,v};
 // Uniform monic denominator d(q)=q-qpivot, removing the nonzero scalar and w^2.
 assert(det.t.size()==2);F piv=QPIVOT[std::find(ROOTS.begin(),ROOTS.end(),r)-ROOTS.begin()];
 Bi d=term(1,0,3)-Bi(piv);Bi scaleunit=exactdivide(det,d);assert(scaleunit.t.size()==1);assert(scaleunit.t.begin()->first==std::make_pair(0,2));
 u=exactdivide(u,scaleunit);v=exactdivide(v,scaleunit);out.den=d;out.kernelnum={u,v};
 for(auto &p:par)p=p*d;par[5]=u;par[6]=v;out.num=combine(c,par);
 // The complete F6 expression is computed symbolically by psi.cpp,
 // with exact denominator bookkeeping; no parameter interpolation is used.
 return out;
}
void writeparam(const RationalChart&r,std::string file){std::ofstream o(file);o<<"{\n\"r\":"<<r.c.r<<",\n\"denominator_h_w\":";printbi(o,r.den);o<<",\n\"determinant_h_w\":";printbi(o,r.det);o<<",\n\"kernel_numerators_h_w\":[";printbi(o,r.kernelnum[0]);o<<',';printbi(o,r.kernelnum[1]);o<<"],\n\"normalized_field\":\"Y^3=P/q; original y=wY\",\n\"normalized_functions\":\"G_i(x,wY)=w*num_i(H,q,x,Y)/(q-qpivot)\",\n\"source_numerators_H_q\":[\n";
 for(int b=0;b<4;b++){if(b)o<<",\n";o<<'[';for(int j=0;j<3;j++){if(j)o<<',';o<<'[';for(unsigned i=0;i<r.num[b][j].size();i++){if(i)o<<',';printbi(o,toHq(r.num[b][j][i],j-1));}o<<']';}o<<']';}o<<"]\n}\n";
}
#ifndef PARAMETRIZE_LIBRARY
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";for(F root:ROOTS){auto r=parametrize(root);writeparam(r,dest+"/param_"+std::to_string(root)+".json");std::cout<<"PASS exact Cramer determinant, linear jet checks, cube-root-free conversion r="<<root<<'\n';}return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
