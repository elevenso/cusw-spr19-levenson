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
  println("edges: " + edge_list.size());
  if (edge_list.size() == 3) {
    new_area = (edge_list.get(0).x*edge_list.get(1).y + edge_list.get(1).x*edge_list.get(2).y + edge_list.get(2).x*edge_list.get(0).y - edge_list.get(0).x*edge_list.get(2).y - edge_list.get(1).x*edge_list.get(0).y - edge_list.get(2).x*edge_list.get(1).y)/2;
  println("new_area: " + new_area);
  }

  if (new_area > area/10) {
    area_bool = false;
    println("Too much area!");
  }
}
