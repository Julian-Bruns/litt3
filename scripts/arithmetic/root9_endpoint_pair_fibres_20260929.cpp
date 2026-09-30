// Full fibre gcds over the complete exact two-sheet projection factors.
#define main accepted_companion_main
#include "pro_companion140_20260928/src/native/companion.cpp"
#undef main
int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root projection.json output.json");init(argv[1]);ptree data;boost::property_tree::read_json(argv[2],data);F pb(data.get<uint32_t>("P_root")),phase(data.get<uint32_t>("phase"));std::vector<FP>rows;for(auto&[k,r]:data.get_child("J"))rows.push_back(frow(r));
 std::ofstream out(argv[3]);out<<"{\"scope\":\"All original-open two-sheet endpoint content incidences, complete resultant projection and fibre gcds.\",\"blocks\":[";bool first=true;
 for(auto&[key,r]:data.get_child("factors")){
  FP mod=frow(r.get_child("modulus"));E::setmod(mod);E z(FP(std::vector<F>{0,1})),q=E(pb)/z.pow(3);if(!at(getrow("d"),q)){std::cout<<"SOURCE_POLE "<<mod.deg()<<std::endl;continue;}
  Poly<E> f,g;f.c.resize(rows.size());g.c.resize(rows.size());for(int i=0;i<(int)rows.size();i++){f.c[i]=at(rows[i],z);g.c[i]=at(rows[i],z*E(phase));}f.trim();g.trim();auto[common,a,b]=xgcd(f,g);std::cout<<"FIBRE "<<mod.deg()<<" GCD "<<common.deg()<<std::endl;
  if(common.deg()==0)continue;if(common.deg()!=1)throw std::runtime_error("nonlinear retained fibre requires separate flattening");E h=-common[0]/common[1],u=h*q;if(!u){std::cout<<"U_ZERO"<<std::endl;continue;}E ui=u.inverse(),s=(at(getrow("a0"),q)+at(getrow("b"),q)*ui+at(getrow("c"),q)*ui.pow(2)+at(getrow("e"),q)*ui.pow(3))/at(getrow("d"),q);if(!s){std::cout<<"F6_ZERO"<<std::endl;continue;}
  auto eval=[&](const Poly<E>&p){E v;for(int k=p.deg();k>=0;k--)v=v*h+p[k];return v;};assert(!eval(f)&&!eval(g));if(!first)out<<',';first=false;out<<"{\"degree\":"<<mod.deg()<<",\"modulus\":";json(out,mod);out<<",\"coordinates\":{\"3\":";json(out,u.p);out<<",\"q\":";json(out,q.p);out<<"},\"H\":";json(out,h.p);out<<'}';out.flush();
 }out<<"]}\n";std::cout<<"COMPLETE_FIBRE_EXPORT"<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
