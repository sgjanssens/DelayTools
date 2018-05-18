# This is the destination directory for the compiled library.
# Please make sure it already exists on your system.
# If necessary, update your Maple initialization file by prepending
# the directory name to the global libname variable. For example,
# on Linux you can add
#
# libname := "/home/sj/maple/lib", libname:
#
# to the ~/.mapleinit file. For more on the initalization file,
# see the worksheet/reference/initialization page in Maple Help.

destdir := "/home/sj/maple/lib":

# Set this to the directory where you downloaded (or: cloned) the
# DelayTools distribution.

rootdir := "/home/sj/DelayTools":


# ---------- Below this line no editing should be required. ---------


# The subdirectory containing the Maple language source files.
srcdir := cat(rootdir, kernelopts(dirsep), "src"):
olddir := currentdir(srcdir):
read ("DelayTools.mpl"):
currentdir(olddir):

# Save the library.
archname := cat(destdir, kernelopts(dirsep), "DelayTools.mla"):
LibraryTools:-Save('DelayTools', archname):


