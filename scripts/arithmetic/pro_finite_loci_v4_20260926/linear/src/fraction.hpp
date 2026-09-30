#pragma once
#include "laurent.hpp"
inline F FRACTION_PIVOT;
inline LW frac_den(){return LW::mon(0,3)-LW(FRACTION_PIVOT);}
inline std::optional<LW> divide_d(const LW& a){
 if(!a)return LW();
 std::map<int,std::map<int,F>> rows;for(auto[e,c]:a.c)rows[e.first][e.second]=c;
 LW q;Poly den=Poly::mon(3)-Poly(FRACTION_PIVOT);
 for(auto [h,row]:rows){int low=row.begin()->first,high=row.rbegin()->first;std::vector<F> v(high-low+1);for(auto[w,c]:row)v[w-low]=c;
  auto [qq,rr]=Poly(v).divrem(den);if(rr)return std::nullopt;for(int j=0;j<=qq.deg();j++)q.put({h,j+low},qq[j]);
 }
 return q;
}
struct LF{
 LW n;int e=0;
 LF()=default;LF(int a):n(a){}LF(F a):n(a){}LF(LW a):n(std::move(a)){}
 LF(LW a,int b):n(std::move(a)),e(b){reduce();}
 void reduce(){if(!n){e=0;return;}while(e>0){auto q=divide_d(n);if(!q)break;n=*q;e--;}}
 explicit operator bool()const{return bool(n);}
 bool operator==(const LF& b)const{return n==b.n&&e==b.e;}
 LF operator-()const{return LF(-n,e);}
 LF operator+(const LF& b)const{int de=std::max(e,b.e);return LF(n*frac_den().pow(de-e)+b.n*frac_den().pow(de-b.e),de);}
 LF operator-(const LF& b)const{return *this+-b;}
 LF operator*(const LF& b)const{return LF(n*b.n,e+b.e);}
 LF operator*(F b)const{return LF(n*b,e);}
 LF operator/(F b)const{return LF(n/b,e);}
 LF& operator+=(const LF& b){return *this=*this+b;}
 LF frob(int p)const{return LF(n.frob(p),e*p);}
};
template<class T> using JVec=std::vector<T>;
template<class T> JVec<T> tjconst(T a){JVec<T> out(JET_N);out[0]=a;return out;}
template<class T> JVec<T> tjadd(JVec<T> a,const JVec<T>& b){for(int i=0;i<JET_N;i++)a[i]+=b[i];return a;}
template<class T> JVec<T> tjscale(JVec<T> a,F b){for(auto&p:a)p=p*b;return a;}
template<class T> JVec<T> tjmul(const JVec<T>& a,const JVec<T>& b){JVec<T> out(JET_N);for(int i=0;i<JET_N;i++)for(int j=0;j+i<JET_N;j++)out[i+j]+=a[i]*b[j];return out;}
template<class T> JVec<T> tjshift(const JVec<T>& a,int s){JVec<T> out(JET_N);for(int i=0;i+s<JET_N;i++)out[i+s]=a[i];return out;}
template<class T> JVec<T> tjpow(JVec<T> a,int n){auto out=tjconst(T(1));while(n){if(n&1)out=tjmul(out,a);a=tjmul(a,a);n>>=1;}return out;}
template<class T> JVec<T> tjfrob(const JVec<T>& a,int p){JVec<T> out(JET_N);for(int i=0;i*p<JET_N;i++)out[i*p]=a[i].frob(p);return out;}
template<class T> std::array<JVec<T>,4> tsource_jets(const std::vector<T>& coeff){
 auto yy=makeY();std::vector<std::vector<F>> yp(11,std::vector<F>(JET_N));yp[0][0]=F(1);
 for(int j=1;j<=10;j++)for(int a=0;a<JET_N;a++)for(int b=0;a+b<JET_N;b++)yp[j][a+b]+=yp[j-1][a]*yy[b];
 std::array<JVec<T>,4> out;for(auto &a:out)a.resize(JET_N);auto cc=coordinates();int shift[4]={35,46,57,70};
 for(size_t k=0;k<cc.size();k++){
  auto [n,i,j]=cc[k];if(n==0)j+=2;int start=shift[n]-3*i-10*j;
  if(start<0)throw std::runtime_error("source pole exceeds jet shift");for(int m=0;start+m<JET_N;m++)out[n][start+m]+=coeff[k]*yp[j][m];
 }
 out[0]=tjscale(out[0],F(3));out[1]=tjscale(out[1],F(2));return out;
}
template<class T> JVec<T> TF_jets(const std::vector<T>& coeff){
 auto sj=tsource_jets(coeff);auto as=sj[0],bs=sj[1],cs=sj[2];
 if(as[0]||!(bs[0]==T(F(2)*input::eps)))throw std::runtime_error("nonunit/incorrect rational quadratic jet");
 JVec<T> rho(JET_N);rho[0]=-(cs[0]/(F(2)*input::eps));
 for(int n=1;n<JET_N;n++){auto eq=tjadd(tjadd(tjmul(as,tjmul(rho,rho)),tjmul(bs,rho)),cs);rho[n]=-eq[n]/(F(2)*input::eps);}
 auto eq=tjadd(tjadd(tjmul(as,tjmul(rho,rho)),tjmul(bs,rho)),cs);for(auto a:eq)if(a)throw std::runtime_error("rational rho jet check");
 JVec<T> qs(JET_N);for(int i=0;i<=input::Q.deg();i++){int m=57-3*i;if(m<JET_N)qs[m]=T(input::Q[i]);}
 auto left=tjadd(qs,tjshift(tjfrob(rho,5),2));
 auto right=tjadd(sj[3],tjshift(tjadd(tjmul(as,tjpow(rho,3)),tjscale(tjmul(bs,tjpow(rho,2)),F(2))),2));
 auto out=tjmul(left,right);auto yy=makeY();JVec<T> yj(JET_N);for(int i=0;i<JET_N;i++)yj[i]=T(yy[i]);auto y10=tjpow(yj,10);
 Poly tp=input::t.pow(3);for(int i=0;i<=tp.deg();i++){int start=27-3*i;for(int m=0;m+start<JET_N;m++)out[m+start]+=y10[m]*tp[i];}return out;
}
