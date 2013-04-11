# OpenGL ES Notes #

*Note*: most `OpenGL ES` calls have `manpages`.  `GLKit` documentation can be
viewed from within Xcode or on the web.

## Links ##
OpenGL Documentation on the web
- http://www.opengl.org/sdk/docs/man/
- http://www.khronos.org/opengles/sdk/docs/man/
- System manpages

vim syntax files
- OpenGL - http://www.vim.org/scripts/script.php?script_id=752
- OpenGL Shading Language
  - http://www.vim.org/scripts/script.php?script_id=1002
  - http://www.vim.org/scripts/script.php?script_id=1220

## Glossary ##
- Geometry
  - The 3D shape of an object
- Primitives
  - The triangles, points, or lines that make up the geometry of a 3D object
- Vertices
  - An array of primitives that describe a 3D object
- Topology
  - How the vertices are interpreted in order to build the 3D object
- Translation
  - Moving an object from it's initial position
  - Translation happens on the Y axis
- Depth
  - The Z axis, how near or how far an object is perceived to be from the viewer
- Rotation
  - Rotating an object around it's central point of origin
    - Rotation happens on the X axis
    - Rotation of an object on the X axis is like turning a knob back and
      forth
  - Counterclockwise rotations are considered positive, clockwise rotations
    are negative
- Scaling
  - Changing the size of an object
- Transformation
  - A combination of translation, rotation and scaling
- XYZ 
  - References to one or more of the axes
- xyz
  - Coordinates
- Geometric transformation
  - Having an the object itself move relative to a common origin
- Coordinate transformation
  - Having the world origin move while the object stays stationary
- Vertex shaders
  - Responsible for processing vertexes (meshes)
  - Stores data in "clip-space" coordinates
- Fragment shaders
  - Responsible for colorizing pixels

# vim: filetype=markdown shiftwidth=2 tabstop=2
