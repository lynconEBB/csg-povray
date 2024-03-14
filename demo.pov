      
#version 3.7
#include "colors.inc"  
#include "shapes3.inc"  

#include "textures.inc" 
#include "stones.inc"


camera {
  location  <0.0, 5.0, -10.0>
  look_at   <0.0, 0.0,  0.0>
}                               

#declare BombGrayColor = <0.1,0.1,0.1> ;

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


#declare Cap = object{//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
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
  object { Cap }
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
}
  

background { color red 0.078 green 0.361 blue 0.753 }
        
light_source {  
    <10, 10, -30> 
    color White
    parallel
    point_at <1, 0, 0> 
}










