class Thing
  def root
    "/home/josh/Desktop/fakemetadata/meta-data/"
  end

  def user_data
    "#cloud-config
password: password"
  end

  def call(env)
    if env["PATH_INFO"] == "/2009-04-04/user-data"
      [200, {"Content-Type" => "text/html"}, [user_data]]
    elsif env["PATH_INFO"] =~ /\/2009\-04\-04\/meta\-data/
      path = env["PATH_INFO"][22..-1] || ""
      file = File.join(root, path)
      if File.directory?(file)
        list = Dir[File.join(file, "*")].collect do |item|
          if File.directory?(item)
            File.basename(item) + "/"
          else
            File.basename(item)
          end
        end
        [200, {"Content-Type" => "text/html"}, [list.join("\n")]]
      else
        [200, {"Content-Type" => "text/html"}, [File.read(file)]]
      end
    else
      [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
    end
  end
end

run Thing.new
