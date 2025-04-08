package game_of_life

import "vendor:raylib"
import "core:fmt"
import "core:os"

drawGrid::proc(grid:^[dynamic][dynamic]int){
  for i in 0..<size_h {
    for j in 0..<size_w {
      if grid[i][j] > 0 {
        raylib.DrawPixel(i32(j), i32(i), raylib.WHITE)
      }else do raylib.DrawPixel(i32(j), i32(i), raylib.BLACK)
    }
  }
}

main::proc(){
  parse_args(os.args)
  assert(size_w > 0 && size_h > 0 && spawn_chance > 0)
  raylib.InitWindow(i32(size_w), i32(size_h), "game of life")
  fmt.printf("Width {}, Height {}\n", size_w, size_h)
  grid :[dynamic][dynamic]int = initialize()
  defer delete(grid)
  for !raylib.WindowShouldClose() {
    raylib.BeginDrawing()
    julia(&grid)
    drawJulia(&grid)
    raylib.EndDrawing()
  }
  raylib.CloseWindow()
}
