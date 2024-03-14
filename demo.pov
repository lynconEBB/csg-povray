#version 3.7
#include "colors.inc"  
#include "shapes3.inc"  
#include "shapes3.inc"
#include "Round_Box_Y.inc"

#include "textures.inc" 
#include "stones.inc"

#declare Cam2 = camera {
  location  <-20.0, 5.0, 0>
  look_at   <0.0, 0.0,  0.0>
  angle 90
}                               


#declare Cam1 = camera {
  location  <0.0, 5.0, -20.0>
  look_at   <0.0, 0.0,  0.0>
  angle 90
}                               

camera {
    Cam1
}

#declare BombGrayColor = <0.1,0.1,0.1> ;
   
background { color red 0.078 green 0.361 blue 0.753 }
        
light_source {  
    <10, 10, -30> 
    color White
    parallel
    point_at <1, 0, 0> 
}   

/*
plane { 
    <0,1,0>, 0  
    hollow
    texture { 
        pigment { 
            color Green 
        }
    }  
} 
*/    

   
#declare BombBody = sphere {
    <0,0,0> 2
    pigment { color BombGrayColor }
    finish {
        ambient 0.2
    } 
    translate <0,0,0>
}

// ============================= Bomb ========================================
/* #declare BombCap = object{//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
    Round_Cone( <0,0,0>, 1, <0,0.7,0>, 0.8 , 0.1, 0)  
    texture{ 
        pigment{ 
            color BombGrayColor
        }         
    } 
    scale<1,1,1>  
    rotate<0,0,0> 
    translate<0,1.6,0>
}  

#declare Bomb = merge {
  object { BombCap }
  object { BombBody }
  translate <0,-2,0> 
  finish { phong 0.5 }
} 
   
#declare BombWick = difference {
    sphere_sweep {
        b_spline
        4,
        <0,-10,0>, 1
        <0,-2,0>, 1
        <2,2,0>, 1
        <20,2,0>, 1
        texture { 
            T_Grnt4 
            normal { agate 0.15 scale 0.15}
        }
        finish {
            ambient 0.3
        }
    }

    box { 
        <-1.00, 0.00, -1.00>, < 1.00, 2.00, 1.00>
        scale <1.2,1.5,1.5> 
        rotate<0,0,15> 
        translate<5,0,0> 
    }
}

union {
    object { Bomb }
    object { 
        BombWick
        scale <1,1,1> * 0.3
        translate <-0.1,1,0>
    }  
} */


// ======================== Character ================================


//-------------------------------------------------------------------------

#declare EggBody = object{ 
    Egg_Shape( 0.2, 0.7  )
    scale <1,3.5,1>
    rotate <0,0,0>
    translate< 0, 0, 0>
}
                                                                                                                                                                       
#declare Shoe = difference {
object{ 
    Egg_Shape( 0.2, 0.5  )
    scale <1,5,1> * 0.5
    rotate <-90,0,0>
    translate< 0, 0, 0>
    pigment {
        color <1,0,0.25>
    } 
}

box {
    <-1, -1, -1>, <1, 1, 1> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
    translate <0,-1,0>
    scale <2,1,8>
} 

}
                                                                                                                                                                       

// ================== HEAD ======================================
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
declare Head = object{ Round_Box_Y ( <-1, -1, -1>, <1, 1, 1>, // <x, y, z> near lower left corner, <x, y, z> far upper right corner
                      0.60, // Border_Radius_Big,  // big radius of vertical borders
                      0.050, // Border_Radius_Small,// small radíus of horizontal borders
                      1, 0 // Merge___On 
                    ) 
        texture {
              pigment{ color White } 
        } // end of texture      
       scale<4,3,2.5>  rotate<90,0,0> translate<0,9,0>
  }

difference {
    object {
        Head
    }
    object {
        Head
        scale<0.8,0.8,1>
        translate <0,1.7,-1>
    }
}

intersection {
    sphere { 
        <0,0,0>, 1.25  
        scale<1,0.5,0.5>
         
        texture { 
            pigment{ color < 1, 0.80, 0.55>}
        }
        rotate<90,0,0>  translate<0,0,0>  scale<1,1,1> * 5
    }  

    object{ Round_Box_Y ( <-1, -1, -1>, <1, 1, 1>, // <x, y, z> near lower left corner, <x, y, z> far upper right corner
                        0.60, // Border_Radius_Big,  // big radius of vertical borders
                        0.050, // Border_Radius_Small,// small radíus of horizontal borders
                        1, // Y_Filled___On,
                        0 // Merge___On 
                        ) //----------------------------------------
            texture {
                pigment{ color White } 
            } 
        scale<3.4,5,2.2>  rotate<90,0,0> translate<0,0,0>
    }
    pigment {
        color < 1, 0.80, 0.55>
    }

    translate <0,9.1,-0.2>
}

sphere {
    <0, 0, 0>, 1 // <x, y, z>, radius
    pigment { color Black }
    scale <1,4,1> * 0.4
    translate <1.5,9,-3>
}
sphere {
    <0, 0, 0>, 1 // <x, y, z>, radius
    pigment { color Black }
    scale <1.2,4,1.2> * 0.4
    translate <-1.5,9,-3>
}

#declare Cinto = intersection {
    object { EggBody }
    box { 
        <-1.00, 0.00, -1.00>, < 1.00, 2.00, 1.00>
        scale <3,0.5,3> 
        rotate<0,0,0> 
        translate<0,1.8,0>     
        
    } 
    pigment {
        color White
    }
    scale <1.05,1,1.05>
}

union {
merge {
    object { 
        EggBody 
        pigment{ color  rgb< 0.25, 0.25, 0.5> }
    } 
    object { Cinto }

}
sphere_sweep {
    linear_spline
    2,
    <0,0,0>, 0.5 
    <7,0,0>, 0.5 
    pigment { 
        White
    }
    finish {
        ambient 0.3
    }
    translate <0,5,0>
}

sphere_sweep {
    linear_spline
    2,
    <0,0,0>, 0.5 
    <-7,0,0>, 0.5 
    pigment { 
        White
    }
    finish {
        ambient 0.3
    }
    translate <0,5,0>
}

sphere {
    <0, 0, 0>, 1 // <x, y, z>, radius
    translate <7,5,0> 
    pigment {
        color <1,0,0.25>
    }
}

sphere {
    <0, 0, 0>, 1 // <x, y, z>, radius
    translate <-7,5,0> 
    pigment {
        color <1,0,0.25>
    }
}      

sphere_sweep {
    linear_spline
    2,
    <-0.5,-2,0>, 0.5 
    <-2,-10,0>, 0.5 
    pigment { 
        White
    }
    finish {
        ambient 0.3
    }
    translate <0,5,0>
}
   
sphere_sweep {
    linear_spline
    2,
    <0.5,-2,0>, 0.5 
    <2,-10,0>, 0.5 
    pigment { 
        White
    }
    finish {
        ambient 0.3
    }
    translate <0,5,0>
}
object {
    Shoe
    translate <2,-6,1>
}
object {
    Shoe
    translate <-2,-6,1>
}
translate <0,0,0>

} 