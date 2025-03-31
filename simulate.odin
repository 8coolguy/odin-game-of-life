package game_of_life 

import "core:fmt"
import "core:flags"
import "core:os"
import "core:strconv"
import "core:math/rand"

main :: proc(){
  args :[]string= os.args
  size :int
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





}


