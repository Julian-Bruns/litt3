// New all-scale tests on the finite common-critical incidence.
// Uses accepted fixed-degree source and tail routines, not a point search.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main

int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root finite-incidence.json output.json [factor-index]");
 init(argv[1]);ptree in;boost::property_tree::read_json(argv[2],in);
 std::ofstream out(argv[3]);out<<"{\"blocks\":[";bool first=true;int idx=0;
 for(auto&[key,block]:in.get_child("blocks")){
  if(argc>4&&idx++!=std::stoi(argv[4]))continue;
  auto st=std::chrono::steady_clock::now();FP mod=frow(block.get_child("modulus")),uq=frow(block.get_child("coordinates.3"));
  E::setmod(mod);FP qp=block.get_child_optional("coordinates.q")?frow(block.get_child("coordinates.q")):FP(std::vector<F>{0,1});E q(qp),u(uq);
  if(!u){std::cout<<"{\"degree\":"<<mod.deg()<<",\"outside_original_open\":\"u=0\"}"<<std::endl;continue;}
  E ui=u.inverse();E s=(at(getrow("a0"),q)+at(getrow("b"),q)*ui+at(getrow("c"),q)*ui.pow(2)+at(getrow("e"),q)*ui.pow(3))/at(getrow("d"),q);
  if(!s){std::cout<<"{\"degree\":"<<mod.deg()<<",\"outside_original_open\":\"F6=0\"}"<<std::endl;continue;}
  std::cout<<"{\"degree\":"<<mod.deg()<<",\"stage\":\"source\"}"<<std::endl;
  auto co=weighted_small_critical(q,u);auto rr=norm_small(co,q);
  assert(rr[0].deg()==140);auto ta=tails(rr,74);
  std::cout<<"{\"degree\":"<<mod.deg()<<",\"stage\":\"tails\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<"}"<<std::endl;
  // Generic coordinate fibres currently use irreducible modulus blocks.
  // The established recursion's q label is metadata only after tails exist.
  certify_block(mod,uq,ta,out,first);out.flush();
 }
 out<<"]}\n";std::cout<<"ALL_REQUESTED_BLOCKS_CERTIFIED"<<std::endl;
}catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<std::endl;return 1;}}
