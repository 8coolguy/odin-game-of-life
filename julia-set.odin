package game_of_life

import "core:fmt"
import "core:math"
import "vendor:raylib"

MAX_ITER::100

euc::proc(a:f32, b:f32) -> f32{
  return math.sqrt_f32((a*a) + (b*b))
}

julia::proc(grid: ^[dynamic][dynamic]int, ci:f32, cj:f32, R:f32) {
  assert(R > 0 && R*R - R >= math.sqrt(ci*ci + cj*cj))
  for i in 0..<size_h {
    for j in 0..<size_w {
      zi:f32= f32(i) / f32(size_h) - .5 
      zj:f32= f32(j) / f32(size_w) - .5
      zi *=2.0
      zj *=2.0
      iteration:=0
      for (iteration < MAX_ITER && zi*zi + zj*zj < R*R) {
        xtemp := zi * zi - zj * zj
        zj = 2 * zj * zi  + cj
        zi = xtemp + ci 
        iteration+=1
      }
      if iteration == MAX_ITER do grid[i][j] = 0
      else do grid[i][j] = iteration
    }
  }
}


drawJulia::proc(grid:^[dynamic][dynamic]int, bg:raylib.Color, primary:raylib.Color, secondary:raylib.Color){
  for i in 0..<size_h {
    for j in 0..<size_w {
      if grid[i][j] > 0 {
        zi:f32= f32(i) / f32(size_h) - .5 
        zj:f32= f32(j) / f32(size_w) - .5
        zi *=2.0
        zj *=2.0
        abs_z := zi * zi + zj * zj;
        fmt.println(f32(grid[i][j]) + 1 - math.log_f32(2,math.log_f32(2,abs_z))/.302)
        color:= raylib.ColorLerp(primary, secondary, f32(MAX_ITER - f32(grid[i][j]) + 1 - math.log_f32(10,math.log_f32(10,abs_z))/.302)/ f32(MAX_ITER) )
        raylib.DrawPixel(i32(j), i32(i), color)
      }else do raylib.DrawPixel(i32(j), i32(i), bg)
    }
  }
}
