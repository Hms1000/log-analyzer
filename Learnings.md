# Log Analyzer Lessons and Learnings

## URL error
- I struggled with git a little bit because I'd pushed an incorrect url `git remote add origin git@github.com:Hms1000/log-analyzer.gi` instead of `git remote add origin git@github.com:Hms1000/log-analyzer`
- I kept on getting 'Repository not found error', upon running `git remote -v` I discovered the error
- I then ran `git remote set-url git@github.com:Hms1000/log-analyzer` and from there the error was gone and I could now push without any problems

## fatal: pathspec 'failed_ips.txt' did not match any files
- whenever i tried running the script this error kept on popping up
- I went over the script and figured out that the 'failed_ips.txt' was not created
- And so i redirected stdin to it

## fatal: pathspec 'failed_ips.txt' did not match any files: AGAIN!!!
- even though after the upgrades this error keeps appearing which makes me wonder if there's something else I'm missing 
- I figured out that in the script git was committing regardless of whether the file exists or not 
- Therefore, I decided to use conditionals so thay git can only commit if the report exists unlike previously where the script was trying to commit even when the report does'nt exist.

## sort: cannot read: failed_ips_2026-03-21.txt: No such file or directory
- I made some upgrades which improves the scripts overall power, however when i run it i'm getting the error above
- I will definitely have to revisit he script again and see , why that is.
