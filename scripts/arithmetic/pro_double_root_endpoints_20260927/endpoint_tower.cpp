// Exact primitive-element moments in K[q,nu]/(M(q),H(q,nu)).
// H is monic in nu. No factorisation, root choice, or reducedness assumption.
#include "field.cpp"
extern "C" int endpoint_tower_moments(const int*mod,int d,const int*gin,int e,const int*uin,int c,int*out){
 try{
  ff_init();if(d<1||d>2048||e<1||e>4||mod[d]!=1)return -1;
  ED=d;EM.assign(mod,mod+d+1);int n=d*e,na=2*n+2;
  vector<E>G(e),v(e,E(d,0)),vv(e,E(d,0));for(int i=0;i<e;i++)G[i]=E(gin+i*d,gin+(i+1)*d);
  E u(uin,uin+d),uwork=u,dual(d,0);for(int j=0;j<d;j++){
   dual[j]=uwork[d-1];int top=uwork.back();for(int h=d-1;h>=0;h--)uwork[h]=sub(h?uwork[h-1]:0,mul(top,EM[h]));
  }
  v[0][0]=1;
  for(int it=0;it<na;it++){
   out[it]=v[e-1][d-1];
   if(it<n){
    out[na+it]=sub(d>=2?v[e-1][d-2]:0,mul(EM[d-1],v[e-1][d-1]));
    int lu=0;for(int j=0;j<d;j++)lu=add(lu,mul(dual[j],v[e-1][j]));out[na+n+it]=lu;
   }
   if(it+1==na)break;
   const E &top=v[e-1];
   for(int i=0;i<e;i++){
    E gtop=emul(G[i],top);int qt=v[i].back();
    for(int j=d-1;j>=0;j--){
     int z=mul(c,sub(j?v[i][j-1]:0,mul(qt,EM[j])));
     if(i)z=add(z,v[i-1][j]);vv[i][j]=sub(z,gtop[j]);
    }
   }
   swap(v,vv);
  }
  return 0;
 }catch(const exception&ex){fprintf(stderr,"tower moments: %s\n",ex.what());return -3;}
}
extern "C" int endpoint_berlekamp_massey(const int*seq,int n,int*out){
 ff_init();KP C={1},B={1};int L=0,m=1,b=1;
 for(int k=0;k<n;k++){
  int d=seq[k];for(int i=1;i<=L;i++)if(i<(int)C.size())d=add(d,mul(C[i],seq[k-i]));
  if(!d){m++;continue;}KP T=C;int f=mul(d,inv(b));if(C.size()<B.size()+m)C.resize(B.size()+m,0);
  for(size_t i=0;i<B.size();i++)C[i+m]=sub(C[i+m],mul(f,B[i]));
  if(2*L<=k){L=k+1-L;B=T;b=d;m=1;}else m++;
 }
 C.resize(L+1,0);for(int i=0;i<=L;i++)out[i]=C[L-i];return L;
}
// Independent presentation check by direct polynomial substitution.
// Surjectivity (z=nu+cq) and equality of dimensions then prove the full
// algebra isomorphism, without relying on the moment construction.
static E image_evaluate(const int*coeff,int len,const E&x){
 E r(ED,0);for(int i=len-1;i>=0;i--){r=emul(r,x);r[0]=add(r[0],coeff[i]);}return r;
}
extern "C" int endpoint_verify_presentation(const int*N,int n,const int*qin,const int*uin,const int*nui,
 const int*M,int d,const int*G,int e,const int*baseu,int shift){
 try{
  ff_init();if(n!=d*e||n<1||n>2048||N[n]!=1||M[d]!=1)return -1;
  ED=n;EM.assign(N,N+n+1);E q(qin,qin+n),u(uin,uin+n),nu(nui,nui+n);
  if(!ezero(image_evaluate(M,d+1,q).data()))return 1;
  if(image_evaluate(baseu,d,q)!=u)return 2;
  E h=eone();for(int j=e-1;j>=0;j--)h=eadd(emul(h,nu),image_evaluate(G+j*d,d,q));
  if(!ezero(h.data()))return 3;
  E z=nu;for(int i=0;i<n;i++)z[i]=add(z[i],mul(shift,q[i]));
  E wanted(n,0);if(n==1)wanted[0]=neg(N[0]);else wanted[1]=1;
  if(z!=wanted)return 4;
  return 0;
 }catch(const exception&ex){fprintf(stderr,"presentation verification: %s\n",ex.what());return -3;}
}
