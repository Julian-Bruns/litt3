#include "algebra.hpp"
struct U {int g,i,j;};
PF P,A,Q,B,L,t,M;CF N;
vector<F> restrictions(const array<CF,4>&G,bool affine){
 vector<F>r;
 CF E3=G[1]-CF(B)*G[0]*F(3);
 CF E4=G[2]-CF(B)*G[1]*F(2)+CF(ppow(B,2))*G[0]*F(3);
 CF E5=G[3]-CF(B)*G[2]+CF(ppow(B,2))*G[1]-CF(ppow(B,3))*G[0];
 for(auto [E,n]:vector<pair<CF,int>>{{E3,3},{E4,4},{E5,5}})for(int j=0;j<3;j++){int k=max(0,(n-j+2)/3);PF rem=E.a[j]%ppow(P,k);for(int i=0;i<10*k;i++)r.push_back(rem[i]);}
 CF c=G[2]-CF(L)*G[1]*F(2)+CF(ppow(L,2))*G[0]*F(3);
 CF d=G[3]-CF(L)*G[2]+CF(ppow(L,2))*G[1]-CF(ppow(L,3))*G[0];
 CF mdn=CF(M)*d;if(affine)mdn+=N;
 for(int j=0;j<3;j++){PF rem=c.a[j]%t;for(int i=0;i<3;i++)r.push_back(rem[i]);rem=mdn.a[j]%ppow(t,2);for(int i=0;i<6;i++)r.push_back(rem[i]);}
 CF top=CF(Q)*G[3];if(affine)top+=CF(ppow(t,3))*N;
 r.push_back(top.a[0][42]);r.push_back(top.a[1][39]);
 return r;
}
void writeLP(ostream&o,const LP&p){o<<p.a.size();for(auto[e,c]:p.a)o<<" "<<e[0]<<" "<<e[1]<<" "<<e[2]<<" "<<e[3]<<" "<<c.v;o<<"\n";}
int main(int argc,char**argv){try{
 F::init();P=coded({11,22,18,5,19,20,15,16,9,22,1});A=coded({1,21,14,22,13});Q=coded({0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24});B=coded({8,14,19,2,10,19,3,24,18,16});L=coded({18,20,20,15});CF::P=P;CL::P=lift(P);
 t=A.exact(PF({-F::raw(25),F(1)})*F::raw(13));M=(Q-ppow(L,5)).exact(ppow(t,3));N=CF::mon(0,10);assert(Q.deriv()==P*ppow(A,2));assert(!((Q-ppow(B,5))%ppow(P,2)));
 vector<U>u;for(auto[i,j]:basis<F>(12))u.push_back({0,i,j});for(int g=1;g<4;g++)for(auto[i,j]:basis<F>(g==1?46:g==2?57:70))u.push_back({g,i,j});
 int nv=u.size();array<CF,4>zero;auto rhs=restrictions(zero,true);int nr=rhs.size();vector<vector<F>> mat(nr+4,vector<F>(nv+5));
 for(int c=0;c<nv;c++){array<CF,4>G;auto v=u[c];G[v.g]=CF::mon(v.i,v.j+(v.g==0?2:0));auto res=restrictions(G,false);for(int i=0;i<nr;i++)mat[i][c]=res[i];if(v.g==0&&v.i==4&&v.j==0)mat[nr][c]=F(1);if(v.g==2&&v.i==19&&v.j==0)mat[nr+1][c]=F(1);if(v.g==2&&v.i==12&&v.j==2)mat[nr+2][c]=F(1);if(v.g==3&&v.i==16&&v.j==2)mat[nr+3][c]=F(1);}
 for(int i=0;i<nr;i++)mat[i][nv]=-rhs[i];for(int i=0;i<4;i++)mat[nr+i][nv+i+1]=F(1);
 int rk=0;vector<int> piv;for(int c=0;c<nv;c++){int j=rk;while(j<nr+4&&!mat[j][c])j++;if(j==nr+4)continue;swap(mat[rk],mat[j]);F inv=mat[rk][c].inverse();for(int k=c;k<nv+5;k++)mat[rk][k]*=inv;for(int i=0;i<nr+4;i++)if(i!=rk&&mat[i][c]){F d=mat[i][c];for(int k=c;k<nv+5;k++)mat[i][k]-=d*mat[rk][k];}piv.push_back(c);rk++;}
 for(int i=rk;i<nr+4;i++)for(int k=nv;k<nv+5;k++)assert(!mat[i][k]);cerr<<"source unknowns "<<nv<<" original equations "<<nr<<" rank with four coordinates "<<rk<<" kernel "<<nv-rk<<"\n";assert(nv-rk==2);
 vector<int>free;for(int c=0;c<nv;c++)if(find(piv.begin(),piv.end(),c)==piv.end())free.push_back(c);
 F eps=F::raw(24)+F::raw(4)*F::raw(25)+F::raw(23)*fpow(F::raw(25),3);F eta=F::raw(11)+F::raw(18)*fpow(F::raw(25),2)+F::raw(20)*fpow(F::raw(25),3);F Cd=F::raw(3)+F::raw(10)*F::raw(25)+fpow(F::raw(25),2)+F::raw(14)*fpow(F::raw(25),3);
 LP h=LP::var(0),w=LP::var(1),z=w*LP(F(2)/eps),e=-LP(Cd)*w*z-LP(eta/F::raw(24))/z,f=-w*w*LP(eps.inverse())-LP(F::raw(8)/F::raw(24))*lpow(z,5);
 vector<LP>coord={LP(1),h,w,e,f},vals(nv);for(int k=0;k<2;k++)vals[free[k]]=LP::var(k+2);
 for(int j=0;j<rk;j++){LP v;for(int k=0;k<5;k++)v+=LP(mat[j][nv+k])*coord[k];for(int k=0;k<2;k++)v-=LP(mat[j][free[k]])*vals[free[k]];vals[piv[j]]=v;}
 array<CL,4>G;for(int c=0;c<nv;c++){auto v=u[c];G[v.g]+=CL::mon(v.i,v.j+(v.g==0?2:0),vals[c]);}
 assert(G[1].a[0][15]==w*LP(Cd));assert(G[1].a[1][12]==LP(eps));
 // Formal infinity expansion with precision 7. Negative orders have been shifted out.
 int prec=7;PL Y(LP(1));PL Pr;for(int i=0;i<=P.deg();i++)Pr+=PL::mon(30-3*i,LP(P[i]));for(int i=1;i<prec;i++){LP coeff=(Pr-spow(Y,3,prec))[i]*LP(F(2));Y+=PL::mon(i,coeff);}assert((spow(Y,3,prec)-Pr).trunc(prec).deg()==-1);
 auto inf=[&](const CL&g,int shift){PL out;for(int j=0;j<3;j++)for(int i=0;i<=g.a[j].deg();i++){int s=shift-3*i-10*j;if(s<0&&bool(g.a[j][i]))throw runtime_error("negative infinity shift");if(s>=0&&s<prec)out+=(ppow(Y,j)*g.a[j][i]).shift(s).trunc(prec);}return out.trunc(prec);};
 PL as=inf(G[0],35)*LP(3),bs=inf(G[1],46)*LP(2),cs=inf(G[2],57);assert(bs[0]==LP(F(2)*eps));
 PL rho(z);for(int i=1;i<prec;i++){LP val=(as*spow(rho,2,prec)+bs*rho+cs)[i];rho+=PL::mon(i,-val/bs[0]);}assert(!(as*spow(rho,2,prec)+bs*rho+cs).trunc(prec));
 PL Fser=((inf(lift(CF(Q)),57)+spow(rho,5,prec).shift(2))*(inf(G[3],70)+(as*spow(rho,3,prec)+bs*spow(rho,2,prec)*LP(2)).shift(2))+inf(lift(CF(ppow(t,3))*N),127)).trunc(prec);
 for(int j=0;j<4;j++)assert(!Fser[j]);
 auto split=[&](const LP&p){array<LP,3>r;for(auto[ee,c]:p.a){auto e=ee;int idx=0;if(e[2]||e[3]){assert(e[2]+e[3]==1&&e[2]>=0&&e[3]>=0);idx=e[2]?1:2;e[2]=e[3]=0;}r[idx]+=LP::mon(e,c);}return r;};
 auto s4=split(Fser[4]),s5=split(Fser[5]);LP det=s4[1]*s5[2]-s4[2]*s5[1];cerr<<"F4,F5 determinant terms "<<det.a.size()<<"\n";assert(det.a.size()==1);auto de=det.a.begin()->first;assert(de[0]==0&&de[1]==2&&de[2]==0&&de[3]==0);
 LP k1=(-s4[0]*s5[2]+s4[2]*s5[0])/det,k2=(-s4[1]*s5[0]+s4[0]*s5[1])/det;
 for(auto&g:G)for(auto&p:g.a)for(auto&c:p.a)c=subst(subst(c,2,k1),3,k2);
 for(int j=0;j<6;j++)assert(!subst(subst(Fser[j],2,k1),3,k2));LP F6=subst(subst(Fser[6],2,k1),3,k2);
 int acodes[]={89654,311173,214299,163299,315361,33043,356725,245794};LP Psi;for(int j=0;j<8;j++)Psi+=LP::mon({0,3*j,0,0},F::raw(acodes[j]));Psi+=LP::mon({1,4,0,0},F::raw(299833))+LP::mon({1,7,0,0},F::raw(232505));LP expected=Psi/LP::mon({0,3,0,0},fpow(F::raw(299619),2));assert(F6==expected);
 cerr<<"F0--F5 vanish; F6 matches supplied Psi exactly; source normalized\n";
 string dir=argc>1?argv[1]:"evidence";ofstream out(dir+"/source.txt");out<<"SOURCE_V1 h w k1 k2\n";for(int g=0;g<4;g++)for(int j=0;j<3;j++){out<<g<<" "<<j<<" "<<G[g].a[j].deg()<<"\n";for(const LP&c:G[g].a[j].a)writeLP(out,c);}ofstream six(dir+"/F6.txt");writeLP(six,F6);ofstream ker(dir+"/kernel.txt");writeLP(ker,k1);writeLP(ker,k2);
 // Full exact source verification, with Laurent coefficients and all affine constraints.
 CL E3=G[1]-CL(lift(B))*G[0]*LP(3),E4=G[2]-CL(lift(B))*G[1]*LP(2)+CL(lift(ppow(B,2)))*G[0]*LP(3),E5=G[3]-CL(lift(B))*G[2]+CL(lift(ppow(B,2)))*G[1]-CL(lift(ppow(B,3)))*G[0];
 for(auto [E,n]:vector<pair<CL,int>>{{E3,3},{E4,4},{E5,5}})for(int j=0;j<3;j++)assert(!(E.a[j]%lift(ppow(P,max(0,(n-j+2)/3)))));
 CL c=G[2]-CL(lift(L))*G[1]*LP(2)+CL(lift(ppow(L,2)))*G[0]*LP(3),d=G[3]-CL(lift(L))*G[2]+CL(lift(ppow(L,2)))*G[1]-CL(lift(ppow(L,3)))*G[0];CL mdn=CL(lift(M))*d+lift(N);for(int j=0;j<3;j++){assert(!(c.a[j]%lift(t)));assert(!(mdn.a[j]%lift(ppow(t,2))));}CL top=CL(lift(Q))*G[3]+CL(lift(ppow(t,3)))*lift(N);assert(!top.a[0][42]);assert(!top.a[1][39]);
 cerr<<"All exact affine congruences and infinity bounds rechecked after normalization\n";size_t count=0;for(auto&g:G)for(auto&p:g.a)for(auto&c:p.a)count+=c.a.size();cerr<<"Source total Laurent terms: "<<count<<"\n";
}catch(exception&e){cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
