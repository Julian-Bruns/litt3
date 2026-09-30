#include "field.cpp"
#include <iostream>
#include <random>
static U ad(U a,U b){return kadd(a,b);}static U su(U a,U b){return kadd(a,kneg(b));}static U mu(U a,U b){return kmul(a,b);}static U pw(U a,int n){return kpow(a,n);}
static U det(std::vector<std::vector<U>>A){int n=A.size();U ans=1;for(int c=0;c<n;c++){int r=c;while(r<n&&!A[r][c])r++;if(r==n)return 0;if(r!=c){std::swap(A[r],A[c]);ans=kneg(ans);}U p=A[c][c];ans=mu(ans,p);U ip=kinv(p);for(int i=c+1;i<n;i++)if(A[i][c]){U sc=mu(A[i][c],ip);for(int j=c+1;j<n;j++)A[i][j]=su(A[i][j],mu(sc,A[c][j]));A[i][c]=0;}}return ans;}
static U syl(U a,U b,U c,U d,U Q,U T,U l){U f[11]={ad(ad(mu(l,pw(Q,2)),mu(Q,d)),T),mu(Q,c),mu(3,mu(Q,b)),mu(2,mu(Q,a)),0,ad(mu(2,mu(l,Q)),d),c,mu(3,b),mu(2,a),0,l};U g[3]={c,b,a};std::vector<std::vector<U>>M(12,std::vector<U>(12));for(int i=0;i<2;i++)for(int j=0;j<=10;j++)M[i][i+j]=f[10-j];for(int i=0;i<10;i++)for(int j=0;j<=2;j++)M[2+i][i+j]=g[2-j];return det(M);}
static U closed(U a,U b,U c,U d,U Q,U T,U l){U a2=pw(a,2),a3=pw(a,3),a4=pw(a,4),a5=pw(a,5),b2=pw(b,2),b3=pw(b,3),b4=pw(b,4),b5=pw(b,5),c2=pw(c,2),c3=pw(c,3),c4=pw(c,4),c5=pw(c,5);
 U J=ad(su(c5,mu(b5,Q)),mu(a5,pw(Q,2)));U TU=su(mu(2,mu(a5,Q)),b5);U TS=ad(su(mu(a3,b3),mu(a4,mu(b,c))),mu(2,mu(a5,d)));
 U K=ad(su(ad(ad(mu(3,mu(b4,c2)),mu(2,mu(a,mu(b2,c3)))),mu(3,mu(a2,c4))),mu(b5,d)),mu(Q,TS));
 U V=ad(ad(ad(su(mu(a3,pw(d,2)),mu(a2,mu(b,mu(c,d)))),mu(a,mu(b3,d))),mu(2,mu(a,mu(b2,c2)))),mu(a2,c3));
 U C1=ad(mu(J,K),mu(T,su(pw(TU,2),mu(2,mu(a5,J)))));U C0=ad(ad(mu(a2,mu(J,V)),mu(T,su(mu(TU,TS),mu(a5,K)))),mu(pw(a,10),pw(T,2)));
 return ad(ad(mu(pw(J,2),pw(l,2)),mu(C1,l)),C0);}
int main(){initfield(nullptr);int n=0;for(U a=0;a<5;a++)for(U b=0;b<5;b++)for(U c=0;c<5;c++)for(U d=0;d<5;d++)for(U q=0;q<5;q++)for(U t=0;t<5;t++)for(U l=0;l<5;l++){assert(syl(a,b,c,d,q,t,l)==closed(a,b,c,d,q,t,l));n++;}std::mt19937 rng(270926);for(int i=0;i<1000;i++){U a=rng()%QQ,b=rng()%QQ,c=rng()%QQ,d=rng()%QQ,q=rng()%QQ,t=rng()%QQ,l=rng()%QQ;if(i%4==0)a=0;if(i%7==0)b=0;if(i%11==0)l=0;assert(syl(a,b,c,d,q,t,l)==closed(a,b,c,d,q,t,l));}std::cout<<"fixed_degrees=(10,2) exhaustive_F5_tuples="<<n<<" deterministic_K_tuples=1000 ALL_PASS\n";}
