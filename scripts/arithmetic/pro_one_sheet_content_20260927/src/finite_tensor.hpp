#pragma once
#include "function_algebra.hpp"
using PV=std::array<U,6>;
static PV fm{},ga{},gb{};
static PV va(PV a,const PV&b){for(int i=0;i<6;i++)a[i]=kadd(a[i],b[i]);return a;}
static PV vn(PV a){for(U&c:a)c=kneg(c);return a;}
static PV vc(PV a,U c){for(U&x:a)x=kmul(x,c);return a;}
static bool vz(const PV&a){for(U c:a)if(c)return false;return true;}
static PV vm(const PV&a,const PV&b){std::array<U,11>c{};for(int i=0;i<6;i++)if(a[i])for(int j=0;j<6;j++)if(b[j])c[i+j]=kadd(c[i+j],kmul(a[i],b[j]));for(int i=10;i>=6;i--)if(c[i])for(int j=0;j<6;j++)if(fm[j])c[i-6+j]=kadd(c[i-6+j],kneg(kmul(c[i],fm[j])));PV r{};for(int i=0;i<6;i++)r[i]=c[i];return r;}
struct E30{std::array<PV,5>a{};E30(){}E30(U c){a[0][0]=c;}bool zero()const{for(auto&b:a)if(!vz(b))return false;return true;}U& at(int i){return a[i/6][i%6];}U at(int i)const{return a[i/6][i%6];}};
static E30 operator+(E30 a,const E30&b){for(int j=0;j<5;j++)a.a[j]=va(a.a[j],b.a[j]);return a;}
static E30 operator-(E30 a,const E30&b){for(int j=0;j<5;j++)a.a[j]=va(a.a[j],vn(b.a[j]));return a;}
static E30 scale(E30 a,U c){for(auto&b:a.a)b=vc(b,c);return a;}
static E30 operator*(const E30&a,const E30&b){std::array<PV,9>c{};for(int i=0;i<5;i++)if(!vz(a.a[i]))for(int j=0;j<5;j++)if(!vz(b.a[j]))c[i+j]=va(c[i+j],vm(a.a[i],b.a[j]));for(int i=8;i>=5;i--)if(!vz(c[i])){c[i-4]=va(c[i-4],vn(vm(c[i],ga)));c[i-5]=va(c[i-5],vn(vm(c[i],gb)));}E30 r;for(int i=0;i<5;i++)r.a[i]=c[i];return r;}
static E30 powe(E30 a,int n){E30 b(1);while(n){if(n&1)b=b*a;n>>=1;if(n)a=a*a;}return b;}
static std::vector<E30> linear_unit(const std::vector<E30>&a){int nc=30*a.size();std::vector<U>M(30*(nc+1));for(int k=0;k<int(a.size());k++)for(int j=0;j<30;j++){E30 b;b.at(j)=1;E30 c=a[k]*b;for(int i=0;i<30;i++)M[i*(nc+1)+30*k+j]=c.at(i);}M[nc]=1;std::vector<int>piv(30);int rank=rref(M.data(),30,nc+1,piv.data());for(int i=rank;i<30;i++)if(M[i*(nc+1)+nc])return{};std::vector<E30>x(a.size());for(int i=0;i<rank;i++)x[piv[i]/30].at(piv[i]%30)=M[i*(nc+1)+nc];E30 chk;for(size_t k=0;k<a.size();k++)chk=chk+a[k]*x[k];if(!(chk-E30(1)).zero())throw std::runtime_error("linear unit identity failed");return x;}
static E30 inverse(const E30&a){auto c=linear_unit({a});if(c.empty())throw std::runtime_error("nonunit in J algebra");return c[0];}
static std::array<std::array<E30,30>,2> FB;
static void initfrob(){for(int i=0;i<30;i++){E30 b;b.at(i)=1;FB[0][i]=powe(b,5);FB[1][i]=powe(b,25);}}
static E30 efrob(const E30&a,int n){E30 r;for(int i=0;i<30;i++)if(a.at(i))r=r+scale(FB[n==5?0:1][i],kpow(a.at(i),n));return r;}
static void we(std::ostream&o,const std::string&name,const E30&a){o<<name;for(int i=0;i<30;i++)o<<" "<<a.at(i);o<<"\n";}
using S30=std::vector<E30>;
static constexpr int PR=73;
static S30 smul30(const S30&a,const S30&b){S30 c(PR);for(int i=0;i<int(a.size());i++)if(!a[i].zero())for(int j=0;i+j<PR&&j<int(b.size());j++)if(!b[j].zero())c[i+j]=c[i+j]+a[i]*b[j];return c;}
static S30 ssq30(const S30&a){S30 c(PR);for(int i=0;i<int(a.size());i++)if(!a[i].zero()){if(2*i<PR)c[2*i]=c[2*i]+a[i]*a[i];for(int j=i+1;i+j<PR&&j<int(a.size());j++)if(!a[j].zero())c[i+j]=c[i+j]+scale(a[i]*a[j],2);}return c;}
static S30 sf30(const S30&a,int n){S30 b(PR);for(int i=0;i*n<PR&&i<int(a.size());i++)b[i*n]=efrob(a[i],n);return b;}
static S30 sadd30(S30 a,const S30&b){for(int i=0;i<PR;i++)a[i]=a[i]+b[i];return a;}
static S30 ssc30(S30 a,U c){for(auto&v:a)v=scale(v,c);return a;}
static S30 ssh30(const S30&a,int s){S30 b(PR);for(int i=0;i+s<PR;i++)b[i+s]=a[i];return b;}
static S30 sps30(const S30&a,const UP&p,const E30&c){S30 b(PR);for(int i=0;i<PR;i++){E30 z;for(int j=0;j<=i&&j<int(p.size());j++)z=z+scale(a[i-j],p[j]);b[i]=z*c;}return b;}
