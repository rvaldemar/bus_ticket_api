class PathFinder
  def initialize(vertices)
    # No. of vertices
    @v = vertices

    # default array to store graph
    @graph = {}
    (0...@v).each { |i| @graph[i] = []}

    @result = []
  end

  # function to add an edge to graph
  def addEdge(u, v)
    @graph[u].push(v)
  end

    '''A recursive function to print all paths from u to d.
    visited[] keeps track of vertices in current path.
    path[] stores actual vertices and path_index is current
    index in path[]'''
    def printAllPathsUtil(u, d, visited, path)

      # Mark the current node as visited and store in path
      visited[u]= true
      path.push(u)

      # If current vertex is same as destination, then print
      # current path[]
      if u == d
          @result.push path.clone
      else
        # If current vertex is not destination
        # Recur for all the vertices adjacent to this vertex
        @graph[u].each do |i|
          unless visited[i]
              printAllPathsUtil(i, d, visited, path)
          end
        end
      end

      # Remove current vertex from path[] and mark it as unvisited
      path.pop
      visited[u]= false
    end


  # Prints all paths from 's' to 'd'
  def printAllPaths(s, d)
    # Mark all the vertices as not visited
    visited = {}

    # Create an array to store paths
    path = []

    # Call the recursive helper function to print all paths
    printAllPathsUtil(s, d, visited, path)
    @result
  end

end
