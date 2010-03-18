namespace :demo do
  task :run do
    # exec {
    #   %w{}
    # }
    # cloud_mongrel_rails start -a oncloud.org -p 8079 -K bd03b82676ab660fb1992775435df2838bf096c9:1268428286:trigonsolutions.oncloud.org -H trigonsolutions.oncloud.org -H www.trigonsolutions.oncloud.org
    %x{
      cloud_mongrel_rails start -a oncloud.org -p 8079 -K bd03b82676ab660fb1992775435df2838bf096c9:1268428286:trigonsolutions.oncloud.org -H trigonsolutions.oncloud.org -H www.trigonsolutions.oncloud.org
    }
  end
end