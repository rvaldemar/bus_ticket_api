class PathFinder
  def initialize(options)
    @s = options[:start_id]
    @d = options[:destination_id]
    @start_date = options[:start_date]
    @end_date = options[:end_date]
    @result = []
  end

  # Prints all paths from 's' to 'd'
  def getAllPaths
    'Calculating paths...'
    # Mark all the vertices as not visited
    visited = {}

    # Create an array to store paths
    path = []

    # Call the recursive helper function to print all paths
    printAllPathsUtil(@s, visited, path, @start_date)
    @result
  end

  private

  '''A recursive function to print all paths from u to d.
  visited[] keeps track of vertices in current path.
  path[] stores actual vertices and path_index is current
  index in path[]'''
  def printAllPathsUtil(u, visited, path, start_date)

    # Mark the current node as visited and store in path
    visited[u]= true
    path.push(u)

    # If current vertex is same as destination, then print
    # current path[]
    if u == @d
        @result.push path.clone
    else
      # If current vertex is not destination
      # Recur for all the vertices adjacent to this vertex

      Route.where(start_id: u, start_date: start_date..@end_date, end_date: start_date..@end_date).each do |route|
        unless visited[route.destination_id]
            printAllPathsUtil(route.destination_id, visited, path, route.start_date)
        end
      end
    end

    # Remove current vertex from path[] and mark it as unvisited
    path.pop
    visited[u]= false
  end

  # function to add an edge to graph
  def addEdge(u, v)
    @graph[u].push(v)
  end

end
