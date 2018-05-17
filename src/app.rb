require "graphviz"
require_relative "reader"

file = ARGV[0] || "caso0000"
reader = Reader.new file
data = reader.data
puts "Running '#{file}'..."

total_nodes = data.shift
nodes = data.slice! 0, total_nodes.to_i
data.shift
edges = data

puts "Total nodes: #{total_nodes}"
puts "Total Connections: #{edges.length}"

# Create a new graph
graph = GraphViz.new( :G, :type => :digraph )

# Create a dictionary with nodes
puts "\nCreating nodes..."
dictionary = {}
nodes.each do |node|
  # arr = ["FOO", "10"]
  # dictionary = {"FOO": "10"}

  arr = node.split(" ")
  dictionary[arr[0]] = arr[1]
end

# Create nodes and edges
puts "\nCreating connections..."
edges.each do |edge|
  # arr = ["FOO", "BAR", "90"]
  # fromNode = "FOO 10"
  # toNode = "BAR 00"
  # label (weight) = "90"

  arr = edge.split(" ")
  fromNode = "#{arr[0]} #{dictionary[arr[0]]}"
  toNode = "#{arr[1]} #{dictionary[arr[1]]}"
  graph.add_edges(fromNode, toNode, label: "#{arr[2]}")
end

# Generate output image
puts "\nLoading image..."
graph.output( :png => File.join(File.dirname(__FILE__), "../img/#{file}.png"))
puts "\nDONE!"
