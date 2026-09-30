#include "exact.hpp"
int main(){init_curve();std::cout<<"primitive_K_code="<<FF::primitive<<"\n";
if(derivative(Q)!=P*power(A,2))throw std::runtime_error("Q prime identity failed");
exactdiv(Q-power(B0,5),power(P,2));exactdiv(Q-power(L0,5),power(A,3));
std::cout<<"input identities passed\n";
auto mons=source_monomials();int n=mons.size();std::map<std::tuple<int,int,int>,std::vector<F>> rows;
auto cs=equations(Source{},true);for(auto[k,v]:cs){rows[k].resize(n+1);rows[k][n]=FF::neg(v);}
for(int s=0;s<n;s++){auto[b,i,j]=mons[s];Source src;src[b]=cm(i,j);for(auto[k,v]:equations(src,false)){rows[k].resize(n+1);rows[k][s]=v;}}
std::vector<std::vector<F>> mat;for(auto&[k,row]:rows)mat.push_back(row);
std::cout<<"system rows="<<mat.size()<<" columns="<<n<<"\n";
std::vector<int>prows;auto piv=rref(mat,n,&prows);std::vector<int>free;for(int i=0;i<n;i++)if(std::find(piv.begin(),piv.end(),i)==piv.end())free.push_back(i);
std::cout<<"rank="<<piv.size()<<" dimension="<<free.size()<<"\n";
std::vector<std::tuple<int,int,int>>rowkeys;for(auto&[k,row]:rows)rowkeys.push_back(k);std::ofstream rc("evidence/rank_certificate.json");rc<<"{\"row_count\":"<<rows.size()<<",\"column_count\":"<<n<<",\"rank\":"<<piv.size()<<",\"minor_row_keys\":[";for(size_t i=0;i<prows.size();i++){if(i)rc<<",";auto[e,x,y]=rowkeys[prows[i]];rc<<"["<<e<<","<<x<<","<<y<<"]";}rc<<"],\"minor_columns\":[";for(size_t i=0;i<piv.size();i++){if(i)rc<<",";rc<<piv[i];}rc<<"]}\n";
std::vector<std::vector<F>> ans(free.size()+1,std::vector<F>(n));for(size_t i=0;i<piv.size();i++)ans[0][piv[i]]=mat[i][n];for(size_t j=0;j<free.size();j++){ans[j+1][free[j]]=1;for(size_t i=0;i<piv.size();i++)ans[j+1][piv[i]]=FF::neg(mat[i][free[j]]);}
std::vector<Source> basis(ans.size());for(size_t b=0;b<ans.size();b++)for(int s=0;s<n;s++){auto[k,i,j]=mons[s];basis[b][k]=basis[b][k]+cm(i,j,ans[b][s]);}
for(size_t b=0;b<basis.size();b++)if(!equations(basis[b],b==0).empty())throw std::runtime_error("affine basis verification failed");
std::cout<<"all affine basis constraints verified\n";
std::ofstream out("evidence/source_basis.json");out<<"{\"monomials\":[";for(int s=0;s<n;s++){if(s)out<<",";auto[k,i,j]=mons[s];out<<"["<<k<<","<<i<<","<<j<<"]";}out<<"],\"free_columns\":[";for(size_t i=0;i<free.size();i++){if(i)out<<",";out<<free[i];}out<<"],\"basis\":[";for(size_t b=0;b<basis.size();b++){if(b)out<<",";out<<"[";for(int i=0;i<4;i++){if(i)out<<",";json_curve(out,basis[b][i]);}out<<"]";}out<<"]}\n";
// Compact binary-free data for fast C++ reloading.
std::ofstream txt("evidence/source_basis.txt");txt<<basis.size()<<"\n";for(auto&s:basis)for(auto&c:s)for(auto&p:c.c){txt<<p.size();for(auto x:p)txt<<" "<<x;txt<<"\n";}
F eps=FF::add(24,FF::add(FF::mul(4,25),FF::mul(23,FF::pow(25,3))));F cd=FF::add(3,FF::add(FF::mul(10,25),FF::add(FF::pow(25,2),FF::mul(14,FF::pow(25,3)))));
std::cout<<"coordinates: basis h w e f G3_x12y c-Cd*w\n";for(size_t b=0;b<basis.size();b++){auto&s=basis[b];F cc=FF::sub(s[1].coef(15,0),FF::mul(cd,s[2].coef(19,0)));std::cout<<b<<" "<<s[0].coef(4,2)<<" "<<s[2].coef(19,0)<<" "<<s[2].coef(12,2)<<" "<<s[3].coef(16,2)<<" "<<s[1].coef(12,1)<<" "<<cc<<"\n";if(cc||s[1].coef(12,1)!=(b==0?eps:0))throw std::runtime_error("coordinate identity failure");}
std::cout<<"reconstruction PASS\n";
}
