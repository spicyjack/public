# OpenGL ES Notes #

*Note*: most `OpenGL ES` calls have `manpages`.  `GLKit` documentation can be
viewed from within Xcode or on the web.

## Links ##
OpenGL Documentation on the web
- http://www.opengl.org/sdk/docs/man/
- http://www.khronos.org/opengles/sdk/docs/man/
- System manpages
- OpenGL State Variables
  - http://www.glprogramming.com/red/appendixb.html
- OpenGL data types
  - http://www.glprogramming.com/red/chapter01.html#name3

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
- Matrices
  - Model matrix
    - The model is every object in the scene; when it is time to render the
      object, the model matrix is calculated for each object.  The model
      matrix is used to transform position coordinates from "world space" to
      "eye space"
  - View matrix
    - The view matrix is where the camera is positioned, and where it is
      facing
  - Projection view/matrix
    - The lens that is put on to the camara.  The matrix used to transform
      position coordinates from "eye space" to "projection space"
  - Viewport
    - Where the image is recorded

## Understanding Transformations ##
Page 132, OpenGL SuperBible, 5th Ed.

- Viewing transformation is applied to the scene
  - Used to determine the vantage point of the scene
  - Applied before any other transformations, because the other
    matrixes will use the completed (i.e. view has been moved to it's
    destination) view matrix to calculate their final matrixes before the
    scene is rendered
  - GLKit Classes: `GLKMatrix4Make[Translation|Scale|Rotation]`

- Transformations are applied to models
  - Translation and rotation matrixes are non-commutive, meaning there will be
    different results depending on whether the translation matrix was
    calculated first, or the rotation matrix was calculated first
  - GLKit Classes: `GLKMatrix4Make[Translation|Scale|Rotation]`

- ModelView matrix is just another term for the view matrix with model
  matrixes applied to it, or the combined view and model matrixes
  - GLKit Classes: `GLKEffectPropertyTransform.modelviewMatrix`

- Projection Transformation is applied to vertices
  - Projection defines the viewing volume and establishes clipping planes
  - GLKit Classes: `GLKMatrix4Make[Ortho|Perspective]`

- Viewport Transformation maps the scene on to the physical window that's
  available for viewing it
  - GLKit Classes: None

## Notes from WebGL Techniques and Performance ##
- http://www.youtube.com/watch?v=rfQ8rKGTVlg

First iteration
- Loop over all of the objects
  - Upload the Shader/Fragment programs to the GPU
  - Set up model attributes and uniforms
  - Call `drawElements` to draw the elements on the screen

Second iteration
- For each type of object (square, cone, circle)
  - Set up common stuff to draw object
    - Example: lighting is shared across all objects, only need to set it up
      once
  - For each instance of object
    - Set up unique stuff for instance
    - Order drawing of models by model
      - If many models are being used over and over again, you only need to
        set up each type of model one time when you are drawing all of the
        models
    - Draw instance

Third Iteration
- Move the world view math into the vertex shader program from the main
  program
- Move all of the cubes into 1 mesh, along with color data
  - Pass the big mesh to the GPU so it can draw it

Fourth Iteration
- Compute the clock for each axis based on a "global clock"
  - Move the math that computes the axis clock into the GPU
  - Pass in the global clock to the GPU so that the GPU can calculate the axis
    clocks

# vim: filetype=markdown shiftwidth=2 tabstop=2
