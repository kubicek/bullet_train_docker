# install docker and alternate configuration script
base_path = "https://raw.githubusercontent.com/kubicek/bullet_train_docker/main/"
get base_path+"Dockerfile", "Dockerfile"
get base_path+"docker-compose.yml", "docker-compose.yml"
get base_path+"bin/configure", "bin/configure"

# modify files for more complex docker setup
gsub_file("Procfile.dev","-p 3000","-p 3000 -b 0.0.0.0")
# not yet sure if needed
#  insert_into_file "config/cable.yml", "  url: <%= ENV.fetch(\"REDIS_URL\") %>\n", :after => "adapter: redis\n"

# commit changes
git add: "."
git commit: %( -m 'Added docker' )

# configure bullet train with alternate script
run('bin/configure')

# folowing are executed manually by now with instruction from configure script
# run('docker compose build')
# run('docker compose run web bin/setup')
# run('docker compose up')
  
