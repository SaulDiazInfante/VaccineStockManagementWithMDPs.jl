println("I am being built...")
#- ls #Optional command.  Just here to confirm the Dependency is in the folder you think it is. 
 #- pwd #Optional command. Just here so you can see where you are in the file system to make sure the path is correct below. 
 - julia --project --color=yes --check-bounds=yes -e 'using Pkg; Pkg.develop(PackageSpec(path="/home/travis/build/path_to_private_Dependency")); Pkg.instantiate()'
 - julia --project --color=yes --check-bounds=yes -e 'using Pkg; Pkg.instantiate(); Pkg.build();'