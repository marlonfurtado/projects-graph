require 'rgl/base'
require 'rgl/traversal'
require 'rgl/dot'
require 'rgl/adjacency'
require 'rgl/mutable'
require_relative "reader"

class Graph
  attr_accessor :graph
  attr_accessor :edge_weights

  def initialize file
    # Create a new graph
    @graph = RGL::DirectedAdjacencyGraph.new
    @edge_weights = Hash.new

    reader = Reader.new file
    @data = reader.data

    puts "Running case '#{file}'..."
    create()
  end

  def create
    total_nodes = @data.shift
    nodes = @data.slice! 0, total_nodes.to_i
    @data.shift
    edges = @data

    puts "Total nodes: #{total_nodes}"
    puts "Total Connections: #{edges.length}"

    # Create a hash with nodes
    puts "Creating nodes..."
    hash_nodes = Hash.new
    nodes.each do |node|
      # arr: ["FOO", "10"]
      # hash: {"FOO": "10"}
      @graph.add_vertex(node)

      arr = node.split(" ")
      hash_nodes.store(arr[0], arr[1])
    end

    # Create nodes and edges
    puts "Creating connections...\n\n"
    edges.each do |edge|
      # arr: ["FOO", "BAR", "90"]
      # fromNode: "FOO 10"
      # toNode: "BAR 00"
      # weight: "90"

      arr = edge.split(" ")
      fromNode = "#{arr[0]} #{hash_nodes[arr[0]]}"
      toNode = "#{arr[1]} #{hash_nodes[arr[1]]}"
      weight = arr[2].to_i

      @edge_weights.store([fromNode, toNode], weight)
      @graph.add_edge(fromNode, toNode)
    end

    # @edge_weights.each { |(from, to), w| @graph.add_edge(from, to) }
  end
end
