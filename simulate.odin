package game_of_life 

import "core:fmt"
import "core:flags"
import "core:os"
import "core:strconv"
import "core:math/rand"
import "core:time"
dx:=[?]int{-1, 1, 0, 0,  1, -1, 1, -1}
dy:=[?]int{0, 0, -1, 1, -1, -1, 1, 1}
size:int

print:: proc(grid:[dynamic][dynamic]int){
  for i in 0..<size {
    for j in 0..<size {
      fmt.print(grid[i][j])
    }
    fmt.println()
  }
}
within_grid::proc(r, c: int) -> bool{
  return r > -1 && r < size && c > -1 && c < size
}
update:: proc(grid:[dynamic][dynamic]int) -> ([dynamic][dynamic]int) {
  grid:=grid
  for i in 0..<size {
    for j in 0..<size {
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
  for i in 0..<size {
    for j in 0..<size {
      value:=grid[i][j]
      if value > 4 do grid[i][j] = 0
      else if value == -3 do grid[i][j] = 1
      else if value == 3 do grid[i][j] = 1
      else if value == 4 do grid[i][j] = 1
      else do grid[i][j] = 0
    }
  }
  return grid


}


main :: proc(){
  args :[]string= os.args
  fmt.print(size)
  //switch statement through different arguments for now just size 
  for i in 1..<len(args) {
    value, ok:=flags.get_subtag(args[i], "size")
    if(ok) {
      if(ok) do size,ok = strconv.parse_int(value)
    }
    fmt.println(size)
  } 
  assert(size > 0)
  grid:[dynamic][dynamic]int
  for i in 0..<size {
    temp:[dynamic]int
    for j in 0..<size {
      value:int = 0
      random_number := rand.int31() % 10
      if (random_number > 3) do value=1
      append(&temp, value)
    }
    append(&grid, temp)
  }
  for {
    print(grid)
    grid = update(grid)
    fmt.println()
    time.sleep(5000000000)
  }




}


