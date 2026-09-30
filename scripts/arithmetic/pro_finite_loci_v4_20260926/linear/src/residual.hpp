#pragma once
#include "fraction.hpp"
struct LambdaPoly{
 std::vector<Poly> c;
 LambdaPoly()=default;LambdaPoly(Poly a){if(a)c={a};}LambdaPoly(int a):LambdaPoly(Poly(a)){}
 void trim(){while(!c.empty()&&!c.back())c.pop_back();}
 LambdaPoly operator+(const LambdaPoly& b)const{auto p=*this;p.c.resize(std::max(c.size(),b.c.size()));for(size_t i=0;i<b.c.size();i++)p.c[i]+=b.c[i];p.trim();return p;}
 LambdaPoly operator-()const{auto p=*this;for(auto &a:p.c)a=-a;return p;}
 LambdaPoly operator-(const LambdaPoly& b)const{return *this+-b;}
 LambdaPoly operator*(const LambdaPoly& b)const{LambdaPoly p;if(c.empty()||b.c.empty())return p;p.c.resize(c.size()+b.c.size()-1);for(size_t i=0;i<c.size();i++)for(size_t j=0;j<b.c.size();j++)p.c[i+j]+=c[i]*b.c[j];p.trim();return p;}
 LambdaPoly operator*(F b)const{LambdaPoly p=*this;for(auto &a:p.c)a=a*b;p.trim();return p;}
 LambdaPoly operator*(const Poly& b)const{LambdaPoly p=*this;for(auto &a:p.c)a=a*b;p.trim();return p;}
 LambdaPoly pow(int n)const{LambdaPoly a=*this,p(1);while(n){if(n&1)p=p*a;a=a*a;n>>=1;}return p;}
 Poly eval(F lambda)const{Poly p;for(int i=int(c.size())-1;i>=0;i--)p=p*lambda+c[i];return p;}
};
inline std::array<Curve,3> universal_quadratic(Curve a,Curve b,Curve c,Curve d,Curve Q,Curve C,Poly v){
 auto E=a*d-b*c,Delta=b.pow(2)+a*c;
 auto a5=a.pow(5),b5=b.pow(5),c5=c.pow(5);
 auto T0=c5-Q*b5+Q.pow(2)*a5,U0=F(2)*Q*a5-b5;
 auto V0=-d*b5-F(2)*c.pow(2)*b.pow(4)-F(3)*a*b.pow(2)*c.pow(3)-F(2)*a.pow(2)*c.pow(4)+Q*(F(2)*a5*d-a.pow(4)*b*c+a.pow(3)*b.pow(3));
 auto W0=a.pow(2)*d.pow(2)-a*b*c*d+F(2)*b.pow(2)*c.pow(2)+b.pow(3)*d+a*c.pow(3);
 auto M0=U0*(F(2)*a*E+b*Delta)-a.pow(2)*V0;
 Curve f2=T0.pow(2)*v.pow(2);
 Curve f1=(T0*V0+C*(U0.pow(2)-F(2)*a5*T0))*v;
 Curve f0=a.pow(3)*(T0*W0+C*M0)+C.pow(2)*a.pow(10);
 return {f0,f1,f2};
}
inline LambdaPoly residual(const Source& s,F r){
 using namespace input;
 Curve g2=s.g[0].divide_y(2),g3=(s.g[1]-F(3)*s.g[0]*B0).divide_y(3);
 Curve g4=(s.g[2]-F(2)*s.g[1]*B0+F(3)*s.g[0]*B0.pow(2)).divide_y(4);
 Curve g5=(s.g[3]-s.g[2]*B0+s.g[1]*B0.pow(2)-s.g[0]*B0.pow(3)).divide_y(5);
 Curve Qbar=Curve::mon(0,1)*(Q-B0.pow(5)).exactdiv(P.pow(2));
 auto res=universal_quadratic(F(3)*g2,F(2)*g3,g4,g5,Qbar,Curve(t.pow(3)),x-Poly(r));
 std::array<LambdaPoly,3> parts;
 for(int j=0;j<3;j++)for(int i=0;i<3;i++)parts[j].c.push_back(res[i].c[j]);
 auto norm=parts[0].pow(3)+parts[1].pow(3)*P+parts[2].pow(3)*P.pow(2)-(parts[0]*parts[1]*parts[2]*P)*F(3);
 Poly den=t.pow(15)*(x-Poly(r)).pow(3);
 for(auto &a:norm.c)a=a.exactdiv(den);norm.trim();return norm;
}
inline Source evaluate_source(const Cramer& c,F H,F w){
 auto den=w.pow(3)-c.pivot;std::vector<F> a;for(auto p:c.num)a.push_back(p.eval(H,w)/den);return source_from_vector(a);
}
inline F numeric_F6(const Source& s){
 auto cc=coordinates();std::vector<LW> vals;auto g2=s.g[0].divide_y(2);
 for(auto co:cc)vals.emplace_back(co.n==0?g2.c[co.j][co.i]:s.g[co.n].c[co.j][co.i]);
 auto fj=F_jets(vals);for(int i=0;i<6;i++)if(fj[i])throw std::runtime_error("numeric F0..5");
 return fj[6].eval(F(1),F(1));
}
inline Poly frobenius_poly(const Poly& p,int e){Poly out;out.c.resize(std::max(0,e*p.deg()+1));for(int i=0;i<=p.deg();i++)out.c[e*i]=p[i].pow(e);out.trim();return out;}
inline std::vector<Poly> conv_trunc(const std::vector<Poly>& a,const std::vector<Poly>& b,int n){
 std::vector<Poly> p(n);for(int i=0;i<(int)a.size()&&i<n;i++)if(a[i])for(int j=0;j<(int)b.size()&&i+j<n;j++)if(b[j])p[i+j]+=a[i]*b[j];return p;
}
inline std::vector<Poly> square_circuit_C(const LambdaPoly& R){
 std::vector<Poly> a(125);
 for(int j=0;j<125;j++){std::vector<F> coeff(R.c.size());for(size_t l=0;l<R.c.size();l++)coeff[l]=R.c[l][140-j];a[j]=Poly(coeff);}
 auto a2=conv_trunc(a,a,125),a3=conv_trunc(a,a2,125);
 std::vector<Poly> b5(125),b25(125);
 for(int i=0;i<25;i++)b5[5*i]=frobenius_poly(a2[i],5);
 for(int i=0;i<5;i++)b25[25*i]=frobenius_poly(a2[i],25);
 return conv_trunc(conv_trunc(a3,b5,125),b25,125);
}
inline std::vector<Poly> complete_square_equations(const LambdaPoly& R){
 auto C=square_circuit_C(R);std::vector<Poly> eq;
 for(int i=71;i<125;i++)eq.push_back(C[i]);
 C.resize(71);auto B2=conv_trunc(C,C,141);F L=R.c[0][140];
 for(int i=125;i<=140;i++){
  std::vector<F> row(R.c.size());for(size_t j=0;j<R.c.size();j++)row[j]=R.c[j][140-i];
  eq.push_back(B2[i]-Poly(row)*L.pow(125));
 }
 return eq;
}
inline std::tuple<Poly,Poly,Poly> xgcd(Poly a,Poly b){Poly s0(1),s1,t0,t1(1);while(b){auto [q,r]=a.divrem(b);a=b;b=r;auto s=s0-q*s1;s0=s1;s1=s;auto t=t0-q*t1;t0=t1;t1=t;}if(a){F iv=a.c.back().inv();a=a*iv;s0=s0*iv;t0=t0*iv;}return {a,s0,t0};}
