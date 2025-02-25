#!/bin/zsh

# Initialize arrays for excluded files and directories
exclude_files=()
exclude_dirs=()

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --exclude)
      if [[ -n "$2" ]]; then
        exclude_files+=("$2")
        shift 2
      else
        echo "Error: --exclude requires a filename."
        exit 1
      fi
      ;;
    --exclude-dir)
      if [[ -n "$2" ]]; then
        exclude_dirs+=("./$2" "./$2/*")
        shift 2
      else
        echo "Error: --exclude-dir requires a directory name."
        exit 1
      fi
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Construct find command with exclusions
exclude_conditions=()

# Exclude directories
for dir in "${exclude_dirs[@]}"; do
  exclude_conditions+=(-path "$dir" -o)
done

# Exclude files
for file in "${exclude_files[@]}"; do
  exclude_conditions+=(-name "$file" -o)
done

# If there are exclusions, add the prune logic
if [[ ${#exclude_conditions[@]} -gt 0 ]]; then
  exclude_conditions+=("-false")
  find . -mindepth 1 \( "${exclude_conditions[@]}" \) -prune -o -print
else
  find . -mindepth 1 -print
fi | sed 's|^\./||' \
  | sort \
  | awk -F/ '
    {
      indent = "";
      for(i = 1; i < NF; i++) {
          indent = indent "  ";
      }
      printf "%s- [%s](./%s)\n", indent, $NF, $0;
    }
  '
