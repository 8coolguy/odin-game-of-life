package game_of_life 

import "core:fmt"
import "core:flags"
import "core:os"
import "core:strconv"
import "core:math/rand"
import "core:time"
dx:=[?]int{-1, 1, 0, 0,  1, -1, 1, -1}
dy:=[?]int{0, 0, -1, 1, -1, -1, 1, 1}
size_w, size_h:int

print:: proc(grid:[dynamic][dynamic]int){
  for i in 0..<size_h {
    for j in 0..<size_w {
      fmt.print(grid[i][j])
    }
    fmt.println()
  }
}
within_grid::proc(r, c: int) -> bool{
  return r > -1 && r < size_h && c > -1 && c < size_w
}
update:: proc(grid:[dynamic][dynamic]int) -> ([dynamic][dynamic]int) {
  grid:=grid
  for i in 0..<size_h {
    for j in 0..<size_w {
      if grid[i][j] > 0 {
        for d_i in 0..<len(dx){
          if within_grid(i + dx[d_i], j + dy[d_i]){
            if grid[i + dx[d_i]][j + dy[d_i]] > 0 do grid[i + dx[d_i]][j + dy[d_i]]+=1
            else do grid[i + dx[d_i]][j + dy[d_i]]-=1
          }
        }
      }
    }
  }
  for i in 0..<size_h {
    for j in 0..<size_w {
      value:=grid[i][j]
      if value > 4 do grid[i][j] = 0
      else if value == -3 do grid[i][j] = 1
      else if value == 3 do grid[i][j] = 1
      else if value == 4 do grid[i][j] = 1
      else do grid[i][j] = 0
      //fmt.printf("{} {}\n", value, grid[i][j])
    }
  }
  return grid
}
initialize::proc() -> (grid: [dynamic][dynamic]int){
  for i in 0..<size_h {
    temp:[dynamic]int
    for j in 0..<size_w {
      value:int = 0
      random_number := rand.int31() % 10
      if (random_number > 7) do value=1
      append(&temp, value)
    }
    append(&grid, temp)
  }
  return
}

parse_args:: proc(args:[]string) {
  for i in 1..<len(args) {
    value, ok:=flags.get_subtag(args[i], "size_w")
    if(ok) {
      if(ok) do size_w,ok = strconv.parse_int(value)
    }
    value, ok=flags.get_subtag(args[i], "size_h")
    if(ok) {
      if(ok) do size_h,ok = strconv.parse_int(value)
    }
  } 
}

@(private="package")
test :: proc(){
  args :[]string= os.args
  parse_args(args)
  assert(size_w > 0 && size_h > 0)
  fmt.printf("Width {}, Height {}\n", size_w, size_h)

  grid :[dynamic][dynamic]int = initialize()
  defer delete(grid)
  for {
    print(grid)
    grid = update(grid)
    fmt.println()
    time.sleep(5000000000)
  }
}


