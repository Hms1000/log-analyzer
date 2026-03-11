# Log Analyzer Lessons and Learnings

## URL error
- I struggled with git a little bit because I'd pushed an incorrect url `git remote add origin git@github.com:Hms1000/log-analyzer.gi` instead of `git remote add origin git@github.com:Hms1000/log-analyzer`
- I kept on getting 'Repository not found error', upon running `git remote -v` I discovered the error
- I then ran `git remote set-url git@github.com:Hms1000/log-analyzer` and from there the error was gone and I could now push without any problems
