require 'gserver'

#
# A server that returns the time in seconds since 1970.
#
class TimeServer < GServer
  def initialize(port=10001, *args)
    super(port, *args)
  end
  def serve(io)
  	io.puts("HTTP/1.1 200 OK\r\n")
 	io.puts("Date: Mon, 23 May 2005 22:38:34 GMT\r\n")
 	io.puts("\r\n")
    io.puts(Time.now.to_s)
    io.puts("\r\n")
  end
end

# Run the server with logging enabled (it's a separate thread).
server = TimeServer.new
server.audit = true                  # Turn logging on.
server.start

gets.chomp
# *** Now point your browser to http://localhost:10001 to see it working ***

# See if it's still running.
# GServer.in_service?(10001)           # -> true
# server.stopped?                      # -> false

# # Shut the server down gracefully.
# server.shutdown

# # Alternatively, stop it immediately.
# GServer.stop(10001)
# or, of course, "server.stop".