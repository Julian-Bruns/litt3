#pragma once
// Polynomial arithmetic in A[z], A=K[q]/(squarefree modulus).
// qa::inverse throws a Split with an exact nonunit factor; callers must retain it.
namespace fa {
using exact::operator+; using exact::operator-; using exact::operator*;
using AP=std::vector<Poly>; // polynomial in z, coefficients in A
inline void trim(AP&a){while(!a.empty()&&a.back().empty())a.pop_back();}
inline AP constant(const Poly&a){return a.empty()?AP{}:AP{a};}
inline AP scalar(const exact::Poly&a){AP z;for(auto c:a)z.push_back(c?Poly{c}:Poly{});trim(z);return z;}
inline Poly at(const AP&a,int i){return i>=0&&i<int(a.size())?a[i]:Poly{};}
inline AP plus(AP a,const AP&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=a[i]+b[i];trim(a);return a;}
inline AP minus(AP a,const AP&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=a[i]-b[i];trim(a);return a;}
inline AP scale(AP a,const Poly&b){for(auto&c:a)c=qa::times(c,b);trim(a);return a;}
inline AP kscale(AP a,F b){for(auto&c:a)c=exact::scale(c,b);trim(a);return a;}
inline AP cut(const AP&a,int start,int stop){if(start>=int(a.size()))return {};AP b(a.begin()+start,a.begin()+std::min<int>(stop,a.size()));trim(b);return b;}
inline void shifted_add(AP&to,const AP&a,int start){to.resize(std::max<int>(to.size(),a.size()+start));for(unsigned i=0;i<a.size();i++)to[i+start]=to[i+start]+a[i];}
inline AP times(const AP&a,const AP&b){
 if(a.empty()||b.empty())return{};
 if(std::min(a.size(),b.size())<=12){AP c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)if(!a[i].empty())for(unsigned j=0;j<b.size();j++)if(!b[j].empty())c[i+j]=c[i+j]+qa::times(a[i],b[j]);trim(c);return c;}
 int k=std::max(a.size(),b.size())/2;auto al=cut(a,0,k),ah=cut(a,k,a.size()),bl=cut(b,0,k),bh=cut(b,k,b.size());auto lo=times(al,bl),hi=times(ah,bh),mid=minus(minus(times(plus(al,ah),plus(bl,bh)),lo),hi);AP c;shifted_add(c,lo,0);shifted_add(c,mid,k);shifted_add(c,hi,2*k);trim(c);return c;
}
inline AP times_scalar(const AP&a,const exact::Poly&b){if(a.empty()||b.empty())return{};AP c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)for(unsigned j=0;j<b.size();j++)if(b[j])c[i+j]=c[i+j]+exact::scale(a[i],b[j]);trim(c);return c;}
inline AP pow(AP a,unsigned n){AP b=scalar({1});while(n){if(n&1)b=times(b,a);a=times(a,a);n>>=1;}return b;}
inline AP frob(AP a){if(a.empty())return a;AP b(5*a.size()-4);for(unsigned i=0;i<a.size();i++)b[5*i]=qa::red(exact::frob(a[i]));trim(b);return b;}
inline AP frob_n(AP a,unsigned n){while(n--)a=frob(a);return a;}
inline std::pair<AP,AP> divide(AP a,const AP&b){if(b.empty())throw std::runtime_error("AP division by zero");auto ib=qa::inverse(b.back());AP q(std::max<int>(0,a.size()-b.size()+1));for(int i=int(a.size())-int(b.size());i>=0;i--){auto c=qa::times(a[i+b.size()-1],ib);q[i]=c;for(unsigned j=0;j<b.size();j++)a[i+j]=a[i+j]-qa::times(c,b[j]);}trim(q);trim(a);return {q,a};}
inline AP exact_divide_scalar(AP a,const exact::Poly&b){if(b.empty())throw std::runtime_error("AP scalar division by zero");F ib=inv(b.back());AP q(std::max<int>(0,a.size()-b.size()+1));for(int i=int(a.size())-int(b.size());i>=0;i--){auto c=exact::scale(a[i+b.size()-1],ib);q[i]=c;for(unsigned j=0;j<b.size();j++)if(b[j])a[i+j]=a[i+j]-exact::scale(c,b[j]);}trim(q);trim(a);if(!a.empty())throw std::runtime_error("inexact AP scalar quotient");return q;}
inline std::tuple<AP,AP,AP> xgcd(AP a,AP b){AP u=scalar({1}),v,s,t=scalar({1});while(!b.empty()){auto[q,r]=divide(a,b);a=b;b=r;auto nu=minus(u,times(q,s)),nv=minus(v,times(q,t));u=s;v=t;s=nu;t=nv;}if(a.empty())return {a,u,v};auto c=qa::inverse(a.back());return {scale(a,c),scale(u,c),scale(v,c)};}
inline Poly evaluate(const AP&a,const Poly&z){Poly b;for(int i=int(a.size())-1;i>=0;i--)b=qa::plus(qa::times(b,z),a[i]);return b;}
inline void print(std::ostream&o,const AP&a){o<<'[';for(unsigned i=0;i<a.size();i++){if(i)o<<',';printpoly(o,a[i]);}o<<']';}
struct CF {std::array<AP,3>a;CF()=default;CF(F b){if(b)a[0]=scalar({b});}CF(AP b){a[0]=std::move(b);}};
inline Poly qinv;
inline CF plus(CF a,const CF&b){for(int i=0;i<3;i++)a.a[i]=plus(a.a[i],b.a[i]);return a;}
inline CF minus(CF a,const CF&b){for(int i=0;i<3;i++)a.a[i]=minus(a.a[i],b.a[i]);return a;}
inline CF kscale(CF a,F c){for(auto&b:a.a)b=kscale(b,c);return a;}
inline CF scale(CF a,const Poly&c){for(auto&b:a.a)b=scale(b,c);return a;}
inline CF times(const CF&a,const CF&b){CF c;for(int i=0;i<3;i++)for(int j=0;j<3;j++){auto z=times(a.a[i],b.a[j]);if(i+j>=3)z=scale(times_scalar(z,P),qinv);c.a[(i+j)%3]=plus(c.a[(i+j)%3],z);}return c;}
inline CF frob(const CF&a){CF b;for(int j=0;j<3;j++){auto z=frob(a.a[j]);int p=5*j/3;z=scale(times_scalar(z,power(P,p)),qa::pow(qinv,p));b.a[(5*j)%3]=z;}return b;}
inline CF divide_Y(const CF&a,int n){CF b;for(int j=0;j<3;j++){int e=j-n,p=e/3,r=e%3;if(r<0){r+=3;p--;}auto z=a.a[j];if(p<0)z=scale(exact_divide_scalar(z,power(P,-p)),qa::pow(qinv,p));else z=scale(times_scalar(z,power(P,p)),qa::pow(qinv,p));b.a[r]=z;}return b;}
using CS=std::array<CF,4>;
inline CF operator+(const CF&a,const CF&b){return plus(a,b);}inline CF operator-(const CF&a,const CF&b){return minus(a,b);}inline CF operator*(const CF&a,const CF&b){return times(a,b);}
inline Poly eval_bi(const Bi&a,const Poly&H){Poly s;for(auto[e,c]:a.t)s=qa::plus(s,exact::scale(qa::times(qa::pow(H,e.first),qa::pow(Poly{0,1},e.second)),c));return s;}
inline CS source(const RationalChart&c,const Poly&H){qinv=qa::inverse(qa::red({0,1}));int ix=std::find(ROOTS.begin(),ROOTS.end(),c.c.r)-ROOTS.begin();Poly deninv=qa::inverse(qa::red({neg(QPIVOT[ix]),1}));CS s;for(int b=0;b<4;b++)for(int j=0;j<3;j++){for(auto &n:c.num[b][j])s[b].a[j].push_back(qa::times(eval_bi(toHq(n,j-1),H),deninv));trim(s[b].a[j]);}return s;}
inline CS smaller(const CS&s){CF bb(scalar(B0)),bb2=bb*bb,bb3=bb2*bb;return {divide_Y(s[0],2),divide_Y(s[1]-kscale(bb*s[0],3),3),divide_Y(s[2]-kscale(bb*s[1],2)+kscale(bb2*s[0],3),4),divide_Y(s[3]-bb*s[2]+bb2*s[1]-bb3*s[0],5)};}
inline std::array<CF,3> resultant(const CS&s,const CF&Qq,const CF&T,const CF&v){
 CF a=s[0],b=s[1],c=s[2],d=s[3];CF a2=a*a,a3=a2*a,a4=a2*a2,a5=frob(a),a10=a5*a5;CF b2=b*b,b3=b2*b,b4=b2*b2,b5=frob(b),c2=c*c,c3=c2*c,c4=c2*c2,c5=frob(c);CF U=b3+kscale(a*b*c,3)+a2*d;CF V=a5*Qq*Qq+b5*Qq+kscale(c5,2),W=b5+kscale(a5*Qq,2);CF K=a2*d*d+a*b*c*d+kscale(b3*d,2)+kscale(b2*c2,2)+kscale(a*c3,2);CF C=kscale(Qq*a5*d,2)+Qq*a4*b*c+kscale(Qq*a3*b3,2)-a2*c4-kscale(a*b2*c3,2)+b5*d+b4*c2;CF E=kscale(W*U,2)-a2*C;return {kscale(a3*V*K+a3*T*E+a10*T*T,4),kscale(v*(V*C+T*(W*W-kscale(a5*V,2))),4),kscale(v*v*V*V,4)};
}
using LP=std::vector<AP>; // mu, then x, then q
inline LP lpadd(LP a,const LP&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=plus(a[i],b[i]);return a;}
inline LP lpsub(LP a,const LP&b){a.resize(std::max(a.size(),b.size()));for(unsigned i=0;i<b.size();i++)a[i]=minus(a[i],b[i]);return a;}
inline LP lpmul(const LP&a,const LP&b){LP c(a.size()+b.size()-1);for(unsigned i=0;i<a.size();i++)for(unsigned j=0;j<b.size();j++)c[i+j]=plus(c[i+j],times(a[i],b[j]));return c;}
inline LP lpP(LP a,int n,F sc=1){for(auto&b:a)b=kscale(scale(times_scalar(b,power(P,n)),qa::pow(qinv,n)),sc);return a;}
inline LP norm(const std::array<CF,3>&f){std::array<LP,3>a;for(int j=0;j<3;j++)for(int i=0;i<3;i++)a[j].push_back(f[i].a[j]);return lpsub(lpadd(lpadd(lpmul(lpmul(a[0],a[0]),a[0]),lpP(lpmul(lpmul(a[1],a[1]),a[1]),1)),lpP(lpmul(lpmul(a[2],a[2]),a[2]),2)),lpP(lpmul(lpmul(a[0],a[1]),a[2]),1,3));}
inline LP residual(const RationalChart&c,const Poly&H){
 auto s=smaller(source(c,H));CF qb;qb.a[1]=scale(scalar(quo(Q,Poly{1})-exact::frob(B0)),qa::pow(Poly{0,1},2));qb.a[1]=exact_divide_scalar(qb.a[1],power(P,2));CF T(scale(scalar(power(tp,3)),qa::pow(Poly{0,1},3))),v(scalar({neg(c.c.r),1}));auto rr=resultant(s,qb,T,v);auto R=norm(rr);auto den=power(tp,15)*power(Poly{neg(c.c.r),1},3);for(auto&f:R)f=scale(exact_divide_scalar(f,den),qa::pow(qinv,15));return R;
}
// B(T)^63 = B^3*(B^2)^5*(B^2)^25 modulo T^125.
// Works in every characteristic-five coefficient algebra; no root selection.
inline std::pair<AP,AP> errors71_72(const LP&R){
 int M=72;std::vector<AP>B(M+1),B2(M+1),B3(M+1);Poly ilc=qa::inverse(at(R[0],140));
 for(int m=0;m<=M;m++){for(auto&f:R)B[m].push_back(qa::times(at(f,140-m),ilc));trim(B[m]);}assert(B[0]==scalar({1}));
 for(int m=0;m<=M;m++)for(int i=0;i<=m/2;i++){auto z=times(B[i],B[m-i]);B2[m]=plus(B2[m],i==m-i?z:kscale(z,2));}
 for(int m=0;m<=M;m++)if(m%5==1||m%5==2)for(int i=0;i<=m;i++)B3[m]=plus(B3[m],times(B[i],B2[m-i]));
 auto target=[&](int m){AP out;for(int j=0;25*j<=m;j++){AP inner;for(int i=0;25*j+5*i<=m;i++)inner=plus(inner,times(frob(B2[i]),B3[m-25*j-5*i]));out=plus(out,times(frob_n(B2[j],2),inner));}return out;};return {target(71),target(72)};
}
} // namespace fa
