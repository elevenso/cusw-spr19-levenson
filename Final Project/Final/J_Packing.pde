//packing problem: gives error if you cut off too much space
/* want to find largest circle that can be inscribed within objects on main field
if objects within grass polygon, become new vertex
center must be within polygon, point farthest from all edges
smallest distance to edge = radius
area = pi*r^2
area_circle >= 1/2 grass space
only matters in grass polygon
*/

ArrayList<PVector> edge_list;

void calc_new_area(){
  
  //for only three objects
  println("edges: " + edge_list.size());
  if (edge_list.size() == 3) {
    new_area = (edge_list.get(0).x*edge_list.get(1).y + edge_list.get(1).x*edge_list.get(2).y + edge_list.get(2).x*edge_list.get(0).y - edge_list.get(0).x*edge_list.get(2).y - edge_list.get(1).x*edge_list.get(0).y - edge_list.get(2).x*edge_list.get(1).y)/2;
  println("new_area: " + new_area);
  }
  
  /*if (edge_list.size()>2){
    for (int i = 1; i<(edge_list.size()-1); i++) {
         new_area += (edge_list.get(i).x * edge_list.get(i-1).y - edge_list.get(i).y*edge_list.get(i-1).x);
      }
      new_area += (edge_list.get(edge_list.size()-1).x*edge_list.get(0).y-edge_list.get(edge_list.size()-1).y*edge_list.get(0).x);
      println("new area: " + new_area/2);
  }*/

  if (new_area > area/10 && new_area < area/4) {
    area_bool = false;
    println("Not enough open space!");
  }
}
