#ifndef COMPANION_JETS_HPP
#define COMPANION_JETS_HPP
#include "algebra.hpp"
namespace comp {
struct F2 {
 F a,b;static inline thread_local F parameter;
 F2(int k=0):a(k%5),b(0){}F2(F x):a(x),b(0){}F2(F x,F y):a(x),b(y){}
 explicit operator bool()const{return bool(a)||bool(b);}
 friend bool operator==(F2 x,F2 y){return x.a==y.a&&x.b==y.b;}
 friend F2 operator+(F2 x,F2 y){return F2(x.a+y.a,x.b+y.b);}
 friend F2 operator-(F2 x){return F2(-x.a,-x.b);}
 friend F2 operator-(F2 x,F2 y){return x+-y;}
 friend F2 operator*(F2 x,F2 y){F ac=x.a*y.a,bd=x.b*y.b;return F2(ac+parameter*bd,(x.a+x.b)*(y.a+y.b)-ac-bd);}
 F2&operator+=(F2 y){a+=y.a;b+=y.b;return *this;}F2&operator-=(F2 y){a-=y.a;b-=y.b;return *this;}F2&operator*=(F2 y){return *this=*this*y;}
 F2 inverse()const{F v=(a*a-parameter*b*b).inverse();return F2(a*v,-b*v);}
 friend F2 operator/(F2 x,F2 y){return x*y.inverse();}
 F2 fifth()const{return F2(a.fifth(),b.fifth()*parameter*parameter);}
 F2 pow(uint64_t n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);F2 z(1),x=*this;while(n){if(n&1)z*=x;n>>=1;if(n)x*=x;}return z;}
 F norm()const{return a*a-parameter*b*b;}
};
inline int jet_order=1;
struct JetNonunit:std::runtime_error{JetNonunit():std::runtime_error("nonunit truncated-series pivot"){} };
template<class T,int MAX=16> struct Jet {
 std::array<T,MAX>c{};
 Jet(int k=0){assert(jet_order<=MAX);c[0]=T(k%5);}Jet(T x){assert(jet_order<=MAX);c[0]=x;}
 explicit operator bool()const{for(int i=0;i<jet_order;i++)if(bool(c[i]))return true;return false;}
 bool unit()const{return bool(c[0]);}
 friend bool operator==(const Jet&x,const Jet&y){for(int i=0;i<jet_order;i++)if(!(x.c[i]==y.c[i]))return false;return true;}
 friend Jet operator+(const Jet&x,const Jet&y){Jet z;for(int i=0;i<jet_order;i++)z.c[i]=x.c[i]+y.c[i];return z;}
 friend Jet operator-(const Jet&x){Jet z;for(int i=0;i<jet_order;i++)z.c[i]=-x.c[i];return z;}
 friend Jet operator-(const Jet&x,const Jet&y){Jet z;for(int i=0;i<jet_order;i++)z.c[i]=x.c[i]-y.c[i];return z;}
 friend Jet operator*(const Jet&x,const Jet&y){Jet z;for(int i=0;i<jet_order;i++)if(bool(x.c[i]))for(int j=0;j<jet_order-i;j++)z.c[i+j]+=x.c[i]*y.c[j];return z;}
 Jet&operator+=(const Jet&y){for(int i=0;i<jet_order;i++)c[i]+=y.c[i];return *this;}Jet&operator-=(const Jet&y){for(int i=0;i<jet_order;i++)c[i]-=y.c[i];return *this;}Jet&operator*=(const Jet&y){return *this=*this*y;}
 Jet inverse()const{if(!unit())throw JetNonunit();Jet z;z.c[0]=c[0].inverse();for(int n=1;n<jet_order;n++){T v=0;for(int i=1;i<=n;i++)v+=c[i]*z.c[n-i];z.c[n]=-v*z.c[0];}return z;}
 friend Jet operator/(const Jet&x,const Jet&y){return x*y.inverse();}
 Jet fifth()const{Jet z;for(int i=0;5*i<jet_order;i++)z.c[5*i]=c[i].fifth();return z;}
 Jet pow(uint64_t n)const{if(n>=5)return pow(n%5)*fifth().pow(n/5);Jet z(1),x=*this;while(n){if(n&1)z*=x;n>>=1;if(n)x*=x;}return z;}
};
template<class J> J berkowitz_det(const std::vector<std::vector<J>>&a){
 int n=a.size();std::vector<J>p{J(1)};
 for(int k=n-1;k>=0;k--){int m=n-k;std::vector<J>c(m+1);c[0]=1;c[1]=-a[k][k];std::vector<J>v(m-1);for(int i=0;i<m-1;i++)v[i]=a[k+1+i][k];
  for(int j=2;j<=m;j++){J z;for(int i=0;i<m-1;i++)z+=a[k][k+1+i]*v[i];c[j]=-z;if(j<m){std::vector<J>w(m-1);for(int i=0;i<m-1;i++)for(int l=0;l<m-1;l++)w[i]+=a[k+1+i][k+1+l]*v[l];v=std::move(w);}}
  std::vector<J>q(m+1);for(int i=0;i<=m;i++)for(int j=0;j<=std::min(i,m-1);j++)q[i]+=c[i-j]*p[j];p=std::move(q);
 }return n%2?-p[n]:p[n];
}
template<class J> J determinant_local(std::vector<std::vector<J>>a){
 int n=a.size();J out(1);
 for(int k=0;k<n;k++){
  int pi=-1,pj=-1;for(int i=k;i<n&&pi<0;i++)for(int j=k;j<n;j++)if(a[i][j].unit()){pi=i;pj=j;break;}
  if(pi<0){if(n-k>=jet_order)return J(0);std::vector<std::vector<J>>b(n-k,std::vector<J>(n-k));for(int i=k;i<n;i++)for(int j=k;j<n;j++)b[i-k][j-k]=a[i][j];return out*berkowitz_det(b);}
  if(pi!=k){std::swap(a[pi],a[k]);out=-out;}if(pj!=k){for(auto&row:a)std::swap(row[pj],row[k]);out=-out;}
  J pivot=a[k][k],inv=pivot.inverse();out*=pivot;
  for(int i=k+1;i<n;i++)if(bool(a[i][k])){J z=a[i][k]*inv;for(int j=k+1;j<n;j++)a[i][j]-=z*a[k][j];a[i][k]=J(0);}
 }
 return out;
}
template<class J> J sylvester_jet(const Poly<J>&f,const Poly<J>&g,int m,int n){
 std::vector<std::vector<J>>a(m+n,std::vector<J>(m+n));
 for(int i=0;i<n;i++)for(int j=0;j<=m;j++)a[i][i+m-j]=f[j];for(int i=0;i<m;i++)for(int j=0;j<=n;j++)a[n+i][i+n-j]=g[j];return determinant_local(std::move(a));
}
inline thread_local uint64_t jet_fallbacks=0;
template<class J> J resultant_jet(const Poly<J>&f0,const Poly<J>&g0,int m0,int n0){
 try{
  if(f0.deg()!=m0||g0.deg()!=n0)throw JetNonunit();Poly<J>f=f0,g=g0;J factor(1);
  while(true){int m=f.deg(),n=g.deg();if(n<0)return J(0);if(n==0)return factor*g[0].pow(m);if(m<n){if((m*n)%2)factor=-factor;std::swap(f,g);continue;}if(!g.c.back().unit())throw JetNonunit();
   auto[q,r]=f.divmod(g);if(!r)return J(0);if((m*n)%2)factor=-factor;factor*=g.c.back().pow(m-r.deg());f=std::move(g);g=std::move(r);
  }
 }catch(JetNonunit&){jet_fallbacks++;return sylvester_jet(f0,g0,m0,n0);}
}
}
#endif
