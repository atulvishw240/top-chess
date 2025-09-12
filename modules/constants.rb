# Contains all the Constants codes used throughout the program
module Constants
  RESET_TERMINAL = "\e[0m".freeze
  WHITE_BACKGROUND = "\e[47m".freeze
  CYAN_BACKGROUND = "\e[48;5;45m".freeze
  BLACK_FOREGROUND = "\e[30m".freeze
  BROWN_FOREGROUND = "\e[38;5;160m".freeze
  CHECK = '\e[48;5;200'.freeze
  CAPTURE = "\e[48;5;200m".freeze
  MARKER = "\e[90m\u{25CF} ".freeze
  EMPTY = '  '.freeze
end
