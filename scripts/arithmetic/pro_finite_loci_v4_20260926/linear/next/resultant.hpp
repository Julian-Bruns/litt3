#pragma once
#include "../src/poly.hpp"
inline F actual_resultant(Poly a,Poly b){
 if(!a||!b)return F();F out(1);
 while(b.deg()>0){int m=a.deg(),n=b.deg();Poly r=a%b;if(!r)return F();if((m*n)&1)out=-out;out*=b.c.back().pow(m-r.deg());a=std::move(b);b=std::move(r);}
 return out*b[0].pow(a.deg());
}
inline F fixed_resultant(Poly a,Poly b,int m,int n){
 if(!a||!b)return F();if(a.deg()>m||b.deg()>n)throw std::runtime_error("fixed degree exceeded");int da=m-a.deg(),db=n-b.deg();if(da&&db)return F();
 F out=actual_resultant(a,b);if(da){out*=b.c.back().pow(da);if((da*n)&1)out=-out;}if(db)out*=a.c.back().pow(db);return out;
}
inline F sylvester_resultant(const Poly& a,const Poly& b,int m,int n){
 std::vector<std::vector<F>> mat(m+n,std::vector<F>(m+n));for(int i=0;i<n;i++)for(int j=0;j<=m;j++)mat[i][i+m-j]=a[j];for(int i=0;i<m;i++)for(int j=0;j<=n;j++)mat[n+i][i+n-j]=b[j];F out(1);
 for(int k=0;k<m+n;k++){int p=k;while(p<m+n&&!mat[p][k])p++;if(p==m+n)return F();if(p!=k){std::swap(mat[p],mat[k]);out=-out;}F z=mat[k][k];out*=z;F iv=z.inv();for(int j=k;j<m+n;j++)mat[k][j]*=iv;for(int i=k+1;i<m+n;i++){F c=mat[i][k];for(int j=k+1;j<m+n;j++)mat[i][j]-=c*mat[k][j];}}
 return out;
}
struct DegreeCertificate{std::vector<int> f,g,u,v;int bound;};
inline DegreeCertificate degree_certificate(const Rows& f,const Rows& g){
 int m=f[0].size()-1,n=g[0].size()-1,s=m+n;DegreeCertificate c;c.f.assign(m+1,-1000000);c.g.assign(n+1,-1000000);
 for(int i=0;i<(int)f.size();i++)for(int j=0;j<=m;j++)if(f[i][j])c.f[j]=i;
 for(int i=0;i<(int)g.size();i++)for(int j=0;j<=n;j++)if(g[i][j])c.g[j]=i;
 std::vector<std::vector<int>> w(s,std::vector<int>(s,-1000000));for(int i=0;i<n;i++)for(int j=0;j<=m;j++)w[i][i+m-j]=c.f[j];for(int i=0;i<m;i++)for(int j=0;j<=n;j++)w[n+i][i+n-j]=c.g[j];
 int M=2000;std::vector<int> u(s+1),v(s+1),p(s+1),way(s+1);const int INF=1000000000;
 for(int i=1;i<=s;i++){
  p[0]=i;int j0=0;std::vector<int> minv(s+1,INF);std::vector<bool> used(s+1);
  do{used[j0]=true;int i0=p[j0],delta=INF,j1=0;for(int j=1;j<=s;j++)if(!used[j]){int cur=M-w[i0-1][j-1]-u[i0]-v[j];if(cur<minv[j]){minv[j]=cur;way[j]=j0;}if(minv[j]<delta){delta=minv[j];j1=j;}}
   for(int j=0;j<=s;j++)if(used[j]){u[p[j]]+=delta;v[j]-=delta;}else minv[j]-=delta;j0=j1;
  }while(p[j0]!=0);
  do{int j1=way[j0];p[j0]=p[j1];j0=j1;}while(j0);
 }
 c.u.resize(s);c.v.resize(s);c.bound=0;for(int i=0;i<s;i++){c.u[i]=M-u[i+1];c.v[i]=-v[i+1];c.bound+=c.u[i]+c.v[i];}
 int score=0;for(int j=1;j<=s;j++){if(w[p[j]-1][j-1]<0)throw std::runtime_error("invalid degree matching");score+=w[p[j]-1][j-1];}
 if(score!=c.bound)throw std::runtime_error("degree matching dual mismatch");for(int i=0;i<s;i++)for(int j=0;j<s;j++)if(w[i][j]>=0&&c.u[i]+c.v[j]<w[i][j])throw std::runtime_error("invalid degree dual");return c;
}
inline void ints_json(std::ostream& s,const std::vector<int>& v){s<<"[";for(size_t i=0;i<v.size();i++){if(i)s<<",";s<<v[i];}s<<"]";}
inline void write_degree(std::ostream& f,const DegreeCertificate& c){f<<"{\"bound\":"<<c.bound<<",\"coefficient_degrees_F\":";ints_json(f,c.f);f<<",\"coefficient_degrees_G\":";ints_json(f,c.g);f<<",\"row_potential\":";ints_json(f,c.u);f<<",\"column_potential\":";ints_json(f,c.v);f<<"}";}
