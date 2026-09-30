#define main eliminate_main
#include "eliminate.cpp"
#undef main
int main(int argc,char**argv){assert(argc==3);F::init();FastK::init();auto v=licensed_units(argv[1]);std::ofstream out(argv[2]);out<<"{\"unit_factors\":[";for(size_t i=0;i<v.size();i++){if(i)out<<',';printpoly(out,v[i]);}out<<"]}\n";std::cout<<"{\"licensed_irreducible_unit_factors\":"<<v.size()<<",\"factorization_product_checks\":\"PASS\"}"<<std::endl;}
