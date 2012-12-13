function git_prompt_info {
  git_prompt_vars
  GIT_PAIR=`git config user.initials | sed 's% %+%'`
  echo -e " $GIT_PAIR$SCM_PREFIX$SCM_BRANCH$SCM_STATE$SCM_SUFFIX"
}