### testing some (strange) behaviors of devtools

### tested with version 1.5 of devtools

### stage 0

if (file.exists("./winsor")) {
    unlink("./winsor", recursive = TRUE, force = TRUE)
}

### stage 1
require(devtools)
create("winsor")
file.show("./winsor/DESCRIPTION") ### description file with no Imports field
file.show("./winsor/R/winsor-package.r")

### stage 2

### copy the edited package-doc file

file.copy("winsor-package.rpre.r", "./winsor/R/winsor-package.r", overwrite = TRUE)
file.show("./winsor/R/winsor-package.r")  ## import line is here

file.copy("x.R", "./winsor/R")
file.show("./winsor/R/x.R")

document("./winsor")

### See what are edited

file.show("./winsor/DESCRIPTION") ### imports is not added
file.show("./winsor/NAMESPACE") ### Name space is created

### Try to test the dependencies

load_all("./winsor")
stupid()  ### error, plyr is not loaded despite the namespace file containing plyr

### stage 3

### copy the edited DESCRIPTION file
file.copy("DESCRIPTION.pre", "./winsor/DESCRIPTION", overwrite = TRUE)
file.show("./winsor/DESCRIPTION") ### still, no Imports
load_all("./winsor")
stupid()  ### error again

### edit DESCRIPTION file manually

cat("Imports: plyr", file = "./winsor/DESCRIPTION", append = TRUE)
file.show("./winsor/DESCRIPTION")

### try again

load_all("./winsor")
stupid()  ### working now

