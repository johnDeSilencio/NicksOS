# For getting suggestions on MERGE_IDs for mergiraf CLI tool
complete --command mergiraf \
  --no-files \
  --condition "__fish_seen_subcommand_from review" \
  --arguments "(ls $HOME/.local/share/mergiraf/merges/)"
