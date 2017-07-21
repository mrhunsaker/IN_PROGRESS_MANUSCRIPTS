###SIMPLISTIC TRISYNAPTIC LOOP
Simple<-create_graph() %>% add_n_nodes(9,label=c("DG","CA3","CA1","Sub","MEC","LEC","PrS_PoS","PER","PRC")) %>%
set_node_attrs("shape",c("circle","circle","circle","circle", "rectangle","rectangle","rectangle","rectangle","rectangle")) %>%
recode_node_attrs("shape","circle -> red", otherwise = "green",node_attr_to="color") %>%
add_edges_w_string("1->2 2->2 2->3 3->4 3->5 3->6 4->5 4->6 5->1 5->2 5->3 5->6 5->4 6->1 6->2 6->3 6->4 6->5 6->8 8->6 8->9 8->9 9->5 7->5 7->5") %>%
select_nodes_by_id(5:9) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","green") %>%
select_nodes_by_id(1:4) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","red")
png("~/Desktop/Simple.png")
render_graph(Simple)
dev.off()


###REALISTIC CONNECTIVITY
Complicated<-create_graph() %>%  add_n_nodes(25,label=c("DG","CA3_c","CA3_ab","CA2", "CA1_d", "CA1_p","Sub_p", "Sub_d","MEC_2","MEC_3","MEC_deep","LEC_2", "LEC_3", "LEC_deep","PrS_PoS","PER","PRC","LS","MS_DBB", "MB","AT_MdT","PL_IL","ACC", "PPC", "RSC")) %>%
###Set Node Shape
set_node_attrs("shape",c("circle","circle","circle","circle","circle","circle","circle","circle","rectangle","rectangle","rectangle","rectangle","rectangle","rectangle","rectangle","rectangle","rectangle","ellipse","ellipse","ellipse","ellipse","hexagon","hexagon","hexagon","hexagon")) %>%
set_node_attrs("type",c("a","a","a","a","a","a","a","a","b","b","b","b","b","b","b","b","b","c","c","c","c","d","d","d","d")) %>%
###Set Node Outline Color
recode_node_attrs("shape","circle -> red", "rectangle -> green", "ellipse -> purple", "hexagon = blue", otherwise = "grey", node_attr_to="color") %>%
###Add in all edges
add_edges_w_string("1->2 1->3 2->1 2->2 2->3 2->18 2->4 2->5 2->6 3->3 3->4 3->5 3->6 3->18 4->5 4->6 4->11 4->14 5->7 5->11 5->19 5->22 5->25 6->8 6->14 6->16 6->19 6->22 6->25 8->6 8->14 8->16 8->19 8->15 8->22 8->25 8->20 7->5 7->11 7->20 7->19 7->15 7->22 7->25 9->11 9->1 9->2 9->3 9->4 9->20 10->11 10->4 10->6 10->8 10->17 10->20 11->10 11->9 12->14 12->1 12->2 12->3 12->4 13->14 13->4 13->5 13->7 13->16 14->12 14->13 15->11 15->25 15->20 16->6 16->14 16->17 17->16 17->11 17->25 18->19 19->20 19->21 19->22 19->1 19->2 19->3 19->4 19->5 19->6 19->7 19->25 20->21 20->25 21->15 21->23 21->25 22->23 22->24 22->25 23->22 23->25 23->17 24->22 24->25 25->15 25->11 25->14 25->24 25->21 25->17") %>%
###Set edge colors
select_nodes_by_id(1:8) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","red")%>%
select_nodes_by_id(9:17) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","green") %>%
select_nodes_by_id(18:21) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","purple") %>%
select_nodes_by_id(22:25) %>%
trav_out_edge() %>%
set_edge_attrs_ws("color","blue")
render_graph(Complicated)


