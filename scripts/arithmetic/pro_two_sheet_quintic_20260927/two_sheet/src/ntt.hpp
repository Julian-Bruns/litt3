#pragma once
#include "quotient.hpp"
using Bi=Pol<PQ>;
QE scale(QE a,F c){if(!c)return QE();for(F&z:a.a.a)z*=c;a.a.trim();return a;}
int ntt_length(int n){int best=INT_MAX;for(int a=1;a<=32;a*=2)for(int b:{1,3})for(int c:{1,13})if(a*b*c>=n)best=min(best,a*b*c);if(best==INT_MAX)throw runtime_error("NTT requested length too large");return best;}
void dft_rec(vector<QE>&a,F root){int n=a.size();if(n<=1)return;int r=n%2==0?2:n%3==0?3:13;assert(n%r==0);int m=n/r;vector<vector<QE>>b(r,vector<QE>(m));for(int s=0;s<r;s++){for(int j=0;j<m;j++)b[s][j]=a[r*j+s];dft_rec(b[s],fpow(root,r));}
 if(r==2){F w(1);for(int j=0;j<m;j++,w*=root){QE t=scale(b[1][j],w);a[j]=b[0][j]+t;a[j+m]=b[0][j]-t;}return;}
 vector<F>rr(r);rr[0]=F(1);F rm=fpow(root,m);for(int i=1;i<r;i++)rr[i]=rr[i-1]*rm;F w(1);for(int j=0;j<m;j++,w*=root){vector<QE>v(r);F ws(1);for(int s=0;s<r;s++,ws*=w)v[s]=scale(b[s][j],ws);for(int t=0;t<r;t++){QE z;for(int s=0;s<r;s++)z+=scale(v[s],rr[(s*t)%r]);a[j+m*t]=z;}}
}
void dft(vector<QE>&a,bool inverse){int n=a.size();assert(390624%n==0);F root=fpow(F::raw(25),390624/n);if(inverse)root=root.inverse();dft_rec(a,root);if(inverse){F sc=F(n).inverse();for(auto&x:a)x=scale(x,sc);}}
void dft2(vector<QE>&a,int nx,int ny,bool inverse){vector<QE>line;for(int i=0;i<nx;i++){line.assign(a.begin()+i*ny,a.begin()+(i+1)*ny);dft(line,inverse);copy(line.begin(),line.end(),a.begin()+i*ny);}line.resize(nx);for(int j=0;j<ny;j++){for(int i=0;i<nx;i++)line[i]=a[i*ny+j];dft(line,inverse);for(int i=0;i<nx;i++)a[i*ny+j]=line[i];}}
int mudeg(const Bi&p){int n=-1;for(auto&a:p.a)n=max(n,a.deg());return n;}
Bi bmul(const Bi&p,const Bi&q,int prec){if(!p||!q)return {};int dx=p.deg()+q.deg(),dy=mudeg(p)+mudeg(q),nx=ntt_length(dx+1),ny=ntt_length(dy+1);vector<QE>a(nx*ny),b(nx*ny);for(int i=0;i<=p.deg();i++)for(int j=0;j<=p.a[i].deg();j++)a[i*ny+j]=p.a[i][j];for(int i=0;i<=q.deg();i++)for(int j=0;j<=q.a[i].deg();j++)b[i*ny+j]=q.a[i][j];dft2(a,nx,ny,false);dft2(b,nx,ny,false);for(int i=0;i<nx*ny;i++)a[i]*=b[i];dft2(a,nx,ny,true);Bi r;r.a.resize(min(prec,dx+1));for(int i=0;i<(int)r.a.size();i++){r.a[i].a.resize(dy+1);for(int j=0;j<=dy;j++)r.a[i].a[j]=a[i*ny+j];r.a[i].trim();}r.trim();return r;}
Bi bscale(Bi p,QE c){for(auto&co:p.a){for(auto&z:co.a)z*=c;co.trim();}p.trim();return p;}
Bi bconstmul(const Bi&p,const PF&q,int prec){Bi r;r.a.resize(min(prec,p.deg()+q.deg()+1));for(int i=0;i<=p.deg();i++)for(int j=0;j<=q.deg()&&i+j<prec;j++){PQ s=p.a[i];for(QE&z:s.a)z=scale(z,q[j]);s.trim();r.a[i+j]+=s;}r.trim();return r;}
PQ pfrob(const PQ&p,int power){PQ r;if(!p)return r;r.a.resize(p.deg()*power+1);for(int i=0;i<=p.deg();i++)if(p.a[i])r.a[i*power]=qpow(p.a[i],power);r.trim();return r;}
void writePQdata(ostream&o,const PQ&p){o<<p.a.size()<<"\n";for(auto c:p.a)writePF(o,c.a);}
PQ readPQdata(istream&i){int n;i>>n;PQ p;for(int j=0;j<n;j++)p.a.push_back(QE(readPF(i)));p.trim();return p;}
