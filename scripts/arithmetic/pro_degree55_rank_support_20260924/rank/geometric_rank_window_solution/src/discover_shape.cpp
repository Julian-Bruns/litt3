#include "module_arithmetic.hpp"
struct Vec {Poly p;vector<int> r;};
Poly pluspoly(Poly a,const Poly&b,int c){for(auto t:b){t.c=MUL[t.c][c];a.push_back(t);}return norm(a);}
Poly timespoly(const Poly&p,const Poly&q){Poly r;for(auto t:p)for(auto u:q)r.push_back({t.m+u.m,MUL[t.c][u.c],t.p});return reduce(r);}
void plusrep(vector<int>&a,vector<int>b,int c){if(a.size()<b.size())a.resize(b.size());for(int i=0;i<(int)b.size();i++)a[i]=ADD[a[i]][MUL[c][b[i]]];}
map<U,Vec,greater<U>> eb;
Vec vred(Vec v){while(!v.p.empty()){auto t=v.p[0];auto it=eb.find(key(t.m,t.p));if(it==eb.end())break;auto &b=it->second;int c=NEG[t.c];v.p=pluspoly(v.p,b.p,c);plusrep(v.r,b.r,c);}return v;}
void printrow(ostream &out,vector<int>a){out<<a.size();for(int c:a)out<<" "<<c;out<<"\n";}
int main(int argc,char**argv){init();ifstream in(argv[1]);int n;in>>NV>>NC>>n;MASK=(U(1)<<(8*NV))-1;reducers.assign(NC,{});for(int i=0;i<n;i++){polys.push_back(readpoly(in));active.insert(i);}refresh();ifstream qs(argv[2]);int nv,nc,nq;qs>>nv>>nc>>nq;vector<Poly> qlist;for(int ii=0;ii<nq;ii++)qlist.push_back(readpoly(qs));Poly q=qlist[0];int comp=argc>4?stoi(argv[4]):0;Poly w={{0,1,comp}};w=timespoly(w,q);w=timespoly(w,q);w=timespoly(w,q);Poly p=w;vector<int> rel;
 vector<Poly> powers;for(int j=0;j<250;j++){powers.push_back(p);vector<int> r(j+1);r[j]=1;Vec v=vred({p,r});cerr<<"power "<<j<<" nf "<<p.size()<<" residual "<<v.p.size()<<"\n";if(v.p.empty()){rel=v.r;break;}int c=INV[v.p[0].c];for(auto&t:v.p)t.c=MUL[c][t.c];for(auto&t:v.r)t=MUL[c][t];eb[key(v.p[0].m,v.p[0].p)]=v;p=timespoly(p,q);}
 ofstream out(argv[3]);out<<NV<<"\n";printrow(out,rel);for(int i=0;i<NV;i++){Poly xi={{U(1)<<(8*i),1,0}};Vec v=vred({timespoly(w,xi),{}});cerr<<"coordinate "<<i<<" residual "<<v.p.size()<<"\n";for(auto&c:v.r)c=NEG[c];printrow(out,v.r);writepoly(out,v.p);}out.close();
 ofstream cert(string(argv[3])+".containment");cert<<NV<<" "<<NC<<" "<<qlist.size()<<"\n";
 for(int qi=0;qi<(int)qlist.size();qi++)for(int j=0;j<NC;j++){
  Poly z={{0,1,j}};for(int r=1;r<=8;r++) {z=timespoly(z,qlist[qi]);if(r<3)continue;Vec a=vred({z,{}});cerr<<"containment q "<<qi<<" component "<<j<<" power "<<r<<" residual "<<a.p.size()<<"\n";
   if(a.p.empty()){cert<<qi<<" "<<j<<" "<<r<<"\n";for(auto &c:a.r)c=NEG[c];printrow(cert,a.r);break;}
   if(r==8){cert<<qi<<" "<<j<<" FAILED\n";}
  }
 }
 cert.close();
}
