package game_of_life

import "core:fmt"
import "vendor:raylib"
import "core:math"

MAX_ITER::10

euc::proc(a:f32, b:f32) -> f32{
  return math.sqrt_f32((a*a) + (b*b))
}

julia::proc(grid: ^[dynamic][dynamic]int) {
  for i in 0..<size_h {
    for j in 0..<size_w {
      zi:f32= f32(i) / f32(size_h) - .5 
      zj:f32= f32(j) / f32(size_w) - .5
      zi *=1.5
      zj *=2.5
      iteration:=0
      for (iteration < MAX_ITER && euc(zi,zj) < 4.0) {
        xtemp := zi * zi - zj * zj
        zj = 2 * zj * zi  -.835
        zi = xtemp - .321
        iteration+=1
      }
      if iteration == MAX_ITER do grid[i][j] = 0
      else do grid[i][j] = iteration
    }
  }
}


drawJulia::proc(grid:^[dynamic][dynamic]int){
  for i in 0..<size_h {
    for j in 0..<size_w {
      if grid[i][j] > 0 {
        color:= raylib.ColorLerp(raylib.YELLOW, raylib.RED, f32(MAX_ITER - grid[i][j]) / f32(MAX_ITER) )
        raylib.DrawPixel(i32(j), i32(i), color)
      }else do raylib.DrawPixel(i32(j), i32(i), raylib.BLACK)
    }
  }
}
