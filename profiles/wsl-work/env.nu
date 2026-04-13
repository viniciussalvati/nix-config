# Adds yarn global packages folder to the path
if (which yarn | length) > 0 {
  let yarnGlobal = yarn global bin
  if ($yarnGlobal | path exists) {
    $env.PATH = $env.PATH | append $yarnGlobal
  }
}
