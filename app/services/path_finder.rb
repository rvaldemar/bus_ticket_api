class PathFinder
  def initialize(options)
    @s = options['start_id'].to_i
    @d = options['destination_id'].to_i
    @start_date = options['start_date'].to_datetime
    @end_date = options['end_date'].to_datetime
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
    @result.sort do |a, b|
      b.first.start_date != a.first.start_date ?
        b.first.start_date <=> a.first.start_date :
        (a.last.end_date - a.first.start_date) - (b.last.end_date - b.first.start_date)
    end
  end

  private

  '''A recursive function to print all paths from u to d.
  visited[] keeps track of vertices in current path.
  path[] stores actual vertices and path_index is current
  index in path[]'''
  def printAllPathsUtil(u, visited, path, start_date, route = nil)

    # Mark the current node as visited and store in path
    visited[u]= true
    path.push(route) if route && route.seats_available?

    # If current vertex is same as destination, then print
    # current path[]
    if u == @d && route && route.seats_available?
        @result.push path.clone
    elsif u != @d
      # If current vertex is not destination
      Route.where(start_id: u, start_date: start_date..@end_date, end_date: start_date..@end_date).each do |route|
        unless visited[route.destination_id]
            printAllPathsUtil(route.destination_id, visited, path, route.start_date, route)
        end
      end
    end

    # Remove current vertex from path[] and mark it as unvisited
    path.pop
    visited[u]= false
  end

end
