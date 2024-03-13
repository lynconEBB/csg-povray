      
#version 3.7
#include "colors.inc"  
#include "shapes3.inc"


// sky (tilt) camera
camera {
  location  <5.0, 5.0, -10.0>
  look_at   <0.0, 0.0,  0.0>
}

 


plane { <0,1,0>, 0  hollow // normal vector, distance to zero ----

        texture{ 
            pigment{ color rgb<0.75,0.35, 0.35> }
	  
        } 
        scale <0,0,0>
        translate <0, -2,0>
   
      } 
      
//----------------------------------------------------------------------------------
#include "shapes3.inc"
//----------------------------------------------------------------------------------

  
    
    
    
// CSG difference, subtract intersections of shapes 2...N from Shape1
difference {
  

  object{ Facetted_Sphere( 6, 16 )// ( Quarter_Meridian_Segments, Equatorial_Segments)
        texture{ pigment{ color Orange }
               
                 
               } // end of texture
         
        scale <1.2,1,1.2>*2 
        rotate <0,0,0>
        translate< 0, 0, 0>
      }  
      
      prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        rotate<90,0,0> //turns prism in x direction! Don't change this line!  

      texture { pigment{ color Black } 
              } // end of texture

       scale <0.3, 0.3, 2.00>
       rotate<0,0,0> 
       translate<-0.600, 00.500, -3.00> 
     }   
     
     prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        rotate<90,0,0> //turns prism in x direction! Don't change this line!  

      texture { pigment{ color Black } 
              } // end of texture

       scale <0.3, 0.3, 2.00>
       rotate<0,0,0> 
       translate<0.6, 00.500, -3.00> 
     } 
}
 
 
 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// This spline describes the path along the object
// From control points 0 to 1
#declare USpline_1 = 
  spline {
    cubic_spline
   -1.0, <0, 9,0>,
    0.0, <0, 1,0>, // start point
    0.5  <2, 3,2>,    
    1.0, <5, 1,0>, // end point
    2.0, <3,-1,0>
  } //--------------------------

// This spline describes the cross section of the object
// For a closed shape the spline should have the same values at control points 0 and 1 
// The z coordinate is not used
#declare VSpline_1 =
  spline {
    cubic_spline
   -0.125, <0.25,-0.25,0>,
    0,     <1.00, 0.00,0>, // start point
    0.125, <0.25, 0.25,0>,
    0.25,  <0.00  1.00,0>,
    0.375,<-0.25, 0.25,0>,
    0.500,<-1.00, 0.00,0>,
    0.625,<-0.25,-0.25,0>,
    0.750, <0.00,-1.00,0>,
    0.875, <0.25,-0.25,0>,
    1.000, <1.00, 0.00,0>, // end point
    1.125, <0.25, 0.25,0>,
  } //--------------------------

// This spline describes how the width varies 
#declare WSpline_1 = spline {
  cubic_spline
   -1.0, 0.00,
    0.0, 0.001, // start point //  Note: shouldn't let it become zero
    0.8, 1.0,
    1.0, 1.0,    // end point
    2.0, 1.5                    
 } //--------------------------
//--------------------------------------------------------------------------
#include "meshmaker.inc"
// For some surfaces the previous version of SweepSpline might 
// possibly look a little better. The new version has a completely
// different algorithm for finding the normals. 
// To use the old version use SweepSpline2() instead
//--------------------------------------------------------------------------
object {
  SweepSpline1( USpline_1, // spline for path along the object
                VSpline_1, // the cross section of the object, not necessarily closed!
                WSpline_1, // spline for how the width varies 
                20,50, // points along, points around, 
                "", // Filename
              ) //----------------------------------------------------------
 //  no_shadow
   texture{   // outside texture
     uv_mapping
     pigment{ checker color rgb <0.0,0,0.0> rgb <1,0.9,0.9> scale <0.04,0.04,1>}
     finish { phong 0.5 }
   } // 
   interior_texture {            // inside texture
     uv_mapping
     pigment{ checker color rgb <0.5,0.0,0.1> rgb <1,1,1> scale <0.04,0.04,0.01>}
     finish { specular 0.5}
   } // 
//  uv_mapping pigment {checker scale 0.05}
//  finish {phong 0.2 phong_size 10}
} //--------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------



background { color red 0.078 green 0.361 blue 0.753 }
        
light_source {  
    <10, 10, -30> 
    color White
    parallel
    point_at <1, 0, 0> 
    
   
}










