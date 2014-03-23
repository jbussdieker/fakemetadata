class Thing
  def call(env)
    if env["PATH_INFO"] == "/2009-04-04/meta-data/instance-id"
      [200, {"Content-Type" => "text/html"}, ["i-99999"]]
    elsif env["PATH_INFO"] == "/2009-04-04/user-data"
      [200, {"Content-Type" => "text/html"}, ["#!/bin/bash\necho test > /var/tmp/blah"]]
    else
      [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
    end
  end
end

run Thing.new
