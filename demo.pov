#version 3.7
#include "colors.inc"  
#include "shapes3.inc"  
#include "shapes3.inc"
#include "Round_Box_Y.inc"
#include "textures.inc" 
#include "stones.inc"

#declare Cam1 = camera {
  location  <0.0, 5.0, -20.0>
  look_at   <0.0, 0.0,  0.0>
  angle 90
}                               

#declare Cam2 = camera {
  location  <-20.0, 20.0, -20>
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
   

// ============================= Bomb ========================================

#declare BombBody = merge {
    object{//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
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

    sphere {
        <0,0,0> 2
        pigment { color BombGrayColor }
        finish {
            ambient 0.2
        } 
        translate <0,0,0>
    }

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

#declare Bomb = union {
    object { BombBody }
    object { 
        BombWick
        scale <1,1,1> * 0.3
        translate <-0.1,1,0>
    }  
    translate <10,9,0>
} 


// ======================== Character ================================
/*
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

declare Head = object{ Round_Box_Y ( <-1, -1, -1>, <1, 1, 1>, // <x, y, z> near lower left corner, <x, y, z> far upper right corner
                      0.60, // Border_Radius_Big,  // big radius of vertical borders
                      0.050, // Border_Radius_Small,// small radíus of horizontal borders
                      1, 0 // Merge___On 
                    ) 
        texture {
              pigment{ color White } 
        }
       scale<4,3,2.5>  rotate<90,0,0> translate<0,9,0>
}

difference {
    object { 
        Head 
        pigment {
            color < 1.0, 0.65, 0.0>
        }
    }
    
    object {
        Head
        scale<0.6,0.6,2> 
        translate <0,3.5,0>
        pigment {
            color < 1.0, 0.65, 0.0>
        }
    }
    scale <0.25,0.25,0.1>
    translate <0,0.2,-2.3>
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
    scale <1,4.7,1> * 0.4
    translate <1.5,9,-3>
}
sphere {
    <0, 0, 0>, 1 // <x, y, z>, radius
    pigment { color Black }
    scale <1.2,4.7,1.2> * 0.4
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

    sphere_sweep {
        linear_spline
        2,
        <0,0,0>, 0.5 
        <0,1,2>, 0.5 
        pigment { 
            White
        }
        finish {
            ambient 0.3
        }
        translate <0,11.5,2.5>
    }

    sphere {
        <0, 12.5, 4.5>, 1 // <x, y, z>, radius
        pigment {
            color <1,0,0.25>
        }
    }      

    triangle {
        <0,0.5,0>, <0,2,0>, <-3,-1,0>
        pigment {
            color Black
        }
        translate <4,13.4,-5>
        scale <1,1,1> * 0.8
    }

    triangle {
        <0,0.5,0>, <0,2,0>, <-3,-1,0>
        pigment {
            color Black
        }
        translate <4,13.4,-5>
        scale <-1,1,1> * 0.8
    }


    translate <0,0,0>

} 
*/

// ======================= Roller item ==================

#declare ItemBase = difference {
    box {
        <-1, -1, -1>, <1, 1, 1>
        pigment {
            color Red
        }
        scale <5,0.5,5>
    }
    box {
        <-1, -1, -1>, <1, 1, 1>
        pigment {
            color Green
        }
        scale <4.5,1,4.5>
        translate <0, 1,0>
    }
}



#declare Wheel = difference {
    cylinder {
        <0, 0, 0>, <0, 0, 1>, 1// center of one end, center of other end, radius
        pigment {
            color Yellow
        }
    }
    cylinder {
        <0, 0, 0>, <0, 0, 1>, 0.5// center of one end, center of other end, radius
        pigment {
            color BombGrayColor
        }
        translate <0,0,-0.5>
    }
}


#declare Strap = difference {
    intersection {
        cylinder {
            <0, 0, 0>, <0, 1, 0>, 4
            pigment {
                color Orange
            }
            scale <1.2,10,1.2>
            translate <4,3,0>
        }

        box {
            <-1, -1, -1>, <1, 1, 1> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
            scale <10,0.5,10> 
            translate <0,10,0>
        }
    }


    box {
        <-1, -1, -1>, <1, 1, 1>
        scale <1,1,1> * 5
        translate <9,10,0>
    }
}

#declare RollerBody = merge {
    difference {
        sphere_sweep {
            linear_spline
            2,
            <-5,0,0>, 5
            <5,0,0>, 5 
            pigment { 
                color <0.0, 0.5, 1.0>
            }
            finish {
                ambient 0.2
            }
            scale <1,1.2,1>
        }
        box {
            <-1, -1, -1>, <1, 1, 1> 
            scale <15,5,5>
            translate <0,-5,0>
        }
    }
    cylinder {
        <0, 0, 0>, <0, 1, 0>, 4
        pigment {
            color <0.0, 0.5, 1.0>
        }
        scale <1,10,1>
        translate <4,3,0>
    }
}

#declare Roller = union {
    object {
        RollerBody
    }

    object {
        Strap
    }

    object {
        Strap
        translate <0,-2,0>
    }

    object {
        Wheel
        scale <1,1,1> * 3
        translate <4, 0, -7>
    }

    object {
        Wheel
        scale <1,1,1> * 3
        translate <-3.5,0,-7>
    }

    object {
        Wheel
        scale <1,1,1> * 3
        translate <4, 0, 4>
    }

    object {
        Wheel
        scale <1,1,1> * 3
        translate <-3.5,0,4>
    }
}

#declare RollerItem = union {
    object {
        Roller
        scale <1,1,1> * 0.35
        translate <0,2,-10>
    }
    object {
        ItemBase
        translate <0,0,-10>
    }
}
// ================== Skull ===========================

#declare Skulli = difference {
ovus {
    1, 1 // base_radius, top_radius (top_radius < base_radius)
    pigment {
        color White
    }
    rotate <0,0,90>
    scale <1,1.2,1> * 3
}
ovus {
    1, 1
    translate < 0,0,-2> 
    scale <1,1,1.2>
    rotate <0,0,0>
    pigment { 
        color Black
    }
}
ovus {
    1, 1
    translate < -3,0,-2> 
    scale <1,1,1.2>
    rotate <0,0,0>
    pigment { 
        color Black
    }
}
sphere {
    <0, 0, 0>, 0.5 // <x, y, z>, radius
    translate <-1.5,-0.5,-3> 
}
}

/* sphere {
    <0, 0, 0>, 0.2 // <x, y, z>, radius
    translate <0,1,-2> 
    pigment {
        color Red
    }
    finish {ambient 4}
}


sphere {
    <0, 0, 0>, 0.2 // <x, y, z>, radius
    translate <-3,1,-2> 
    pigment {
        color Red
    }
    finish {ambient 4}
} */

#declare Skull =  merge {

object {
    Skulli
}

object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<0,0,0>,<-1,-1,-1>, 0.25 , 0)  
         
        texture{ pigment{ color White}
        }
        scale<1.5,3,2>  
        rotate<0, 0,0> 
        translate<-2.5,-1.5,-1.5>
      } 

object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<0,0,0>,<-1,-1,-1>, 0.25 , 0)  
         
        texture{ pigment{ color White}
        }
        scale<1.5,3,2>  
        rotate<0, 0,0> 
        translate<-0.8,-1.5,-1.5>
      } 

object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<0,0,0>,<-1,-1,-1>, 0.25 , 0)  
         
        texture{ pigment{ color White}
        }
        scale<1.5,3,2>  
        rotate<0, 0,0> 
        translate<0.8,-1.5,-1.5>
      } 
}
/* object {
    ItemBase
} */