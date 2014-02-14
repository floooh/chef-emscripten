@test "Verify node.js is in the path" {
  run node --version
  [ "$status" -eq 0 ]
}
@test "Verify that emcc is in the path" {
  . ~/.bash_profile
  which emcc
}
@test "Verify that java is in the path" {
  which java
}

