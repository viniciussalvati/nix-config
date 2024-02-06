{
  userCommands = {
    # See `:help expand()` and `help filename-modifiers`
    CopyRelativePath.command = "let @+ = expand('%:p:.')";
    CopyFullPath.command = "let @+ = expand('%:p')";
    CopyFileName.command = "let @+ = expand('%:t')";
  };
}
