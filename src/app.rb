require_relative "graph"

file = ARGV[0] || "caso0000"
G = Graph.new(file)
graph = G.graph

puts graph.num_vertices
puts graph.num_edges
