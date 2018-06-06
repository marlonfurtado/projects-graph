require_relative "graph"

file = ARGV[0] || "caso0000"
G = Graph.new(file)
graph = G.graph
graphModified = G.graph
edge_weights = G.edge_weights

nodeRoot = nil
total = 0

# ROOT: unico elemento que não tem pai
# No caso reverse, é o unico elemento que não tem filhos (grau de saída == 0)

graph.each_vertex do |node|
  if (graph.reverse.out_degree(node) === 0)
    nodeRoot = node
    break
  end
end

bfs = graph.bfs_iterator(nodeRoot)
allNodes = graph.vertices

# print bfs.color_map

bfs.each do |node|
  nodeValue = node.split(" ")[1].to_i

  allNodes.each do |nextNode|
    isEdge = !!edge_weights[[node, nextNode]]

    if (isEdge)
      nextNodeValue = nextNode.split(" ")[1].to_i
      weight = edge_weights[[node, nextNode]]

      value = (nextNodeValue * weight) + nodeValue
      total += value
    end
  end
end

puts "\n\nTOTAL PROJETO:  #{total}\n\n\n"
