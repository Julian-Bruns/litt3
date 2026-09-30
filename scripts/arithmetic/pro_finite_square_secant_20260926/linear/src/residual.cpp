#define PSI_LIBRARY
#include "psi.cpp"
using LambdaPoly=std::vector<Poly>;
Source evaluate_source(const RationalChart&c,F h,F w){F denominator=eval(c.den,h,w);if(!denominator)throw std::runtime_error("Cramer pivot");Source s;
 for(int b=0;b<4;b++)for(int j=0;j<3;j++){auto&to=s[b].a[j];to.resize(c.num[b][j].size());for(unsigned i=0;i<to.size();i++)to[i]=divi(eval(c.num[b][j][i],h,w),denominator);trim(to);}return s;
}
BiSource embed_source(const Source&s){BiSource o;for(int b=0;b<4;b++)for(int j=0;j<3;j++)for(F c:s[b].a[j])o[b][j].push_back(Bi(c));return o;}
F pointF6(const Source&s){auto fs=Fjet(embed_source(s));for(int i=0;i<6;i++)assert(fs[i].zero());assert(fs[6].t.size()<=1);return fs[6].zero()?0:fs[6].t.begin()->second;}
long long binom(int n,int k){if(k<0||k>n)return 0;long long a=1;for(int i=1;i<=k;i++)a=a*(n+1-i)/i;return a;}
void verify_source_direct(F r,const Source&s){
 Fun v(Poly{neg(r),1}),T=Fun(power(tp,3))*monom(0,10);
 std::array<Fun,11>N;N[0]=v;for(int i=2;i<=5;i++)N[i]=s[i-2];N[5]=N[5]+v*Fun(Q);
 for(int j=1;j<=5;j++){Fun z;for(int i=0;i<=j;i++)z=z+scale(Fun(power(scale(B0,4),j-i))*N[i],binom(5-i,j-i)%5);divide_y(z,j);}
 for(int j=0;j<=4;j++){Fun z;for(int i=0;i<=5;i++)if(5-i>=j)z=z+scale(Fun(power(scale(L0,4),5-i-j))*N[i],binom(5-i,j)%5);z=Fun(Q-frob(L0))*z;if(j==0)z=z+T;assert(fmod(z,power(tp,5-j)).zero());}
 for(int j=0;j<=10;j++){Fun z=N[j];if(j>=5)z=z+Fun(Q)*N[j-5];if(j==10)z=z+T;assert(pole(z)<=10+12*j-std::max(0,j-5));}
 auto D=divide_y(s[0],2);assert(eval(D.a[0],r)==0);assert(pole(D)<=13);assert(pole(s[1])<=46);assert(pole(s[2])<=57);
 auto top=topcoords(s);assert(coeff(s[1].a[1],12)==eps);assert(coeff(s[1].a[0],15)==add(mul(Ca,top[0]),mul(Cd,top[1])));
 if(top[1]){F z=divi(mul(2,top[1]),eps),c=coeff(s[1].a[0],15);assert(top[2]==neg(add(mul(c,z),divi(eta,mul(24,z)))));assert(top[3]==neg(add(divi(fpow(top[1],2),eps),mul(divi(8,24),fpow(z,5)))));}
}
Fun frob_fun(const Fun&a){Fun b;for(int j=0;j<3;j++){Fun z;z.a[(5*j)%3]=frob(a.a[j])*power(CP,(5*j)/3);b=b+z;}return b;}
std::array<Fun,3> resultant_coeffs(const Source&s,const Fun&Qq,const Fun&T,const Fun&v){
 Fun a=s[0],b=s[1],c=s[2],d=s[3];
 Fun a2=a*a,a3=a2*a,a4=a2*a2,a5=frob_fun(a),a10=a5*a5;
 Fun b2=b*b,b3=b2*b,b4=b2*b2,b5=frob_fun(b),c2=c*c,c3=c2*c,c4=c2*c2,c5=frob_fun(c);
 Fun U=b3+scale(a*b*c,3)+a2*d;
 Fun V=a5*Qq*Qq+b5*Qq+scale(c5,2),W=b5+scale(a5*Qq,2);
 Fun K=a2*d*d+a*b*c*d+scale(b3*d,2)+scale(b2*c2,2)+scale(a*c3,2);
 Fun C=scale(Qq*a5*d,2)+Qq*a4*b*c+scale(Qq*a3*b3,2)-a2*c4-scale(a*b2*c3,2)+b5*d+b4*c2;
 Fun E=scale(W*U,2)-a2*C;
 Fun R2=scale(v*v*V*V,4);
 Fun R1=scale(v*(V*C+T*(W*W-scale(a5*V,2))),4);
 Fun R0=scale(a3*V*K+a3*T*E+a10*T*T,4);
 return {R0,R1,R2};
}
LambdaPoly lpadd(LambdaPoly a,const LambdaPoly&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=a[i]+b[i];return a;}
LambdaPoly lpsub(LambdaPoly a,const LambdaPoly&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=a[i]-b[i];return a;}
LambdaPoly lpmul(const LambdaPoly&a,const LambdaPoly&b){LambdaPoly c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)for(unsigned j=0;j<b.size();j++)c[i+j]=c[i+j]+a[i]*b[j];return c;}
LambdaPoly lpscale(LambdaPoly a,const Poly&s){for(auto&b:a)b=b*s;return a;}
LambdaPoly lpnorm(const std::array<Fun,3>&f){std::array<LambdaPoly,3>a;for(int j=0;j<3;j++)for(int i=0;i<3;i++)a[j].push_back(f[i].a[j]);return lpsub(lpadd(lpadd(lpmul(lpmul(a[0],a[0]),a[0]),lpscale(lpmul(lpmul(a[1],a[1]),a[1]),CP)),lpscale(lpmul(lpmul(a[2],a[2]),a[2]),power(CP,2))),lpscale(lpmul(lpmul(a[0],a[1]),a[2]),scale(CP,3)));}
Source smaller_source(const Source&s){Source g;g[0]=divide_y(s[0],2);g[1]=divide_y(s[1]-scale(Fun(B0)*s[0],3),3);g[2]=divide_y(s[2]-scale(Fun(B0)*s[1],2)+scale(Fun(power(B0,2))*s[0],3),4);g[3]=divide_y(s[3]-Fun(B0)*s[2]+Fun(power(B0,2))*s[1]-Fun(power(B0,3))*s[0],5);return g;}
LambdaPoly residual(F r,const Source&s,bool small=true){Fun v(Poly{neg(r),1});std::array<Fun,3>res;
 Poly den=power(tp,15)*power(v.a[0],3);
 if(small){auto gg=smaller_source(s);Fun qbar=monom(0,1)*Fun(quo(Q-frob(B0),power(P,2)));res=resultant_coeffs(gg,qbar,Fun(power(tp,3)),v);}
 else{res=resultant_coeffs(s,Fun(Q),Fun(power(tp,3))*monom(0,10),v);den=den*power(P,40);}
 auto R=lpnorm(res);for(auto&rr:R)rr=quo(rr,den);return R;
}
Poly evaluate_lambda(const LambdaPoly&R,F lambda){Poly p;for(int i=int(R.size())-1;i>=0;i--)p=scale(p,lambda)+R[i];return p;}
std::pair<bool,Poly> square_test(const Poly&R){if(R.empty())return {true,{}};if(deg(R)%2)return {false,{}};int n=deg(R)/2;Poly B=scale(R,inv(R.back()));std::reverse(B.begin(),B.end());Poly j(n+1);j[0]=1;for(int m=1;m<=n;m++){F s=0;for(int i=1;i<m;i++)s=add(s,mul(j[i],j[m-i]));j[m]=mul(3,sub(coeff(B,m),s));}
 bool yes=power(j,2)==B;std::reverse(j.begin(),j.end());return {yes,j};}
struct ScaleTest{Poly gcdpoly;std::vector<std::pair<int,Poly>> generators;std::vector<Poly> bezout;};
ScaleTest all_scales(const LambdaPoly&R,int max_index=140){
 F lc=coeff(R[0],140);if(!lc)throw std::runtime_error("degree-140 leading coefficient zero");for(unsigned l=1;l<R.size();l++)if(coeff(R[l],140))throw std::runtime_error("leading coefficient depends on scale");
 std::vector<Poly>B(141);for(int m=0;m<=140;m++){B[m].resize(R.size());for(unsigned l=0;l<R.size();l++)B[m][l]=divi(coeff(R[l],140-m),lc);trim(B[m]);}assert(B[0]==Poly{1});
 std::vector<Poly>j(141);j[0]={1};ScaleTest o;
 for(int m=1;m<=max_index;m++){
  Poly s;for(int i=1;i<m;i++)s=s+j[i]*j[m-i];j[m]=scale(B[m]-s,3);
  if(m>70&&!j[m].empty()){
   if(o.generators.empty()){o.gcdpoly=scale(j[m],inv(j[m].back()));o.bezout={Poly{inv(j[m].back())}};}
   else{auto[g,u,v]=xgcd(o.gcdpoly,j[m]);for(auto&z:o.bezout)z=z*u;o.bezout.push_back(v);o.gcdpoly=g;}
   o.generators.push_back({m,j[m]});if(o.gcdpoly==Poly{1})break;
  }
 }
 Poly check;for(unsigned i=0;i<o.generators.size();i++)check=check+o.bezout[i]*o.generators[i].second;assert(check==o.gcdpoly);return o;
}
#ifndef RESIDUAL_LIBRARY
int main(int argc,char**argv){try{initdata();std::string dest=argc>1?argv[1]:"data";for(F root:ROOTS){auto c=parametrize(root);F h=2,w=3;auto s=evaluate_source(c,h,w);verify_source_direct(root,s);F f6=pointF6(s);assert(f6);auto R=residual(root,s);auto Rbig=residual(root,s,false);assert(R==Rbig);assert(deg(R[0])==140);for(unsigned l=1;l<R.size();l++)assert(deg(R[l])<140);F lc=fpow(mul(mul(3,fpow(h,3)),mul(fpow(eps,8),f6)),3);assert(R[0].back()==lc);
 auto test=all_scales(R);assert(test.gcdpoly==Poly{1});std::ofstream out(dest+"/check_"+std::to_string(root)+".json");out<<"{\"status\":\"exact single-ratio-fiber verification only; not a global exclusion\",\"r\":"<<root<<",\"h\":"<<h<<",\"w\":"<<w<<",\"F6\":"<<f6<<",\"lambda_generators\":[";for(unsigned i=0;i<test.generators.size();i++){if(i)out<<',';out<<"{\"index\":"<<test.generators[i].first<<",\"polynomial\":";printpoly(out,test.generators[i].second);out<<",\"bezout\":";printpoly(out,test.bezout[i]);out<<'}';}out<<"],\"gcd\":";printpoly(out,test.gcdpoly);out<<"}\n";
 std::cout<<"PASS full source conditions, both resultant routes, degree and leading coefficient r="<<root<<" h="<<h<<" w="<<w<<" F6="<<f6<<" scale gcd=1 indices=";for(auto [i,p]:test.generators)std::cout<<i<<":"<<deg(p)<<" ";std::cout<<'\n';}
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
#endif
