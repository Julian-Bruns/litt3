#pragma once
#include <array>
#include <vector>
#include <iostream>
#include <algorithm>
#include <cstdint>
#include <cassert>
#include <stdexcept>
using namespace std;
// F = F_5[t]/(t^7+t+1), integer base-5 polynomial codes.
constexpr int Q=78125, ORDER=Q-1;
int AD[625][625], SU[625][625];
vector<int> LG(Q,-1), EX(2*ORDER), FROB(Q);
int add(int a,int b){return AD[a%625][b%625]+625*AD[a/625][b/625];}
int sub(int a,int b){return SU[a%625][b%625]+625*SU[a/625][b/625];}
int neg(int a){return sub(0,a);}
int mul(int a,int b){return (a&&b)?EX[LG[a]+LG[b]]:0;}
int inv(int a){assert(a);return EX[ORDER-LG[a]];}
int pw(int a,uint64_t n){int r=1;while(n){if(n&1)r=mul(r,a);a=mul(a,a);n>>=1;}return r;}
int slowmul(int a,int b){int aa[7],bb[7],c[13]={};for(int i=0;i<7;i++){aa[i]=a%5;a/=5;bb[i]=b%5;b/=5;}for(int i=0;i<7;i++)for(int j=0;j<7;j++)c[i+j]=(c[i+j]+aa[i]*bb[j])%5;for(int i=12;i>=7;i--){c[i-7]=(c[i-7]+5-c[i])%5;c[i-6]=(c[i-6]+5-c[i])%5;}int r=0;for(int i=6;i>=0;i--)r=5*r+c[i];return r;}
void init(){for(int a=0;a<625;a++)for(int b=0;b<625;b++){int aa=a,bb=b,c=0,d=0,p=1;for(int i=0;i<4;i++){c+=((aa%5+bb%5)%5)*p;d+=((aa%5+5-bb%5)%5)*p;aa/=5;bb/=5;p*=5;}AD[a][b]=c;SU[a][b]=d;}int gen=5;
 for(;;gen++){auto sp=[&](int a,int n){int r=1;while(n){if(n&1)r=slowmul(r,a);a=slowmul(a,a);n>>=1;}return r;};if(sp(gen,ORDER)==1&&sp(gen,ORDER/2)!=1&&sp(gen,ORDER/19531)!=1)break;}
 int z=1;for(int i=0;i<ORDER;i++){assert(LG[z]<0);LG[z]=i;EX[i]=z;z=slowmul(z,gen);}assert(z==1);for(int i=0;i<ORDER;i++)EX[i+ORDER]=EX[i];for(int a=0;a<Q;a++)FROB[a]=pw(a,5);cerr<<"F generator "<<gen<<"; order "<<ORDER<<"\n";
}
struct C{int a=0,b=0; C(){} C(int aa,int bb=0):a(aa),b(bb){} bool zero()const{return a==0&&b==0;} };
C operator+(C x,C y){return C(add(x.a,y.a),add(x.b,y.b));}
C operator-(C x,C y){return C(sub(x.a,y.a),sub(x.b,y.b));}
C operator-(C x){return C(neg(x.a),neg(x.b));}
C operator*(C x,C y){return C(add(mul(x.a,y.a),mul(2,mul(x.b,y.b))),add(mul(x.a,y.b),mul(x.b,y.a)));}
C ci(C x){int n=sub(mul(x.a,x.a),mul(2,mul(x.b,x.b)));assert(n);return C(mul(x.a,inv(n)),neg(mul(x.b,inv(n))));}
C cp(C x,uint64_t n){C r(1);while(n){if(n&1)r=r*x;x=x*x;n>>=1;}return r;}
C cf(C x){return C(FROB[x.a],neg(FROB[x.b]));}
bool operator==(C x,C y){return x.a==y.a&&x.b==y.b;}
// beta=j+3, j^2=2; coded a+5b means a+b beta.
C code(int n){return C((n%5+3*(n/5))%5,n/5);}
struct L{array<C,4> c{};L(){} L(C x){c[0]=x;}bool zero()const{for(C x:c)if(!x.zero())return false;return true;}};
L operator+(const L&x,const L&y){L z;for(int i=0;i<4;i++)z.c[i]=x.c[i]+y.c[i];return z;}
L operator-(const L&x,const L&y){L z;for(int i=0;i<4;i++)z.c[i]=x.c[i]-y.c[i];return z;}
L operator-(const L&x){L z;for(int i=0;i<4;i++)z.c[i]=-x.c[i];return z;}
L scale(const L&x,C y){L z;for(int i=0;i<4;i++)z.c[i]=x.c[i]*y;return z;}
L operator*(const L&x,const L&y){C z[7];for(int i=0;i<4;i++)for(int j=0;j<4;j++)z[i+j]=z[i+j]+x.c[i]*y.c[j];int monic[4]={5,2,6,7};for(int i=6;i>=4;i--)for(int j=0;j<4;j++)z[i-4+j]=z[i-4+j]-z[i]*code(monic[j]);L r;for(int i=0;i<4;i++)r.c[i]=z[i];return r;}
L lp(L x,uint64_t n){L r(C(1));while(n){if(n&1)r=r*x;x=x*x;n>>=1;}return r;}
L fromrow(array<int,4>row){L z;for(int i=0;i<4;i++)z.c[i]=code(row[i]);return z;}
array<int,8> coords(L x){array<int,8> a;for(int i=0;i<4;i++){a[2*i]=x.c[i].a;a[2*i+1]=x.c[i].b;}return a;}
C ZP[29];

struct Endpoint {L bv,mv;int root,exp;};
vector<Endpoint> endpoints;
void endpoints_init(){C z;
 for(int a=1;;a++){z=cp(C(a,1),210466056ULL);if(!(z==C(1))){assert(cp(z,29)==C(1));break;}}
 ZP[0]=C(1);for(int i=1;i<29;i++)ZP[i]=ZP[i-1]*z;
 cerr<<"zeta="<<z.a<<","<<z.b<<"\n";
 L B=fromrow({1,3,8,15}), M=fromrow({22,7,9,23});
 for(int i=0;i<4;i++){for(int e=0;e<29;e++)endpoints.push_back({scale(B,ZP[(8*e)%29]),scale(M,ZP[(5*e)%29]),i,e});B=lp(B,25);M=lp(M,25);}
 assert(endpoints.size()==116);
}

struct EndpointSystem {
    L constant;
    array<L,4> columns;
    array<array<int,5>,7> augmented;
};
EndpointSystem system_at(int z,int f,int g) {
    const C C0=code(22)*C(2), Cj=C0*C(0,1), Csq=C0*C0;
    L c=scale(endpoints[0].bv+endpoints[z].bv,C(3));
    L a=scale(endpoints[0].mv+endpoints[z].mv,C(3));
    L d=scale(endpoints[f].bv+endpoints[g].bv,C(3));
    L b=scale(endpoints[f].mv+endpoints[g].mv,C(3));
    EndpointSystem out;
    out.constant=c*d-a*b;
    out.columns={scale(c+d,C0),scale(c-d,Cj),-scale(a+b,C0),scale(a-b,Cj)};
    for(int i=0;i<6;i++) {
        int j=1+i/2;
        out.augmented[i][4]=neg(i%2?out.constant.c[j].b:out.constant.c[j].a);
        for(int k=0;k<4;k++) out.augmented[i][k]=i%2?out.columns[k].c[j].b:out.columns[k].c[j].a;
    }
    out.augmented[6][4]=neg(sub(mul(Csq.b,out.constant.c[0].a),mul(Csq.a,out.constant.c[0].b)));
    for(int k=0;k<4;k++) out.augmented[6][k]=sub(mul(Csq.b,out.columns[k].c[0].a),mul(Csq.a,out.columns[k].c[0].b));
    return out;
}
L full_residual(const EndpointSystem &s,array<int,4> x) {
    L val=s.constant;
    for(int k=0;k<4;k++) val=val+scale(s.columns[k],C(x[k]));
    int norm=sub(sub(mul(x[0],x[0]),mul(2,mul(x[1],x[1]))),sub(mul(x[2],x[2]),mul(2,mul(x[3],x[3]))));
    C c=code(22)*C(2);
    return val+L((c*c)*C(norm));
}
array<int,29> fourier_row(array<int,4> x) {
    C moments[29]; int e=2; C value(x[0],x[1]);
    for(int i=0;i<14;i++) {moments[e]=value;e=e*5%29;value=cf(value);}
    e=6;value=C(x[2],x[3]);
    for(int i=0;i<14;i++) {moments[e]=value;e=e*5%29;value=cf(value);}
    array<int,29> row{};
    for(int i=0;i<29;i++) {
        C value;
        for(int j=1;j<29;j++) value=value+moments[j]*ZP[(29-(i*j)%29)%29];
        value=value*C(4);
        if(value.b!=0 || value.a>=5) throw runtime_error("Fourier inversion did not land in F_5");
        row[i]=value.a;
    }
    return row;
}

